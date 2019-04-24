Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7F1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF39720878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfDXJld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:41:33 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:34583 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfDXJld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:41:33 -0400
Received: from [192.168.1.115] ([95.114.95.254]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MQdtO-1h7lEh1sxy-00Nk9L; Wed, 24 Apr 2019 11:40:05 +0200
Subject: Re: [PATCH v10 0/7] Add Fieldbus subsystem + support HMS Profinet
 card
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>,
        "J. Kiszka" <jan.kiszka@siemens.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
References: <20190409144250.7237-1-TheSven73@gmail.com>
 <982e69c6-4e68-6f62-8bed-cd5a1802272b@metux.net>
 <CAGngYiUTHZFFY=H7xXHzZnN4pS0jAqWBTrcw04hjf5S-ykxC9w@mail.gmail.com>
 <c1831703-a476-8870-0a5f-9060bda0f669@metux.net>
 <CAGngYiXx2eKR7DnHm9sNWVC+B1F2N6uUNXqZAq4rey2yjU1RyA@mail.gmail.com>
 <23a25601-ed98-5348-9bac-bf8fc2baea5e@metux.net>
 <CAGngYiVJwRh_ESLfSYWak4RU60T2D1HW0-3Hg1CZbRjWhaSN5Q@mail.gmail.com>
 <7ceaeb70-f937-bd84-95e5-d7a6baeb5d87@metux.net>
 <CAGngYiUPZ+g4eXJKvgA9GSJXgOFAAf6Q3qqAheiqNSnJ+Dbx+w@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <e07f7575-2617-a11a-fd78-d068b10a8171@metux.net>
Date:   Wed, 24 Apr 2019 11:40:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGngYiUPZ+g4eXJKvgA9GSJXgOFAAf6Q3qqAheiqNSnJ+Dbx+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:sPEu/ZQ8A/s2Oj+J95ERmhskebn++VDuhKDUCEfuzUlJuje5mwM
 mdsD12lpR5VOgPwqyWizYwh6PltSAty3Q6n6mfxW/AfL/ZQRt+ikZaCbzc2SGuc8mQVyTRz
 8EhitEoy048U7diAkcMvq7mXsUwOODo91kXBBXLgvDmtd7lPM4MNgdMlVFrzqEVw6ApvqUG
 hNJHCJctteySiwODwtFtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jKPz/DgbKEc=:U/3mAmhnYIK0lvUVWncSfF
 DLmODzAlYja4WFrCdBiCGWjoH6yDt3csESufr1VQlVcXKGAW033wQXF5tQ0ygoMfSg0GreYHi
 2bUg0UwUH4ePq9xftyS4p9HsPTKgXcPbK6LxVj8XLHB4FkmStMqY0ny88LnvDvxHgtGY4ecQL
 DCwKIG19izDyp+jgBY8X99uz9s/nSfx7PbhJ6bCo7NxMBKcXc6RNd9+p6BASON6Ut5wwabd89
 Ms2ucmP4InXOLN7ILkHWk6jqXdg/nUqgxcDfehxZC9W4B7u9ApezUjtBy2UNpcwmc45FDb6+8
 GJZ5P8uyWok67kabDo5fnesY0lx4RlXJIuLYvxfm+gZJjSGuE1CWRqV5+UftMKsGSCMr76t70
 9HBUQi2IjGXApJEv38VFQGKcMmhMxV2gF49inHaNkuyJdQx2N1s0tpAmdu/SCl4TmIxmm65BG
 kcLp9Txuw91YfvdXGu+1M6w0oSly0B1BZkw14m4EXPwZGZGufjGkxRm4nUM/As4iUl53/qL2E
 +SXhLqUCJEpqjt9GP8ZEwUoFNWks00++K/h5bNSdSBk4plYMLn+aEDSbU2t1MUHY1lKKawWCg
 dCfsPJ+702JN5zfVuCGAvkQxNQ1yb0NncZm7duuSoEuoAAGVw06jpB+odI+QXNQ3NG4CV7JrI
 n33Nov/28kOoRGWg4xSiCQGgw4DCdTIho8QTOpBdDGs1GCGgCkINrhsJj4R9YGaPwLsAFW65U
 kV4Pt6hLO7NwjDRAyGMRUfTE3aoEqyp2Vjgo3S2AnZHzQ/WKniblMPmyjdK+AxUdXnEk7oe92
 XxiJjWHYd8/8hUJTlqri8ljMqNKi9rwoKcMVzX1J/gzUjnJ6/I1/ZB+TEprS46VkLorAm3CA7
 MFPyOGi6UDI5mtvZVGwZCeAAHy6puofTJ8P74izg5l1uuof5aKZRBatbSCSWpb9R97QxKvmCQ
 a83ZApQ3QVQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.04.19 19:34, Sven Van Asbroeck wrote:

> If you have a fieldbus device you want to add to mainline Linux, and> you wish to piggy-back onto the fieldbus_dev subsystem, then we can>
discuss fieldbus API changes/additions/improvements during the> patch
review stage.
With those cases, piggy-backing wouldn't make much sense, as their
semantics is pretty different.

My whole point here was just that it shouldn't be called "fieldbus",
but iec61158 instead.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
