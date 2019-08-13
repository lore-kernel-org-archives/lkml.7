Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E92EC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 20:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE6120665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 20:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FNpL+MFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfHMUnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 16:43:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44531 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfHMUnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 16:43:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id c81so3255776pfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 13:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wedeTRt18LF5MmeSQANDHDmPkQrZQasBte+17UN0Uok=;
        b=FNpL+MFoqL+CcbHGv3P3AIhLuDCKtOB3CCpbeOGWU5vhyTaCG9qwLCYvaz6mUgbR43
         9xMtJAuL9M3SuJ0+Qpk5iAA1D4ghWpwCAPgSvp16oH29zAme0N1tfz0OKvmvg1NLjyws
         eF7Gd21hpRW+x0sxix7tGlh5f3/LDDqCCtNk1YzSfXbtKPBexB3yAT1bFw1P4iJnPZb1
         cbESvgGTDDDa2ZyEFZCqe5vtrtBLAVNSSteMU0wp9Cte58POwIFnn05tfFj5d7GDB/WX
         ZkSmGyLjt8X0gmWR2u2E1MVP8h8QgNAXM4eEQP2fhaMI5LQAeV421Z7zLEen1D4tmeDm
         ABKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wedeTRt18LF5MmeSQANDHDmPkQrZQasBte+17UN0Uok=;
        b=NmBPd9bC7/sgapeyh/ZKRe/H4ZpDuqj3TGBIdnPvc5p/Ql4jQa0sedexg5sFwADFen
         SmqJ6x+eyTskdHloIvlUOWgua8JrKeA4g8LCE6NpX8sQGdzRpVrlZRxdRB6Htuf60Z+A
         UZ+53FHg2pR8zbqDoBmQG2qNsN3bbOLP/Cco0c0/CGdL9Ryd4LBeoEwOv1diPNffFa7K
         fkHbgr9Wr+FvmNewNVDLPxN4oWFBJdeDWsQdyaOgCWll8ZT/1gTk0AFjZa/RTMLr3ZvZ
         mbhYbHVqyONe/R12XKL2Q8L0JC+fmMXAilTyyx3k3sACg8+LOOoPqMbctgYO9hVrwERy
         l15w==
X-Gm-Message-State: APjAAAXdWg7CV46f8pnCIttOFjzPYvhHNH4ukmf8r5SXJW/BcKYXPI2w
        hnMp/rGejyOhsccp2aesT76ksww6A4aM3HcK4cUtWQ==
X-Google-Smtp-Source: APXvYqxhtzYE0QLYkYDVy2cD7X7/qEOHczJKl5d7ACHw1m+SOe+brERicZvIdCM8ZZTtSbo171hwe2clAfFqC+rqRLs=
X-Received: by 2002:a17:90a:ac02:: with SMTP id o2mr3955419pjq.134.1565728994589;
 Tue, 13 Aug 2019 13:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdkAJcOCGvveBYaDD2kf4vx7m=b+Nxyn3_n=9aCBapzDcw@mail.gmail.com>
 <20190813173448.109859-1-nhuck@google.com>
In-Reply-To: <20190813173448.109859-1-nhuck@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 13 Aug 2019 13:43:03 -0700
Message-ID: <CAKwvOdmFc3RfHMVxdym9upmck=h6AnNW58ho+0ferOUVkaxajw@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: mv_xor_v2: Fix -Wshift-negative-value
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 10:35 AM 'Nathan Huckleberry' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> Clang produces the following warning
>
> drivers/dma/mv_xor_v2.c:264:40: warning: shifting a negative signed value
>         is undefined [-Wshift-negative-value]
>         reg &= (~MV_XOR_V2_DMA_IMSG_THRD_MASK <<
>         MV_XOR_V2_DMA_IMSG_THRD_SHIFT);
>                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
> drivers/dma/mv_xor_v2.c:271:46: warning: shifting a negative signed value
>         is undefined [-Wshift-negative-value]
>         reg &= (~MV_XOR_V2_DMA_IMSG_TIMER_THRD_MASK <<
>                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
>
> Upon further investigation MV_XOR_V2_DMA_IMSG_THRD_SHIFT and
> MV_XOR_V2_DMA_IMSG_TIMER_THRD_SHIFT are both 0. Since shifting by 0 does
> nothing, these variables can be removed.
>
> Cc: clang-built-linux@googlegroups.com
> Link: https://github.com/ClangBuiltLinux/linux/issues/521
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>

Thanks for sending a v2:
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/dma/mv_xor_v2.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
> index fa5dab481203..e3850f04f676 100644
> --- a/drivers/dma/mv_xor_v2.c
> +++ b/drivers/dma/mv_xor_v2.c
> @@ -33,7 +33,6 @@
>  #define MV_XOR_V2_DMA_IMSG_CDAT_OFF                    0x014
>  #define MV_XOR_V2_DMA_IMSG_THRD_OFF                    0x018
>  #define   MV_XOR_V2_DMA_IMSG_THRD_MASK                 0x7FFF
> -#define   MV_XOR_V2_DMA_IMSG_THRD_SHIFT                        0x0
>  #define   MV_XOR_V2_DMA_IMSG_TIMER_EN                  BIT(18)
>  #define MV_XOR_V2_DMA_DESQ_AWATTR_OFF                  0x01C
>    /* Same flags as MV_XOR_V2_DMA_DESQ_ARATTR_OFF */
> @@ -50,7 +49,6 @@
>  #define MV_XOR_V2_DMA_DESQ_ADD_OFF                     0x808
>  #define MV_XOR_V2_DMA_IMSG_TMOT                                0x810
>  #define   MV_XOR_V2_DMA_IMSG_TIMER_THRD_MASK           0x1FFF
> -#define   MV_XOR_V2_DMA_IMSG_TIMER_THRD_SHIFT          0
>
>  /* XOR Global registers */
>  #define MV_XOR_V2_GLOB_BW_CTRL                         0x4
> @@ -261,16 +259,15 @@ void mv_xor_v2_enable_imsg_thrd(struct mv_xor_v2_device *xor_dev)
>
>         /* Configure threshold of number of descriptors, and enable timer */
>         reg = readl(xor_dev->dma_base + MV_XOR_V2_DMA_IMSG_THRD_OFF);
> -       reg &= (~MV_XOR_V2_DMA_IMSG_THRD_MASK << MV_XOR_V2_DMA_IMSG_THRD_SHIFT);
> -       reg |= (MV_XOR_V2_DONE_IMSG_THRD << MV_XOR_V2_DMA_IMSG_THRD_SHIFT);
> +       reg &= ~MV_XOR_V2_DMA_IMSG_THRD_MASK;
> +       reg |= MV_XOR_V2_DONE_IMSG_THRD;
>         reg |= MV_XOR_V2_DMA_IMSG_TIMER_EN;
>         writel(reg, xor_dev->dma_base + MV_XOR_V2_DMA_IMSG_THRD_OFF);
>
>         /* Configure Timer Threshold */
>         reg = readl(xor_dev->dma_base + MV_XOR_V2_DMA_IMSG_TMOT);
> -       reg &= (~MV_XOR_V2_DMA_IMSG_TIMER_THRD_MASK <<
> -               MV_XOR_V2_DMA_IMSG_TIMER_THRD_SHIFT);
> -       reg |= (MV_XOR_V2_TIMER_THRD << MV_XOR_V2_DMA_IMSG_TIMER_THRD_SHIFT);
> +       reg &= ~MV_XOR_V2_DMA_IMSG_TIMER_THRD_MASK;
> +       reg |= MV_XOR_V2_TIMER_THRD;
>         writel(reg, xor_dev->dma_base + MV_XOR_V2_DMA_IMSG_TMOT);
>  }
>
> --
> 2.23.0.rc1.153.gdeed80330f-goog
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20190813173448.109859-1-nhuck%40google.com.



-- 
Thanks,
~Nick Desaulniers
