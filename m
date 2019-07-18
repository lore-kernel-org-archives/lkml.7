Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFBFC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D105C208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A/Jgq0UA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391484AbfGRVXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 17:23:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35187 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbfGRVXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 17:23:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id s1so7147037pgr.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 14:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qMusGExo/4n7tjYsdiRBxr2+eOsOxIvhg6GNsS6h/VU=;
        b=A/Jgq0UAId/tqrsgZ3n1oD1nwV+a4MytDfdNUhZbeJiRzMgPMGwA7oTedadzpGMHCT
         I9avxhIhWrbv0g09wgtISjzsthyBB5qsmvMPQJhsBvcYgvCqtldjQ8chLXFhrm/bFlz+
         NQQOdK26pfln6Kk9uL8zfFiEyh3jl2dasIFvzdjLMuCjLxhc0Moh2XgiPUje/ijlixiT
         CDeiyvWJDxMF3HYysXZ134jGDPkxu83cgTNMMUMeHDbFFpQ06cy12c47RUzxUGliIYCM
         Xcbn7WQGW/+UKVFoE0g5CM3TOO8EM6oMCoHr5t1mdBCyLdw+8YzvcG9fv3Kc0PCO2Ib5
         9FPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMusGExo/4n7tjYsdiRBxr2+eOsOxIvhg6GNsS6h/VU=;
        b=Zz2qxbTSm32I/SH9CKvAbJAchsRlmBmhf5XGcnmRsAW3JXuLM94mLfXaXdRLjuwwGR
         m1JSmcdcccQFkZmToqXMaF3q9pDT4uhFfyS4O0cnJEkRIFNeKQinVve+4YDVZTV0pKVc
         7ldBC9MarW0xq2gtDlssvPzAE5r/onG5NNLenZoDXwpEPgWbTdIkGRtY3G42ktisJkp5
         Lm70ivsx7wCEpB7hfey4N2aps6oUH7xkbEPa49l4/lU1PwMKoe5Bh6FD9oPW0sWrs0EW
         k3iUYU+7ACwwPXazdgwkZIFLVGZY8gauHxEnFGqIFdFpcDhnwhmr5l4lEU9x2UbDWKOk
         ao7g==
X-Gm-Message-State: APjAAAVyQZwdyaVokj+W4moWPldMRT82y0cgP7yPGiAs20EoiZetwHVX
        J5+7zKhFjRnwfWXBVsnNBkIL3/+dUlWqbD1+k8VZUw==
X-Google-Smtp-Source: APXvYqxDZUBzH3HKrxpUAhL/zKBxCHCsy2uwkURdpVBA6Sf7UmRSy+3v2QdQc9xur5HS5uQ+FGNdozTxhr5JyvPEtK0=
X-Received: by 2002:a63:2cd1:: with SMTP id s200mr46339342pgs.10.1563485021175;
 Thu, 18 Jul 2019 14:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190718141652.3323402-1-arnd@arndb.de>
In-Reply-To: <20190718141652.3323402-1-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 Jul 2019 14:23:30 -0700
Message-ID: <CAKwvOdnEnsVOu+kJUF8=pppAZ7=nSBe6a-nZdnChH_YmhA-jcg@mail.gmail.com>
Subject: Re: [PATCH] media: vivid: work around high stack usage with clang
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Johan Korsnes <johan.korsnes@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Gabriel Francisco Mandaji <gfmandaji@gmail.com>,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 7:16 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Building a KASAN-enabled kernel with clang ends up in a case where too
> much is inlined into vivid_thread_vid_cap() and the stack usage grows
> a lot, possibly when the register allocation fails to produce efficient
> code and spills a lot of temporaries to the stack. This uses more
> than twice the amount of stack than the sum of the individual functions
> when they are not inlined:
>
> drivers/media/platform/vivid/vivid-kthread-cap.c:766:12: error: stack frame size of 2208 bytes in function 'vivid_thread_vid_cap' [-Werror,-Wframe-larger-than=]
>
> Marking two of the key functions in here as 'noinline_for_stack' avoids
> the pathological case in clang without any apparent downside for gcc.

Thanks for the patch, should be one less warning for CI.
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Not sure how much effort we want to put into fixing clang to not
> get into this case. I could open an llvm bug report if something
> thinks this has a chance of getting fixed there.
> ---
>  drivers/media/platform/vivid/vivid-kthread-cap.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/platform/vivid/vivid-kthread-cap.c b/drivers/media/platform/vivid/vivid-kthread-cap.c
> index 6cf495a7d5cc..4f94897e6303 100644
> --- a/drivers/media/platform/vivid/vivid-kthread-cap.c
> +++ b/drivers/media/platform/vivid/vivid-kthread-cap.c
> @@ -232,8 +232,8 @@ static void *plane_vaddr(struct tpg_data *tpg, struct vivid_buffer *buf,
>         return vbuf;
>  }
>
> -static int vivid_copy_buffer(struct vivid_dev *dev, unsigned p, u8 *vcapbuf,
> -               struct vivid_buffer *vid_cap_buf)
> +static noinline_for_stack int vivid_copy_buffer(struct vivid_dev *dev, unsigned p,
> +               u8 *vcapbuf, struct vivid_buffer *vid_cap_buf)
>  {
>         bool blank = dev->must_blank[vid_cap_buf->vb.vb2_buf.index];
>         struct tpg_data *tpg = &dev->tpg;
> @@ -670,7 +670,8 @@ static void vivid_cap_update_frame_period(struct vivid_dev *dev)
>         dev->cap_frame_period = f_period;
>  }
>
> -static void vivid_thread_vid_cap_tick(struct vivid_dev *dev, int dropped_bufs)
> +static noinline_for_stack void vivid_thread_vid_cap_tick(struct vivid_dev *dev,
> +                                                        int dropped_bufs)
>  {
>         struct vivid_buffer *vid_cap_buf = NULL;
>         struct vivid_buffer *vbi_cap_buf = NULL;
> --
> 2.20.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20190718141652.3323402-1-arnd%40arndb.de.



-- 
Thanks,
~Nick Desaulniers
