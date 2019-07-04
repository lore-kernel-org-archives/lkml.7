Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65E0C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659DE21882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 05:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="dy/Qns8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfGDFlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 01:41:16 -0400
Received: from mout.web.de ([212.227.17.11]:49397 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfGDFlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 01:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562218854;
        bh=k9TYF9HKZzXLhRxDny7GgaR04jhBQklys5OUyA9vKOo=;
        h=X-UI-Sender-Class:Subject:Cc:References:To:From:Date:In-Reply-To;
        b=dy/Qns8rnU32Yh8aTamyG4X4xMplOHlbhE/tYUPzDPo7UKJ1Vu3+b0391sEOFbWan
         DAJxcALS2uO9nDahC3EshchTNXsHaQNWeYg/EhT2/8PF7GYn9XPQPeteHoanSDc1Op
         4XZTPpYW1FawwdeWuirADpd03Ps1jollomQmtsS4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.138.50]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ljrdd-1iFVHj0fiz-00bvap; Thu, 04
 Jul 2019 07:40:54 +0200
Subject: Re: [v2] coccinelle: semantic code search for missing of_node_put
Cc:     Yi Wang <wang.yi59@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
References: <201907041041053843118@zte.com.cn>
To:     Wen Yang <wen.yang99@zte.com.cn>, cocci@systeme.lip6.fr
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <44be5924-26ca-5106-aa25-3cbc3343aa2c@web.de>
Date:   Thu, 4 Jul 2019 07:40:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <201907041041053843118@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NUL6USSBmBUdj3c+K1ytqEqNyKEsNC0L9lewvJevzjoFCdcoDMy
 hmUvqTJvetGjOp2mz7Pcn081BmWJT1IU/cXPupJGIOlhGUEieB9dz1xh1neRPtUUUtBnrrg
 Luz/L0sfXG/lTRK6BpvFsZHRCM1HfS1u+bJFMuv+UZ85DmzSAzMzPBOSvOZxOI/5yCie4XT
 KKqqHARkWGSh1F4Fygy/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2RkVUiY/UBM=:q4sMI+xPchVHDgt15IfcNi
 JUTP/KP61AXKb/5Mg3zCxhr7XT8w/8neyByZniGpQlKfguR5ggI8kDb+1JvRISb2Sp6G0+c15
 MICTUPzYwEcQlpUylcJp1cipY8RhbRIVaFmo0k5ebnyWSpjK7oSoPLJeMB1fEjenpz8U+VwUd
 ytjX8BzEfLmDqWoghP4xPoBttxJQVwE6IiNAGyuK5nDPTAODrMmNNjIOWy0RVyH5JTvgPfz6T
 z2C/utClYG59DQaD2YKXBrkE48LRE9sWAfYN2onVPT8J9wfjwiSABMfyEATkbwdodkdXH/ZxL
 5ewDM1zyCGHpEDh3k3/Pha+uN8xlFggaqFq+cWPosT5Oj68XxGSReLCEQLxMoYKeooVO1piTp
 MkaLTH2UdbDHTrm6OZETGFSQQNaQfJVQkXpTH32GMGEWGsMWZmoeIptvkj2I/uxRruqK8FxKh
 IbbqUK2rDlLDvJ41uTzgLlMw2E5ocMxH0JrsH2JRUL/OY4XQOF3wve+uLjw6HZxeRaV4yfKdb
 zr1QXvexB/14kSdXJ+JRIB86ofuxm4jjA7+luvNQc9hTru/zE3iQ86BKdBKmKjXNlGbH2P9ko
 lgdX+fHebqGHRtHI1YrDp7d/jFwTkegV3Br9iXDXSlOFpUK8X89DljVTj7slJAXqVp+VLSuhm
 1cONOFeVv7ioFWbqMdbFriBCnG2R4IOOTtyuQHt46I+BfGTAxX1p8yvw2rl2jlRmbSDysdBRa
 UI/0XlHuuY1YAIyHL215coSDDExh57B4oS4No9jSxHupyPg/BOwy8Wdt6SDy2eOWfR/FPq9DZ
 Zr8Dpof9kPDGb+fobOJIvK10Z5/xDole3vWl96Dep4AlQ2/ZBKkjqoSW/BSP7OBfsgqR4jibq
 hCaN9XYwImZtNGDyX4lh93DVObwWiTRkfNXGAE4m/RMO8MgabBaspBirIor9ltg14IDWIGzK2
 LYfRcgnxOls5iaay5oDSnjvPLhZpp1dozuJoQCxa0gTrxruGH23MgtVCCBdb+qSXXNf0A37Ve
 dZV54oJLKOZLMlcxCrCBmJhh+bVrj9QiXJaxhrctfW8bhDif5Rf1tk0pso4FzEnrZAhhl9T5v
 QdA9RSfAqRUx72YW8neauhPGBK72mF/iyda
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We will also provide an example written in Python later.

Will the code move from the commit description into a file
for your next patch version?


> We first use this script to find out all the function names to be proces=
sed,

I am still curious on how the output format selection will become clearer
for the potentially desired automatic data conversion.


> and then copy these function names into r1.

Would this action be performed by another software build script?


>>> +@initialize:python@
>>> +@@
>>> +
>>> +seen =3D set()
>>> +
>>> +def add_if_not_present (p1, p2):
>>
>> It seems that you would like to use iteration functionality.

I am waiting on another constructive answer for this implementation detail=
.


>>> +x =3D @p1\(of_find_all_nodes\|
>>
>> I would find this SmPL disjunction easier to read without the usage
>> of extra backslashes.
>>
>> +x =3D
>> +(of_=E2=80=A6
>> +|of_=E2=80=A6
>> +)@p1(...);
>>
>>
>> Which sort criteria were applied for the generation of the shown
>> function name list?
>
> As julia pointed out, your current writing is not compiled.

* It can be needed for a while to specify the mentioned position variable
  at an other place.

* Would you like to adjust the SmPL coding style here?

* Will the application of sort criteria be clarified for such identifier l=
ists?


>>> +if (x =3D=3D NULL || ...) S
>>> +... when !=3D e =3D (T)x
>>> +    when !=3D true x =3D=3D NULL
=E2=80=A6
> Our previous version used the "when any" clause, so we need
> "when !=3D true x =3D=3D NULL".

I suggest to reconsider further aspects for such constraints.


> We can delete this code exclusion specification  for this version.

I would find another assignment exclusion more appropriate at this place.

Regards,
Markus
