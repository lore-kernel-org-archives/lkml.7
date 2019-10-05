Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864B8C3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 09:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D7D2133F
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 09:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ak2tssST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfJEJ1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 05:27:13 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33588 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfJEJ1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 05:27:13 -0400
Received: by mail-io1-f66.google.com with SMTP id z19so18842656ior.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 02:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QHyW/o/CoA0o6FWw7l9fi68BR5FObERbkYSm9Sv/LZw=;
        b=ak2tssST16lqas6WzZIrsyK+jgUXaCDlXQpgn7BKTHgP1w2V6NpqOX5xgdjS/P4sr9
         6PQcF4bKkyG8WX+CxkwHM+btTcIh+J6GOsitVfYbS+lXF5peV8HqvKxw/aze1onW/KE2
         h/zi9f8GHgQFIJKj9CEPzWBXLzX++ii4kCzSdudTJF8qmuni1mr+yo1fPSD+esg4IfmE
         UStdgicuNNrjQOZ4j+7dgonnE9Drq8GjoseZ32RI0EriULjNR4VHFvqza+iW8scyelKa
         6O5GL9NjwG/FM45FYPANQAvig7MExsI/v4faa/xiZawUNAjCyuRG8ohcnWBaqMvUMQfD
         pQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QHyW/o/CoA0o6FWw7l9fi68BR5FObERbkYSm9Sv/LZw=;
        b=mnrB5pzMKqTFycuHVzBaGptPXdpmb/SDR667yIU6eLCPWr5cQmI97rJy6GTYFoMtNp
         cP9b9erb7hkG6bFNa9NWm2lPv9KxEjv4yMemDCEGZep7SJFJEKBqM/8XMZ9PRXSnu4No
         OXlVEmwy4cxxJ4/+eLENbd4e4dZjj53rUq0Cm5kSrW5U2ewgbYaKBV7HORDKo6r5Yk30
         BA3UIL8IX3/tibJWyPTZWnxwBy0Cx1cwbypdfR7FwtyVf8EOLSkQsdxhiEPDXf1/XYVI
         Q/GYzIDsCHKKl9fC1LhZchunYCTBBKFdn0LRfJYU299IkgBVyeUL00gg51dGBzV+Br7l
         GXYw==
X-Gm-Message-State: APjAAAVsusprA8HGAhPQ5LefHzgZYSlDUfIzrZaS/ogoCcKjS3KEAcWl
        L/mvVnH3ZwPwL5PtT+0h6LeKcajKflO49S7bBB91+nLsSA8=
X-Google-Smtp-Source: APXvYqxQRPwtXNvynpdhc7a9KaRihoxBJKX/XnRfUFHaIuxyKIaDrrUQrr9erpW1If9gz6B96vY4Vd1TkAjcDaxxel0=
X-Received: by 2002:a92:b74f:: with SMTP id c15mr20296605ilm.43.1570267632433;
 Sat, 05 Oct 2019 02:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191001182927.70448-1-john.stultz@linaro.org>
In-Reply-To: <20191001182927.70448-1-john.stultz@linaro.org>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Sat, 5 Oct 2019 17:27:01 +0800
Message-ID: <CAKGbVbspHBNtEPGc_RbHdKUyrBTmQADueUSO+U+cFLUPzw0fBQ@mail.gmail.com>
Subject: Re: [PATCH] drm: lima: Add support for multiple reset lines
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 2:29 AM John Stultz <john.stultz@linaro.org> wrote:
>
> From: Peter Griffin <peter.griffin@linaro.org>
>
> Some SoCs like HiKey have 2 reset lines, so update
> to use the devm_reset_control_array_* variant of the
> API so that multiple resets can be specified in DT.
>
> Cc: Qiang Yu <yuq825@gmail.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: lima@lists.freedesktop.org
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/gpu/drm/lima/lima_device.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_device.c b/drivers/gpu/drm/lima/lima_device.c
> index d86b8d81a483..e3e0ca11382e 100644
> --- a/drivers/gpu/drm/lima/lima_device.c
> +++ b/drivers/gpu/drm/lima/lima_device.c
> @@ -105,7 +105,8 @@ static int lima_clk_init(struct lima_device *dev)
>         if (err)
>                 goto error_out0;
>
> -       dev->reset = devm_reset_control_get_optional(dev->dev, NULL);
> +       dev->reset = devm_reset_control_array_get_optional_shared(dev->dev);
> +
>         if (IS_ERR(dev->reset)) {
>                 err = PTR_ERR(dev->reset);
>                 if (err != -EPROBE_DEFER)
> --
> 2.17.1
>

Looks good for me, patch is:
Reviewed-by: Qiang Yu <yuq825@gmail.com>

I'll apply it to drm-misc-next.

Thanks,
Qiang
