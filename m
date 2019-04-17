Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B161C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51F320821
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732712AbfDQP1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:27:23 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:39125 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732668AbfDQP1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:27:20 -0400
Received: from [192.168.1.110] ([95.117.89.119]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M3lgJ-1hFxMk3HBj-000wdm; Wed, 17 Apr 2019 17:25:57 +0200
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
 <34a70ef9-4bb2-98f6-2344-3a0482b5cb7f@metux.net>
 <CAGngYiUroMwErLugXeVXwHc37Nm+Bw4Tv5i1VUv8=qVcNbaSQQ@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <2630e582-cc4b-764e-9f20-f5a2905fa4ab@metux.net>
Date:   Wed, 17 Apr 2019 17:25:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGngYiUroMwErLugXeVXwHc37Nm+Bw4Tv5i1VUv8=qVcNbaSQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0lX/jf4s/iXLqccJv6PB9lez3n9RHceg57Js3yvgwuB/sEsQldB
 drq4KzHH9bzAwqxtI05KS6y1DJMbjUR1BfJnX6IIrjHcf+UXTbIa9RNEf4fFOa7r8b1gci2
 UJWimHtEUzJGk2VdA58ldEpSiCnczZ07JeF8k2psOgBRLyGzCbRZsK5cs3eb+hmUA14QqGS
 AxZGXsHJzOsTQV5j3h12Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gJVE+2r6Vfo=:Hzff4fh9bn1RjbOtJWiKVW
 lIXCvOmeCUquyth+LNSpsbct+dZYHz8KMHWzD8nza9gP+x05gqWe+0u8hBILBaunJpxtWZUoj
 bO60gUh+9POUb8Nxm9WbPcwBMvyJjZzZ+CnNKrM6qZ+V1QuDqWbsWUwknkqby9ZYO9P8PRFzm
 aik9s63UnlUAifGEKdRBSGL0gbnkNTxnkiG8SlMRNflYhCNcAZ3IdkvyOjMrFKbOoWIXKDZGK
 lOM5RoMpZuGvlCmdS1+JkHtXXBFJNzGydOeKffZ9ZCiFAqxSihKT2ONTekCZoohcUmbtQAXPS
 D66iSViN2HpuuNK38nEcJ5dZXsyyXCB6pcFX7Gh/m4CoiePLPkhbiKTkYK5zm/Ek/nBeO2kt/
 mDltvbaPXx/SmP9J5qhFWfgXAhlRgj9culWJXfaGRcthdWFSdfgRKkOefooBUAG3QD+JcKMFU
 xGpElDkb9B4mCmT7cmXOTU7q9zke/450bmZJPWN5e9Tizg5w3xOWJoRiHB9sjGVe/MLR/Zt+t
 DinttrOichXEfpgWOGtpQTXcWPIHWO9QXWGzSodsk7bxDL+tt1uFGpdnE4AmmsF1pZu1+Z/vk
 00ytEtFnwnWKwF/pmLtUpuUUSU1sWwWvZMp5ifRq3cmu4QYLIucpbRlVLl2B5qyl7eKgAzbEQ
 fJivTx4SFw7BbFDxONtmZvMZFDXwebxv0wmw2JPjCzuYUxUDg1OgSKDhL029oDPTXzr72Iims
 z5g+tweMsljc+jY018ZE1YiIsmgA73n+mOL9fs0O6iXecWftu6A4O6JO4x8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.04.19 00:00, Sven Van Asbroeck wrote:

Hi,

>> But this port supports probing ?>> (so it's, bit like a single usb port w/o hub ;-))> > Yes, that's
exactly it.
Okay, then your approach introducing a bus_type is correct, IMHO.

>> I guess that things like introducing new bus types or device classes>> are something that subsystem maintainers wanna be aware of :)>>>
> fieldbus_dev is a new subsystem.
> At first I attempted to mainline the anybus-s drivers with a 'roll-your-own'
> userspace API, but the feedback I got was: this userspace API should
> really be generic... So this is my attempt to create a generic fieldbus_dev
> API !

Yes, it's an own class of devices, many other (semantically) simiar
devices out there. Therefore, an own subsystem for that is a good idea.

But: I'd rather call it it "iec61158" instead of fieldbus", as there're
lots of different fieldbus types (eg. MVB has pretty different semantics
than iec61158)

> It's almost certainly insufficient, but it's a start. Ideally, this
> should get lots of review from people in the industry, but response 
> to this patchset has been underwhelming. 

It's still a niche, at least for Linux. Only few people here ever had
their hands on such PLC systems.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
