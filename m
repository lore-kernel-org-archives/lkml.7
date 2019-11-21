Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9456C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 21:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A202B2068E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 21:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ewatgbtJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfKUVuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 16:50:08 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36850 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfKUVuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 16:50:08 -0500
Received: by mail-ed1-f68.google.com with SMTP id f7so4191084edq.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 13:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=441CDEY7r+jAiyFqGWKYoN/In8wLFWAjU8LoG44hNKs=;
        b=ewatgbtJd/GVsBazwuLbhDVy3ondBBL6YXn7+xys4ddOWJgSkvQyUhlZBIt3D9xmGY
         fvdvmkQS0NxDmjkrips5s3HdM7Jb0R/3Ge4SW9aEdseDuGeFkoxsMgIp8pBLWPw2uC/E
         n6lyziC2b0Cntk9mU4KbVq1dLXGcgZJfUOhXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=441CDEY7r+jAiyFqGWKYoN/In8wLFWAjU8LoG44hNKs=;
        b=EBPlQ5wid3PcGqLks1wgUrzHUougQnmB+dop+Y6NPys9vjCQPBD1m/XP00ApCok681
         fm+ypnR0CLWIsu/LmAkq157qyedEetW4m1XQ/9Hr3TfhCl5f3U+yBouwg/ut5WecXJnT
         M+X9CtwKj8Fn+Fe+JL/RFrb8YTXF5VTPZjP3RuGEcmtUZnolAh8hmExiGQ6uzKD+gGXE
         +U6zCFLshidhakwr59W7CF5+EiT8nMGpR/p67oWA4QPwVAzDyuLvLOd+cpZWqWGyh9T9
         2Fibjc6mXBm3Zb3JcVXv5JFSls1jlK4xCB1uvUKCRsO+VFTxaNh3PjIo29DFoqf8i3Os
         yXBA==
X-Gm-Message-State: APjAAAU/a/Te9rZQzwgfwHPpAdn3Mmanjh6uUAKrRhg74Ggn0MLf+/4Y
        sGpnE5Ux51G/c+VWvCPsPZvjMT4oP8k=
X-Google-Smtp-Source: APXvYqz3zldE47wNoETz4Xb4cR44daq2BMce/hait+KRvmJ9aQ8tfnVa4rTVaNmdEzmaKdo1m6BlGg==
X-Received: by 2002:a17:906:1d02:: with SMTP id n2mr16484794ejh.219.1574373004406;
        Thu, 21 Nov 2019 13:50:04 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id y2sm170518edd.2.2019.11.21.13.50.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 13:50:03 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id i12so6216233wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 13:50:03 -0800 (PST)
X-Received: by 2002:adf:db8e:: with SMTP id u14mr4763385wri.274.1574373002609;
 Thu, 21 Nov 2019 13:50:02 -0800 (PST)
MIME-Version: 1.0
References: <20191121211053.48861-1-rrangel@chromium.org> <20191121140830.4.Iddc7dd74f893297cb932e9825d413e7890633b3d@changeid>
 <CABXOdTeotUnO_7k9UycJ0vJEKV8pdZOjRrepDv5WVo5RmOLnEA@mail.gmail.com>
In-Reply-To: <CABXOdTeotUnO_7k9UycJ0vJEKV8pdZOjRrepDv5WVo5RmOLnEA@mail.gmail.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Thu, 21 Nov 2019 14:49:51 -0700
X-Gmail-Original-Message-ID: <CAHQZ30CYQd1-ZHJeVnKi9CMeZGiRJmvfYN5PRrpN26gcEJZXOA@mail.gmail.com>
Message-ID: <CAHQZ30CYQd1-ZHJeVnKi9CMeZGiRJmvfYN5PRrpN26gcEJZXOA@mail.gmail.com>
Subject: Re: [PATCH 4/4] platform/chrome: i2c: i2c-cros-ec-tunnel: Convert i2c
 tunnel to MFD Cell
To:     Guenter Roeck <groeck@google.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        Guenter Roeck <groeck@chromium.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 2:40 PM Guenter Roeck <groeck@google.com> wrote:
>
> On Thu, Nov 21, 2019 at 1:11 PM Raul E Rangel <rrangel@chromium.org> wrote:
> >
> > If the i2c-cros-ec-tunnel driver is compiled into the kernel, it is
> > possible that i2c-cros-ec-tunnel could be probed before cros_ec_XXX
> > has finished initializing and setting the drvdata. This would cause a
> > NULL pointer panic.
> >
> > Converting this driver over to an MFD solves the problem and aligns with
> > where the cros_ec is going.
> >
>
> I thought the mfd maintainer objects to the use of the mfd API outside
> drivers/mfd. Did that change recently ?

The MFD apis are only used in drivers/mfd/cros_ec_dev.c.
drivers/i2c/busses/i2c-cros-ec-tunnel.c just registers as a simple
driver.

Raul
