Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB99C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 21:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C815F2063F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 21:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ipq2V1iJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbfHOVFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 17:05:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35698 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729562AbfHOVFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 17:05:08 -0400
Received: from zn.tnic (p200300EC2F0B5200F4090F5F0FC894B7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:5200:f409:f5f:fc8:94b7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 050B11EC074B;
        Thu, 15 Aug 2019 23:05:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565903107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3cTqspnxsRR+dFtWCSWAL1onU2pvC0uxIqpEe+/lcYY=;
        b=Ipq2V1iJgsNLv9JZZ2ex9QwuIv/pOG9GfxP5YFImUmGL7w5NNfRH5wMrUzhU8THeFQi4YZ
        sgCc9SsMP0DxBvRnxTCF4crIRMPOhqkCroMfre5zzrgQGJk6t9m02uFUwdiBDjB1v8qoL0
        j0sz2O37NXmrbpPn4o0ctrIpXqTRLv8=
Date:   Thu, 15 Aug 2019 23:05:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] x86/CPU/AMD: Clear RDRAND CPUID bit on AMD family 15h/16h
Message-ID: <20190815210547.GL15313@zn.tnic>
References: <776cb5c2d33e7fd0d2893904724c0e52b394f24a.1565817448.git.thomas.lendacky@amd.com>
 <a24a2c7d-cfab-a049-37e8-7260a9063a7c@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a24a2c7d-cfab-a049-37e8-7260a9063a7c@citrix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 09:59:03PM +0100, Andrew Cooper wrote:
> If you're virtualised, the write to MSR_AMD64_CPUID_FN_1 almost
> certainly won't take effect, which means userspace will still be able to
> see the bit.

msr_clear_bit() has a return value. We should check it before
doing anything further. I hope the HV actually signals the write
success/failure properly so that we get a correct return value.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
