Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227F8C4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41B0207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="hQbxD0Ie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389386AbfISKvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 06:51:03 -0400
Received: from mout.web.de ([212.227.15.4]:59627 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387987AbfISKvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568890233;
        bh=gk2fpL4tf9VggpIstfREPAvxj+olstdSC1GCzLekNqw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hQbxD0IeLduESvXiWcIQrh6lCPdGouAA/p4CZtJnV3uzCGoxtMB4dYcnLcv1LLiGm
         VSQwueqfLgJVFCBrqlrjwJyPFsZZ/DkPXSlfN9+w2naIAaGYWxbFWs+/jwL1ofln3x
         kL+eKZBnSdsSJ+i516Hus85/Brx/v0ChE0p6QlQA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.191.36]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lgs1W-1hpbgN1c0c-00oGvM; Thu, 19
 Sep 2019 12:50:33 +0200
Subject: Re: [PATCH] mtd: st_spi_fsm: Use devm_platform_ioremap_resource() in
 stfsm_probe()
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     Allison Randal <allison@lohutok.net>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
References: <e1d32aa4-7c82-64e0-b7c4-33c94d9a2769@web.de>
 <20190919111014.6c569cf3@xps13>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <17a1fccd-0ac3-f257-dec9-228b33a18cfa@web.de>
Date:   Thu, 19 Sep 2019 12:50:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190919111014.6c569cf3@xps13>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8+u1HWWTRH6nzzO9AbrP7hhTnSrdv33bj/2tz+7v6J//YdZMq/D
 diZ8naliyh4I2Sw5d/VgVzrytgBuUNka0lCUur0qTvTuo3Hk5wvPciHlUkBoG7votC5kLNb
 0f5e3juhCoZEKEQfT8J7XEe+ubk0l3Fk7DZqCY9wKK/icmiR5YLsl2c3fmAMENcqJelEUPF
 RK1XHnhjItLDrcL+gD1gQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TY3AGiQYbtg=:KDEntD9vgQ5O18ikVIqawi
 GXPYhxZ7p4NMqQmxLn5PTYNstFHtp8OTBDuBawFfLUJo2K6Bc3jcP+0gC/oQ3gs6Ia58kNLF4
 g7gDQZquonMIbvBwQFbY7gjBvT3kWGzHviDK6cGpPvHxq7wuiDG4sjvPLqsCTupxCXmpj7mJd
 yI0aYh77/nUPXoEXLK/7GK6oX3JyoH9S+NhS61pRXGO1+xJfkasu62uqxEUpe/BJFD8p5hqWl
 6V7RkwFDTt/Hat6ZEaMFbTg5hYN07OvqeiA/Z+oMQl5jfn7xlFrjmG1eM5gcvyEA0n7m8oNIc
 1/YEEfO7DQ6sgK4uTXUmlXhyaivKV0MzJhz9cNXpP0lKvzkUFGTt2qHpWWDp5hnBIwqqqDFVB
 Stc/yxDyv42HFQTzhoQC3Px6mTANDo2MihoTuo/SbdPYr0Mq5xGSMbl8liUGVWY05z3GEbl4u
 igcyvIZg4mdyfvkstCb3wtWjE+Qkz9euYTe8BvKFOJEzWY0MS0Or6qEEdopYhLartkybW07Ww
 qEhKOmDSe90ilD8+jNzASba/8m1gQfJEKLgw9WpTTdGnca2y3WX+dTHCtu14qB4JLoNPbGWCG
 BHH0MHP5VUHkhXklCOWrMv33TUxZsy3tl8o1ioOt0G6TX/Cnx2G6xjVFWqIShs36QtzvrJMfq
 l5jMCZIfElTBstLa3bF29US9lVIDVUg0tTigTuemQ1zQKK87d8cvUUTj3k8Vzo5O7T8TmmWZ0
 spIEe3qC7qR9l0lApsprElG/gpY59LN9ObuSnCumKZWm0V25CqUPfeQe9+p/sS5vB2ZPv0xUe
 juaVHQWeXz/FCgYfDjdM61TJgbz9OUSZ+lsBvp2OQjxFIEhE5dbwRJBOJdnG4pl5oMix7WlTV
 LwwSjp5Oh7y0g9VNX7ebVmjVI6P1f9eUcfIczd+nMXsoNDTTCZAi8C4cu3Ei158Q7fjDgLmhH
 Q0spGAHBuMaVdC4FGCU2wxZB7PweufQ3q6jLerHuEvbK+X/z1JzcEwAOQ+dgasob7f1dc1g4D
 jk4T6vc0XMAVQg9Hi2WsC/ehRVByPFwZpBfInKV8+y83UaAPDL/izM+nyh1fZ/JU3Q1ttYUvI
 sKp8m7nnUcvLO552+LSF0KM4U8OT3zMS9xRlccqsHjvpQyj7hNUMM5qIJCvM52/5SpPfr0qrI
 cTLOBSS9xYyV0Eet7vczFdZAX5iyczHKkZIRbMDHW4WLUMV01gaqjuH+1pY73QwOcbKdt+F7m
 ws79pX7b3SmYN8NUfr3JTn1rXgjoeraIXlcSqVA0C2UXaCJJeYiVdOPaVwGQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +++ b/drivers/mtd/devices/st_spi_fsm.c
>> @@ -2034,13 +2034,7 @@ static int stfsm_probe(struct platform_device *p=
dev)
>>
>>  	platform_set_drvdata(pdev, fsm);
>>
>> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -	if (!res) {
>> -		dev_err(&pdev->dev, "Resource not found\n");
>> -		return -ENODEV;
>> -	}
>> -
>> -	fsm->base =3D devm_ioremap_resource(&pdev->dev, res);
>> +	fsm->base =3D devm_platform_ioremap_resource(pdev, 0);
>>  	if (IS_ERR(fsm->base)) {
>>  		dev_err(&pdev->dev,
>>  			"Failed to reserve memory region %pR\n", res);
>> --
>> 2.23.0
>>
>
>
> Is this even compiled tested? 'res' is not initialized anymore so you
> can't use it in the error trace. I suppose you should even drop it from
> the stack parameters.

Would you accept to reduce the error message another bit?

Regards,
Markus
