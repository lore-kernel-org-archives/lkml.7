Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DAAC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 05:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18D520867
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 05:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ikJYTCbc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfJFFVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 01:21:44 -0400
Received: from mout.web.de ([217.72.192.78]:41983 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfJFFVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 01:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570339275;
        bh=Gzwjj7P9wQpJ+/SFZL5s/IigHlX0dcbFlXIX9fH7eVA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ikJYTCbcHu82jjzFxtXbePWLIr9nCdQFyNt/ip0qveDzK5Bhu5SrwCoZwhgBln0q9
         AD9CXYoaACmNa632XUl9mxtI92tGsvTRAeoe6XtL68nz+OEHgvU0N3TpUwWftIS2je
         vyQnvG0KNgsEzEQ6oTpsAqpwEcO7yfaKB7oi2qcA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.114.140]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MYO45-1icaJX306L-00VAOa; Sun, 06
 Oct 2019 07:21:14 +0200
Subject: Re: [Cocci] [RFC] scripts: Fix coccicheck failed
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Martijn Coenen <maco@android.com>,
        =?UTF-8?Q?Matthias_M=c3=a4nnich?= <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yue Haibing <yuehaibing@huawei.com>
Cc:     linux-kernel@vger.kernel.org
References: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
 <21684307-d05c-1856-c849-95436aedeb86@web.de>
 <alpine.DEB.2.21.1910051425050.2653@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f64fc086-7852-b074-6247-108b753dc272@web.de>
Date:   Sun, 6 Oct 2019 07:21:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910051425050.2653@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XVYI1s9CF/DzmkQbhpyKPdghNbOybt89fDNSP+wQNrMXl6wQC9M
 StU/7dwi8q0jN9nxp7vYWjtPbDyi4sbQYLyUNL/wQdlXTNq8H7CjGfzNsl9Z4CqvOd4VMg3
 sljBvqrOZxXYlQ2Rs75cNpxWcGXu9O/j/fjAPfOtnwtbTXkyUAIus6CZcoySSV/za42AEdD
 PMrKt5BjhtbbVMdrEGXvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y18Sm5TQzm0=:MlGQbqacqjgkdIs11qgG84
 JpLb05MQe5mkGqDyWACsnsIQlaKUvOfqEhK86VFcPpMy/UmpV3WqWU7lJ6uSJehk/W3CToj9n
 EsuOHIL4q2ZifX44NFBMA3ay1TzuRndkehTbXz2sHGCo56PbEr0VlIn3VcIFuWapLSRu/EpI7
 K8GbD1aFkJB6EpYwzPKVN2miv2YMuZotkcUKn+MGGR7nw/h6zET3hoof1lYIEfdR5o8M8s/t4
 lwby92SAKsYGPg2KlJaeRs8iRn27yolfaZjHriXZclB08tWeEIfr4W44/EGuC0zAwAZLmxAHl
 jXgEYwf+Uy2UccCvq5vz95E7o/6VV403pH1U2so/wO1ifG7ClfEPZpbWva9qHtppE6CUTP0aw
 Ozg4uR4ZM4ou303CP/2oKpEn7VBxltAWULb2Tj/CQ9NuUGgCYuP/HokIHp0mCeS5zVCSjepks
 UjdjvChk+LEKhT1KSmy7UuhH5F7a6dKSlnyjiSD/6z3m9SwLf2pPkF2bQW8h1J1rN+FqVYZp8
 4vASkrrSIfNI0emDnyKWdicgwIiXh8IU7g+D3qiI9CgR3m5nE45J9PYAfataYiVQg1acm2rFH
 R20tu5/1Z/Ga1Jt/KUlVL+aL46KTFe6nVUv7ZtY8qegIY2WxcJzDe6gR8Fwb/oik04GaEvB67
 TUupbKGXu4dW50YbY75NtKW7jaRL9G9ZhRnvURSlz/ZuQzp+uPe3MOiPvhHGGPubCbHkRmgYQ
 xysLgzPQqjvlUgpg4z+SZuIxVZ7pxcxOnnVM5TE7ED77p8sDbSTleKR1nvB85FRjziRsDm7Sm
 HsOdCAWUzumeO6qPRfaZBiyL8fZ6vQ0Dk81//ubhkRUyNm751iZfmxyRXrsDqaEp/+OXMKoWu
 PDqc6rdOt7iSty4tGC298iFJF74ksUr9hA4LD8MYGJqnaJp9U8D9wameM0ZJKZjHfi84Tu8dB
 Gm1xopg3cf039T2HyjUar4d96PVsGSe78LOymFxDvd269Ex5qhNlRxpP8TBp4gFtGg8PUCMqo
 iQSFi6WWwqHdHaTPdJFfvFFrFdOWlnloSJTwzYsaImxi2otCz5yObbsV0VX7FVNK5AxYun2X5
 BklY6grplEhz93FLKNe9gxTGk9JS5qeAG+HY4aN1IqxPzxhG74VMr1c2rQC7e8hr5XsKrpMbo
 5LXHkvaRE6JzGayxEQH0oypaW85GpQWkLhRm+8CqPPe0rbn41hesJqa+sFgWE6B0eM/7eAY9y
 QhHR4XvaLYzjGNgjT4UEWUq84xSHgbxp0+89wlri3byrYMyjx6CAoqhWazQU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Would you like to take the change possibility into account
>> that the coccicheck system configuration should be adapted instead?
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/scripts/coccicheck?id=3D4ea655343ce4180fe9b2c7ec8cb8ef9884a47901#n257
>
> I prefer the one line change for now.  If more issues arise one can see
> what is more desirable at a larger scale.

I got the impression that the script =E2=80=9Cadd_namespace.cocci=E2=80=9D=
 should never
be automatically called by the current default setting of the tool =E2=80=
=9Ccoccicheck=E2=80=9D
also because it requires the input parameter =E2=80=9Cname space=E2=80=9D =
(SmPL identifier =E2=80=9Cvirtual.ns=E2=80=9D).
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
scripts/coccinelle/misc/add_namespace.cocci?id=3Deb8305aecb958e8787e7d603c=
7765c1dcace3a2b

Would you like to increase your software development attention for
efficient system configuration on this issue?

Regards,
Markus
