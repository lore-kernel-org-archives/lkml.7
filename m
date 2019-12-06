Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD325C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 21:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757E520867
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 21:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EzYr1iSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfLFV7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 16:59:20 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39349 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfLFV7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 16:59:20 -0500
Received: by mail-pl1-f195.google.com with SMTP id o9so3278289plk.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 13:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QRBpOBKrG8bdYcDSxvL4Ncie9tUQ46zSSXSNCQ/ptww=;
        b=EzYr1iSS/43KvcyAMRF5WxsPmvM4P1WVDXs7cB8RszXAhHNAjjyGHW/9wXHa9GPFQK
         bDmsZ95dWgvAF9DuNC+7HmT/LvTWpQJgDVj/rXk7/pSR41xYMtdKzceoobvKuFhN6moE
         NHMoCj5RV1oxu3FJSS20U1Pdlhq/Ofzn0iEL+5tlvNfpAS/fB87A+u8G3kNKSXqzjZ+f
         TK0RKqxKzGLEtC03aNXRmB1O1lgd9pK6siizuiqBb8wNHcquEr/Z/cNaT8cKApRNNX7u
         Si4FRbR12limo6gRjCIpIhFJ7v7F3W0uT6jkx0xWxxxLFUirLMeMiYrAgwVK1merHRKX
         COzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QRBpOBKrG8bdYcDSxvL4Ncie9tUQ46zSSXSNCQ/ptww=;
        b=q92lXEifEdPF0++dEOB1dr4+HJXZZVL7Bvpu0uE8EFJcUjAfXI/pAgU3yJUjN6Psr+
         U7OvZ2hCC5C7h+qWoGIxpuq9UJvokuz0fVN4IYm1xxivTDUlHo/kEGNX9+ozKFSQxBnF
         np4+YpX4kkMZpnrJv0vFYgbJfAMkK13Fg+xbi0diaF8sgTIVXmXcepuSpmvmlhd0kU9c
         CxjBeWypn9hotXkDEJVQrK9j9BWVI6SWzqLPQh31muqU8Jpw/+nLWYzY+iCal4XJJDvP
         rfhUnbshM1eZmIg3YZC/mSHHnw8UZWwdFk7nexYAc///9CEVrgv1XWGg7jfMBXC1z6+T
         TzPw==
X-Gm-Message-State: APjAAAXbB8iowBYJ7Ofg8RMqvc1rvbnHHvrfqG0DmmjnO0Z7r7hRmZdl
        ehpl8b+P2DS676uudgL7kGknu458mOx8IbO122LVdA==
X-Google-Smtp-Source: APXvYqwHYwaMTzN123flVCAXr3GzbWAtJi/KnOVS9rjd9DBDXsUkXHvlLkq8qqed8tGFJHZSrIRI79QQhFD4ssPrKxc=
X-Received: by 2002:a17:902:9f91:: with SMTP id g17mr3377709plq.179.1575669559051;
 Fri, 06 Dec 2019 13:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20191024201240.49063-1-natechancellor@gmail.com> <20191105045907.26123-1-natechancellor@gmail.com>
In-Reply-To: <20191105045907.26123-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 6 Dec 2019 13:59:07 -0800
Message-ID: <CAKwvOdndvDuOFtPrdSuN=1nRpbc-T9qHKzQoVZ4JaAedKe9_SQ@mail.gmail.com>
Subject: Re: [PATCH v2] media: v4l2-device.h: Explicitly compare grpmask to
 zero in v4l2_device_mask_call_all
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bumping for review.

On Mon, Nov 4, 2019 at 9:00 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with Clang + -Wtautological-constant-compare, several of
> the ivtv drivers warn along the lines of:
>
>  drivers/media/pci/cx18/cx18-driver.c:1005:21: warning: converting the
>  result of '<<' to a boolean always evaluates to true
>  [-Wtautological-constant-compare]
>                          cx18_call_hw(cx, CX18_HW_GPIO_RESET_CTRL,
>                                          ^
>  drivers/media/pci/cx18/cx18-cards.h:18:37: note: expanded from macro
>  'CX18_HW_GPIO_RESET_CTRL'
>  #define CX18_HW_GPIO_RESET_CTRL         (1 << 6)
>                                            ^
>  1 warning generated.
>
> This is because the shift operation is implicitly converted to a boolean
> in v4l2_device_mask_call_all before being negated. This can be solved by
> just comparing the mask result to 0 explicitly so that there is no
> boolean conversion.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/752
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> v1 -> v2: https://lore.kernel.org/lkml/20191024201240.49063-1-natechancellor@gmail.com/
>
> * Fix typo in commit message
> * Add Nick's Reviewed-by.
>
>  include/media/v4l2-device.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/media/v4l2-device.h b/include/media/v4l2-device.h
> index e0b8f2602670..8564b3227887 100644
> --- a/include/media/v4l2-device.h
> +++ b/include/media/v4l2-device.h
> @@ -431,8 +431,8 @@ static inline bool v4l2_device_supports_requests(struct v4l2_device *v4l2_dev)
>                 struct v4l2_subdev *__sd;                               \
>                                                                         \
>                 __v4l2_device_call_subdevs_p(v4l2_dev, __sd,            \
> -                       !(grpmsk) || (__sd->grp_id & (grpmsk)), o, f ,  \
> -                       ##args);                                        \
> +                       (grpmsk) == 0 || (__sd->grp_id & (grpmsk)), o,  \
> +                       f , ##args);                                    \
>         } while (0)
>
>  /**
> --
> 2.24.0
>


-- 
Thanks,
~Nick Desaulniers
