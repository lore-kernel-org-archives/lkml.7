Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B4BC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE992199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qU5ZgH7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfGVI0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 04:26:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35761 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfGVI0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:26:41 -0400
Received: by mail-lf1-f65.google.com with SMTP id p197so25946094lfa.2;
        Mon, 22 Jul 2019 01:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qfvfkEyZd+DLJr7SlSsxk5CR4wqlGHyDi7qXTnWxyjM=;
        b=qU5ZgH7lnaBzI3Nk5qQNMvhVjMl1vZtjvP9SIy4aOn1q2RIFIL5sAukQ+3bhdueGsf
         gF8gLTsZT604maLq0+AppwcO65gamoxEZLGspJOmgg4gf0xYYZ8jBYG5qwrYKk/BXyRJ
         KOPx7ak3bgjRRiylLqULa2Dgx8dDTnjDL81skNMbTQktuIrwOxJUPGx4WI7O0GGObHJC
         7ubrWYDhzeHI50ALl8xoEgp/omFiEBRd7mHRj5mB42vvJUoHH6GF3YybSOuAgSTSAxCO
         gBb6cTwH9guFxUqHNDSlFxGiwrMrCoGUKv28FutneKRZuXRl8o3ZRFgKBxjx+VvqE2aY
         msPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qfvfkEyZd+DLJr7SlSsxk5CR4wqlGHyDi7qXTnWxyjM=;
        b=WMyN8m16HWBYr3crDlY2wSxBTWhWZWTDFUf+jzSz3eua0XsHKX1DbmJf4hrexOvP5+
         hKXhA+u5CN7Hdqh/NA9XMSt0VBexfn2TEXosC6isT/OXmeeOdiSPiplwjL/YPCyWh0Y4
         6LLdRDvzM39i+X2CAvXpiGRdvHwwTGgKzkiy71H+dzHR2xONeYOzpSrwZF8coZSEo2V3
         Jm386ikwilOgcocVZ54SqUDI0XO8fWwK0z+FweTpNXxgssaq2POdxIL22W2JilMN7LL6
         3JgFXueRwZTHgcv8qrYncDA36epZ8tMqexz/Bn+5WCP79afa0P2Mx+dcyb7aM/hbS4bo
         THOQ==
X-Gm-Message-State: APjAAAUczZppSdTwr2b+rDwLwJKUg0WSrZA68hoST1kwzGFO85ogPPkC
        DZw9TqMbS3NczcXDgDfG60M10yLLPGpqLRo8+ns=
X-Google-Smtp-Source: APXvYqwdhc62rde+BTL3HtJEfabYZbOQO1FtvdIwx9Mc0UCkMBYiG0Q9xBEQCHEmk0uZ9+MEutmP0pVQlvGMwM821Q8=
X-Received: by 2002:ac2:568e:: with SMTP id 14mr31838975lfr.189.1563783998994;
 Mon, 22 Jul 2019 01:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <1562781795-3494-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1562781795-3494-1-git-send-email-jrdr.linux@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 22 Jul 2019 13:56:27 +0530
Message-ID: <CAFqt6zb-LmG4PrWCXfmDqor2bgxyFJRt5Yg0vmNgE9zvaw+S3Q@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: nvidia: Remove extra return
To:     adaplas@gmail.com, b.zolnierkie@samsung.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 11:28 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Minor cleanup to remove extra return statement.
>

Any comment on this patch ?

> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/video/fbdev/nvidia/nv_backlight.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/nvidia/nv_backlight.c b/drivers/video/fbdev/nvidia/nv_backlight.c
> index e705a78..2ce5352 100644
> --- a/drivers/video/fbdev/nvidia/nv_backlight.c
> +++ b/drivers/video/fbdev/nvidia/nv_backlight.c
> @@ -123,8 +123,6 @@ void nvidia_bl_init(struct nvidia_par *par)
>
>         printk("nvidia: Backlight initialized (%s)\n", name);
>
> -       return;
> -
>  error:
>         return;
>  }
> --
> 1.9.1
>
