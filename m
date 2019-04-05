Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50F0C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F75217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="M/FtXUgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbfDEJTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:19:23 -0400
Received: from mout.web.de ([212.227.17.12]:43945 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730173AbfDEJTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 05:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1554455934;
        bh=vfd1+K9eMRFBzj/8bcKznUUdQR/xBp2pVruv3YcAvUw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=M/FtXUgOPdo11cUuLj8ZCUb8MZRjxYLG2gx4zGAEcHCh/5iao1hB+/Aj48nCa856L
         dQ2zxzJLAvTZ3qsMs2V7qwRIzUqn8ct9PigomsJxvbKl5DmOM9NgKV5KsQ8V0B003W
         BoiTluMn6zsriVvqdYxy/XqUwAS6l3xQ8rO1N/Es=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.156.119]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MhDgb-1hY6yF24or-00MNmq; Fri, 05
 Apr 2019 11:18:54 +0200
Subject: Re: [1/3] net: xilinx: fix possible object reference leak
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anirudha Sarangi <anirudh@xilinx.com>,
        John Linn <John.Linn@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yi Wang <wang.yi59@zte.com.cn>
References: <1553223849-7143-1-git-send-email-wen.yang99@zte.com.cn>
 <d2f169a0-b982-82ca-b2f1-963b8a579504@web.de> <20190405081339.GO32590@kadam>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b58d4aa3-198d-c75f-7a3e-319ce05c7f42@web.de>
Date:   Fri, 5 Apr 2019 11:18:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405081339.GO32590@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Svi/5ALthkYGdqWg6VERZlUqfDb84yI7mmhG82pYPM3nNPr2KHQ
 1P9IqoXec3uRRC0MwsD+E6a5yeZLdNy2iWDj/NV4cjYKUdDNapoy95Sc0B1y0Rlg8395il2
 AWB5uo1FK0jdk3FzfHRDyUDv2A3efXJ52+fechDHj9fE32FrOkN5mxziYGf1P3bnHrb8eaT
 suwp/tt7OIetrj27+X+tg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OUd/Io2pUxM=:OZ0yyE1L9YIBsrWeU14ptE
 Ye/R2G9u10o/wpRzr/1sC2hTecaaJ2RMes41SlXUvqrU+P7n03Wjq+8Cdcd75rVK1OSuzaaP5
 dUEhI3n6Ft4s9C7PgLKg4WM2csBJKsHkFHiotwRvVA7GuEFmgDHIM0RuT+vd2CEkWZ6VvLVwU
 5Jlmhaz+PBrASCiwhgT34iZskQBctAB1Ykf0fwdxnVl5q5eJ29LSPt1+MdAGyPZrOydADQNm3
 YCQMrnb3v7suY9J9tn1QRAOip8K0s2Kfy+DHQb+7h0bcsBZ1DSWrlfMFJZMm0jJRbbZiUrTa6
 xiWFIlwyZKOyWGpmJ//0ZUsIzthA8rlsbLJf4U7jjBCqDK8aficTyLZdBmUvBN0iahjlZPH9j
 khO3mulfI4WDFqhdLcSLsE1NLH/Gw2co6AhLvOmwR3O+rnfs6z8OuQhNqq+jT+GhrA4ANdFQV
 05Rh/zr/qTLRdAeAGHhtJLA8a2sk3DixdZKbQ8pjF/2TwDiQgLXtrfUCMgDao+jST/kFE198U
 6A1qL1GGbmQXhLa+fk9nNnhdutyfbUaN1I/HOTjgZfCJbwVT7rK84ZEo9sI+UHzvh/+ZMdHjs
 1UU0OJXTIjqllOQKUKjXGjjXohDnkyW9MscxuZInf1JGO+bn1QsLU4s9OGeJuMqoszbJrCFdi
 BKY8Sr9zz4R/L95CDKEERSIduruA0nIkJVa6KXvj3vTT8dIAi/W59sVEFakD9Q4YXv9PFfhRT
 yfKyjv0TCx/+AQkBq5hNGxU2C5uIA3oppeUDHtclIBd0cCjZcUNDPuz3ZsxmwcPMXRwRQ1HqT
 zmgtlgnb+dirmaWfG0lgsLThr45zuPFoiv22KYHnWlG41tzwGx8yleg6KXKVikcY47YbvVByi
 nbbwAK4p6BV9ksAfgM57hghQY93X+ZHlXrcTsntDDuv6LpoB8iopmSYP6X0OjWznzI7eRalvP
 XFq3Kr/QHPQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We don't have a copy of the patch your discussing

I find this information inappropriate because I quoted
a questionable change.

Will any contributors get interested in another update for
the implementation of the function =E2=80=9Caxienet_probe=E2=80=9D?
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/d=
rivers/net/ethernet/xilinx/xilinx_axienet_main.c?id=3Dfa3a419d2f674b431d38=
748cb58fb7da17ee8949#n1576


> and it's not even clear who you're responding to.

I wonder about this feedback.

Regards,
Markus
