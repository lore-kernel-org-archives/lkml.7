Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C79BC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95E6214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZSWj6tvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbfLLWwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 17:52:19 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54072 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730707AbfLLWwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 17:52:18 -0500
Received: from zn.tnic (p200300EC2F0A5A00B4F8B0259BBDD02E.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5a00:b4f8:b025:9bbd:d02e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 722BD1EC0B73;
        Thu, 12 Dec 2019 23:52:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576191137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=I+6z30f30I6nzK22n10S/qvVdimFKEIApG864hhwozE=;
        b=ZSWj6tvEbRghIKYhiFRQxD/CUxOZbYtFakqG/F3cprL57n4lXuwuZnOHq66hSdODVIQQsx
        x728844ttPnfBk5OioQWoQro+7bmd4+2RYDruiXWM28VqLE2OErRq0AdPH6eFlY2l2f3KC
        g6Ka0lr2wOGG1/FMtAZgFYsGwROrmtw=
Date:   Thu, 12 Dec 2019 23:52:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpufeatures: Add feature flag for fast short rep
 movsb
Message-ID: <20191212225210.GA22094@zn.tnic>
References: <20191212214908.20185-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191212214908.20185-1-tony.luck@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 01:49:08PM -0800, Tony Luck wrote:
> From the Intel Optimization Reference Manual:
> 
> 3.7.6.1 Fast Short REP MOVSB
> Beginning with processors based on Ice Lake Client microarchitecture,
> REP MOVSB performance of short operations is enhanced. The enhancement
> applies to string lengths between 1 and 128 bytes long.  Support for
> fast-short REP MOVSB is enumerated by the CPUID feature flag: CPUID
> [EAX=7H, ECX=0H).EDX.FAST_SHORT_REP_MOVSB[bit 4] = 1. There is no change
> in the REP STOS performance.
> 
> Add an X86_FEATURE_FSRM flag for this.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
> 
> Net effect of this patch is just to make "fsrm" appear in the
> flags section of /proc/cpuinfo. Maybe someone can look into whether
> we should make copy routines that use "rep movsb" check for this
> flag to optimize copies on older CPUs that don't have it?

We can then add the feature flag too. Just showing it in /proc/cpuinfo
without any users is kinda pointless...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
