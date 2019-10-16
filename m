Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29001FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA9421848
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="qLxpUWf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390169AbfJPKzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:55:40 -0400
Received: from mout.web.de ([217.72.192.78]:56909 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbfJPKzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571223325;
        bh=9hGM7QZW7K6FCP5fR5zNGHHeyiwHfphf+QDUF2oHu0U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=qLxpUWf/xVzEmb/ZVbuuRxdebcjcqLsHloMG67CqAc+2iRdZJ/oBl6ZGWKxzENt8h
         Oxpj0LV0RXcyE0szB/8vzQpVk1XGKf9L1oS9j4kSt/DLL3v8b0CeolWReXJCqbBP9X
         WMeIF3Ob+xNUZ2UfupD1EWbKPGYS8hYE9yLsp2RI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.85.206]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lrs70-1hubdS48as-013eaG; Wed, 16
 Oct 2019 12:55:25 +0200
Subject: Re: clk: samsung: Checking a kmemdup() call in
 _samsung_clk_register_pll()
To:     Tomasz Figa <tomasz.figa@gmail.com>, linux-clk@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        LKML <linux-kernel@vger.kernel.org>
References: <7933ce8f-ca1b-6ed8-14b9-59679130dc47@web.de>
 <CA+Ln22GpcMF5e8wjwoRH0wExyoGfta4n3YuaOBNDE+rfqhSZjg@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <285fab33-0513-8a6b-f30d-f602c4e5108e@web.de>
Date:   Wed, 16 Oct 2019 12:55:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CA+Ln22GpcMF5e8wjwoRH0wExyoGfta4n3YuaOBNDE+rfqhSZjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QY8HeRQ0+MtB9b2AjBwt9dbFhwe/aom547qm3b5oPTH1B4G+uDZ
 Qb1zzRWWF3yHilOPpYvKtNKVhDxOmyI/8+8AM5AvSw9U9n4QIFW/W8B+sr1Auew7CCn+bEW
 NDLU7PpuBwMSWmgUfCt5CFJOyTvhC7Js6Rt9f/5ONtIN2XBLQ4xKO2dpAp8xTTzLeLibx+0
 gVwn/vUYTEt19mqXT+iTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1QfOLYj7ivM=:CPU/xSDv17hkDhgeHtm1DD
 3CsE2JpFO06UPgn90VOPn3ChJKgN9MCFDxPCOJnuWoOdzNa3dnZbFB0PHXh1o0pXiMLT0ycf/
 GN50AUdYRglNSg/W+ngcS+BmQOGZ9uFFFa8LwfyX7P1exz4ajj7r59I1nQG1ZdUyKoawuzu1k
 cjKurP/J+vCmY74r8OIZ4wK1nNKNZ2h6HbmCTXF1XFC1l4ZJXgt5496AXQIOPHld2WDScs4cJ
 WnpchhljDvfP6MlJKmhotF5pq/Go2DjpRQD29IN32jaGqWF/u0AhB4eWPu1tZRVCijASapaM2
 1U9N/JKSSksV/O/KQYbGHRIdhEQg7aeLZI62d7nmiZJEm+1hRAlXmLeOj39FfJwZxuZVLYnAW
 53n/0IuMQKTW3I9lnoqdUk02Oi7K3i6JZZOM/9d4z+RDdYtxgn/Oz1gF3h2gn+NfHBzu488Uo
 XxkViVPSLaNL2rWB61rmJeLKGHifC9CyoJdFdT42llAfT6XJk6l7wQ5eSMoFwK41MnuLeN2Gj
 HpHhAwnpyL+UNJ1CIsrC7Eb3GpD1ztvtiw34mvpBpZ5qA5Km/itbylKbaQe+dl9yVoP5LKFv4
 hauLD34/LSZ1e8bArwrCTYQdFLVyvuJKfryamZVS0xWNmhQwDQ7l83/gjxnmuuyF3GYqvrYm0
 IJluEpDBW2fu+LqZnDS3RvekragfigKtz7K0RuQN5YYBw6dboe/p3K2U9EUQ2R15RtYCt663x
 16nNWPPtEeWcQ9AGrgCYy3IE3WCVGCpyxwv6bmDLKWWjTYEZA72o2f9kxkDCTzMm4S2S0idTL
 wo1a665Q0vYL1e721FcXCW6CU6n+suN0/vPFEk5QS0EyhH0HmRxjUcxijU/IQTODJqFPPztZM
 kOk99W7q7xM54XBK/deMd+KEogXdfSfF9pXUKE5Jg8+oWamb6MLtAcovhd0amhDeenerON8ky
 Lly8VJPzzy9yC3+/mp23Xl7Nj4/WvUotQZCYK79jkBxPWuZ3dyAUma6e7OvR1zF5LvLAYX4/+
 fV7u0oKumeIlzGdj++QQMaNu98yvua9JAQoM2cbMDvDgSHlh5H9QiOwM55fTYhfx0DIhNCRV+
 ANrDyVgEVjy3SdTY8wOuyzBg9MnZM6HjBhSDva3lOWdPbKQLsk0lFSCq2mup8/3LYN6fQR0AL
 3lefzwrG+8Wuzai/vO2zFwyLjwM9zd97XGf5/D/rcjTQG8bfSyBD2mt+8ud1c2d8Kkw8Kpp4d
 DjzgmGvu2y4OpvrY7exSsSYKFEd/mShvN8cYBoKXQLIFhMNexm8qQhuVSpgY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> * Is there a need to adjust the error handling here?
>
> No, there isn't much that can be done if we fail the allocation at
> such an early stage.

Can it matter to perform the setting =E2=80=9Cpll->rate_count=E2=80=9D onl=
y according
to a null pointer check for the variable =E2=80=9Cpll->rate_table=E2=80=9D
because of the function call =E2=80=9Ckmemdup=E2=80=9D?

Regards,
Markus
