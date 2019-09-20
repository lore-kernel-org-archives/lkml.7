Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B765C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4982086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jPvq1xo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404178AbfITQUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:20:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42416 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387644AbfITQUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:20:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id q12so4833679pff.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vlNGfK1QkeKihZ4C4Tfs64KHadfyM3q44e2VI4eyD3A=;
        b=jPvq1xo2VKxr3BDR3r7JrBL+WPTyholNKVawQB0EIuY3oOAFbxYM/uA5HMC2fbYkic
         N+WbDQvIvyuzqCIEBZvdePa9S1vqkH6K2m+EW/LDDM5YxksbqG7BltCluuCjXA8C6rA7
         oHUFuiqrNcCKpzeBNyoIFf5CiOpQ7mWVH8K4LjuMdP+70bqDaHmnZ0Meec8zRHOKfRHW
         WkfhMJuUv5shwWw4+4MZYjOsBWWfUVi91S2tVPqfkpzmI25/3+lVsKK8NU8bZ3jTRK1Q
         VmeH6eXJojh3Y3TPr80WtGaHCxT9hYoF2HjqaXLkg8KcbvcmXvsnsKXNp1G8WPXDWFwI
         GALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vlNGfK1QkeKihZ4C4Tfs64KHadfyM3q44e2VI4eyD3A=;
        b=HK6s1l4ckytEVddhKjFyTa5eoE44+oA23LgLepVAr6w6f/c15jKD07IVY9/PQ0Zf6A
         6j6NJYIfocuW4fR9XAkoFxy28JGzq/68poM8jKPX5dB2WUASs28SuahMTdrrReay3o8c
         ojzSsMv9aaYRSIEvGXERbzRRuJvLOaJF5+dAeyiOpWJwWDpRZcFvo16UhkUtip4PsGQ+
         qvJafnHntOB/0ArK38QzQrG8GUUzBU9cqZvGd/Lk7ys4QztyJfovuplxqPzAq4Ha4FCs
         oEbCzeD0HU1duA1oBxH4p40jPPetIxupffxHmge+t/xuHjHwfFbLLpk7ADbzxFqJbtDa
         JdkQ==
X-Gm-Message-State: APjAAAX1iHLif5D2h6NTy75IMCruxPJOFjH85YC+U5qhYAAQyywPTrAS
        HeHhj1G+AtjiTGvD6NkbyQ8SeEtLEi2KqNWJd22Chg==
X-Google-Smtp-Source: APXvYqwrqKTqYsi8OR1VdueDkW2Mi43aJ5Pj88pR9RVaDL1ha76c1BEGk/C9C4FKe3KucmQ34BVGRHYWuJyH1TnFXko=
X-Received: by 2002:a17:90a:ff18:: with SMTP id ce24mr5537560pjb.123.1568996432715;
 Fri, 20 Sep 2019 09:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190920153951.25762-1-ilie.halip@gmail.com>
In-Reply-To: <20190920153951.25762-1-ilie.halip@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 20 Sep 2019 09:20:20 -0700
Message-ID: <CAKwvOdkvrRgQ7KtGag0yDH+ry7a6=pd5xudrNm9X+5oVu2Z20A@mail.gmail.com>
Subject: Re: [PATCH] powerpc/pmac/smp: avoid unused-variable warnings
To:     Ilie Halip <ilie.halip@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 8:41 AM Ilie Halip <ilie.halip@gmail.com> wrote:
>
> When building with ppc64_defconfig, the compiler reports
> that these 2 variables are not used:
>     warning: unused variable 'core99_l2_cache' [-Wunused-variable]
>     warning: unused variable 'core99_l3_cache' [-Wunused-variable]
>
> They are only used when CONFIG_PPC64 is not defined. Move
> them into a section which does the same macro check.
>
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Ilie Halip <ilie.halip@gmail.com>

Hi Ilie, thanks for the patch.  LGTM (Please include link tags if your
link addresses a bug in our bug tracker; it helps us track where/when
patches land, in case they need to be backported).
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/663

> ---
>  arch/powerpc/platforms/powermac/smp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
> index f95fbdee6efe..e44c606f119e 100644
> --- a/arch/powerpc/platforms/powermac/smp.c
> +++ b/arch/powerpc/platforms/powermac/smp.c
> @@ -648,6 +648,10 @@ static void smp_core99_pfunc_tb_freeze(int freeze)
>
>  static unsigned int core99_tb_gpio;    /* Timebase freeze GPIO */
>
> +/* L2 and L3 cache settings to pass from CPU0 to CPU1 on G4 cpus */
> +volatile static long int core99_l2_cache;
> +volatile static long int core99_l3_cache;
> +
>  static void smp_core99_gpio_tb_freeze(int freeze)
>  {
>         if (freeze)
> @@ -660,10 +664,6 @@ static void smp_core99_gpio_tb_freeze(int freeze)
>
>  #endif /* !CONFIG_PPC64 */
>
> -/* L2 and L3 cache settings to pass from CPU0 to CPU1 on G4 cpus */
> -volatile static long int core99_l2_cache;
> -volatile static long int core99_l3_cache;
> -
>  static void core99_init_caches(int cpu)
>  {
>  #ifndef CONFIG_PPC64
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20190920153951.25762-1-ilie.halip%40gmail.com.



-- 
Thanks,
~Nick Desaulniers
