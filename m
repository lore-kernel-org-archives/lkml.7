Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D238DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D727218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 11:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="U/UXHT/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfDXLuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:50:07 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:36092 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfDXLuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 07:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1556106604;
        l=28; s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=GXXVnf+OEgyp2Gp9YmU5G49I6goIXenY3HYTxH7tAh4=;
        b=U/UXHT/w0te7O6AE8BXndFd/S/4z1AkRXXH385l+XAlUebd236at+z975jKYCTGqTd
        rxsmbLFHj4vSJkLJr45o7C1aZagVGrUgtM8nYwA/2wn9J/zzZm6gsE5NPcmWHi3mZta5
        nKlywVyBgD00z77L1eQj26QLDlkdZl06RM0jwNgxLE7PF6YJwzJmH1kyMCAJtq8j6kWE
        1GpPhfV0PtRHO4mHF6g/V/TQKCyHWGJ+HLMpF0CaLS7GTocd2X2+VEbgs6Ppjxr4o0O+
        iMuZT9WOVr7kI7QRIV36DNoBsR8M83jLSxumN/3QOVqgmHJ8aAodoqidZwx34+0cAPVu
        u+MQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJV8h5kkxQ"
X-RZG-CLASS-ID: mo00
Received: from [192.168.40.202]
        by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
        with ESMTPSA id q0b361v3OBmWmoX
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 24 Apr 2019 13:48:32 +0200 (CEST)
Subject: Re: [PATCH v10 0/7] Add Fieldbus subsystem + support HMS Profinet
 card
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
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
 <c1b783b0-9773-17f5-d043-35e28f7797f0@suse.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <d54b294e-d641-bb14-84ed-39d9a9079dc7@hartkopp.net>
Date:   Wed, 24 Apr 2019 13:48:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c1b783b0-9773-17f5-d043-35e28f7797f0@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.04.19 13:00, Andreas Färber wrote:
> Am 24.04.19 um 12:26 schrieb Oliver Hartkopp:

>> The Controller Area Network also belongs to the class of field busses
>> and has its own networking subsystem in linux/net/can.
>>
>> So using a 'class' of communication protocols as naming scheme doesn't
>> fit IMHO.
> 
> And - again - NACK. Calling a subsystem just iec61158 is going to hide
> what it is and stand in the way of development of this niche system. I
> asked Enrico to come up with a better naming proposal such as having
> iec61158 as subfolder to human-readable fieldbus, but I did not see him
> coming up with any such new proposals apart from repeating this name.
> 
> Also please read Sven's comment again: It you don't like the current
> naming you'll need to post follow-up patches, as v11 of this subsystem
> has been merged into staging. No complaint about piggy-backing on v10 is
> going to change that fact now!
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/tree/drivers/staging/fieldbus?h=staging-next
> 
> And since we're at it, Enrico's response to me just threw around a bunch
> of acronyms instead of explaining which ones have an _actual_ conflict
> with this subsystem - my point precisely was that if they use sockets or
> ttys then there's no real conflict apart from lots of things classifying
> as "fieldbus".

Ok, I either tried to get through the fieldbus code and the 
documentation from above.

I hopefully got it right by: You implemented a standardized chardev ABI 
that enables a data exchange between userspace and kernel, where other 
drivers can register 'from inside the kernel', that feel like being a 
fieldbus controller?!?

When checking out the Anybus website the first hit for serial fieldbus 
is https://www.anybus.com/technologies/fieldbus-serial/can-canopen .

CANopen is CAN based - and the CAN network drivers and CAN controllers 
definitely do not expose sysfs entries like

	/sys/class/fieldbus_dev/fieldbus_devX/write_area_size

How can this fit together for me and what would be the plan to cover 
CANopen or EtherCAT in the fieldbus subsystem? Does it need some kind of 
CANopen protocol driver that registers to your ABI and speaks to CAN 
interfaces on the other side?

If this would have been outlined more clearly I wouldn't have stumbled 
over the fieldbus naming scheme.

Regards,
Oliver
