Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B47C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0939821473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="coDrCP2b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfFNM2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:28:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57020 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727627AbfFNM17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:27:59 -0400
Received: from zn.tnic (p200300EC2F097F00E4D2751AE9C0507E.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:7f00:e4d2:751a:e9c0:507e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5AD7F1EC0513;
        Fri, 14 Jun 2019 14:27:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560515277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3Dy5G9geV+OkhxNXR/2joBt7M8itcKEaeTEPUiWK5cg=;
        b=coDrCP2bmVeuJSnmN/3W1oNa3Ql8JVRkfq/B3SEv8X7Mt8ixHO4pNBKAn6hXX1SpDg9Whc
        VQdicFzEmmL1yWiUr5lt28jde3a9JheUd+Zte6rR8ZPjMTk3qMr0E8zGDqD/CXKODn1Cie
        V7K3UcEvAPAfA4wnGPnsM/wTAWpVNWw=
Date:   Fri, 14 Jun 2019 14:27:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 2/3] x86/cpufeatures: Combine word 11 and 12 into new
 scattered features word 11
Message-ID: <20190614122749.GE2586@zn.tnic>
References: <1560459064-195037-1-git-send-email-fenghua.yu@intel.com>
 <1560459064-195037-3-git-send-email-fenghua.yu@intel.com>
 <20190614114410.GD2586@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190614114410.GD2586@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 01:44:10PM +0200, Borislav Petkov wrote:
> On Thu, Jun 13, 2019 at 01:51:03PM -0700, Fenghua Yu wrote:
> > It's a waste for the four X86_FEATURE_CQM_* features to occupy two
> > pure feature bits words. To better utilize feature words, re-define
> > word 11 to host scattered features and move the four X86_FEATURE_CQM_*
> > features into word 11. More scattered features can be added in word 11
> > in the future.
> > 
> > KVM doesn't support resctrl now. So it's safe to move the
> > X86_FEATURE_CQM_* features to scattered features word 11 for KVM.
> > 
> > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> 
> ...
> 
> > diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> > index 9a327d5b6d1f..d78a61408243 100644
> > --- a/arch/x86/kvm/cpuid.h
> > +++ b/arch/x86/kvm/cpuid.h
> > @@ -47,8 +47,6 @@ static const struct cpuid_reg reverse_cpuid[] = {
> >  	[CPUID_8000_0001_ECX] = {0x80000001, 0, CPUID_ECX},
> >  	[CPUID_7_0_EBX]       = {         7, 0, CPUID_EBX},
> >  	[CPUID_D_1_EAX]       = {       0xd, 1, CPUID_EAX},
> > -	[CPUID_F_0_EDX]       = {       0xf, 0, CPUID_EDX},
> > -	[CPUID_F_1_EDX]       = {       0xf, 1, CPUID_EDX},
> 
> I think you're going to have to change those to:
> 
>         [CPUID_LNX_4]         = {         0, 0, 0},
>         [CPUID_7_1_EAX]       = {         7, 1, CPUID_EAX },
> 
> instead of removing them because kvm is basically hardcoding the feature
> words and then bitches when array elements in the middle get removed:

Alternatively - and what I think is the better solution - would be to
remove those BUILD_BUG_ONs in x86_feature_cpuid and filter out the
Linux-defined leafs dynamically. This way the array won't have holes in
it.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
