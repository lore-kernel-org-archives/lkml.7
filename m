Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FCFC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 23:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7AB206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 23:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiNt2yrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfCIXem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 18:34:42 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45505 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfCIXel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 18:34:41 -0500
Received: by mail-pg1-f196.google.com with SMTP id 125so1068225pgc.12;
        Sat, 09 Mar 2019 15:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RF9mb9ARgTAKo657nd3DvnNrip0BY9GpRE8hBfR1UxY=;
        b=aiNt2yrY0C/JI0MM92PNMRZB+H1Q2lsSboKRUxzmxNYEybllw5vRm7BfImOHCGmhMr
         MGNQeofBtO3ddoziwIvqvMJ7SAuOt1e8UEwTDA9Ifz5IzORj3eS5+8jaQ2j8dvRz/JJ1
         Dy2S3vlQ6L6XqF3tG1xn032MBCKIMFmrHrP1n3bH+wVT2dIPwkG49YiQbuisMExZ/Afn
         /GnFDoRjNNp+ec0RkGz2vtaif16aytxyj82+WOE7MPr5sQYLPh4FCXCIW+VOLW9F/CGs
         eF0nRGk5La21GxzpNYl0Jht1vOwpZ1tc3eB7pAfjzyAYYkVF/p0sahPy0MO1yrkfud60
         q5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RF9mb9ARgTAKo657nd3DvnNrip0BY9GpRE8hBfR1UxY=;
        b=CXTtPJs+Bpqh5bSYM8NB0wH/o0eCz5K/9IyIqqpbYNqGcRVrLS9swyXdBPIKxCpJlu
         CWi4+XKKZWObmHQgLZaUPkiVF/7GtJktmsaGaGInqahQzA+NI/47COHGU6mEV4Szms3L
         Dqt1DTPGZGONU1cII+hbji426i0EXIhNNGJa19P26ifZE8LiH2nybvUsqqEQJ6zFMqbz
         VGAf9C+5roHVwY1XCK5GYlsmrdcGU5DDJAyxE0cj7j512rK2UndtNloNuo4i7D1XKRVC
         peoMlkX5BqzkItQ9VhwUOX+JbsFEtQVwDVqXyQpU2cuyOtfLLAafYc7lQqvOUy6xsIJc
         imeg==
X-Gm-Message-State: APjAAAWgIb8kbc5tnOSdgcm5JNQsFhorVJN84Z7Dx97SLocnF7hIlLI+
        rWKeeqQuH0s6IAXhYmpgWo4=
X-Google-Smtp-Source: APXvYqyaw8Q+bqE6EafF5Ie2YkAQTei+HVJrM8deD0P6uvRc+UX2GQcUH2sbUUFQGzxkthQ5TUPQgQ==
X-Received: by 2002:aa7:82d7:: with SMTP id f23mr26062840pfn.114.1552174480672;
        Sat, 09 Mar 2019 15:34:40 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u24sm2522827pfm.140.2019.03.09.15.34.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Mar 2019 15:34:39 -0800 (PST)
Date:   Sat, 9 Mar 2019 15:34:38 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Zhu Yi <yi.zhu5@cn.bosch.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: raspberrypi-ts: select CONFIG_INPUT_POLLDEV
Message-ID: <20190309233438.GC13699@dtor-ws>
References: <20190304195845.1096214-1-arnd@arndb.de>
 <87a8108f573e04d5c2eaaaa23be0f3a58bd45eb1.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a8108f573e04d5c2eaaaa23be0f3a58bd45eb1.camel@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 11:39:42AM +0100, Nicolas Saenz Julienne wrote:
> On Mon, 2019-03-04 at 20:57 +0100, Arnd Bergmann wrote:
> > When CONFIG_INPUT_POLLDEV is disabled, we get a link error:
> > 
> > drivers/input/touchscreen/raspberrypi-ts.o: In function `rpi_ts_probe':
> > raspberrypi-ts.c:(.text+0xec): undefined reference to
> > `devm_input_allocate_polled_device'
> > raspberrypi-ts.c:(.text+0xec): relocation truncated to fit: R_AARCH64_CALL26
> > against undefined symbol `devm_input_allocate_polled_device'
> > raspberrypi-ts.c:(.text+0x19c): undefined reference to
> > `input_register_polled_device'
> > raspberrypi-ts.c:(.text+0x19c): relocation truncated to fit: R_AARCH64_CALL26
> > against undefined symbol `input_register_polled_device'
> > 
> > Select that symbol like we do from the other similar drivers.
> > 
> > Fixes: 0b9f28fed3f7 ("Input: add official Raspberry Pi's touchscreen driver")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/input/touchscreen/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/input/touchscreen/Kconfig
> > b/drivers/input/touchscreen/Kconfig
> > index 7c597a49c265..7a4884ad198b 100644
> > --- a/drivers/input/touchscreen/Kconfig
> > +++ b/drivers/input/touchscreen/Kconfig
> > @@ -699,6 +699,7 @@ config TOUCHSCREEN_EDT_FT5X06
> >  config TOUCHSCREEN_RASPBERRYPI_FW
> >  	tristate "Raspberry Pi's firmware base touch screen support"
> >  	depends on RASPBERRYPI_FIRMWARE || (RASPBERRYPI_FIRMWARE=n &&
> > COMPILE_TEST)
> > +	select INPUT_POLLDEV
> >  	help
> >  	  Say Y here if you have the official Raspberry Pi 7 inch screen on
> >  	  your system.
> 
> Thanks!
> Looks good to me.
> 
> Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 

Applied, thank you.


-- 
Dmitry
