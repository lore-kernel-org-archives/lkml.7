Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B90BC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 09:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96E12173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 09:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557392498;
	bh=/Ye22PNcmdArW/Ks9NOpkzG8d8CMYYnamgONNgmvtbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OjEiZCJeoE8dS6XDNk2LsEKQRJGULp+Mbs3cEfkqjs8vuz7k1nJ7Ex7NX7SdxEFNk
	 KTMYqmtvS02yt5faecW4ZisISV8OzVa46ioCeRrNiQRtbIHnNUvLHJIT1XzxoCYoIf
	 j19Z/KLnu2XvjZPwOhW5Cv2l7mlY81lzR0roSJOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfEIJBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 05:01:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53423 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfEIJBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 05:01:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id 198so2190347wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 02:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nqLxdcgeFWH5aASAjEK5SKDiBhv2TdNPpRhOtK7qLSo=;
        b=eQhWRaKwmJAUICbBbj5FYxykFD8I7hU+9tvLY6qzxwOrQl00QXBG/MYDrW02o3SK8p
         FeDWGYr3u2EZp3f4mMERyC4EjNG2z4shFa33z+ozLsKptCJvGdVR2GQS0Fa6wjo0KL35
         HDvgBVi7pOWckRLIbbaJj97/k6PpVCrgycW5ZH9k63tkxNwF514dD7Y5T/B88J7e1O5g
         o8xu5jyFgapNeufIC8PpJ01rUH1C0lJyl96s6dOiihxCl1NaVkZlqGGstgzZX4nAaAnx
         K6bJVXhaIHY99JsPzUWQ4UDoIbup1ewV3Bo6aVN6s7ismUkYbI5CvAst5fv2ktQtihdD
         BSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nqLxdcgeFWH5aASAjEK5SKDiBhv2TdNPpRhOtK7qLSo=;
        b=odMTOvKNvVIif+On+0IIJ/ZQNLH1dGwpUdyoASRFn1OiD7SncJTTfvWovH8D0wX7S3
         9raGVZ0DwHl8of2SZxF/cfoP9t9qsq1T21o0IDMn/5XBDHYNGRwik/tM45hPUPQfBmEH
         N9IWJO/EFxfHE6joaeEbXuD7njBPSiSvIfZA33jmuLRuiT6+zQT9hx9OKF59yaRShyIv
         MNIO8rX/buYSxh/KujZeGNuaTCZ2vjBabY5NDdTUhbsc0D70n1pmdaJ9mG7KG+CLUwfk
         b5whbUpSTgQzw0uosILcD2RHqgdPHsaB9R682/+zRXxdEDAPtTBZ6EOXOEaq6NiGJ/Cq
         YZDw==
X-Gm-Message-State: APjAAAU49dWLWgaleKlMi+2WPNoA/oRk0Q1FhVJKJ9Np4b0XPBbM/a4q
        3KggS8gd/tdaglNNe7c3jBs=
X-Google-Smtp-Source: APXvYqymSht+gVaRpGyNWmr8RvtKFjssdPg5T1XwNwmkrkH8dqW7v9Ze3CEoWeOOwbN6OmbGCYtqLQ==
X-Received: by 2002:a7b:ca42:: with SMTP id m2mr1980359wml.35.1557392494819;
        Thu, 09 May 2019 02:01:34 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s3sm1882325wre.97.2019.05.09.02.01.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 02:01:33 -0700 (PDT)
Date:   Thu, 9 May 2019 11:01:31 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Yury Norov <ynorov@marvell.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mm: Clean up the __[PHYSICAL/VIRTUAL]_MASK_SHIFT
 definitions a bit
Message-ID: <20190509090131.GA130570@gmail.com>
References: <20190508204411.13452-1-ynorov@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508204411.13452-1-ynorov@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Yury Norov <yury.norov@gmail.com> wrote:

> __VIRTUAL_MASK_SHIFT is defined twice to the same valie in
> arch/x86/include/asm/page_32_types.h. Fix it.
> 
> Signed-off-by: Yury Norov <ynorov@marvell.com>
> ---
>  arch/x86/include/asm/page_32_types.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/page_32_types.h b/arch/x86/include/asm/page_32_types.h
> index 0d5c739eebd7..9bfac5c80d89 100644
> --- a/arch/x86/include/asm/page_32_types.h
> +++ b/arch/x86/include/asm/page_32_types.h
> @@ -28,6 +28,8 @@
>  #define MCE_STACK 0
>  #define N_EXCEPTION_STACKS 1
>  
> +#define __VIRTUAL_MASK_SHIFT	32
> +
>  #ifdef CONFIG_X86_PAE
>  /*
>   * This is beyond the 44 bit limit imposed by the 32bit long pfns,
> @@ -36,11 +38,8 @@
>   * The real limit is still 44 bits.
>   */
>  #define __PHYSICAL_MASK_SHIFT	52
> -#define __VIRTUAL_MASK_SHIFT	32
> -
>  #else  /* !CONFIG_X86_PAE */
>  #define __PHYSICAL_MASK_SHIFT	32
> -#define __VIRTUAL_MASK_SHIFT	32
>  #endif	/* CONFIG_X86_PAE */

I think it's clearer to see them defined where the physical mask shift is 
defined.

How about the patch below? It does away with the weird formatting and 
cleans up both the comments and the style of the definition:

/*
 * 52 bits on PAE is beyond the 44-bit limit imposed by the
 * 32-bit long PFNs, but we need the full mask to make sure
 * inverted PROT_NONE entries have all the host bits set
 * in a guest. The real limit is still 44 bits.
 */
#ifdef CONFIG_X86_PAE
# define __PHYSICAL_MASK_SHIFT	52
# define __VIRTUAL_MASK_SHIFT	32
#else
# define __PHYSICAL_MASK_SHIFT	32
# define __VIRTUAL_MASK_SHIFT	32
#endif

?

Thanks,

	Ingo

===============>
From: Ingo Molnar <mingo@kernel.org>
Date: Thu, 9 May 2019 10:59:44 +0200
Subject: [PATCH] x86/mm: Clean up the __[PHYSICAL/VIRTUAL]_MASK_SHIFT definitions a bit

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/page_32_types.h | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/page_32_types.h b/arch/x86/include/asm/page_32_types.h
index 565ad755c785..009e96d4b6d4 100644
--- a/arch/x86/include/asm/page_32_types.h
+++ b/arch/x86/include/asm/page_32_types.h
@@ -26,20 +26,19 @@
 
 #define N_EXCEPTION_STACKS	1
 
-#ifdef CONFIG_X86_PAE
 /*
- * This is beyond the 44 bit limit imposed by the 32bit long pfns,
- * but we need the full mask to make sure inverted PROT_NONE
- * entries have all the host bits set in a guest.
- * The real limit is still 44 bits.
+ * 52 bits on PAE is beyond the 44-bit limit imposed by the
+ * 32-bit long PFNs, but we need the full mask to make sure
+ * inverted PROT_NONE entries have all the host bits set
+ * in a guest. The real limit is still 44 bits.
  */
-#define __PHYSICAL_MASK_SHIFT	52
-#define __VIRTUAL_MASK_SHIFT	32
-
-#else  /* !CONFIG_X86_PAE */
-#define __PHYSICAL_MASK_SHIFT	32
-#define __VIRTUAL_MASK_SHIFT	32
-#endif	/* CONFIG_X86_PAE */
+#ifdef CONFIG_X86_PAE
+# define __PHYSICAL_MASK_SHIFT	52
+# define __VIRTUAL_MASK_SHIFT	32
+#else
+# define __PHYSICAL_MASK_SHIFT	32
+# define __VIRTUAL_MASK_SHIFT	32
+#endif
 
 /*
  * Kernel image size is limited to 512 MB (see in arch/x86/kernel/head_32.S)

