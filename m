Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0A7C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 08:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93E72067B
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 08:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="DyGrS8iM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfJMIps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 04:45:48 -0400
Received: from mout.web.de ([217.72.192.78]:45967 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728311AbfJMIpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 04:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570956319;
        bh=tl46Ug4LUxpNSNf1sk6vaj+ltIONSStJV7jqb+dnayU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DyGrS8iMNnQ/RhFiIqBYnnqylo5pb/pVX0LGoyRlksJMoqh2vug/HgMKtruf9/XXF
         Pl8U6wgAGe+YkCAfnIh7i4xPLyQ15CNds/r69APHaxnfMyTWgX+uR90S0Dvan8rV3Y
         905gpicwnULLN9hJqQjxQXk93i8+2t5GGyDgY7tA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.141.172]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lfj2k-1hhTrY30SA-00pMp7; Sun, 13
 Oct 2019 10:45:18 +0200
Subject: Re: clk: rockchip: Checking a kmemdup() call in
 rockchip_clk_register_pll()
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel-janitors@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        LKML <linux-kernel@vger.kernel.org>
References: <e96505a8-b554-f61e-3940-0b9e9c7850ff@web.de>
 <5801053.xxhhKtLrcJ@diego>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <29d12079-d888-e090-da5a-c407c13d696b@web.de>
Date:   Sun, 13 Oct 2019 10:45:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <5801053.xxhhKtLrcJ@diego>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UbqXrjjtJE/QQqImZXB1Da6RMdTuLFjcUSAed0McyVEvjz70aVM
 dqqNSFUQsQ4eEcC03dZ8lYCY1slZg2KO11OwIHeG/GQQyM/MZEpC9h4kKkPKVO16xtGUd9S
 vdA3f7rkDCnWXuGcuaXZKBP1hyfLF8s8djJJQH62vvz+j7LX7Qm6ozi9cpoOhYdyRQiIFx2
 T313lX/HlfpPFcisZcqhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jy2QTgB97MM=:OOntxVwoPLLkWXJKzvKkoK
 OZO1ITqS1apzNa7Zn0Mas5FWGoHgytggc1ssy/84muhYoB5whzgthDiBMyhExejzYOPbf1rFt
 khIWTdNvyITXqwACDquNcqYgT1gfWr/N6P9M2E2foyHpyrBuywGUnS6hhrTsMrlwbaW8Gps7F
 JZMVWb+YNJYzxcJCNEwWjdqJCrzSvGQk0ucaP30hSGxhIVVc+CpH0ZLGtShR0fjh/IjkfsZlL
 yiiTlkgE+EoZy4yieplgeGsEFuyRbV4HS434/SVuks1HzuI++8foI6An9yU6Uaioc2sF5DobI
 w+OwXyJBqdIRu5dnmg+WE21C8PwZYbxCU+vs37dfq13PmvbTqCeYRSby1vfHgBKNQ9jnYc21l
 poVVbL98JkQraxtrfW1/V070VmZ84pQNFmZLRGxYxgbSDXPYg3+sMI03Sadmh7EVsXDpHp60/
 b7tB9hVXScaLVJnykBYzfgY8l7QdR5FMWJzQxPNsZBcIvwccso+n5MgJZ8CUOBePzEsUKyKT+
 RhLMQZJm/qB2noD9ae3DA41KJonf+fdhINDdyHTXbUyxZtnaP67oMrz9ZqZrlTLh66J/gISw7
 nHzzQV750x9zuJXQaHq9I1ywZWg9T82iu8bTkjQnLZF6+RapY7BKrAZc1I50IUWH1F2BiALxa
 YKRGwYfn7CSs87+RMcNgtTsEQrvNgbT9bsJf6aTsSdHQ8yDdLFl60K+IhIlohgurVpacqa50S
 6zaoflkfRnzLYK5aTp2IbBwbTCC18UKrfE7akiyg/RltdOdCzKbJ+oZj5bu6VyL3YaPhV3zqz
 k0gfxorDYwSCmzjDyXvo1UzuhSGLJiFPvv1l6Fqt7RBXaK7Ym46ntGl3JgZvQ6XFRjlnvJ0Uy
 G8ALUOfS1c6eQ9qQOYsGvbk9Ek9I8RXxvKPbkp7P1niFzY3qFeHOmooXPK8zUpQExA1+gCjkU
 Fv77dJcOK+XgVOYAGhumIHs//G4IczTgAaUS9V8GsF4usgJFkKECYXWKSoCZmSBa80k88KMgB
 jjudhxwE7JS4C9uDKZFdNYPEfxcW0yf3SG+si6OgNbpGz7SqJgjVnZLBe0sGwuk0MyhUv6Fdk
 9mT+PUay8P1ZxMNL9buJf5lG5S75UnJMwKWXaQCeXLLZC9N7iPf+oXKhBucXC/5hN1eAjbL2I
 WEGIDOXv0hgk7e1id+VpE8fX0Je0xhdncNXYzxvQMLldfV30Z7eGRbEjkhSZRKgn8ve787k4e
 erJKHdPNWc8021k5dxtB0LdXKp6GjP4SCGXPTTwREf3Y98eNQtHxC9nuDnqU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/clk/rockchip/clk-pll.c?id=3D1c0cc5f1ae5ee5a6913704c0d75a6e99604ee=
30a#n913
>> https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/clk/rockchip/c=
lk-pll.c#L913
>>
>> * Do you find the usage of the format string =E2=80=9C%s: could not all=
ocate
>>   rate table for %s\n=E2=80=9D still appropriate at this place?
>
> If there is an internal "no-memory" output from inside kmemdup now,
> I guess the one in the clock driver would be a duplicate and could go aw=
ay.

How do you think about to recheck information sources around
the Linux allocation failure report?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?id=3Dda94001239cceb93c132a31928d6ddc4=
214862d5#n878


>> * Is there a need to adjust the error handling here?
>
> There is no need for additional error handling.

If you would like to omit the macro call =E2=80=9CWARN=E2=80=9D, I would e=
xpect also
to express a corresponding null pointer check.


> Like if the rate-table could not be duplicated,
> the clock will still report the correct clockrate
> you can just not set a new rate.

How much will a different system configuration matter finally?
(Do you really want to treat this setting as =E2=80=9Coptional=E2=80=9D?)


> And for a system it's always better to have the clock driver present
> than for all device-drivers to fail probing. Especially as this start as
> core clock driver, so there is no deferring possible.

I imagine that such a view can be clarified further.

Regards,
Markus
