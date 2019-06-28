Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156F0C5B57A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AB4208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="h9MlfGsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfF1OQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 10:16:37 -0400
Received: from mout.web.de ([212.227.17.12]:56307 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfF1OQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 10:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1561731374;
        bh=EhlgD4OxUpSkqoFWG7/7Dq7I5UiCGhuvGXHoYj+a1Gg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=h9MlfGsw2Xyi+Mh4ElJxdCkyyNjn+CwrNaAJGNi39ludy5CJNUOhqhsdNJfRf67ct
         jCmLgSObBxWBc+AbkOup+ygKy6EUXmF40NKeAstdE0c78EB38CT8VyLl40rMAQ4wMB
         ZDs8XqPvO+AlwQsbbJcPbGKIWxR9Q4TocB1huo6k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.53.73]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lopa3-1iDkiT0El1-00gtGZ; Fri, 28
 Jun 2019 16:16:14 +0200
Subject: Re: [v2] coccinelle: semantic code search for missing of_node_put
To:     Julia Lawall <julia.lawall@lip6.fr>, cocci@systeme.lip6.fr
Cc:     Wen Yang <wen.yang99@zte.com.cn>, linux-kernel@vger.kernel.org,
        Yi Wang <wang.yi59@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <1561690732-20694-1-git-send-email-wen.yang99@zte.com.cn>
 <904b9362-cd01-ffc9-600b-0c48848617a0@web.de>
 <alpine.DEB.2.21.1906281304470.2538@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <36196c4e-a09f-3d0d-5a08-68fa53ee740a@web.de>
Date:   Fri, 28 Jun 2019 16:16:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906281304470.2538@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6TJzD2OmbcEscAXcpelpi6muhWm2XruDunxrw6Hn4QD7cbKMWEv
 jaUb9yB/oshUFhslLAKq1uMMBk3agHq8+KruUQlYg3/reQo1ZTDEL5Ou/QfklU18ulO4TAQ
 B5AycFN2RAFswnpfg3aBMi5MYHdOAprJFGFRp5sM9ItrFLuH+ToDmBRTC6VxQmY0k3dAJYd
 qAFHTRSziJ7GSBU4nG2sA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0GExo9EVfMo=:gzCcthGy6SzAXhBtSASr76
 tcAq5wkIF0hMe0eylDzNtkQteMtc9o00i+MCE3nwuRzNQMqTY4vB9LxR0mcEA+OqWYHxagaGl
 5bgrv5tiFDxV13R/9pQ43evQtDTEIZ/qIsjPjQ7v8vjbyrzrHwwUdu156kuss6YveKHp8+USw
 EZUKtb5mem1iTP+Ivote0y0JMpXcnDlQ415qxs5C2OBxY3NeU4yN2OZPpowPsr0lcOUOnp+l1
 tBTloFYVLy91CkNaKrVEwjSDG3eIVD3yox93iTOeQLl3qhoAFzIy3FAqeMGyK1H05Alsf4wKq
 YoBrhaWm9IECPOd0y1tpkrm1HwgJzl4hgf4WFlqGpen9VfnsuK1QFSvZ5bmAPXr5lDREzsADs
 sLtm/+JfrRBRR/gse3TrCSANC1J3lA5IGSSWstnwv9pGJ5hOAQbZi0ocurqnhIItqyOSxmeFR
 9AeWqU+etMBahneA6AmJjdVEtk/WWtsm4v5KIW3iDd8ZQWRVk8DE13e2SCLA9PMSglLzOB5ch
 84pKdILbxbspVqDPiMvFss5kMi9lqFFIqU8iYzubme4r49Ly4/+I4sDtBgNc1Vn8d1Xx0bBDP
 Qywg92eOkUvX7ok4+Gmp7xP1Z4oHUird9l5aYd6KEW/0RsxEFZZMQBSs1k3XdgAWF+DH96HFr
 6T/XVykTJJugk38WY3HFFQA1UmjtJek2Z1E0H4LVKnkFS9sFpIb7PmK/nozwShOFtjXjwivzV
 WbF3cJ1+TauUnSNjtvm93okuJTRQN4DyfC7q29lEhZtUkiPc8jzmUycRhGpyINCBXz7riNMhi
 EuYxUEvZpXeE77DnIfNiOJlrQeITRaSU6qguLQn2qMrowW1ajVQGYCrBVFjNKV7IXturhBTs8
 KkhzhluqboTz/y6DF4St40mETBIji5/MGWYwdvZVE0jM4mlHAsEAdul9Zn0j62o5BVx2U2Sm7
 gU/KCI3uOXZ8QxVcNyA7RJk9NxzABaLz41mLGrWJebxB3iYYRBcATENPftJbY5SLBoNSyWgL8
 iNxIGPd+LfP+1IID54KP/aIP7AP6MDqFGw7FTuz9sYFlYk9aNKVFQn1hVaUE0F11x3c4bGWyb
 XPQmQdhw1BoBzu4u6Ocg1tn2cgotmRh3H18
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +x =3D
>> +(of_=E2=80=A6
>> +|of_=E2=80=A6
>> +)@p1(...);
>
> Did you actually test this?  I doubt that a position metavariable can be
> put on a ) of a disjunction.

Would you ever like to support this possibility?


>> +|return
>> +(x
>> +|of_fwnode_handle(x)
>> +);
>
> The original code is much more readable.

We have got different views around such specification variants.


> The internal representation will be the same.

I imagine that the Coccinelle software might evolve into additional direct=
ions.


Regards,
Markus
