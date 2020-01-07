Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1327C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD892081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C/TMqDRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgAGKE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:04:27 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41416 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbgAGKE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:04:26 -0500
Received: by mail-lf1-f66.google.com with SMTP id m30so38433036lfp.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 02:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IaT+HGrfAbav44v71XZlSNd1URgNRj4zIy7n7ZKUqH4=;
        b=C/TMqDRfkoUuJ0f7T7D+O5oR+b6o4w0FNo/T1F+R1AHCSi74QZrP0ulqX/mlk/yMb3
         CgBbnBDXHH3RQbFfjeIBmDCMxBgBJoWMyfSinbTkTKu7+eAqlL4UQ+G6Qu9e8sGULoAW
         scPPSgM5ky8Dgu+u+57Yj0r+9bLeLU5VTQ5mngb2qRSIofjffwJo8cHE39XF1zC55KbR
         sBdWKaMBlfnmYRjXkQ6NzWwAl4XoASa4PfrvonyU+r6J1Kj88we/W4tZT4yErxsOgisP
         oDj7YGWcd/AGmfR3FZQWc7Lz9Z+TBcTUrOnS7BUoLmif98Q98aJ28tRnBC4luasznBue
         V+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IaT+HGrfAbav44v71XZlSNd1URgNRj4zIy7n7ZKUqH4=;
        b=G0niA+ziGicOF9y70rLzWQM+nmMAU7O9q6WgYddKetJNYpRmlm14K00ruRGxt9cDht
         OVAFwFbuhTHx5R86hdblqcqoXJc4X6wRa1utuGuTJrVxVhwoZWxGR2FeKM88iYWit1uZ
         k8uzdj2yxb4d3FIxQJRnPRvqYqja485SnzzykC9kANCMmH7zAAUW5sPBE6BHD1mpJXEq
         9ZHKVYrvl2kJJWr+kT34/gFW7YkgVk7naf6W3IanIaeUwkDvxNlaaSQlQMkX8y5odB6e
         zvFGUPdyYrb50OWjGEfBCPPOz1zy1zOsDIBL2xiZSw6jG3QRaond6mOyNbwV+f3+e/S0
         PZAg==
X-Gm-Message-State: APjAAAXkkrWJ7qzu2rC2wm9GIF1K00B0ipHwschbTUa/Te0oVY2WH0t8
        4nHLlMfBv1k4Y/D9q22KM8v0jv/aZkyyQnne0uY/oA==
X-Google-Smtp-Source: APXvYqzIqvdiEJyuN737lKRaPRJmxancOJCuQ7zjFMf8BOpiiEvcoUI8UR/icK9L/Hp7tnD+upUM0vg9QbSylxpdyTQ=
X-Received: by 2002:a19:2389:: with SMTP id j131mr56672702lfj.86.1578391464246;
 Tue, 07 Jan 2020 02:04:24 -0800 (PST)
MIME-Version: 1.0
References: <20191224120709.18247-1-brgl@bgdev.pl> <20191224120709.18247-5-brgl@bgdev.pl>
In-Reply-To: <20191224120709.18247-5-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 11:04:13 +0100
Message-ID: <CACRpkdb7Hvn6pYF_3W9tUQfbZ8NJBTymeHFgrgNi+tKLa6YTgA@mail.gmail.com>
Subject: Re: [PATCH v4 04/13] gpiolib: use gpiochip_get_desc() in linehandle_create()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 1:07 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Unduplicate the ngpio check by simply calling gpiochip_get_desc() and
> checking its return value.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
