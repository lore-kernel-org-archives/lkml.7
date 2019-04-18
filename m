Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C858AC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E2092183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388251AbfDRIUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:20:18 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:40477 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733049AbfDRIUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:20:17 -0400
Received: from [192.168.1.110] ([77.9.47.20]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MgNpJ-1gdIKB1Jp1-00hyJV; Thu, 18 Apr 2019 10:18:52 +0200
Subject: Re: [PATCH v11 3/7] anybus-s: support the Arcx anybus controller
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
 <20190416155618.1369-4-TheSven73@gmail.com>
 <2caf5f92-164a-3723-e2ef-42e4045d2ec3@metux.net>
 <CAGngYiXZSaUwrCiqavMGDRb5Vuo2x8fTjDetT00PAjjtrYW+NA@mail.gmail.com>
 <bd36b798-d129-c81a-ab2d-22a5b46567f6@metux.net>
 <CAGngYiUaUoRUAiGUGbJEWGRj0bszeSsDDBfZMwoWokQRrMUhfA@mail.gmail.com>
 <3103f45a-facf-89a3-8a36-84507c570909@metux.net>
 <CAGngYiXd34hTriDsKvhOWogaF0uLfVbUn5BzJc3cUnZcWpFXAg@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <c1c84e6b-99db-672e-4062-9129d5e89d10@metux.net>
Date:   Thu, 18 Apr 2019 10:18:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGngYiXd34hTriDsKvhOWogaF0uLfVbUn5BzJc3cUnZcWpFXAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1TyE5mF5j6cS9zDc//KHnvOiv5sVa46LUSHfJis33KQNTcq8zjd
 tS3ftryLllNWQ59B1w/TTqG9f23pJiax/cRv8XHH5U93R3SvZV3lExPiqBh4sDY/lm9xnht
 ZU0L9Hpoa8YnOduM2qEr2qzx7gcamUPHubjRQW5O/iVKTipU7lIw4HH3lUMHAEizCaX4jgh
 cwvWnu+GTTZDWT/vDpVsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TVVILci4b5M=:dBTAiEISpgGHcGZOBU0+TL
 8WwL4XhGBlBOCK0QiB+wv2Bm1T83+ZuZrKXvwyFGtdk+L5kIgRC2v4IRfgi4Tv0N7WKmiX0Yp
 5IjirGUQJAGybc7AG0ya6yTFZf4Vk8FbmbGqcGtXEmca9Pu9GbqIE4DCTYgfQUh86fgKgIyxD
 tsNM1EVxADDUUd5CnRiYpPXflQNI7jhnbbEEfgtvOWTYfX1qCegOFTabjBdK46cnDB3hVtJ2Y
 2Ws4COeKTqE85JtATHHQ+LPLRqKcRfv3cufWN83Fvlnhrn97ylHN/sbOzNO4AdQE0OjN2wuZi
 y0mGn8vnSdbuIZ58AAjRycJfJET7ffF7DRBOJ8l/GKF5QO8wBFsiHKlOPRmqlD/RptinnHkFv
 kTB/UF3KUlwFfMEY1eQvxHgGBat/AnIPW5CrA8hxR9wowDTK+tyGK4B2rI/YErFHqsiO/R7py
 r8kMrd58WGJl0zyNFz/myBqRzsDxJzRkZIZZwtH5mexNzWWftNTDCkfzqAJxZzYCTaYqZorND
 DQ8nBWAKmrKoQDymTp7qe7sfrt1F2TrVmtZ3hlpaeD74/nII/EePjNiITMrJ3GvtofeDRS2tj
 qPHHW/xS+5z/tz4L55rLwqRrNrDbwhLpzsCK7F3abFd7WNQAkMcPiJAso4YBwbs3cLqwJ8ekJ
 0or8fX6V97KMMjw+uY5SvgruGGZVX582UEZTcK2iaa0/ZUNxtmskM+XaQ2DJxRhOF86C932yz
 cVUg6YwvGkz3rWD0WbwO23n/w5ilH5UHJXqroQoJpkbw6LiXJTAGjNqN7cw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.04.19 16:17, Sven Van Asbroeck wrote:

<snip>

> But in this case, it's really a power output from an external card> on a PCB assembly. Regulator seemed the kernel abstraction> closest to
what this actually represents.
Oh, just missed that in my other mail.

So, that input line is *always* hardwired to the regulator ?Okay, that's
a different situation.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
