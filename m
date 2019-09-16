Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07415C4CEC7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 03:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB3A20873
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 03:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="giWqacrf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbfIPD0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 23:26:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45212 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbfIPD03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 23:26:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id c21so2761239qtj.12
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 20:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CHLN0YgFwIwYHZwb2pxqsYeg1mD8xv4r4aaeCn/rYDg=;
        b=giWqacrfQiVrlrnNCNX19zBLZpYkzv/d++9UCHt+m3d0xxFhBXFbrJvUf9PYWWGly9
         QwgCJhzTNtLQmfoHehdFE6KdHrmNsKx8VG6TI3VHmw54e8OGcYdzW9yfAbV0rgZ2wnu+
         0Gvll6Br3/x5sSMVkiy3N1y0nyInMPEA/3gog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CHLN0YgFwIwYHZwb2pxqsYeg1mD8xv4r4aaeCn/rYDg=;
        b=t9EnZMbFpChNmrkFPFjFyUjOgVkbVSyKN3h8X0YPHS9R2HNJ/Hxgne33TDbF+aU3bo
         PVCZR7EdhbJkj7UgPJ+/5obQa+H0o6tRs8PA7WY7T/j+3tSxgUZQwRMsowQWvLFGoc7z
         n2M/4XXA0cnPRQgUtwV4ckblPqj7BoeqBHq776eaqGf4NRzrzybIOVn8VOVeUyoyh2At
         MTSMYD3HmHssz3h+KbXelhlTC1432IfNMLivzhhWXW7OKWYWkILsLnq8h0tZJmilM4Xq
         Nk9Y35s16sDe+FX2OKuchcM9JwXRHvE7iVpwzlsnM9W6uFIeQ4EZTOWFmpG5DplA2Hoo
         QLHg==
X-Gm-Message-State: APjAAAUbwhBIzXXs4otKFqySNUhX+RsCDTOUbqQ0KWxljQ6c9p9lMrj3
        hvjojrecPojPuacyKyWlL1Xu+evhZLIvymUJwPlJuA==
X-Google-Smtp-Source: APXvYqx4qQhOGqxA9L1RqOKMV0wdsrWpPIh1F9cp74vnCrQahZ7zJmqiFQZxyRi9xirkjPYk6Emlx9le5w5PNtjR/Ag=
X-Received: by 2002:ac8:3647:: with SMTP id n7mr15936531qtb.159.1568604387185;
 Sun, 15 Sep 2019 20:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190913220317.58289-1-dtor@chromium.org>
In-Reply-To: <20190913220317.58289-1-dtor@chromium.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 16 Sep 2019 11:26:16 +0800
Message-ID: <CANMq1KALGLdZmOgcrrOROU5BXjwnXWSfq6fr85jfRn079JympQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] HID: google: whiskers: more robust tablet mode detection
To:     Dmitry Torokhov <dtor@chromium.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Benson Leung <bleung@chromium.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 6:03 AM Dmitry Torokhov <dtor@chromium.org> wrote:
>
> The USB interface may get detected before the platform/EC one, so let's
> note the state of the base (if we receive event) and use it to correctly
> initialize the tablet mode switch state.
>
> Also let's start the HID interface immediately when probing, this will
> ensure that we correctly process "base folded" events that may be sent
> as we initialize the base. Note that this requires us to add a release()

s/release/remove/ ?

> function where we stop and close the hardware and switch the LED
> registration away from devm interface as we need to make sure that we
> destroy the LED instance before we stop the hardware.
>
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> ---
>  drivers/hid/hid-google-hammer.c | 71 ++++++++++++++++++++++++++-------
>  1 file changed, 56 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
> index 84f8c127ebdc..4f64f93ddfcb 100644
> --- a/drivers/hid/hid-google-hammer.c
> +++ b/drivers/hid/hid-google-hammer.c
> @@ -208,7 +209,14 @@ static int __cbas_ec_probe(struct platform_device *pdev)
>                 return error;
>         }
>
> -       input_report_switch(input, SW_TABLET_MODE, !cbas_ec.base_present);
> +       if (!cbas_ec.base_present)
> +               cbas_ec.base_folded = false;

I'm not sure to see why this is necessary? The folded base state
should be in bss and false anyway, and even if it was true, it would
not change the result of the expression below (!cbas_ec.base_present
|| cbas_ec.base_folded).

> +
> +       dev_dbg(&pdev->dev, "%s: base: %d, folded: %d\n", __func__,
> +               cbas_ec.base_present, cbas_ec.base_folded);
> +
> +       input_report_switch(input, SW_TABLET_MODE,
> +                           !cbas_ec.base_present || cbas_ec.base_folded);
>
>         cbas_ec_set_input(input);
>
