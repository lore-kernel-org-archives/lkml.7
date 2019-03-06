Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53A3C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61D020684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="gTgRimAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfCFLSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:18:30 -0500
Received: from mout.web.de ([212.227.15.3]:51771 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfCFLSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:18:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1551871093;
        bh=dkC6c7XltdejrNRH4toIXc+41IHTqRrbUjK4KrfcU/0=;
        h=X-UI-Sender-Class:Subject:Cc:References:From:To:Date:In-Reply-To;
        b=gTgRimAd5gMe5x62bLDOfhWLTYCiMoPx6Mn3DeFjucMMCmoyrBCY5V/V/uYhlzC1x
         JaNVbvLOgZafLI4Yyp/9/cf+MehoKNCS4vikipe4cHsLYQqRVa9S3ieZk+RdOVkSgF
         Tc3QTfL4h3DpYwHyufh24Ko+WX+9ggXHJBbS+tEU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.80.135]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LvBJK-1h9dmJ0fLe-010LcN; Wed, 06
 Mar 2019 12:18:13 +0100
Subject: Re: [v6] coccinelle: semantic code search for missing put_device()
Cc:     Wen Yang <yellowriver2010@hotmail.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
References: <201902191014156680299@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Wen Yang <wen.yang99@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>
Message-ID: <26dfa462-296c-6daf-5f22-30c20593c9cd@web.de>
Date:   Wed, 6 Mar 2019 12:18:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <201902191014156680299@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:zRt0TW4S+VgctpkkBMCnziMvTR2UdYKZxOBk8vsXqnDy5tmI32F
 LxESADpU7g2Uv3JKpGu0GkYpJLgZtMejZofuzDOumutUkX6HpbFiKCcMu1e80UyBNpe28RG
 QrK/c6SN09Y0btTYm4kIxQebmYnWUvX9l93Dcq/xWLFzPcKr1l8MYdiC1ydMersVps49ChR
 E7kVinvXW7pG0/CCuBkdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xOQ5jjph6q0=:DaTtkJHzvU+D6XH/L4YxtV
 c6A/copolht319FpZw9FRxLYbzBkWN4Cg6x+Edm60fieqQtFfT2reV41/i+nihORWLLwQgl9f
 8eTk0w8MJBbgDeRZByRlC5tkTyiqtX0H6AUCQ12CSuWbMoGuRaARAwz/p84uk3V5Y4Y+lRJ5e
 cSmtvdxYLP1Xtst6vYPFmGoP67B12dARNX4M9wiWczg+n4FioPvhBr47e6BFg5lEh8Q5sOjXe
 Yyy2YdXS6TAc2SZqV3W7qO04+SJtSQZTHHxYL8ngw6pm5X0eOnNNNx6pPFtsGTbV/5Kn22Dwa
 duthj2VT/8n8HjPDRGUWRWqEdWHiloQoU1TkEy91uFCad8C7GCpGTjQOEKs6l7grjhlfGgVcp
 gAd3c3jOIFs9E24vN4cpn2LjQf8vW9eX8Ld4d4RoDiStKQtU1kq01Ks9Mkam/SAKHLtkD4cVa
 xg2cHuJeUZ2v7FZ0QO36yMAydBZQwaEYvzYyL5491LwdNfGHi0yJ+f3mqO5CNOcuf9YsFMLIP
 3H+H6S4fuwH5ai1FLnxjf7aVovebeq5pdsRQb/yF4D59EPVzI5Xsza24iWAe/oquX84EFiN0g
 in5sMz5sM2ykAQLLPK6IMbK6gKxdd5NR3rzuu+6uDZuRid31nBO8F6Kk/u2/xT0GqD6yOU8dn
 HFk6J9D96PKwsmhSohJWitaRt+sMWrfeNxBzNp+8wa8rSxcS1oPSOKsVBrC6rPJkkifkPqsiO
 iY6YHaUoOv6yo0+YVSCSnZ6cd0OXpLQZz0/W7STpZMEnzQOblXx7h0OC5mihOai3bFkVqza2+
 Ya1ZAaYgwCyhPgMAifgLueKuXGeebQAC3Q8WRfC1VRNrl1qrJLsCBaHzad/qfruB3LjJaFsPG
 lsxQkDIaA7S+5yfh/Z8b2OZiyJIOANp1hlglvTs84V2tYujlYAr5+JokxN91x5KC2fnxzOhB8
 M3ymKVyF6Jg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you have any other questions?

I would like to point another aspect out for further development considerations.

The initial assignment targets are (id)expressions in the discussed analysis
approach so far.
Would you like to care also for value (or pointer) initialisations by resource
allocation calls at the following source code places?

* Variable definition

* Designated initialiser


Will possible software extensions trigger interesting challenges?

Regards,
Markus
