Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D06C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C5D2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfDXLAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:00:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:33890 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726122AbfDXLAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:00:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 01297AD94;
        Wed, 24 Apr 2019 11:00:10 +0000 (UTC)
Subject: Re: [PATCH v10 0/7] Add Fieldbus subsystem + support HMS Profinet
 card
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
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
 <CAGngYiXx2eKR7DnHm9sNWVC+B1F2N6uUNXqZAq4rey2yjU1RyA@mail.gmail.com>
 <23a25601-ed98-5348-9bac-bf8fc2baea5e@metux.net>
 <CAGngYiVJwRh_ESLfSYWak4RU60T2D1HW0-3Hg1CZbRjWhaSN5Q@mail.gmail.com>
 <7ceaeb70-f937-bd84-95e5-d7a6baeb5d87@metux.net>
 <CAGngYiUPZ+g4eXJKvgA9GSJXgOFAAf6Q3qqAheiqNSnJ+Dbx+w@mail.gmail.com>
 <e07f7575-2617-a11a-fd78-d068b10a8171@metux.net>
 <06024a8a-ad00-8062-215b-01b2f95a6e24@hartkopp.net>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Linux GmbH
Message-ID: <c1b783b0-9773-17f5-d043-35e28f7797f0@suse.de>
Date:   Wed, 24 Apr 2019 13:00:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <06024a8a-ad00-8062-215b-01b2f95a6e24@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.04.19 um 12:26 schrieb Oliver Hartkopp:
> Thanks Enrico!
> 
> On 24.04.19 11:40, Enrico Weigelt, metux IT consult wrote:
>> On 18.04.19 19:34, Sven Van Asbroeck wrote:
>>
>>> If you have a fieldbus device you want to add to mainline Linux, and>
>>> you wish to piggy-back onto the fieldbus_dev subsystem, then we can>
>> discuss fieldbus API changes/additions/improvements during the> patch
>> review stage.
>> With those cases, piggy-backing wouldn't make much sense, as their
>> semantics is pretty different.
>>
>> My whole point here was just that it shouldn't be called "fieldbus",
>> but iec61158 instead.
>>
> 
> Full ACK!
> 
> The Controller Area Network also belongs to the class of field busses
> and has its own networking subsystem in linux/net/can.
> 
> So using a 'class' of communication protocols as naming scheme doesn't
> fit IMHO.

And - again - NACK. Calling a subsystem just iec61158 is going to hide
what it is and stand in the way of development of this niche system. I
asked Enrico to come up with a better naming proposal such as having
iec61158 as subfolder to human-readable fieldbus, but I did not see him
coming up with any such new proposals apart from repeating this name.

Also please read Sven's comment again: It you don't like the current
naming you'll need to post follow-up patches, as v11 of this subsystem
has been merged into staging. No complaint about piggy-backing on v10 is
going to change that fact now!

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/tree/drivers/staging/fieldbus?h=staging-next

And since we're at it, Enrico's response to me just threw around a bunch
of acronyms instead of explaining which ones have an _actual_ conflict
with this subsystem - my point precisely was that if they use sockets or
ttys then there's no real conflict apart from lots of things classifying
as "fieldbus".

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
