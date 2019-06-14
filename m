Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0D6C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62502082C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Y3h8Ywzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfFNLoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 07:44:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50340 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbfFNLoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 07:44:19 -0400
Received: from zn.tnic (p200300EC2F097F00C4A032B92937AA15.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:7f00:c4a0:32b9:2937:aa15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B6C931EC0911;
        Fri, 14 Jun 2019 13:44:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560512657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xJiQKds9daYcI0Rz9VfC2JJuBX2EaMYu3LKFjb/Vmt8=;
        b=Y3h8YwzmAsMfAXptgAnqTVOPSzAl9/VINGz0CSBifu/eP9U3pm83e90vQopVh8I56isnSS
        IkuKgFzIs8v26TjBxk7LO6FX4Jf3d3f4hWyfPo7K/yKjByUwiYMxS2KgkccREJTyzTD3KC
        8NTQ3PofI+luXdUl8ayPBfauJH6PPp8=
Date:   Fri, 14 Jun 2019 13:44:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 2/3] x86/cpufeatures: Combine word 11 and 12 into new
 scattered features word 11
Message-ID: <20190614114410.GD2586@zn.tnic>
References: <1560459064-195037-1-git-send-email-fenghua.yu@intel.com>
 <1560459064-195037-3-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1560459064-195037-3-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 01:51:03PM -0700, Fenghua Yu wrote:
> It's a waste for the four X86_FEATURE_CQM_* features to occupy two
> pure feature bits words. To better utilize feature words, re-define
> word 11 to host scattered features and move the four X86_FEATURE_CQM_*
> features into word 11. More scattered features can be added in word 11
> in the future.
> 
> KVM doesn't support resctrl now. So it's safe to move the
> X86_FEATURE_CQM_* features to scattered features word 11 for KVM.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

...

> diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> index 9a327d5b6d1f..d78a61408243 100644
> --- a/arch/x86/kvm/cpuid.h
> +++ b/arch/x86/kvm/cpuid.h
> @@ -47,8 +47,6 @@ static const struct cpuid_reg reverse_cpuid[] = {
>  	[CPUID_8000_0001_ECX] = {0x80000001, 0, CPUID_ECX},
>  	[CPUID_7_0_EBX]       = {         7, 0, CPUID_EBX},
>  	[CPUID_D_1_EAX]       = {       0xd, 1, CPUID_EAX},
> -	[CPUID_F_0_EDX]       = {       0xf, 0, CPUID_EDX},
> -	[CPUID_F_1_EDX]       = {       0xf, 1, CPUID_EDX},

I think you're going to have to change those to:

        [CPUID_LNX_4]         = {         0, 0, 0},
        [CPUID_7_1_EAX]       = {         7, 1, CPUID_EAX },

instead of removing them because kvm is basically hardcoding the feature
words and then bitches when array elements in the middle get removed:

In file included from ./include/linux/export.h:45,
                 from ./include/linux/linkage.h:7,
                 from ./include/linux/preempt.h:10,
                 from ./include/linux/hardirq.h:5,
                 from ./include/linux/kvm_host.h:10,
                 from arch/x86/kvm/x86.c:22:
In function ‘x86_feature_cpuid’,
    inlined from ‘guest_cpuid_get_register’ at arch/x86/kvm/cpuid.h:71:33,
    inlined from ‘guest_cpuid_has’ at arch/x86/kvm/cpuid.h:100:8,
    inlined from ‘kvm_get_msr_common’ at arch/x86/kvm/x86.c:2804:8:
./include/linux/compiler.h:345:38: error: call to ‘__compiletime_assert_62’ declared with attribute error: BUILD_BUG_ON failed: x86_leaf >= ARRAY_SIZE(reverse_cpuid)
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                      ^
./include/linux/compiler.h:326:4: note: in definition of macro ‘__compiletime_assert’
    prefix ## suffix();    \
    ^~~~~~
./include/linux/compiler.h:345:2: note: in expansion of macro ‘_compiletime_assert’
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
  ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:50:2: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
  ^~~~~~~~~~~~~~~~
arch/x86/kvm/cpuid.h:62:2: note: in expansion of macro ‘BUILD_BUG_ON’
  BUILD_BUG_ON(x86_leaf >= ARRAY_SIZE(reverse_cpuid));
  ^~~~~~~~~~~~
./include/linux/compiler.h:345:38: error: call to ‘__compiletime_assert_63’ declared with attribute error: BUILD_BUG_ON failed: reverse_cpuid[x86_leaf].function == 0
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
                                      ^
./include/linux/compiler.h:326:4: note: in definition of macro ‘__compiletime_assert’
    prefix ## suffix();    \
    ^~~~~~
./include/linux/compiler.h:345:2: note: in expansion of macro ‘_compiletime_assert’
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
  ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:50:2: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
  ^~~~~~~~~~~~~~~~
arch/x86/kvm/cpuid.h:63:2: note: in expansion of macro ‘BUILD_BUG_ON’
  BUILD_BUG_ON(reverse_cpuid[x86_leaf].function == 0);
  ^~~~~~~~~~~~
make[2]: *** [scripts/Makefile.build:278: arch/x86/kvm/x86.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [scripts/Makefile.build:489: arch/x86/kvm] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1071: arch/x86] Error 2
make: *** Waiting for unfinished jobs....

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
