Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43A6C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A0E20679
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pPN6yXoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfG2Jnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 05:43:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44646 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbfG2Jnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 05:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bVzta0BJYrJudw8AwRhFwUnSytnSHUT+J8mdnn5TxzU=; b=pPN6yXoC0TkroJbJB2/F6SDvM
        LTj+TZpnHQST8RlEOXcv1gNm7h2Nj9/bN0B9AYu7fOnbvMuzjT2Dm1Iewyx9cgZLtp1HT4mETjOeD
        QjPpa4+JmFskOFY7C4o7ZufxBIWbWcq6FIWOjBiBprxmnXr3JtWuL++kk6/X3tCGl0/F+8ubeeIuJ
        Qp6lqetBqzH13i81En8P31P7lWkc+gRSzHVDdCbf88khDvHZOxs98rWIOuDY4uLIL/82k28O9Rant
        sbyx+s2lCw18h+WQg3fhxxE49mp3TlUklVaFVKRyXuSVihs4WAAVYTDRwpxrKzahMo1GPwy35ZUhE
        HeIcZ8YPA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs2Bn-00009C-UY; Mon, 29 Jul 2019 09:43:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 93F622025E7A9; Mon, 29 Jul 2019 11:43:29 +0200 (CEST)
Date:   Mon, 29 Jul 2019 11:43:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: drop REG_OUT macro from hweight functions
Message-ID: <20190729094329.GW31381@hirez.programming.kicks-ass.net>
References: <20190728115140.GA32463@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728115140.GA32463@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 02:51:40PM +0300, Alexey Dobriyan wrote:
> Output register is always RAX/EAX.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  arch/x86/include/asm/arch_hweight.h |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> --- a/arch/x86/include/asm/arch_hweight.h
> +++ b/arch/x86/include/asm/arch_hweight.h
> @@ -6,10 +6,8 @@
>  
>  #ifdef CONFIG_64BIT
>  #define REG_IN "D"
> -#define REG_OUT "a"
>  #else
>  #define REG_IN "a"
> -#define REG_OUT "a"
>  #endif
>  
>  static __always_inline unsigned int __arch_hweight32(unsigned int w)
> @@ -17,7 +15,7 @@ static __always_inline unsigned int __arch_hweight32(unsigned int w)
>  	unsigned int res;
>  
>  	asm (ALTERNATIVE("call __sw_hweight32", "popcntl %1, %0", X86_FEATURE_POPCNT)
> -			 : "="REG_OUT (res)
> +			 : "=a" (res)
>  			 : REG_IN (w));
>  
>  	return res;
> @@ -45,7 +43,7 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
>  	unsigned long res;
>  
>  	asm (ALTERNATIVE("call __sw_hweight64", "popcntq %1, %0", X86_FEATURE_POPCNT)
> -			 : "="REG_OUT (res)
> +			 : "=a" (res)
>  			 : REG_IN (w));
>  
>  	return res;

I _think_ something like the below should also work:

(fwiw _ASM_ARG 5 and 6 are broken, as are all the QLWB variants)

---
diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
index ba88edd0d58b..88704612b2f7 100644
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
+			 : _ASM_ARG1 (w));
 
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
