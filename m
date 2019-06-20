Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61771C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3545F2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Zui/vej+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfFTKhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 06:37:33 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41342 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbfFTKhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 06:37:33 -0400
Received: from zn.tnic (p200300EC2F07DE001CBAC5B40D023BBB.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:de00:1cba:c5b4:d02:3bbb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5705B1EC08BF;
        Thu, 20 Jun 2019 12:37:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1561027051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uNCl92NHKqImItrHgjFdygAi3apkvbs9h7DQxi7o4Q8=;
        b=Zui/vej+25gdHxS3fERSrEEahZQzkYs8gXbaocYaNy9+1nAm1Rz+VnRN0B5BIfJCIgDvt7
        tSR+IRpWMwK8BycxNu7O10ule8dBeFnJK/ieFgDnjgkQQAcVn3BhLIu7PLrlgj/bsbOjWn
        60WdYGnCczIJ/CMX9I5I08zsTt1OjMk=
Date:   Thu, 20 Jun 2019 12:37:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v2 2/2] x86/cpufeatures: Enumerate new AVX512 BFLOAT16
 instructions
Message-ID: <20190620103720.GB28032@zn.tnic>
References: <1560794416-217638-1-git-send-email-fenghua.yu@intel.com>
 <1560794416-217638-3-git-send-email-fenghua.yu@intel.com>
 <20190619173140.GH9574@zn.tnic>
 <20190619213404.GB234387@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190619213404.GB234387@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 02:34:04PM -0700, Fenghua Yu wrote:
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index efb114298cfb..4910cb421b82 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -847,6 +847,9 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
>  		c->x86_capability[CPUID_7_0_EBX] = ebx;
>  		c->x86_capability[CPUID_7_ECX] = ecx;
>  		c->x86_capability[CPUID_7_EDX] = edx;
> +
> +		cpuid_count(0x00000007, 1, &eax, &ebx, &ecx, &edx);
> +		c->x86_capability[CPUID_7_1_EAX] = eax;
>  	}

You need to test the sub-leaf index validity here before accessing
subleaf 1:

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 4910cb421b82..dad20bc891d5 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -848,8 +848,11 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_capability[CPUID_7_ECX] = ecx;
 		c->x86_capability[CPUID_7_EDX] = edx;
 
-		cpuid_count(0x00000007, 1, &eax, &ebx, &ecx, &edx);
-		c->x86_capability[CPUID_7_1_EAX] = eax;
+		/* Check valid sub-leaf index before accessing it */
+		if (eax >= 1) {
+			cpuid_count(0x00000007, 1, &eax, &ebx, &ecx, &edx);
+			c->x86_capability[CPUID_7_1_EAX] = eax;
+		}
 	}
 
 	/* Extended state features: level 0x0000000d */

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
