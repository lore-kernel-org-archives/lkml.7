Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE75AC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 13:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853DD20870
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 13:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Wp976cgS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfDNNQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 09:16:33 -0400
Received: from mout.web.de ([217.72.192.78]:59879 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbfDNNQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 09:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1555247782;
        bh=uQaXxvQdUUlFOyGZtOnVXoapePhfXKtWXNjvejoByeY=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=Wp976cgSYidzYHOfZkyGgWW4EeTUtgCdMg4i+HM/FVA+vXPHjWJGh4monGxGokTD1
         eyH7c7BrTdBMQdHBrs4LTQ45CS6j9iM+RAtms4X94hnAK1eHrIg3NEz6vM6yZe9AvS
         eoL9rIlqrbSfgXBcYhWIkZ8qn/yvCbK4F08aBqfg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.103.133]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LsyNK-1gr5ci16OA-012Uy7; Sun, 14
 Apr 2019 15:16:22 +0200
Cc:     linux-kernel@vger.kernel.org, Yi Wang <wang.yi59@zte.com.cn>
References: <1555048943-39589-2-git-send-email-wen.yang99@zte.com.cn>
Subject: Re: [PATCH 1/5] pinctrl: pistachio: fix leaked of_node references
To:     Wen Yang <wen.yang99@zte.com.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d2957471-b2b2-0266-61d1-03bc4a643fb7@web.de>
Date:   Sun, 14 Apr 2019 15:15:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555048943-39589-2-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:sVsNRgjKRuwrBjywtaVErqA638GuzhuEe7i8E3dScpza2t7cy/O
 k4HaZ7T4rHV/LG76BWEIey2hsBMxLe8TxHJ8+0xttAXrOVY44qQJoeoTfqlHCsXZtvCATNa
 aHN5MMtUa4LpqPFQT5RyVsbxGkho/yTJ4riTIr9M95w77jpjFn3tG2bDvroIw9xPNmB9geJ
 MAmQJCgGeA5+qSgtws/sg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wG3SeCsgNuM=:2tDuOF/KOlICy2A2ckt1Mu
 sS78cr1NqW8NsT7C4t1GphBD0ckfGl/Tn1sGQ/lEgXCG2D53e4H0JfOrolG+hVE/g4vTN40Lt
 cJ4lW0Btmeos09R/7bOEjiIRxNo6ghQKUsXCtZ1Sh4Eq8B7/p84NAdLFdBVtSAeTxOH79M2FQ
 U95kRv7qAWKyD9rjkKycgmCYrvbk0+uDG0TBr3J08PvPWBqgyYHpvWMr6jtvO790Leoh44S53
 IqN+ZX6Gx6OGmcTWukmXk0A12BkRkieIG3SM4ZDWdo/VKv7V7LFZCklB9iMNJ95mDDu0WSCYW
 PkY/VtZa+AiEOCiISSCisAyXoAMCMehp7hoQUcmI18Xdf7bNkuzNTyHenuGjGFx0lSxzA+br8
 NVmvqVO3qCjodlBj/B7xvy2PEfW3koff12UC9g4pzaQYZFl/HUt6BTwnO3PKgtRdcygPQVsMm
 IiX/mUi9150SkWhZbJ6ezxbkuCl3QgDyxFOfiNlP3aUOGInNOt1V0s7Lu+LfUqJUmoVy/yNR7
 4uT/DWnx0ezKCnm8H5OltJQdpIM9csQIKSJNDdHpHqnau4MpyzWay3bQO1hKVFjLTa4fdQ0gC
 R1jK3Eo2UYciT80E7b5l1J+2YMbt0L9dDhJocouKAZhvjSXuKfPD4FUc0xB8dZDP8UNU85AIx
 YYKsI8B9T3QLkFZ5smwIuNl08FpI83foSXki6DGt33wyeIkImj4y0OSCmjev6ox34T/NWq6Y4
 Ui7krjbIcnMsv2wRJUgmDMW0XoCzB1szZ49YlMI2pEeTHHpeQ7+djIEUrI/0QLG4RxJnKB9Fr
 GUp4YThFcCxrg/geX9ilt9eQTw99DUsNYrn9z9RgdqoHTEI0VcH4LY9hsyPPijVo+p9+3D2q8
 AFmM1BJ7d7HbAqZTdtEpBhvCUkKcn4BwBJnxYyMWaE+2LneUU2m6GNEbYpJ4W16E5AjTMQaCX
 1xRGhusI7dA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -1367,6 +1367,7 @@ static int pistachio_gpio_register(struct pistachio_pinctrl *pctl)
>  		if (!of_find_property(child, "gpio-controller", NULL)) {
>  			dev_err(pctl->dev,
>  				"No gpio-controller property for bank %u\n", i);
> +			of_node_put(child);
>  			ret = -ENODEV;
>  			goto err;
>  		}
> @@ -1374,6 +1375,7 @@ static int pistachio_gpio_register(struct pistachio_pinctrl *pctl)
>  		irq = irq_of_parse_and_map(child, 0);
>  		if (irq < 0) {
>  			dev_err(pctl->dev, "No IRQ for bank %u: %d\n", i, irq);
> +			of_node_put(child);
>  			ret = irq;
>  			goto err;
>  		}

Would you like to move such duplicate statements (and other function calls)
to additional jump targets for the desired exception handling?

Regards,
Markus
