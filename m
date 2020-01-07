Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF615C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8174E2081E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x5KxWlGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgAGKFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:05:02 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37952 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgAGKFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:05:02 -0500
Received: by mail-lf1-f65.google.com with SMTP id r14so38491938lfm.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 02:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=awClw5OAQIwoGJ1RZz6WGsXMCWNAAQaZn8rQr6h6O5s=;
        b=x5KxWlGe7nbe02Q9as2w62MXuN/BIWWDnrFUKqM2bPddubzze64XtDbRYCeyDm6rm2
         qi8wSDPT1ADgriXyfveliTg+kLK9wl2nA2natoUTp7Vz1aMtCjtkfVOQZsI2oIrTzs/Y
         u+Ssk63d3rThpDc3d7NekeZWAHe6VxuaExN4gw5bpiHDM3ScGcQnr+aL3ZB9/y9QyztF
         k9KAajHdQXFlj1F9/3YBkmp50in8DKYhFWiL2WRI7eCHceWKtbDHQs85UQoDOIZpw2jz
         j9aCHM2u7r97AS9b++W1qiREBX7/RzZeT8D21s4TYx8uTUqV9QlpjqDnlubbqfc/EkEI
         fSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=awClw5OAQIwoGJ1RZz6WGsXMCWNAAQaZn8rQr6h6O5s=;
        b=cZpgO+nG0ryaVaa77qE5n9FkHG5k8bI8qmw23LxTBt4d3a91pQbSX16xKURRhKE8JF
         MIrOLuJkKcOy0sRUR7e7d1LXd25UMjXVXLSPDhuL7hkw0l4LmehEaAGEI58k4DHHXYdC
         R65J/K751TgohfR3ec2RRnnwJvBbj71V+fytsSSlXpvs6lWyJLRXe035HUEAWSLjUBKQ
         JIQ4Ed4ejhOXzaUNinJNK7F/8N+cyQH0M4vV5v2cLb75P//gL/yNngAFZS+Ns5dZOoU9
         MsWLcFv4sm64yTUYr9r30+YAq+SImjNApI89mlyAD4mqD+zObuUmfAWRmP9Bt2Yi2a62
         /7hg==
X-Gm-Message-State: APjAAAXGMxFyuE5NQHv3tJxP93bgjaxzUQgazQtUZp7v5J2eJMDFWYHG
        CKosUS+H6z2kesLgetX2Nj4LKmr5sKvY920REhZnIFtlfnIkNw==
X-Google-Smtp-Source: APXvYqw0j/84MKECKcv0/Q78CRciq/3n0s13Yasvj4qWuUXq74vhfWWyeCyqp/+mpqyYZnb4UfHpt8+hrdDc7TszrfA=
X-Received: by 2002:ac2:4945:: with SMTP id o5mr58196144lfi.93.1578391499976;
 Tue, 07 Jan 2020 02:04:59 -0800 (PST)
MIME-Version: 1.0
References: <20191224120709.18247-1-brgl@bgdev.pl> <20191224120709.18247-7-brgl@bgdev.pl>
In-Reply-To: <20191224120709.18247-7-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 11:04:48 +0100
Message-ID: <CACRpkdb3kE3Pkzgb0tg03BW-hggbDFez7ZWt5XZAuMZsqGO0xQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/13] gpiolib: use gpiochip_get_desc() in gpio_ioctl()
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
> Unduplicate the offset check by simply calling gpiochip_get_desc() and
> checking its return value.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
