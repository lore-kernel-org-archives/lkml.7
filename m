Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF61C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 17:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F0726CCB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 17:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfEaRGJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 13:06:09 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:24491 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfEaRGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 13:06:08 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/vrwDeuaw=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
        with ESMTPSA id j04dc1v4VH6364g
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 31 May 2019 19:06:03 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Subject: BUG: gpio: pca953x: 24 bit expanders broken since v5.2-rc1
Date:   Fri, 31 May 2019 19:06:03 +0200
Message-Id: <F29452FD-AFA4-422B-992C-D348FEEAE0E2@goldelico.com>
Cc:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        kernel@pyra-handheld.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Nandor Han <nandor.han@vaisala.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tony Lindgren <tony@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We discovered that the ti,tca6424 and the nxp,pcal6524 used on the
omap5uevm resp. pyra-handheld are broken starting with
v5.2-rc1.

The symptom is:

> [    7.524125] pca953x 4-0022: failed writing register
> [    7.529444] pca953x: probe of 4-0022 failed with error -22    

Tony also noticed this to happen with some BeagleBone Black cape.

Some analysis shows that it happens in device_pca95xx_init()
when trying to write the invert register (PCA953X_INVERT).

The PCA953X_INVERT 0x02 is translated into 0x88. Because
since

	b32cecb46bdc8 gpio: pca953x: Extract the register address mangling to single function

a 24 bit expander always gets the autoincrement flag REG_ADDR_AI
(0x80) set. I don't know if that happened before.

Now, this was not a (visible) problem until patch

	8b9f9d4dc511 regmap: verify if register is writeable before writing operations

enforces to check the register number before invoking the
callback pca953x_writeable_register(). pca953x_writeable_register()
seems to know about REG_ADDR_AI (through reg & REG_ADDR_MASK) and
accepts 0x88 as a valid register number.

After the regmap patch the register is checked against
pca953x_i2c_regmap.max_register before applying REG_ADDR_MASK
and 0x88 is obviously beyond, explaining the symptom.

A test shows that reverting 8b9f9d4dc511 makes the driver work again.

But IMHO this is the wrong fix, because I think the combined use of
regmap and REG_ADDR_AI in the pca953x driver seems to be fundamentally
broken and not the new regmap address test. Unless we expect that regmap can
pass the REG_ADDR_AI address bit to i2c but ignores it during cache
lookup. Then, I think the pca953x_i2c_regmap.reg_bits should also be
7 and not 8.

So the real solution should IMHO be to eliminate using the autoincrement
mode of these chips. But this may break the PCA9575 which seems
to need AI for multi-byte writes according to some comment.

BR and thanks,
Nikolaus


