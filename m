Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3265CA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 09:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25FF222BD
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 09:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="FtDECA/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfJSJB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 05:01:28 -0400
Received: from mout.web.de ([212.227.17.11]:38137 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbfJSJB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 05:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571475658;
        bh=Y0P275WIDbqUvVHf7QGFoPGv/7wKy4zEqthAUu1mhYM=;
        h=X-UI-Sender-Class:Cc:References:Subject:From:To:Date:In-Reply-To;
        b=FtDECA/5nRq2nBR1udCWmVf9gw/3il2/NlW+Rf4xEUClzFnf4iDm4Lqx1RQZY+5Uy
         6ht5apbdF9g9vNGALWfNuISIvsIcJpj23Z0WppM4p55f5ZMI4ej1ycdYwlrb7sb2oj
         AbTIEMJggubbtjDEVBlt+gDZ4Ae74VDvWr2Mlk3c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.29.47]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lhev7-1hiJCK34a1-00mtlI; Sat, 19
 Oct 2019 11:00:57 +0200
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <20191017142237.9734-1-alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] coccinelle: api/devm_platform_ioremap_resource: remove
 useless script
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        kernel-janitors@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>
Message-ID: <81269cd6-e26d-b8aa-cf17-3a2285851564@web.de>
Date:   Sat, 19 Oct 2019 11:00:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191017142237.9734-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:n7SOa2KwYtmH3qJyG+Slf0RgFprTJOYyGnUuYDM6FZXVU0gMeCd
 Ok5ehlGb67AWeDovehQnQwuHGKjPpxrAzNJi/Q+v4LGaPgtG104lbRO4hM410KmqeLkJ28L
 XBbt0jBeek4zhvprVGsz4OFcNd8QWkCxiep3Um/QN8VG3IsQVXqGZD6ADNRcDCp79i/uHxW
 d73Ca2Hv8ZipJjuhjg3FQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8zy4gtP21y0=:/WblYARSLGCqPUUwrorxtC
 cPJ9nBbRSEoUGVyrJbX6IyLWIRg5Kb0kZrlmsPGCiweH6dT1SS+I98bswh18/+qj7IJ8MiZhH
 gWiL5toBYniUySE2Vb0+QEJgBqCgSLmm2V4MMhEFVVzCRrmUgwv4jlRPHEzRLKWRq/KoZ9Gnq
 T6yhyJjhI4LmpwGH8ZaNjdDBNRwRa9yUUZv2CBpO9+L/Umso4piWOkYyVcdsJdde1XZCjJ3bh
 vqu7a5jTrkuiTkYOuk/Jx9VG2eJ0nMalFgukM24LBreavqBtZhbqMaPxFjxZW54iY6JwAfjUI
 PlolizvVmkjOMg0/yXOi5H9bZaZZ1nRe7vvU0M4LJuBNhFguCO/GoMCR/pGBz5ElmxhPFEw3i
 K4fsVzvd4g9LzDZtCmTWsMRgTqdacVHn9plz1VKvWr/9mpMcWesz+Ue5stKwwLZk9A4vN4qT4
 azJMujCoCpquJHQuFnRM/7hnmuIQec5iX30uuf4j1vGNlOxb/6tPbJoZ/0cmHvB1LlQ7BptqF
 ZBZBXm74FgaG7TUlYweqTRJzTexadZNohvKb2QzPB3Tl5/jFkeeoh3vgUDN3fdgujDX8LFpem
 Ln9wjF5VPpgy56yLQ14vqw3zQ37kdcMhFDBZJ9N5WkGf8DQVTw7Rs2XhA0yATJe8lCDqBjw0r
 t0WxxcbIgAdxzxclq8TQ71nf5qWqocZUUJpyKZ6we2uzaLZrvDMpImd7OdOkOglD8CRDBv29K
 TPI6+Fb61eJDb/NXB/2I+mzADxVRZUBgUl8wNeusfKZAeft35FVM2agRdRGjA0qaq8LKKMG/e
 WjAS7w70eM2HtgLWqCgqCUieq+TM0+MjXeP5/FKl8ybxzfs3xQzvmWlY4ZgMVci+8KFnkm6wp
 ph60AsRlThY2ZgpEa6xOC9OEnFs6a+X/OZwMaJDtNbZh2ZR8p+2iSefhObr985zhBT3G0Shms
 TCjEG51Bjd1S0+yuC0m3HRZ85efBJeUcN8s2FRv4ZxPetR+BjbVRSVktpjBwIL87NQ+YSzqbD
 iHxvdsM47HDibI+2e7N0uI4ysK16awd0GFRkzyxgFKyZfjM1k/5QeDVhyNZigLZi1WDtLEMHp
 FY4mxA+pPTb1Oo6Xs1vD0exxpH2Vg1/jTQpJ2S7IlqTHB1aanxGIroIOMXieI4eoiLj1rp/pK
 WzuJ/cU7pLUKO4ukNvEF+rk41yZSoOBBZ9HgLuw9FD1mlZVTsjEQHD4Mjpaz07XuXM4qHNhSE
 12Hyt4uBsgIIJQIGNZN9V7Ghvw0EBQINyAZt8kbbavzPwsHLPcQKclLfHL20=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> While it is useful for new drivers to use devm_platform_ioremap_resource,

This is nice.


> this script is currently used to spam maintainers,

This view is unfortunate.

Do we stumble on a target conflict again?


> often updating very old drivers.

This can also happen.


> The net benefit is the removal of 2 lines of code in the driver

Additional effects can be reconsidered, can't they?


> but the review load for the maintainers is huge.

Does collateral evolution trigger a remarkable amount of changes occasionally?


How will such feedback influence the development and integration of
further scripts for the semantic patch language (Coccinelle software)?

Regards,
Markus
