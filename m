Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF515C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15F02166E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="BmDH2RnR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387557AbfGXPBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 11:01:17 -0400
Received: from mout.web.de ([212.227.15.14]:49261 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfGXPBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 11:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1563980446;
        bh=UNIw31EWwENU1KpZDLF9JJzGisQJXh7iOvS96EYhzps=;
        h=X-UI-Sender-Class:Cc:References:Subject:From:To:Date:In-Reply-To;
        b=BmDH2RnRWI66XyEo7JP399xXoEh4juNjLtu+ZBohkTDlU0YMX1SMqg+QfNpXsHdHV
         ZYnX0RmZnDAxCX17WFVv7FtSIgLkdRh1WEq0zANbrA/FFSI8hyDtWBbP4FSJjqZcNn
         UvcK/dlO03xdXScEx45OkEb3xxiblMzM+VsCi8IA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.51.56]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MA5ZB-1hfYKF0cll-00BHVf; Wed, 24
 Jul 2019 17:00:46 +0200
Cc:     linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>
References: <20190723181624.203864-2-swboyd@chromium.org>
Subject: Re: [PATCH v4 1/3] driver core: platform: Add an error message to
 platform_get_irq*()
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Stephen Boyd <swboyd@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel-janitors@vger.kernel.org
Message-ID: <d12a32e6-fd82-71f8-c320-ea6e844db3f4@web.de>
Date:   Wed, 24 Jul 2019 17:00:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723181624.203864-2-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mx2Pi+/bLnOpBEN8Nl1hFHCnXHzWkHA1OoTT0jVHTQReHG6ACbo
 KC7b6ufJkCEPllGa0EdK85GnhtuISKKDeErKdHeDbWiabMUzDh2+LirzVlVR2CMqJCPIVHB
 cYarJKDjt9utfwSLT56aUcSkVv96FNa4adCSGo0Y8nsr7naxXZO+Ci8NegYeQeRVK4JUANg
 vTeUqvad05Ud2B2r8Pvaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QGdQ6R4Sce0=:sBhuJ3JrIrq05oSU1n6vHy
 w7F+xDTa/DP38LnjiW7iCBFVk18frG4ID+/xFX0RETtt6wjFF7/Qcze96dyYJLPAFOzXy/2o5
 jE4DH/JPJNHVSHCu3NXWFc3kAd8JTOI7f4Fxt1oKdzKsURqChFNqE8ysWeQ5ywoOe8uAY8kj4
 MohB9tsEXJmV79Gykx6kRYYDqT83ATn3UpCiXugxU8lYz2fbb/ZzoIQVoPfsshb6gUu1prlt5
 dz1qr5DxgMfr9xaNK+6cdtvfwZb6shObOgxXirLvE4njYGOOkyF2/+VmvYRFofD74CShkm+Lj
 wQHVB+syNMrQNUMDGRxGuBdaPfgeai5i1xalOIZ1WaRbcoz5Wj8tOIuj2UQWAhZHiZssLd31b
 OW5NcnGfhh5pgEzIjQRWjH/n/+OhIbuoBUrlwWIl12BUZdHtZZbqy8lKllviRrk1ji7voHMx0
 bB1UCEfqPJq8ijrLnm3oS4vweFPJ3QnKOTpmN+P3Ep57BErxZms36+P3F1T8DYv8fEIPBun3H
 rH7BUFeyMhw+IVCnwMJKM484b7y5NynczYofJSbOB5idacPW6kaGR4PJVPrVZAm3NpV53IKtU
 doaTFWJ+LtcKwdVmK2JdTDh5MYibBHLS98zafeMUpLbt3Ww9vrWaIrc6o/X7BSjC3YASufdF5
 O1blARBMWj2on/LYIGxX8SafSGa1E4oMuPgJVdpVCnMHWN0BOI4KPsfFOz6Lu5lgRjXHxCnQd
 iKbB2taIhZw3x6OupzWqTA7QvvJ15AKuiKDlJIp9+osVr8o60wHei951RlFuic4+nCYhq5w05
 RZLNzDZLz7c5spPkrIkE+vr7QPtoIaKtU3XxzvXVUx9cXNNwMqr15opAi00ZZLE58jomGqOfs
 giZcoZaspCJMV3HThHgks0kAoZqg+3yEqI4/Cv1TNKNLbSMotzkXMZcxGOAWGEJEC+X8WyKiw
 eKK0Pu5RZYsZ1QDn2gRxoJANBj6HbSdoV2IeBSIlG+tmWumWka5KAENPooXaYGoi51OSdeqSW
 JLKPgUZrPS0mEEyR1Tlb20wQdzuCWSwLdenErS2p0Qlf2zJzY7YFKZpeVlQ16OF/Fi9vPKTpo
 46cJKMyQBNSaJgJ7t/JswAJyhNcv/Mkfop+
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Let's consolidate all these error messages into the API itself,
> allowing us to get rid of the error messages in each driver.

Such information from the commit descriptions sounds positive.


> +++ b/drivers/base/platform.c
=E2=80=A6
> @@ -163,6 +158,22 @@ int platform_get_irq(struct platform_device *dev, u=
nsigned int num)
=E2=80=A6
> +/**
> + * platform_get_irq - get an IRQ for a device
> + * @dev: platform device
> + * @num: IRQ number index
> + */

Do you find the provided description for the programming interface
really sufficient then?
Would it be more helpful to indicate the existence of an appropriate error=
 message
also in this software documentation (besides the C source code)?

Regards,
Markus
