Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4270BC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1522053B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JqZwTLTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfJFSL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 14:11:27 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:38414 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfJFSL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 14:11:26 -0400
Received: by mail-vk1-f194.google.com with SMTP id s72so2496911vkh.5;
        Sun, 06 Oct 2019 11:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XvhZjKNZd7ezMcvYLdUk4d1cF2+Jz0JmAVSLszIBT2A=;
        b=JqZwTLTBp0H21eSD9zA8Q1JSuXLhZKi7280qCXLWNDa1vX10J2yxVcXrL16QdtUBHc
         pScVR9B4JReFA2lfJRixZS3CbtSxM72X2/JB5xyQGWhFZ7aW9lYzMHKADT0TAwuUYT6y
         fd0q+u8xzBDFujeR4IZaTIiLWU8G6xSR1lQJI0DGMSSB8RAQC1C/CDsiE9ESKClMtWrT
         SAnqYhCjzB6I7qKJxmJgagNFt6CU5AymX6FLNLJ5NqhdSoUxcm1CYOzOJO48EfJO5dX4
         cuhKe2+IlBv/71jVH8LP9xRkhJl7stAqVp1WhHxKlKHi1UvXoFWdmldAdOxPPpYZ92VE
         AYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XvhZjKNZd7ezMcvYLdUk4d1cF2+Jz0JmAVSLszIBT2A=;
        b=BcfTHUMsVu+cBYySQ9INou3NNOLk7vl/7K58R0mzLXoMmHYv5gGvpp+2Mq6MicaroE
         PFJt6GgIyEbUY5FK7QYNEx+DcsU1ZfXzxWc5F6QqjqzVsfxLh32JA7sDGTaWufAQ24Vj
         94NAw2NBes8OUg2OivANhK007TTaix/BxS+1ackx2l//0W1BDC0hFytDCf17M12G+349
         MKouz2zQamv95SY50abpxeZfXI2LIABqe3zHiLVBQsMn8W5VpWbES2o2v8JXxDbqoX5j
         ZR0soUSRcHKD67/ujq1VLf20TLT3r+t8PQIaMVBcq628bvD0HgmK3hpbSgpd5BN/DmyX
         KrEA==
X-Gm-Message-State: APjAAAVnOZBVNi3tMRcOCLClCqC7aTGqLt7U1niFyrzOUEEfY36t1/l6
        7hTwa5Yn2WR66sJVJ7AJLibElm/zvT5NtL3XzUU=
X-Google-Smtp-Source: APXvYqxuW3H8XQIumbD21ksD8zppbT4zFvS2Lqcjei2gxAhaMSAXkJ/r6UQnGb4Eyn+eJNoiJigfqPfjsFvR+e1x15o=
X-Received: by 2002:a1f:a705:: with SMTP id q5mr12627945vke.85.1570385484250;
 Sun, 06 Oct 2019 11:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20191006163314.23191-1-aford173@gmail.com>
In-Reply-To: <20191006163314.23191-1-aford173@gmail.com>
From:   Yegor Yefremov <yegorslists@googlemail.com>
Date:   Sun, 6 Oct 2019 20:11:14 +0200
Message-ID: <CAGm1_kvC7745jhRawSinTtMr4LSbTFaE7-pnoar=tpjLD2nDcQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] serial: mctrl_gpio: Check for NULL pointer
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vignesh R <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Tony Lindgren <tony@atomide.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 6, 2019 at 6:33 PM Adam Ford <aford173@gmail.com> wrote:
>
> When using mctrl_gpio_to_gpiod, it dereferences gpios into a single
> requested GPIO.  This dereferencing can break if gpios is NULL,
> so this patch adds a NULL check before dereferencing it.  If
> gpios is NULL, this function will also return NULL.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Yegor Yefremov <yegorslists@googlemail.com>

> ---
> V2:  This patch is new to the V2 of this series, so patch 2/2 can
>      work without risking a NULL dereference
> diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
> index d9074303c88e..fb4781292d40 100644
> --- a/drivers/tty/serial/serial_mctrl_gpio.c
> +++ b/drivers/tty/serial/serial_mctrl_gpio.c
> @@ -66,6 +66,9 @@ EXPORT_SYMBOL_GPL(mctrl_gpio_set);
>  struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_gpios *gpios,
>                                       enum mctrl_gpio_idx gidx)
>  {
> +       if (gpios == NULL)
> +               return NULL;
> +
>         return gpios->gpio[gidx];
>  }
>  EXPORT_SYMBOL_GPL(mctrl_gpio_to_gpiod);
> --
> 2.17.1
>
