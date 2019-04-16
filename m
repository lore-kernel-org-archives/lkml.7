Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35399C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4B820684
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfDPVAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:00:09 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:52723 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbfDPVAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:00:09 -0400
Received: from [192.168.1.110] ([95.117.99.70]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mtf39-1gzoE93LVH-00v9wM; Tue, 16 Apr 2019 22:58:42 +0200
Subject: Re: [PATCH v11 2/7] anybus-s: support HMS Anybus-S bus
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
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
References: <20190416155618.1369-1-TheSven73@gmail.com>
 <20190416155618.1369-3-TheSven73@gmail.com>
 <4aecef30-0d64-c5f7-c4de-43b0754e2fdd@metux.net>
 <CAGngYiX3QP25MLupsc-=gfb6CAh5wK49eGs2xqHh_5LxrKtaAA@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <34a70ef9-4bb2-98f6-2344-3a0482b5cb7f@metux.net>
Date:   Tue, 16 Apr 2019 22:58:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGngYiX3QP25MLupsc-=gfb6CAh5wK49eGs2xqHh_5LxrKtaAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:BuoZ6Jzc/LxDDLv9s/Ra1L03wreYaPXLmS0WBNwBGIdmw0cjO1Q
 6IhUhfqFpRZ0bc17B8I1RV3F1YUKm3iDRJr21kgb/d37mF2gzdHTpVkZ6fzW7SziHl31e4H
 crQlGTRl8wX6WKxNRJdqR8Xfm86QTwTtZf6H+hOKz+NzkGvTNrDheanvp2JGahn5ZRLCdcV
 aO475o8vkXFeVFcCMx61A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sY8d+Tkq0gI=:HG3UW/M8ryYsib/p+EV8IO
 Fe/uFk6GirlBgzY4BlnU61vuyR/EpjuUwEAg55jTfyZxKmwC+e7MWRGTPBVNkP7oF3xbRVruK
 SONjNq3dD8VjQe7bh/ndvikno01T00lOkM5MveecrxphBZ+QCL3vZfy9bUw6hMy3ohb2wxNgR
 ytenjb0tjD7xXEP+WQHxQfQng/O4g9nBmdov3T6jucaZ2MxyFDqzYB5+X7N2zM5kHac4T6BEn
 gQ6iQPKnMu/l0UaOS1FxJc2kDoUN95lq0fiNpTbPNNBNjAm6MKVVW+1MKat8dCu7wL39sSFZK
 BAkWo9/z+sqjou9Xb12CH5V/I9X08pDVQltf55I3I+bZYVd0lOE97ayrkM47+ETYKwFOa7H4v
 mkCgX7+k511loK8Frr9v+vCz9uHkagxeWWaPOeOaxEbR9Z/OjJi7mFDNpNVd36kJUwRZ0QtZw
 03/eFYFXZtgu9eazcptxBA9fE/6vQxa966HbDo/otgcGIRJEq5CoTabcxZpHf8IksWtUdgr5V
 en8QZFA3VeSf6gQZjgnazUfmzmCx2B+E77VScxCZKsEQgKtwTSXEVh5v+yTw7thD/QD2T1kZF
 4Ci07wiZCgrbdUvTsWqbOpWQQnDMxdgQhh1GRXetnijl9KBja2FW0EE7luO5PJkPXdKgfPk1z
 QdZDRpJjaLGGfaU3hZ2pL/wQSAqjqZsDzezCt8CUDaq3I0ZUtirT4CpoFaxxZIiOw45l3udgy
 Cbl8deP3SJ40ocjqRK/yYjxhZNyXd9bGmb08X+fMwAiXCQOj00DJJmjnl6k=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.19 20:43, Sven Van Asbroeck wrote:

Hi,

> Correct on both points :)
> The author of this proprietary standard (HMS) calls this a bus, but only
> a single card can be connected to a slot. So it's not like pci or usb,
> where you can connect multiple devices to a host.

But this port supports probing ?
(so it's, bit like a single usb port w/o hub ;-))

>> Maybe that deserves a bit more documentation :p
>>
> 
> Sure, I can do that. What would be the best location for this?
> The commit message? The Kconfig blurb? Comments in host.c?
> Somewhere in Documentation/ ?

In the long run, Documentation/ IMHO would be the best place
(at least for longer explainations).

OTOH, a few more precise words in the commit message would be nice, too.

I guess that things like introducing new bus types or device classes
are something that subsystem maintainers wanna be aware of :)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
