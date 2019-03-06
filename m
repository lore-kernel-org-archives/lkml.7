Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B97BC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4451820661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbfCFUDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:03:00 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52198 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfCFUDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:03:00 -0500
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h1cka-0003yB-9H; Wed, 06 Mar 2019 21:02:48 +0100
Date:   Wed, 6 Mar 2019 21:02:47 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Louis Taylor <louis@kragniz.eu>
cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        fanc.fnst@cn.fujitsu.com, bhe@redhat.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, ndesaulniers@google.com,
        jflat@chromium.org
Subject: Re: [PATCH] x86/KASLR: always return a value from
 process_mem_region
In-Reply-To: <20190302184929.28971-1-louis@kragniz.eu>
Message-ID: <alpine.DEB.2.21.1903062059570.1646@nanos.tec.linutronix.de>
References: <20190302184929.28971-1-louis@kragniz.eu>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Louis,

On Sat, 2 Mar 2019, Louis Taylor wrote:

> When compiling with -Wreturn-type, clang warns:
> 
> arch/x86/boot/compressed/kaslr.c:704:1: warning: control may reach end of
>       non-void function [-Wreturn-type]
> 
> This function's return statement should probably have been placed
> outside the #endif, so move it there
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/360
> Signed-off-by: Louis Taylor <louis@kragniz.eu>

This lacks a

Fixes: commitsha1 (".....")

tag

>  arch/x86/boot/compressed/kaslr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index fa0332dda9f2..2e53c056ba20 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -697,8 +697,8 @@ static bool process_mem_region(struct mem_vector *region,
>  			return 1;
>  		}
>  	}
> -	return 0;
>  #endif
> +	return 0;
>  }

This does not longer apply to mainline because the function does not longer
have a return value. So if that's important, you need to hash that out with
the stable folks.

Thanks,

	tglx
