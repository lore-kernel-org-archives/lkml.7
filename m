Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797C5C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46697206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PJ8/+ox2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfG2KEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 06:04:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50186 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfG2KEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bVrlXLTKjzQSrCNbyRFlcQ9T4V/M3MWibCOzfM4QNPw=; b=PJ8/+ox28kUya6Uv3tkBtkFyO
        2Rlsaep34YBsQKZuZAMOQx8NVTH0BZpscj74VkHWZ2rhzFz7qpUFrlFGVQqqTboti0XpThDGeNGVm
        MQ4GuWHGlSZbiwaApIBH2IFjgvg5qBbXqzbquoxEZiL1qxWCFH5UH1iztjljSyvKR72sN8ds/Irwp
        aKEnzxYgof5adDUR+4FgCaalprWb/egrMxjR93TPTtsT5/Ozsv6FJzTQeDwvzX+Ve7pnpZSKIVawz
        +bPWvPHe5ikaLPbtziSK9VFsLIdnzMzPGIfny7Lg4I++HVA8eXxTnBhPIqZdqrDLq3MeKxxnP8euC
        0v/WxCZew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs2WP-0005UM-79; Mon, 29 Jul 2019 10:04:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F5C32025E7A9; Mon, 29 Jul 2019 12:04:47 +0200 (CEST)
Date:   Mon, 29 Jul 2019 12:04:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: drop REG_OUT macro from hweight functions
Message-ID: <20190729100447.GD31425@hirez.programming.kicks-ass.net>
References: <20190728115140.GA32463@avx2>
 <20190729094329.GW31381@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729094329.GW31381@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 11:43:29AM +0200, Peter Zijlstra wrote:

> I _think_ something like the below should also work:
> 
> (fwiw _ASM_ARG 5 and 6 are broken, as are all the QLWB variants)

Fixed that, because

> ---
> diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
> index ba88edd0d58b..88704612b2f7 100644
> --- a/arch/x86/include/asm/arch_hweight.h
> +++ b/arch/x86/include/asm/arch_hweight.h
> @@ -3,22 +3,15 @@
>  #define _ASM_X86_HWEIGHT_H
>  
>  #include <asm/cpufeatures.h>
> -
> -#ifdef CONFIG_64BIT
> -#define REG_IN "D"
> -#define REG_OUT "a"
> -#else
> -#define REG_IN "a"
> -#define REG_OUT "a"
> -#endif
> +#include <asm/asm.h>
>  
>  static __always_inline unsigned int __arch_hweight32(unsigned int w)
>  {
>  	unsigned int res;
>  
>  	asm (ALTERNATIVE("call __sw_hweight32", "popcntl %1, %0", X86_FEATURE_POPCNT)
> -			 : "="REG_OUT (res)
> -			 : REG_IN (w));
> +			 : "=a" (res)
> +			 : _ASM_ARG1 (w));

That needs _ASM_ARG1L because popcntl..

---
diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
index ba88edd0d58b..3cab7f382a43 100644
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -3,22 +3,15 @@
 #define _ASM_X86_HWEIGHT_H
 
 #include <asm/cpufeatures.h>
-
-#ifdef CONFIG_64BIT
-#define REG_IN "D"
-#define REG_OUT "a"
-#else
-#define REG_IN "a"
-#define REG_OUT "a"
-#endif
+#include <asm/asm.h>
 
 static __always_inline unsigned int __arch_hweight32(unsigned int w)
 {
 	unsigned int res;
 
 	asm (ALTERNATIVE("call __sw_hweight32", "popcntl %1, %0", X86_FEATURE_POPCNT)
-			 : "="REG_OUT (res)
-			 : REG_IN (w));
+			 : "=a" (res)
+			 : _ASM_ARG1L (w));
 
 	return res;
 }
@@ -45,8 +38,8 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 	unsigned long res;
 
 	asm (ALTERNATIVE("call __sw_hweight64", "popcntq %1, %0", X86_FEATURE_POPCNT)
-			 : "="REG_OUT (res)
-			 : REG_IN (w));
+			 : "=a" (res)
+			 : _ASM_ARG1 (w));
 
 	return res;
 }
diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 3ff577c0b102..0bb0bbcd4551 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -53,17 +53,17 @@
 #define _ASM_ARG2	_ASM_DX
 #define _ASM_ARG3	_ASM_CX
 
-#define _ASM_ARG1L	eax
-#define _ASM_ARG2L	edx
-#define _ASM_ARG3L	ecx
+#define _ASM_ARG1L	_ASM_ARG1
+#define _ASM_ARG2L	_ASM_ARG2
+#define _ASM_ARG3L	_ASM_ARG3
 
-#define _ASM_ARG1W	ax
-#define _ASM_ARG2W	dx
-#define _ASM_ARG3W	cx
+#define _ASM_ARG1W	__ASM_FORM_RAW(ax)
+#define _ASM_ARG2W	__ASM_FORM_RAW(dx)
+#define _ASM_ARG3W	__ASM_FORM_RAW(cx)
 
-#define _ASM_ARG1B	al
-#define _ASM_ARG2B	dl
-#define _ASM_ARG3B	cl
+#define _ASM_ARG1B	__ASM_FORM_RAW(al)
+#define _ASM_ARG2B	__ASM_FORM_RAW(dl)
+#define _ASM_ARG3B	__ASM_FORM_RAW(cl)
 
 #else
 /* 64 bit */
@@ -72,36 +72,29 @@
 #define _ASM_ARG2	_ASM_SI
 #define _ASM_ARG3	_ASM_DX
 #define _ASM_ARG4	_ASM_CX
-#define _ASM_ARG5	r8
-#define _ASM_ARG6	r9
-
-#define _ASM_ARG1Q	rdi
-#define _ASM_ARG2Q	rsi
-#define _ASM_ARG3Q	rdx
-#define _ASM_ARG4Q	rcx
-#define _ASM_ARG5Q	r8
-#define _ASM_ARG6Q	r9
-
-#define _ASM_ARG1L	edi
-#define _ASM_ARG2L	esi
-#define _ASM_ARG3L	edx
-#define _ASM_ARG4L	ecx
-#define _ASM_ARG5L	r8d
-#define _ASM_ARG6L	r9d
-
-#define _ASM_ARG1W	di
-#define _ASM_ARG2W	si
-#define _ASM_ARG3W	dx
-#define _ASM_ARG4W	cx
-#define _ASM_ARG5W	r8w
-#define _ASM_ARG6W	r9w
-
-#define _ASM_ARG1B	dil
-#define _ASM_ARG2B	sil
-#define _ASM_ARG3B	dl
-#define _ASM_ARG4B	cl
-#define _ASM_ARG5B	r8b
-#define _ASM_ARG6B	r9b
+#define _ASM_ARG5	__ASM_REG(8)
+#define _ASM_ARG6	__ASM_REG(9)
+
+#define _ASM_ARG1L	__ASM_FORM_RAW(edi)
+#define _ASM_ARG2L	__ASM_FORM_RAW(esi)
+#define _ASM_ARG3L	__ASM_FORM_RAW(edx)
+#define _ASM_ARG4L	__ASM_FORM_RAW(ecx)
+#define _ASM_ARG5L	__ASM_FORM_RAW(r8d)
+#define _ASM_ARG6L	__ASM_FORM_RAW(r9d)
+
+#define _ASM_ARG1W	__ASM_FORM_RAW(di)
+#define _ASM_ARG2W	__ASM_FORM_RAW(si)
+#define _ASM_ARG3W	__ASM_FORM_RAW(dx)
+#define _ASM_ARG4W	__ASM_FORM_RAW(cx)
+#define _ASM_ARG5W	__ASM_FORM_RAW(r8w)
+#define _ASM_ARG6W	__ASM_FORM_RAW(r9w)
+
+#define _ASM_ARG1B	__ASM_FORM_RAW(dil)
+#define _ASM_ARG2B	__ASM_FORM_RAW(sil)
+#define _ASM_ARG3B	__ASM_FORM_RAW(dl)
+#define _ASM_ARG4B	__ASM_FORM_RAW(cl)
+#define _ASM_ARG5B	__ASM_FORM_RAW(r8b)
+#define _ASM_ARG6B	__ASM_FORM_RAW(r9b)
 
 #endif
 
