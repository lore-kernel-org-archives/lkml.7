Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3CFC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD4120863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="VsAJLuyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfKZUdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 15:33:46 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43094 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbfKZUdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 15:33:46 -0500
Received: from zn.tnic (p200300EC2F0EC2005CA5EB7C7B4C9F6D.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:c200:5ca5:eb7c:7b4c:9f6d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A8CD41EC0CD0;
        Tue, 26 Nov 2019 21:33:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574800424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iXiR8c4Wu8JOd5YrOJ8NRMqVP3IvH0GLK9wTwDPLBvs=;
        b=VsAJLuybjs1MESkg9swK5Q18VHaIEWHI7FnsajBTw5FLw83m0r789mc09KWYtzpd25b3GO
        FqBNiLsSedaMI3fpiTz6MlEEfSHfVGEai/3ySzdh9ux79wsQIIraD3czMAaiTs8ELGDklr
        VU4mWXCYJq818OHsdNCbUs2RqJ0dPOo=
Date:   Tue, 26 Nov 2019 21:33:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86: Filter MSR writes from luserspace
Message-ID: <20191126203336.GF31379@zn.tnic>
References: <20191126112234.GA22393@zn.tnic>
 <87zhgie6nl.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zhgie6nl.fsf@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 12:15:10PM -0800, Andi Kleen wrote:
> This will break a bazillion of tools that rely on programing many of
> those MSRs from user space.

Userspace has no deal to poke into random MSRs. End of story.

The next version will switch to a whitelist and I've added the ones
which are used by turbostat and powertop:

int msr_filter_write(u32 reg)
{
        switch (reg) {
        case MSR_IA32_ENERGY_PERF_BIAS:
        case MSR_RAPL_POWER_UNIT:
        case MSR_DRAM_POWER_LIMIT:
        case MSR_PP0_POWER_LIMIT:
        case MSR_PP1_POWER_LIMIT:
                return 0;

I guess adding other, non-critical MSRs to that list is fine.

But if people really wanna program the hardware, a proper interface
needs to be designed. This patch has an example for why poking at random
MSRs from userspace is simply not going to work in the long run.

And if they still wanna poke at MSRs and if you look at the patch in
more detail, you'll see there's msr.allow_writes=1 and we'll taint the
kernel.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
