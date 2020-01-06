Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA7FC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E831D207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgAFVLt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:11:49 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:54025 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgAFVLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:11:48 -0500
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id C8153200003;
        Mon,  6 Jan 2020 21:11:45 +0000 (UTC)
Date:   Mon, 6 Jan 2020 22:11:35 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20200106221135.1da27439@xps13>
In-Reply-To: <CAHp75VeJNZWz_Cv=dozAwt74OBu8TgyYe5bNU3sHreRMdqxR8A@mail.gmail.com>
References: <20191129191023.2209-1-miquel.raynal@bootlin.com>
        <CAHp75VeJNZWz_Cv=dozAwt74OBu8TgyYe5bNU3sHreRMdqxR8A@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

> > +/*
> > + * Max7313 PWM specific methods
> > + *
> > + * Limitations:
> > + * - Does not support a disabled state
> > + * - Period fixed to 31.25ms
> > + * - Only supports normal polarity
> > + * - Some glitches cannot be prevented
> > + */  
> 
> Can we have below in a separate file and attach it to the gpio-pca953x
> code iff CONFIG_PWM != n?

I tried to do it but there are too many functions from the PCA
driver that would be called in the PWM annex. This leads to hiding
generic parts of the driver which have nothing to do with the PWM in a
header file, which I don't think is wise. I prefer not to do it.

Thanks for your understanding,
Miquèl
