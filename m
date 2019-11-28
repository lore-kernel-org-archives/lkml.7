Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A4DC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1528F21741
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="UmMaPnJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfK1Jo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 04:44:27 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49426 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfK1Jo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 04:44:27 -0500
Received: from zn.tnic (p200300EC2F0E060055D3D929B3485235.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:600:55d3:d929:b348:5235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6438C1EC0CE3;
        Thu, 28 Nov 2019 10:44:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574934266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=W5sn9QKbwB87agJzbPwbTzq11sd28BV4RzLD3iRiIMo=;
        b=UmMaPnJiUOwAXyO0jtZqoTaK3MJn5EUkJyl6sYpW7Qu60Uy99kd0WDvVYuOKBGeRSbhghS
        PGXJY5YO37y8YeH1hKJHt0dlE8hoDkQ+aL+PFeCPLeS88UVJ/HqOa5hnwOsbSyeRO1ocBL
        bB6BLUdPS40KMqFhzwfmHKw+7TyyXtk=
Date:   Thu, 28 Nov 2019 10:44:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: unchecked MSR access error in throttle_active_work()
Message-ID: <20191128094419.GB17745@zn.tnic>
References: <20191128085447.GA3682@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191128085447.GA3682@owl.dominikbrodowski.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 09:54:47AM +0100, Dominik Brodowski wrote:
> On most recent mainline kernels (such as 5.5-rc0 up to a6ed68d6468b), I see
> the following output in dmesg during startup:
> 
> [   78.016676] unchecked MSR access error: WRMSR to 0x19c (tried to write 0x00000000880f3a80) at rIP: 0xffffffff84ab5742 (throttle_active_work+0xf2/0x230)
> [   78.016686] Call Trace:
> [   78.016694]  process_one_work+0x247/0x590
> [   78.016703]  worker_thread+0x50/0x3b0
> [   78.016710]  kthread+0x10a/0x140
> [   78.016715]  ? process_one_work+0x590/0x590
> [   78.016735]  ? kthread_park+0x90/0x90
> [   78.016740]  ret_from_fork+0x3a/0x50
> 
> Any clues?

Most likely

f6656208f04e ("x86/mce/therm_throt: Optimize notifications of thermal throttle")

I guess we're missing some X86_FEATURE_ check for that MSR to exist.

Adding more people to Cc.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
