Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C89C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C65B20675
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="o7LaBHG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfENQuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 12:50:50 -0400
Received: from mout.web.de ([212.227.17.11]:59957 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfENQur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 12:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557852620;
        bh=tTdGn7PAdq23/snhcsDYMPF+/i7fZBX9nZlKLsqxWGQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=o7LaBHG6AeXvjOrrrZmK8VGcB45IX2YXT+HOE6N0fwo6LF0Y33mU8hyvb6fVWoz1Y
         1WIPgZ6pQOjaJ59JYnBcIzsnnfRon0NJZ5X2OB37/6yaHPBA4rd7muMgWQQxq6n+JG
         t+gL7mmCuWUoxlaFAeXnNwIJOLo1OQbKwl6+DEsE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.122.180]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MLgQp-1hQJeC43nv-000uPk; Tue, 14
 May 2019 18:50:20 +0200
Subject: [PATCH 2/3] Coccinelle: pci_free_consistent: Reduce a bit of
 duplicate SmPL code
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>
Cc:     Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Yi Wang <wang.yi59@zte.com.cn>
References: <e30b9777-6440-b041-9df9-f1a27ce06c6c@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8626b768-470c-8362-1a57-6c94b5b0e077@web.de>
Date:   Tue, 14 May 2019 18:50:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e30b9777-6440-b041-9df9-f1a27ce06c6c@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GgDDO/BXayEqFb4QLhv/T4MtJvJMQDgmTcLfGkP4nauP8cwp8mY
 WQPFMUsNHojcS1gttXte3HAP1QYEBPjGUd4ZJo+Kt9YjkzZY+NwLQWeeIq0Nvs4xSX5EfTU
 7zOyf1nz7XWR9OICJuGpJZsVTb8OPtK54gG9hwGa9nH4+satkV7ipSLuRsd0pBq5Y8JWHHh
 WIA4zzrTsDPDO3Ux9lgmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MGp+bf0DBeI=:DB0ItxL2ysWR0HWLIeV1Y4
 nvsMiQw03UmOvFxfdljdI3M7j1JbKSa6RKBt4uhPl6Nq38jEdVZRsOi/Q+eGn7JP4ejpN0etg
 VQHGVfPpJgTn2Pnd3K+gvZxzT55K0pk56lsUIouL2053ejh5D8tpaab06Y0ZaWdh+rHCV5kg8
 hu6lead3Z0iV1r4BzOmPrFLoSk95f/9FRv+/cC/Aug9CsUy0C3qU6f/1XlAzF4BOIpm8RtT83
 ddOA3PPi9jZniilMOJnMpjtXqHE/ZNxME1zOuoic1AFJzmDB7OtBuGTZiX9kl6L7WrT968OnB
 lIVEJeXgG4B/wsjFQPFvSvZo3NqLlcDwaIyKSwlTzkVaoOawXgM2u1wOZfCC52W5mXT9FnOo2
 o9ltEYec9tl0qW9FbeV9rLx4HqREdnlokffBW6cErpwUJqBtwsXN59xosjvGq46RG0x7EXP/m
 jho4uIsBkSUbzQ5nFmo/8v0S95zOcgkUJrAndAtzwP55aJEqZtiXT44FRTdcFCo1gwLf/Xhz/
 F2uNj7iqaM8Orfo7+oNeXd0uGYaTMDzKC5TKo2WQKPCCwhYBgRbn+NgkxE2357Ndm89CY4NUX
 dvhvdwfxVMyQq0NujJSXWQxpySS1TG7/7aTkDbouRw+HiR8mvKM1FQgzt2Z9vTKvyznQ0FAtW
 PM340eetSqPNQ/DfLJDogNgw9+KYPWKqAO8Hy5hv4GuAKLtwL1vL8EElBGI75qBFjW4332i7k
 7gWPpF7+XDJ0fypxIGYup1ua6Snvmlo94ZHUNw0MtxZlDogCUn5jjI+Zmaez39owJpSkbiOBl
 ZyWyfUlGOrItm1vuxZgeMSRGunsoocs3dpGq3GQrBmpW6XF/PPrl5ahPo16cRQ2KrxX1BwCqJ
 rkbyp/rOu1uv8cQW9b0ID0tnx4gSFaoQleL9IIwPn+iKBD4CoVbj0saAsWFpZsZxV9lw/Q7sj
 2ZEIOpo96vw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 14 May 2019 17:18:24 +0200

A return statement was specified with a known value for three branches
of a SmPL disjunction.
Reduce duplicate SmPL code there by using another disjunction for
these return values.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 scripts/coccinelle/free/pci_free_consistent.cocci | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/coccinelle/free/pci_free_consistent.cocci b/scripts/c=
occinelle/free/pci_free_consistent.cocci
index 2056d6680cb8..45bc14ece151 100644
=2D-- a/scripts/coccinelle/free/pci_free_consistent.cocci
+++ b/scripts/coccinelle/free/pci_free_consistent.cocci
@@ -25,11 +25,11 @@ if (id =3D=3D NULL || ...) { ... return ...; }
     when !=3D e =3D (T)id
     when exists
 (
-return 0;
-|
-return 1;
-|
-return id;
+ return
+(0
+|1
+|id
+);
 |
 return@p2 ...;
 )
=2D-
2.21.0

