Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B421CC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8DE20848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="rVpGjTcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbfEQIK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 04:10:59 -0400
Received: from mout.web.de ([212.227.15.3]:53359 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727624AbfEQIK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 04:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1558080628;
        bh=J9K+QoqU3UYtwvJYsuBhvqWwXGcC/7TdWOUbdomSZwI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=rVpGjTcpFWfoS0ZWe0cWAiqx6vLuRMfDjUopX8dwLRJNZGU+RvgMJDrATdIBN55tS
         2MZ6HUFunAVtZoH/IXGpXvVl1wmj1Sik/q7sRUUZHd3cSPy2tYP2T4ys5QsoMFtKVu
         5FV0fZ1N1JjMdQEq9aZaXhCRIV8NVxjD48X6yVRY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.147.35]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lr2Yd-1gnpfr1pz9-00eZxl; Fri, 17
 May 2019 10:10:28 +0200
Subject: Re: Coccinelle: semantic patch for missing of_node_put
To:     Wen Yang <wen.yang99@zte.com.cn>, cocci@systeme.lip6.fr
Cc:     linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <201905171432571474636@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <44112f31-0d96-481d-cc5d-df84c348ea15@web.de>
Date:   Fri, 17 May 2019 10:10:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201905171432571474636@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2QQf5wMT8BFQXEuNp+xGLX1Tt7pJeeig4OtXxPGl10zK1+0j03E
 Oj1N5VcdbhYZlVR9Wmt48v/g4Tk8a5Y5IjkDqUHKXOTaxnee5ukBazx8/L7A4SsVW2erW4d
 /R27sOM2mtHuDDlyoOINN9N7dov+LJgwG1GVICKGHTtrXACzvrJPXvnXDhrPtTtF1G3feqB
 NzzyrY27JSWUCjCTPrPLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wDyscf+bBdc=:2+u5Sa4yN1KdZRx9KQRTQy
 VxSv0CVgkHYNOEgfbCFIexuPUbIeqLU3qIjNHuiyOKuLxdJlcJZS8EWU3lG1Ppr2qnDpgI0oI
 5ZdvmArbY64k0a3cSQk++R81er9zqj9ydKZ6ElStfNzDeudYTvTOlFeMgEXn9rJYLn+P9Yx8Y
 v4IvDM8XSXAD5MAiRvEJiFyjvkoXmZ9CRrYrC7jTVU4Fblbl3s2GJbu8q8jDx/l/Ilu/LdI3F
 ePxvZ/iJCiwAW2Edh781DrZ7TynQxyHeEk3kgfAw73QofpSMOqipXajCEtch7jrzmdxVgsAKO
 qU1Z7U9goodzzIqqLx5o4XOxpRn+HwuzzeI2QggcqcTg+OZrYJgef/XGsDWRcfSaRNALfhe4V
 USGkZLCBeoJTU68+XDwKLc40ZB8wTQnptBqsYBjKM2SSO1jukn54hytasqSoN1vaFx107asZB
 L99o1TJskd1Wloca/wVYi+8gWY0mGJpIKB/rmLXpWxNZNqR4OM0cj//uVseMA5XsY9g6JTgXX
 bRTLl79z2x1UM8xtVPJQPR128jsSNyKGhVVGcarBk/Gv7P5D7H2MFST5+SdXNEf5oZd3tMYaT
 2wybMRqkQp9uyfElH83m+kcrBEuy2NDL1xeWK7ieOL9dsvXIcF+3PcdCDZAk/GVSTwWFvjy4j
 pNQoUZHz8kQos8FmHR9Gbwxe5QNEIk7IR3Q0/ORsFQeIi6wDTIOhfdIR7XRPqZGLk/hnDFKLr
 H2dkxNfitotcrhBhemjDQNxX1h2dX0X1u9OnWHNA2stfViVN/pO3WTx++FHABl9CRK1cpu8M7
 3SGuHufv+jNTAN1rHMCcPUuSiLzomqR5IJ4Y2dQdUoyBmZmhMIsH94Q7OkDi5sDuKqKpQ45dn
 ePvOhwxvSK7ok/c+cc5G/2eqI9ZqQ6HYuHAletwiBXrgLDdB7gW7r0CeZCuCW2JOKtSHSuagy
 3FVH5WdbPkJkRbosbSYp0qdetKgYSipEwtHH1LyuL4RnI3QD3ope6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 1, A simple method.
> We did some experiments, and we could get the list of functions that nee=
d to be considered directly through this script:
>
> $ spatch --tokens-c drivers/of/base.c  2>&1  | grep "Tag3 " | grep "of_n=
ode_put() on it when done." | awk -F " - " '{print $1}' | grep  -o "of_[[:=
print:]]*"

Thanks for your command demonstration.

* How are the chances to get these tags better documented?
  https://github.com/coccinelle/coccinelle/blob/66a1118e04a6aaf1acdae89623=
313c8e05158a8d/docs/manual/spatch_options.tex#L165

* Would you like to combine the texts from the first two greps
  in a single search pattern?

* I imagine that sort criteria can become relevant for
  the determined function name list.

* Will a software build script be needed for this purpose?


> 2, A general method.
> We also try to get the list of functions to consider by writing a SmPL,
> but this method is not feasible at present, because it is not easy to pa=
rse the comment
> header information of these functions.

I am curious if corresponding software development challenges
will be picked up more.


> @r1@
> identifier fn;
> comment x;

This item is not mentioned as a key word in the manual for
the semantic patch language so far while the word is used
at seven places in this document.


> @@
>
> struct device_node * fn (...)
> {
> ...
> }

You can not get the desired information if a metavariable like =E2=80=9Cx=
=E2=80=9D
is not actually used in the SmPL search code.

How do you think about to take corresponding source code positions
better into account?


> 3, It's probably interesting to get valuable informations from the comme=
nts of a function.

Other development tools provide better support for this data processing ar=
ea.


> We will continue to learn the source code of coccinelle and try to find =
a way to achieve it.

How will the situation evolve here?


> Please kindly give me some help.

Do you find the following clarification request interesting?

Fix two calls for the program =E2=80=9Cocamldoc=E2=80=9D
https://github.com/coccinelle/coccinelle/issues/111


> We will continue to optimize this SmPL and send a V2 version next week.

I got another development concern in the meantime.
It seems that you would like to use iteration functionality (add_if_not_pr=
esent).
https://github.com/coccinelle/coccinelle/blob/99e081e9b89d49301b7bd2c5e5aa=
c88c66eaaa6a/docs/manual/cocci_syntax.tex#L1826

How will it matter here?

Regards,
Markus
