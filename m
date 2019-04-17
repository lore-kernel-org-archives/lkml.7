Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE68C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F3920675
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732902AbfDQREm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:04:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:60470 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729512AbfDQREm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:04:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2C54DADC1;
        Wed, 17 Apr 2019 17:04:40 +0000 (UTC)
Subject: Re: [PATCH v10 0/7] Add Fieldbus subsystem + support HMS Profinet
 card
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
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
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Linux GmbH
Message-ID: <31245f21-ae98-f10f-9484-a1719164ce16@suse.de>
Date:   Wed, 17 Apr 2019 19:04:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c1831703-a476-8870-0a5f-9060bda0f669@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enrico,

Am 16.04.19 um 18:49 schrieb Enrico Weigelt, metux IT consult:
> On 15.04.19 20:31, Sven Van Asbroeck wrote:
>>> Maybe it would be better calling it "IEC-61158" instead of "fieldbus" ?>>> > Yes, we are certainly open to that, if it is more correct and/or
> better> accepted by users.
> Thanks, I'd really appreciate that :)
> 
> Maybe I'm a bit beaurocratic here, but I really believe that precise
> naming is important, eg. for avoiding potential conflicts w/ different
> fieldbus classes (eg. mvb) that might come in the future.

I somewhat see your point, but I would not have recognized iec61158 as
something relevant to my hardware, whereas fieldbus is understandable.

If you see specific conflicts or differences, please explain them
instead of just throwing around bus names. :) Then we can more easily
discuss whether to make changes to this framework or whether we indeed
need some fieldbus/iec61158/ subdirectory. For your RS-485 I don't see a
conflict as that'll just go via tty/serial/ and optionally serdev, no?
However, I'd be curious how I/O Link might relate to this, it seems to
have no public specifications.

> By the way: any special reason for doing this via device instead of
> socket (like we have w/ can) ?
> 
> I'm, personally, pretty undecided which way is better. Device nodes give
> us easy access control via fs permissions, while socket allows
> firewalling.

While I do like sockets, they seem more useful for packet-based
communication, which may be an implementation detail of fieldbus_dev
drivers, but AFAIU that's unrelated to Sven's memory-focused subsystem
representing a view of the data received, which may be different from
the last packet received. Also, when a packet is received via socket, it
gets dequeued, whereas you'll want to access the device's memory without
restrictions.

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
