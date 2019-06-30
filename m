Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A618C5B576
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 20:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5719F20673
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 20:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=joaomoreno-com.20150623.gappssmtp.com header.i=@joaomoreno-com.20150623.gappssmtp.com header.b="2Ku9MTvH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfF3UPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 16:15:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40907 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfF3UPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 16:15:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so11492227wre.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 13:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joaomoreno-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=9rYVKL0/pSn/eewxhzuux6rx0RJc+uzCB/js30GKxtg=;
        b=2Ku9MTvHqt3rtESZS0nDj8fXN6pqoQYXKXuStjE/8g2T9GeCR4TwoILM5q+IglapSy
         3GKfmOGX4x8mqa1csdJ41pgisBMCYBZmYfiZNMY5ZySlIcnm+NdovpsB+Fe0/AfA4hnQ
         gXSy+z61trUpZ54AsGns7Ad5uo2Gr/zI4Z0v1oq5iWK/vLAIEqxIZOtuZe+zgR/3nO/G
         syFKgnUIkcn5mR7d/Pekj7Ze8gmBOf7Hq0kwJOzuDhOEeEgjkl+y0SRF0tQVngftsa6W
         GOmN0pZmP69yQpFefaluvk9h1UQfX7ZGy/oLc7Q8YcAN1A63joFyEqoj7ofTzKEFQl7+
         yJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=9rYVKL0/pSn/eewxhzuux6rx0RJc+uzCB/js30GKxtg=;
        b=rQuNOXvetXm4cViBsak7LOsqv/NiLAThcvRW2PSssk2EwQOjpuRtpfGwYTxoKhY5w1
         Bf7DNS4jkTCAoHejlVhnWs0VrRjFXmbba/WzaqbMCUtUK8c4EvL/AHzrTU7vL4U4lM2U
         VHDfUsbCC6+ZD7YQaeqB9ERCmAna2ssvSDv4lUVHy8233u/cmfAZIFBD9fed/Tu6Okh4
         0jPuGevuEDCjCeDgfITS1Bf9TWH5RiV+iqJvlWhnD/FUf7I6fcffGgER+uSIDOmT3+9L
         MExTXwg6k1uTjRsOwfYpaibqZJn0tj+kKovjKVEweaJdUsFxK5ofKaGUXuWUrDgxGTiR
         hsQw==
X-Gm-Message-State: APjAAAWW9gh6LziChEWzeQf/Vf2FVLiHuvbgZxthPIMxipEpP/oVqMrc
        jX6iXy9x2+BeJ3IdKPY5AfvSF+U3wjZ5bU2BcYb01Q==
X-Received: by 2002:a5d:4609:: with SMTP id t9mt1021400wrq.85.1561925743879;
 Sun, 30 Jun 2019 13:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190610213106.19342-1-mail@joaomoreno.com>
In-Reply-To: <20190610213106.19342-1-mail@joaomoreno.com>
From:   =?UTF-8?B?Sm/Do28gTW9yZW5v?= <mail@joaomoreno.com>
Date:   Sun, 30 Jun 2019 22:15:33 +0200
Message-ID: <CAHxFc3QC147B6j4pBztjK7stLgCveeYhJWojai_SbKNbnpC9yw@mail.gmail.com>
Subject: Re: [PATCH] HID: apple: Fix stuck function keys when using FN
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri & Benjamin,

Let me know if you need something else to get this patch moving forward. This
fixes an issue I hit daily, it would be great to get it fixed.

Thanks.

On Mon, 10 Jun 2019 at 23:31, Joao Moreno <mail@joaomoreno.com> wrote:
>
> This fixes an issue in which key down events for function keys would be
> repeatedly emitted even after the user has raised the physical key. For
> example, the driver fails to emit the F5 key up event when going through
> the following steps:
> - fnmode=1: hold FN, hold F5, release FN, release F5
> - fnmode=2: hold F5, hold FN, release F5, release FN
>
> The repeated F5 key down events can be easily verified using xev.
>
> Signed-off-by: Joao Moreno <mail@joaomoreno.com>
> ---
>  drivers/hid/hid-apple.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index 1cb41992aaa1..81867a6fa047 100644
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
> @@ -205,20 +205,21 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
>                 trans = apple_find_translation (table, usage->code);
>
>                 if (trans) {
> -                       if (test_bit(usage->code, asc->pressed_fn))
> -                               do_translate = 1;
> -                       else if (trans->flags & APPLE_FLAG_FKEY)
> -                               do_translate = (fnmode == 2 && asc->fn_on) ||
> -                                       (fnmode == 1 && !asc->fn_on);
> +                       int fn_on = value ? asc->fn_on :
> +                               test_bit(usage->code, asc->pressed_fn);
> +
> +                       if (!value)
> +                               clear_bit(usage->code, asc->pressed_fn);
> +                       else if (asc->fn_on)
> +                               set_bit(usage->code, asc->pressed_fn);
> +
> +                       if (trans->flags & APPLE_FLAG_FKEY)
> +                               do_translate = (fnmode == 2 && fn_on) ||
> +                                       (fnmode == 1 && !fn_on);
>                         else
>                                 do_translate = asc->fn_on;
>
>                         if (do_translate) {
> -                               if (value)
> -                                       set_bit(usage->code, asc->pressed_fn);
> -                               else
> -                                       clear_bit(usage->code, asc->pressed_fn);
> -
>                                 input_event(input, usage->type, trans->to,
>                                                 value);
>
> --
> 2.19.1
>
