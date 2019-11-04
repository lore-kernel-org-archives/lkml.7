Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E800ACA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92BF2089C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KfC9yMED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfKDTH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 14:07:28 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41360 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfKDTH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 14:07:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id p26so12994471pfq.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 11:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qiT/RTwB3QsCtVvMpBuYQ/1nWBRVJkE25Jq2NSRmXeE=;
        b=KfC9yMEDspWl6sSTz1vNwX9GAo4X42HiPKedR8cXRKXtxfIE9MHoJr0XDEzaey4xs3
         sCx/3ewbV1C68GnicCxPXcQoxSsVUpOm+xU2lZ80y2vAosdKFZ0UDPvJFDqD+Cho1ybk
         gIu3yqX5gH2txu8Wl9Oge6hBigtKUSay8Egun9BolSGc312ntDFbf0gVg0zTAesJjlB9
         8mAijgYpvdHCyZuisjC441KwI5iQlggQ2m+G5sRo/J/jAUCDHyQ9Kozm3wcF++Lji7z4
         ZCUYa7DaL3Z3EaDw5z7xQcSFWNxJM0kDP91pqk1iYmGB/5tE1vPKtNsobE0TgI8h6JgT
         ARkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qiT/RTwB3QsCtVvMpBuYQ/1nWBRVJkE25Jq2NSRmXeE=;
        b=AZn7WClfeHWFJnheTQZ3LRB5bd97RsbVcHnS0pFVXOZTEMSaNxLKbMV1uYA7KAFoiI
         X0X8oRKWV4TFWJPyWHQ42h4YkUl5sZV4wtyRnDfBlZQnJ5cvlcMiCa6An+vlcWrASMxc
         9/X6D5x0rc9Gs3O7jEDpahmGKW/KD9lpKPTNoCo4tboiYr4Hpi4s6kJQMDPJiizwXBHS
         k49HTwaUYWAnUe+5XztfVsqlHbRilp7y4KD1WE77s67T2lz02movxk3xs0Vf7wK2Er+G
         qSb9hJj8AFk9iFjlWKgpVtI1AOTmPNJPCF3lGn448s3ao5OIn0T07aOL6blHjlqvPEdH
         5XeQ==
X-Gm-Message-State: APjAAAVkjlQnXRWsMOv0MFheKLsnzkZOKuH3+a9I2rGe3cVDW4skpVKz
        j5UeG3gloff6CglayWyyvUWy7+4YDMw5yd46CR+iTQ==
X-Google-Smtp-Source: APXvYqx3b2lihMeSLiLX2nU4LDfh6brFpn6cqrHskdQOsliW0tCGGF08K592EVZ7tiGoP1zY0FWbF61ZmZK8TZkmt4I=
X-Received: by 2002:a17:90a:1f4b:: with SMTP id y11mr797567pjy.123.1572894447068;
 Mon, 04 Nov 2019 11:07:27 -0800 (PST)
MIME-Version: 1.0
References: <20191024201240.49063-1-natechancellor@gmail.com>
In-Reply-To: <20191024201240.49063-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 4 Nov 2019 11:07:15 -0800
Message-ID: <CAKwvOdm=L5z0Oqqa797Xsxk0M_=on3bEs7SZePZFNY9kLUU1Ug@mail.gmail.com>
Subject: Re: [PATCH] media: v4l2-device.h: Explicitly compare grpmask to zero
 in v4l2_device_mask_call_all
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 1:17 PM Nathan Chancellor
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
> just comparing the mask result to 0 explicity so that there is no

s/explicity/explicitly/

Harmless enough change, thanks for the patch, and sorry for taking so
long to review.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> boolean conversion.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/752
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> I am aware that there is suddenly a style mismatch (some macros using
> !(grpmask) and this one using (grpmask) == 0) but I chose to display the
> minimal fix. If you want me to update all the macros to use this style,
> I'd be happy to in a followup patch.
>
> There are 19 of these warnings in the drivers/media/pci folder, which
> can be seen here:
>
> https://github.com/ClangBuiltLinux/linux/issues/488#issuecomment-545218125
>
> This is the simplest fix but if you all prefer an alternative one, I
> would be happy to see/review/test it. The ultimate goal is to get
> -Wtautological-compare enabled because there are several subwarnings
> that would be helpful to have and right now they are all disabled:
>
> https://github.com/ClangBuiltLinux/linux/issues/488
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


-- 
Thanks,
~Nick Desaulniers
