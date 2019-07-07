Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2844EC0650E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 09:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69A720830
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 09:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="W0OfBzOu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfGGJ4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 05:56:32 -0400
Received: from mout.web.de ([212.227.15.4]:40175 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfGGJ4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 05:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562493340;
        bh=pIjU5m/hqLHnMDS7/Bh23VXp+9hOmQNr+dTLRGj0K68=;
        h=X-UI-Sender-Class:To:References:Subject:Cc:From:Date:In-Reply-To;
        b=W0OfBzOuqHzvAFoWBqdlMUDb8VefY6nIl6ywgfiNunx8X6Nt4RxBSRvt0kLD6sIxo
         EZXMK0NaVt4WCjmSfZ8dtRq8t0lJ8iwv62oC8/1bPOhGddyNa4EdquakiFXqxkHfum
         xOeJLF3etDWkqfjDcK0qJztfmD+AnJghN/6LJ6Uo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.61.32]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MAvVk-1hcOvg1a6e-009vxx; Sun, 07
 Jul 2019 11:55:40 +0200
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        kernel-janitors@vger.kernel.org
References: <alpine.DEB.2.21.1907061538580.2523@hadrien>
Subject: Re: Coccinelle: api: add devm_platform_ioremap_resource script
Cc:     Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Enrico Weigelt <lkml@metux.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Palix <nicolas.palix@imag.fr>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <de953581-7ae6-952c-3922-3d5b25f48e17@web.de>
Date:   Sun, 7 Jul 2019 11:55:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907061538580.2523@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ck4fJzu9yqecdi81wzMxgjvoVpi4RxMhFWtUEhMVkUywLrC3pT7
 H21csEWb3NiK7yWUuMgWIj+HPSKtKFroB9CxPsuM/KwbgsYt5JG7YNYwtt6f7CCgFlpxjyJ
 6YlUGAjn7cgvmjVzuXdC1a844g1P2LkQsKNRdls9vHbPpBHfbYWnHn5i271KjfNcQMVE12y
 Ax+WbMwoGc3xIt9R90ykA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C2hneSWOXv8=:SvmbeApjUkXpIoGCJdJ5es
 xMgj0rwSUae2b59xlQkcyY+xBr7P9i+SuXz2OQtcx5U4to3KU3Va/CZ3GxToBrX9O3qsCGYxr
 DvocH4nNW6/Pd8zuqfD52SriRDfg9OAMeB3KDE3CB+LJOxS+UGlmJB6gugyW/mwMXfLDMkfl0
 RA+2oYW411EE3tgVtSCUDJ4PEJZ5cwUTBRWLKuws03wSsza+okAj/dRTpm1pP3LGmJaxMAjC/
 0vnubdBOUXX5ZlSzX88F6+23KQMj5loFDPDTaFDRdVgYe3GqfIXdzxgDn7r7rI4JIqK20uzB7
 LvZCxMdyyz1xhXLtCfMjjzLE/0R/830Gi510C7TJNfy2yEo75JZ4EvYVGNfflxCHQE+MIaiDS
 RAWRWUP9cQzz65zJRsvcVsQ9HpUZdMySqTgJCkDe4F7ZLqIk1zaO1IcSkjdeuO4YpYCdZZNUw
 LSQoYGgH2bpSUvKtxjxD2mtGLwGKNYzGSM0UoGiEi1fUNfjNusV1iZWg/YGcAWwouP7CIoOMn
 DMTHfAO38QvFKA+K3jYH6PT66M2eRExxciRi3E8zz6PE0Z4Wel4eO46zZGbWUyAjNY1vtcupg
 CLXblJ7xoL7aRJqjYU1dx4uD+68eGV5WFuBV5Wwf3vGQZBir2vnbnKhVKh3oUePRZ7zkoNr5x
 ccNH6Hyx1YXoeU3OLsqvraUaLJtADwNCMfIxh6P8NwJl8bCikPInQWHFWtl+7i9Cwvr73Vjr4
 FpLi0VKbg5HHeLeSDE21uKdSZQ6HiBspkkzAdn48WqhLLkqLjZJznS88N5aBBlKtwcmfqAIpQ
 R4LdLZQ/VgF1nmoHUuk1Hw/yDDBI/hyzFk9w8kLLi1uCbAy/0Xv3HajB6CI21FBaPpdMyYStU
 7qWc2Jzol+K62LcVux7UC81LEzRPLmQrDuPPhc8qaaoH23N/ikyk56dtig8+MdYvJy3Itv8rO
 nH0tXRfvZh7H9lUYrP2YljRHa5Cz6tTSFursACWtzQAoxZ5AZdm3ksPikvM4hwf64mPcw98Z/
 MPpWmclQMgTrSXR76eiu2ZosNkfb62OcsDda+LV4ToGnrlfv0J3Z7HDbhmLBKFpqRN8mn6aZ2
 kuN42TbTO9j60AVgG3+eeuWoCIYs2+kUz2j
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I will apply with Julia's Signed-off-by instead of Acked-by.

>> I will also add SPDX tag.

>>

>> Is this OK?


>
> Yes, thanks.


Will the clarification for following implementation details get any more
software development attention?
https://systeme.lip6.fr/pipermail/cocci/2019-June/005975.html
https://lore.kernel.org/lkml/7b4fe770-dadd-80ba-2ba4-0f2bc90984ef@web.de/

* The flag =E2=80=9CIORESOURCE_MEM=E2=80=9D

* Exclusion of variable assignments by SmPL when constraints

Regards,
Markus
