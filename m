Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A90C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 18:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044342196E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 18:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="EH1vmoja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732576AbfISSRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 14:17:43 -0400
Received: from mout.web.de ([212.227.15.14]:58675 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389923AbfISSRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 14:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568917055;
        bh=Mn7H6xHac7+YgWw5ExZQ7NpTTpj1wObuTz0x0wOxj2Q=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=EH1vmojaA3Mu1SvLHPR1Ot/MQjBuxSUqKgVN2AVrGHxWTghyE+e8IJYIq5ZtWXhkX
         Qjts9BZ6AmyBj6n65Gd7ioOua/nFm+MpIawOSbI2vH4IV0AAFu240BZk9ILbGpaJdn
         p1Gax/KiYfLKjRCF31IcT8N8wgNx5V5KXCViotQ4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.191.36]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lc8n7-1hlKsU2PcT-00jYXi; Thu, 19
 Sep 2019 20:17:35 +0200
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-ide@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190815060014.2191-1-nishkadg.linux@gmail.com>
Subject: Re: [PATCH] ata: libahci_platform: Add of_node_put() before loop exit
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c61069af-29c0-449a-a07f-c89c5a5535fa@web.de>
Date:   Thu, 19 Sep 2019 20:17:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190815060014.2191-1-nishkadg.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nzKw3wyZsubFjlljoNomFG4WACDEUOfE0pZ5d82fQgTkMxPisve
 N48RqhZy5dh4NUIG/Txi5F4M83FzyxGQ1UmUXZpYe9WfUxJSHXG5MkNUYxb3crKZDv+L+wo
 2gHoe/gp/YObShqOXbh5I3dQPbVHpgAvkgLRV8pZs+zO/e69N1xgXBtaF068TIgVtJyDJKh
 oNcSayVpLN3umSWziN+rg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E9+fhUT11VA=:aZWTWHgIDupJsEg6T54BOf
 jj4ty5ysJSrCGCqRYASBI5T9zxYCEys+aaHERFWuaTalq+FtePuV8P7LQ53QtK9dtinUO7BJT
 I26Rqc0PgJ4VpYUn5tdecvj2OrIAp45RUjrNsyDiNV2yYChYzy+eHlBKBsu6TAT+I22IpLW1e
 GjtSBuPLBTInUw5i5wGLKrUe+HPkZj30oc9Ar+MPd/KJHsvhEi2czbTEncjZJFNAl3wuqPGGk
 Rl8I+IdJuPUkGZV2OZHzXHZ2xWAIl905roEC69+woF1Xx4COZCgjMLwJwDmHBc+RK1zgCn1YL
 mk1lYmxHDxozz7S6wp4nvU3JWMqMZMqpnPLEHNqvdj5RAtJzI1S9N70cUPK/AVzfmitM5i1jH
 IBqxu5G3bvvFOqZE4bHKWpRYdH2E3P+yIudUbvGLkLe0K86ywiKX/QpdbvMsNVBtioBhJP9pK
 bM+bVVGXcKpLaVsqIz/vip9BJ9jMBaX8dMg+mXWkcMSKtpcRjflf9QQigJ0uDV6B3/Pg5oz+I
 dtrBobtLZ8IerMYsZDUbco+FDLItoFuJJ6n2943LzoH92zsJXBVon9Y/z0geUXZto9PwTMPHC
 Q0KQjaHqTDsnqpzUwR5jZBa51T/eqB/8UHTUNdLy5VrkbmVII5PpvvNZ+RtO8jZoR5qCuP56P
 J+/5n8Tft7pTAKL/mgAsO37Ay9FIhCSzgGsIIR+o+v9pneTGbBc4OYLf7auKwiDz3cojQwTaz
 UudOt/GCup0T/3Rl9l+UvN2++h4PcbajbGeRMaK1r0s7vvHp7VcqVGgyYwyHLxqe6nO8ENYcQ
 pgMtPj8tgIIweBb+E9t7wghzutykqAcPwe5ZP8ghLT3ImCGrk+Zc61hq5aD/5+wKid8G8Y5yk
 ALMawDGQPvYG7VLow1OQV3+pVPg1Sk3Fs/v98DReC/OBiokA7l+YW8Dw+0k+9bqaoqVYKbOqw
 tHkPS/qt4PuaacZ1FIRKtFSzkBpQLPezHDPZwfHRRzym+R6HeyfK/Qc/e/jcEyPbcc0FNqd/z
 LIep0wC2J7aF7ITMSQKUJYSbOH+D/XeM0acwEXcBNgsiISdZhLLIzvIgBCamZny5WqIBRUJID
 nRC9iXpCZYNpHZiczbDzPw18gauUDjl7MQwFf0pMjGR2hg2gec8yQ386V2SI12fBzdfNi5eRb
 UEie80jKIme+VkEFOUXY7/1PtKl6TN9uE13WrLL7jbGRdM2+Kizy6xNBHRrMQ+nU48Q02gxh2
 NW9TKBKH4XaUllIkCUvKIbGsL2X2+iVAzujKNSQcNUuIO6fgaTSVJ/JgfS5M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +++ b/drivers/ata/libahci_platform.c
> @@ -497,6 +497,7 @@ struct ahci_host_priv *ahci_platform_get_resources(s=
truct platform_device *pdev,
>
>  			if (of_property_read_u32(child, "reg", &port)) {
>  				rc =3D -EINVAL;
> +				of_node_put(child);
>  				goto err_out;
>  			}

I suggest to move the added function call to another jump target.

-				goto err_out;
+				goto err_put_node;
 	=E2=80=A6
+err_put_node:
 	of_node_put(child);
 err_out:
 	=E2=80=A6


Regards,
Markus
