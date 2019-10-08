Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97042C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 05:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6259A2054F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 05:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jOsITpV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfJHFdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 01:33:17 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45399 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729464AbfJHFdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 01:33:17 -0400
Received: by mail-ed1-f65.google.com with SMTP id h33so14469409edh.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 22:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LapW5Mhx7A3MmJCZg7TvfQvSI/HGXIWjFByANU41b0g=;
        b=jOsITpV2dARCbBIs7CsRBuTlQkh4OLvDnEPLViJ3atMG3HrLQzr9VvEXUm72O02aKV
         Rv0PMe/QG4clTSibMQU5hNpxlbZFdvv7hvq1WAkaQEzRMe9jt+7UPHjqLGwt3KaMRIID
         CubosTQVW1ATclgVCb0CpfjWguky4G6AUmceM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LapW5Mhx7A3MmJCZg7TvfQvSI/HGXIWjFByANU41b0g=;
        b=BxhfZNZurjJt4Isqe4DTiS8qzM4OWtWEDvyyUyd5xV6hwH/QEeLt0QlH8h0kTp1bHQ
         poByzO8gEmw6bdj+xwENuXTbPxUONZaTRNXobC4fXa7iQV97ipaVV70cAieVNitMVdmU
         qC35SphumEdAujJMyuIXzawzZxoon3a9XhV14HW+wej7coH+0wtjU0fPE9E11d1aA6pm
         PKJ9ApIsYEkVYcY7G8zYMWcB6gHo5dRcV8k/5hcxbmQjXfrbyYKxr9tq3oeWbvTKETiV
         dlmXf1v8xQ8kwvNG/OY3RcgdkcxABGHdLKF9IPbQLdXEx2zkZ5H9P9cWgI1RRePj3s5u
         RVyw==
X-Gm-Message-State: APjAAAWy8gkPrCfGuFYAPYc1oF+4BHhFo9at7GVV5egGa8be/DAxLS2p
        EuUusafadsbi+65+kri0tvb5YSYzt6QoWA==
X-Google-Smtp-Source: APXvYqwXOW4/g0Ll3Y5/oY4CTqMeN4hCZ8KXTxVoNXW204tYVHHvzuMS4YaX3SrtgepIAnToeh77sA==
X-Received: by 2002:a05:6402:1a4f:: with SMTP id bf15mr32663467edb.292.1570512793886;
        Mon, 07 Oct 2019 22:33:13 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id l7sm3660822edv.84.2019.10.07.22.33.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 22:33:13 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id v17so1641172wml.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 22:33:13 -0700 (PDT)
X-Received: by 2002:a1c:e404:: with SMTP id b4mr2327776wmh.90.1570512484241;
 Mon, 07 Oct 2019 22:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191007174505.10681-1-ezequiel@collabora.com> <20191007174505.10681-3-ezequiel@collabora.com>
In-Reply-To: <20191007174505.10681-3-ezequiel@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 8 Oct 2019 14:27:53 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BNu2ea3ei_imHmEwmdna0+iiSbQSv_SBsdHfP4Uh1h4Q@mail.gmail.com>
Message-ID: <CAAFQd5BNu2ea3ei_imHmEwmdna0+iiSbQSv_SBsdHfP4Uh1h4Q@mail.gmail.com>
Subject: Re: [PATCH v2 for 5.4 2/4] media: hantro: Fix H264 max frmsize
 supported on RK3288
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        fbuergisser@chromium.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ezequiel, Jonas,

On Tue, Oct 8, 2019 at 2:46 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> From: Jonas Karlman <jonas@kwiboo.se>
>
> TRM specify supported image size 48x48 to 4096x2304 at step size 16 pixels,
> change frmsize max_width/max_height to match TRM.
>
> Fixes: 760327930e10 ("media: hantro: Enable H264 decoding on rk3288")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2:
> * No changes.
>
>  drivers/staging/media/hantro/rk3288_vpu_hw.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/media/hantro/rk3288_vpu_hw.c b/drivers/staging/media/hantro/rk3288_vpu_hw.c
> index 6bfcc47d1e58..ebb017b8a334 100644
> --- a/drivers/staging/media/hantro/rk3288_vpu_hw.c
> +++ b/drivers/staging/media/hantro/rk3288_vpu_hw.c
> @@ -67,10 +67,10 @@ static const struct hantro_fmt rk3288_vpu_dec_fmts[] = {
>                 .max_depth = 2,
>                 .frmsize = {
>                         .min_width = 48,
> -                       .max_width = 3840,
> +                       .max_width = 4096,
>                         .step_width = H264_MB_DIM,
>                         .min_height = 48,
> -                       .max_height = 2160,
> +                       .max_height = 2304,

This doesn't match the datasheet I have, which is RK3288 Datasheet Rev
1.4 and which has the values as in current code. What's the one you
got the values from?

Best regards,
Tomasz
