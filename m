Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EF7C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF60520854
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ejtivDu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfCHAfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 19:35:39 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38623 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfCHAfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 19:35:38 -0500
Received: by mail-pg1-f196.google.com with SMTP id m2so12627236pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 16:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aG3QOmEP9Q9OLnyOSa80+pJxYbFD37ymXQLe2O3g+vw=;
        b=ejtivDu9lB6XzBFllO17yRLe5/WHBaXHpsfem3UCfvOLjtrURGL4QXDgp6tF7drcRS
         Z78S/bF1NdsJKVxnfXR47n7vrJZQLRPDnUDjqRJiizIZ+E9e/mDYdNd6t2zagztyhB5Z
         sL4M2YumQ38H+9WxRz3k2fb0DW1vTlivtb4So5aHhZEPcEYQo8vXrlCFagW2n8gQZB3R
         dvLVokdf4wdRAl2CIYYeQRjj9wV5+jhpK8lGlhNZ99ACN9TxqLbj/gIj+4UMjcXTf5vq
         L40i8s26a4QAgQvFQNxi7Wq/3HUU1JmYbFCAbeKuyWBBuHA8nL+O3dcWkmepEm+Xp695
         +OSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aG3QOmEP9Q9OLnyOSa80+pJxYbFD37ymXQLe2O3g+vw=;
        b=Ukc2Gb3IK32BdOxmFje2VqKLMiJPpUHfSGmTNAPdTPe59pZF4+jIuUIeiGitp4VCXb
         MFqeo25PgH0b8nChf+xQZNCCZ6R1iZlJaiguUZexwUSbpyyb3CJ/KoLdjo6WE0T+26C6
         Eth+wqZ41lB2Cq49xXu/JLSqzqK4Fw1GMTRQAPwqim10qHXaN6aB+fFODLnQLfkRyqyx
         oHi4a2eCVNxiAUPZ+bqhG7cNLeM1AwkdTfjA6MlJmyEyqQPo0HLUIaINjM3Np8qzgOHc
         kyciIPYgFBPNv4XFvflKh2vq/b5z/90HmAXGRTh/6Zj2RhmqTVtqpNoGvzPqJVmt0Jp/
         V0bw==
X-Gm-Message-State: APjAAAXzZq/p9XqRVOQB3In7K1dLxcLhNM6Ok4EWZAqvjurr2pSbwakt
        QSScXh4vDSnUybyhF+VJUny2j8zlOLa8WrI3iVd0bw==
X-Google-Smtp-Source: APXvYqwDRcTtOAH26wremieOCn0S7QsBB0GQKFBZLidSGDHTB/I92Zdx1oMFnz3MMC25keYRD+5SzQQFSavA0WBf8Yk=
X-Received: by 2002:a63:fe58:: with SMTP id x24mr14069519pgj.255.1552005337751;
 Thu, 07 Mar 2019 16:35:37 -0800 (PST)
MIME-Version: 1.0
References: <20190307214546.9624-1-natechancellor@gmail.com>
In-Reply-To: <20190307214546.9624-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 Mar 2019 16:35:26 -0800
Message-ID: <CAKwvOdkeVmcoD7WusKE83MmRjX+h73rnHDY=Rn_a7LXsULPsrw@mail.gmail.com>
Subject: Re: [PATCH] iio: common: ssp_sensors: Initialize calculated_time in ssp_common_process_data
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 1:46 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with -Wsometimes-uninitialized, Clang warns:
>
> drivers/iio/common/ssp_sensors/ssp_iio.c:95:6: warning: variable
> 'calculated_time' is used uninitialized whenever 'if' condition is false
> [-Wsometimes-uninitialized]
>
> While it isn't wrong, this will never be a problem because
> iio_push_to_buffers_with_timestamp only uses calculated_time
> on the same condition that it is assigned (when scan_timestamp
> is not zero). While iio_push_to_buffers_with_timestamp is marked
> as inline, Clang does inlining in the optimization stage, which
> happens after the semantic analysis phase (plus inline is merely
> a hint to the compiler).
>
> Fix this by just zero initializing calculated_time.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/394
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Knowing that the same invariant holds across function boundaries to
protect access of unitialized values and thus undefined behavior
sounds tricky to diagnose accurately.  Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/iio/common/ssp_sensors/ssp_iio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/common/ssp_sensors/ssp_iio.c b/drivers/iio/common/ssp_sensors/ssp_iio.c
> index 645f2e3975db..e38f704d88b7 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_iio.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_iio.c
> @@ -81,7 +81,7 @@ int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
>                             unsigned int len, int64_t timestamp)
>  {
>         __le32 time;
> -       int64_t calculated_time;
> +       int64_t calculated_time = 0;
>         struct ssp_sensor_data *spd = iio_priv(indio_dev);
>
>         if (indio_dev->scan_bytes == 0)
> --
> 2.21.0
>


-- 
Thanks,
~Nick Desaulniers
