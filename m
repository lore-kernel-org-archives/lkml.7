Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CA2C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90E824D02
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfFCIID convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:08:03 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:35997 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfFCIIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:08:02 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBp5hRw/qOxWRk4dCyhrHcWveo6dYddJLwU7zfP8dEA8ZeyIBhBhmPt"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2001:16b8:2643:ce00:3513:fe32:ce68:90d3]
        by smtp.strato.de (RZmta 44.18 AUTH)
        with ESMTPSA id j04dc1v53880Cwv
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 3 Jun 2019 10:08:00 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: BUG: gpio: pca953x: 24 bit expanders broken since v5.2-rc1
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CACRpkdajVu2H-9zX4gAEnHHR8gd=4jseabLGsHB=0CF1BKH-JA@mail.gmail.com>
Date:   Mon, 3 Jun 2019 10:08:08 +0200
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Nandor Han <nandor.han@vaisala.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <AA845A5E-65BE-41A4-A2CC-37C6DA432E6E@goldelico.com>
References: <F29452FD-AFA4-422B-992C-D348FEEAE0E2@goldelico.com> <CACRpkdajVu2H-9zX4gAEnHHR8gd=4jseabLGsHB=0CF1BKH-JA@mail.gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 01.06.2019 um 23:57 schrieb Linus Walleij <linus.walleij@linaro.org>:
> 
> On Fri, May 31, 2019 at 7:06 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
> 
>> Now, this was not a (visible) problem until patch
>> 
>>        8b9f9d4dc511 regmap: verify if register is writeable before writing operations
>> 
>> enforces to check the register number before invoking the
>> callback pca953x_writeable_register(). pca953x_writeable_register()
>> seems to know about REG_ADDR_AI (through reg & REG_ADDR_MASK) and
>> accepts 0x88 as a valid register number.
>> 
>> After the regmap patch the register is checked against
>> pca953x_i2c_regmap.max_register before applying REG_ADDR_MASK
>> and 0x88 is obviously beyond, explaining the symptom.
> 
> Can we simply bump the .max_register in
> pca953x_i2c_regmap to 0xff for a quick fix with a comment
> FIXME to figure it out the right way?

Yes, that might be a quick workaround closer to the correct code location
in the driver.

There seem not to be many regmap accesses with randomly toggled REG_ADDR_AI
bit and therefore risk of seeing two different cache entries where they would
assume the same is low (and not higher than before we fix anything).

I'll give it a try asap.

BR,
Nikolaus
