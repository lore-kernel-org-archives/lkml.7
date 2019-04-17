Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CA8C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE941217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732965AbfDQUPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:15:32 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:58953 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQUPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:15:31 -0400
Received: from [192.168.1.110] ([95.117.89.119]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Md6V3-1ggh712z2Z-00aBmZ; Wed, 17 Apr 2019 22:14:04 +0200
Subject: Re: [PATCH v10 0/7] Add Fieldbus subsystem + support HMS Profinet
 card
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
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
 <31245f21-ae98-f10f-9484-a1719164ce16@suse.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <293d9421-4a1c-cc12-f3a7-3f6ea3adb6ea@metux.net>
Date:   Wed, 17 Apr 2019 22:13:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <31245f21-ae98-f10f-9484-a1719164ce16@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RslL9JEQ43EjUWwyo4ZLUo0XqNN21ltWInyz0jUjIDZj+Nn3neO
 ZpwkwTszdO9752lNgVAwtw6QBs6YPIfpjz5g3A6k8DvJZuiPCoztnBBSJcHf31JyQJ2SnVf
 oT+K7AP3yqmRu3fKPZVwSkfq1ZNMgzJyZRxJoHmjbKUo7UYxq9b5d2UOmfz07beetYm9WZ9
 7esMCmWc5LFUfdzOqYSoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s9QDRNhL2bo=:RfTlmRSrpQo2GZWBNZ/Z/O
 rggTItsRDktdYXi5T24lAx3j/T8njbowmvR56RURpEAwcHU5bf6fzK7a6bxLXnHXS2P4mxIsi
 dMCnYjLCJJZ5myi88LGCBCba0jPX1/S88jGSGv+G5N8eG2IJijiWlzNryF5mVAv+3ZuHiKDi9
 vAepC5DUDDc6xmNjgRm9TTT+DTUv+OZsHPHSRBEikIylsmLr8XLeJwIE9yBbIXe+bYkDqEKQ8
 Bv6YsmJnnhJTlg0cre1UrWR5TSnqmhndHMR+TB28TI2T/Jq1F8K1eAba3Z2ebOaxAr1puZf+g
 exkQNv5Sk7kgro4S1fIrTZZ1kLiqez/cPRB1lENjBOQq7zQ/GNGbF0TBTqdCftHoBe3conWUJ
 Q2hQdMrdY1nUgnUDOIkWDnvU2OTnCKWsdPo1Acju9vTDst8TAafSDw+opIleqbEzByS0HS1Dd
 Jg4L8YjVEENvQr0xwaGEp6PK+xct4DvPGaX0YSFKoe2IPHm8V48k/S+g1y1XFWHJQA1UN2jTY
 c0DvDDTwiG0aZk+olX7Ca6ZBPT27t8oG0ugq5Y9lYp8xNMmA5qTA/wncr34MplUScoJKRvymt
 /KjRZQ31wf1u9zdtaDt11Ip9+MD/Ct9LF/eiguMcBRlcVvnS6xFDRidXewNkiVShiLskpXF1k
 5p77tESkKRk/iY6iQWM77LXqtp9xC+M++ZAJ316v3KiqnCvJYHoalIxtao3lHUZToTAU3Yigx
 O4pCRW1nZAw7Yh8UneTE3ni43yNjTMCIEfPWuYe7eJqNuQi83mb0lVAnv7ykfH3zyDRewKfTE
 nmyH5xFsollXT5SVgj8dXVcgNszbr33G/j+YMITBo1q5El3qYVApOEA7Tlwt8LdeY67D/0p
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.04.19 19:04, Andreas Färber wrote:

Hi,

> If you see specific conflicts or differences, please explain them> instead of just throwing around bus names. :) Then we can more easily>
discuss whether to make changes to this framework or whether we indeed>
need some fieldbus/iec61158/ subdirectory.

For example, MVB semantically is more similar to can/canopen or even
SNMP than to iec61158. T-bus is logically more a typically network
interface (similar to 802.3 or HDLC), WTB is actually HDCL via RS485.
KNX has similarities to canopen or SNMP. DALI is somewhat similar
to I2C.

Ergo: there're various fieldbus protocols with entirely different
concepts. Distributed process memory like in iec61158 is just one
of them.

> For your RS-485 I don't see > conflict as that'll just go via tty/serial/ and optionally serdev, no?

That's just layer 0/1. Ontop of that there're various protocols.
Some folks do some ASCII-based protocol ontop of that (eg. elevators,
water plants, etc), others put in HDLC (eg. WTB), some do completely
weird things ;-)

> However, I'd be curious how I/O Link might relate to this, it seems to> have no public specifications.
https://io-link.com/de/Download/Download.php
https://io-link.com/share/Downloads/Spec-Interface/IOL-Interface-Spec_10002_V112_Jul13.pdf

> While I do like sockets, they seem more useful for packet-based> communication, which may be an implementation detail of fieldbus_dev>
drivers, but AFAIU that's unrelated to Sven's memory-focused subsystem>
representing a view of the data received, which may be different from>
the last packet received. Also, when a packet is received via socket,
it> gets dequeued, whereas you'll want to access the device's memory
without> restrictions.
okay, if the device always represents the current process memory, w/o
showing the actual communication, then Sven's approach makes sense.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
