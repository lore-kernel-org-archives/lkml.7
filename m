Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD96C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9EF2068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="O7+ZGTvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKVSZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:25:10 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:40654 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfKVSZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 13:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1574447108; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cDQ9DP+nSpXqUMgZar+w9Dd+vKhFlMEv57dus8BQRpQ=;
        b=O7+ZGTvuyaTyah38XNcampj8b2AQe77fHoHdyG3LjKC2c2Jr8xPQqNtD7XMZiKaCJQ/XjP
        cN22cPAhCW3DKqqtYLQ2MJHqICR+A64kPZ9vDyBKDRgt1hCX3YxQHff/U0kjVotvHi+JGv
        RwByXPqV+5afr8ADMfB23s+cwS3edIA=
Date:   Fri, 22 Nov 2019 19:25:02 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 4.19 070/422] pinctrl: ingenic: Probe driver at
 subsys_initcall
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Message-Id: <1574447102.3.1@crapouillou.net>
In-Reply-To: <20191121101750.GB26882@amd>
References: <20191119051400.261610025@linuxfoundation.org>
        <20191119051404.162474836@linuxfoundation.org> <20191121101750.GB26882@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,


Le jeu., nov. 21, 2019 at 11:17, Pavel Machek <pavel@denx.de> a =E9crit :
> On Tue 2019-11-19 06:14:27, Greg Kroah-Hartman wrote:
>>  From: Paul Cercueil <paul@crapouillou.net>
>>=20
>>  [ Upstream commit 556a36a71ed80e17ade49225b58513ea3c9e4558 ]
>>=20
>>  Using postcore_initcall() makes the driver try to initialize way too
>>  early.
>=20
> Does it fix concrete bug / would you say it is suitable for -stable?

When using postcore_initcall() it locks up early in the boot process,=20
so it definitely fixes a bug. I think it locks up because standard=20
(non-early) platform drivers can't be probed postcore (but they can be=20
registered and probed later).

>=20
>>  +++ b/drivers/pinctrl/pinctrl-ingenic.c
>>  @@ -847,4 +847,4 @@ static int __init=20
>> ingenic_pinctrl_drv_register(void)
>>   {
>>   	return platform_driver_register(&ingenic_pinctrl_driver);
>>   }
>>  -postcore_initcall(ingenic_pinctrl_drv_register);
>>  +subsys_initcall(ingenic_pinctrl_drv_register);
>=20
> There are other pinctrl drivers initialized very early, do they need
> fixing, too?

The other drivers call platform_driver_register(), not=20
platform_driver_probe(), which means that they will probe at the same=20
time as the other platform drivers.

The reason platform_driver_probe() is used in pinctrl-ingenic is that=20
it allows the probe function and all the code attached to be marked=20
__init.

Cheers,
-Paul

=

