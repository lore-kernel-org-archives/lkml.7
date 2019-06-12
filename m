Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A47C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9021206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q5HV6uR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbfFMRCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:02:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45166 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729523AbfFLXOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 19:14:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id s11so10520394pfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 16:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hpdxxdnECrCjfxRQwQAXITDsXaRY4S9Y8qNe9cxvook=;
        b=q5HV6uR0qU8gfYERpbtgOXiB16bdDKZqjJ8yqVAfRUsCVrr5UW/VXIBUMalc8kGJ8e
         SW7vyN8ZLRzUsDrmlPCeMSaqxOd8NAk8riv426uuleJQLBjjdTxd6ru4CW97jxqxoNj0
         pcIfFYgGvVNX3u0Fayt2GCS0cMD2hUYzwXOQ6Icz4dsJaconOW9atwDICfo6tWeujct9
         +411xP5ry8xLiW2r1AhVFPkoCcKzJa0MaXshle9M8188Eo/h3VW4RprwrwerqSKSq7Lt
         3J7LbbB9FVNZp3WJm5sKC7P3Ic8etu9+CgIvgCmarryYcQLvbtzVS5rNackF2tSbrJfR
         E78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hpdxxdnECrCjfxRQwQAXITDsXaRY4S9Y8qNe9cxvook=;
        b=hcIyYlmkG09ksaY1PQiY9aPaS/7VV8m7s+H33lmtykscOsYO4XgzBPahTYEN8t8p+n
         pI1s/5+ZABjG9XA2X019jrOheLzbnqibd3l+oesOVPuUPykcF7kiSD2+4LQ8wbtBAeaw
         yObBLDtsLphwVajvwearvVpm40eZlNFohTJnXggsD8k8b2C8yEh1dkW1MvovjbzYp/Wl
         VmQRIF/9ykLRr4rt3LGK7KDThZtG2YyULQGrhLmZe38Ya278Nyqi8yLf+H4eLOBo/6Ef
         Oxgc1nVKgO8GuoopiUSYPfCYDCv6mwQ+TxUZk7AyzrS1wqil3nxHU+5sdVasyyh544iK
         mT0w==
X-Gm-Message-State: APjAAAWlIiDka7XfaiQ47IYx6DRpsVYIhKsU5OZwGV4KesjseAMUhJwQ
        e4dtGT1ch4pRpSx/NS1FGBbWfAdxnuFNu4X68ESI5Q==
X-Google-Smtp-Source: APXvYqztz5V4dpKFE1Y8iXl/I0qdlviNE8GgjRikSDpqDKtChZ+KTIWt5CleNZQU3O9ZT60wDef+zNwlYot5W099IjY=
X-Received: by 2002:a17:90a:2488:: with SMTP id i8mr1547499pje.123.1560381277880;
 Wed, 12 Jun 2019 16:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190612225419.241618-1-nhuck@google.com>
In-Reply-To: <20190612225419.241618-1-nhuck@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 12 Jun 2019 16:14:26 -0700
Message-ID: <CAKwvOdkAJcOCGvveBYaDD2kf4vx7m=b+Nxyn3_n=9aCBapzDcw@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: mv_xor_v2: Fix -Wshift-negative-value
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 3:54 PM 'Nathan Huckleberry' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
> Upon further investigation MV_XOR_V2_DMA_IMSG_THRD_SHIFT and
> MV_XOR_V2_DMA_IMSG_TIMER_THRD_SHIFT are both 0. Since shifting by 0 does
> nothing, these variables can be removed.
>
> Cc: clang-built-linux@googlegroups.com
> Link: https://github.com/ClangBuiltLinux/linux/issues/521
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> ---
>  drivers/dma/mv_xor_v2.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
> index fa5dab481203..5d2e0d1f3ec9 100644
> --- a/drivers/dma/mv_xor_v2.c
> +++ b/drivers/dma/mv_xor_v2.c
> @@ -261,16 +259,15 @@ void mv_xor_v2_enable_imsg_thrd(struct mv_xor_v2_device *xor_dev)
>
>         /* Configure threshold of number of descriptors, and enable timer */
>         reg = readl(xor_dev->dma_base + MV_XOR_V2_DMA_IMSG_THRD_OFF);
> -       reg &= (~MV_XOR_V2_DMA_IMSG_THRD_MASK << MV_XOR_V2_DMA_IMSG_THRD_SHIFT);
> -       reg |= (MV_XOR_V2_DONE_IMSG_THRD << MV_XOR_V2_DMA_IMSG_THRD_SHIFT);
> +       reg &= (~MV_XOR_V2_DMA_IMSG_THRD_MASK);
> +       reg |= (MV_XOR_V2_DONE_IMSG_THRD);
>         reg |= MV_XOR_V2_DMA_IMSG_TIMER_EN;
>         writel(reg, xor_dev->dma_base + MV_XOR_V2_DMA_IMSG_THRD_OFF);
>
>         /* Configure Timer Threshold */
>         reg = readl(xor_dev->dma_base + MV_XOR_V2_DMA_IMSG_TMOT);
> -       reg &= (~MV_XOR_V2_DMA_IMSG_TIMER_THRD_MASK <<
> -               MV_XOR_V2_DMA_IMSG_TIMER_THRD_SHIFT);
> -       reg |= (MV_XOR_V2_TIMER_THRD << MV_XOR_V2_DMA_IMSG_TIMER_THRD_SHIFT);
> +       reg &= (~MV_XOR_V2_DMA_IMSG_TIMER_THRD_MASK);
> +       reg |= (MV_XOR_V2_TIMER_THRD);

Don't need the parentheses anymore. Please send a v2.

-- 
Thanks,
~Nick Desaulniers
