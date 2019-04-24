Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D84C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A59D21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="YBcLj8CE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfDXKic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:38:32 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:9354 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfDXKic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:38:32 -0400
X-Greylist: delayed 535 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Apr 2019 06:38:30 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1556102309;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=GLMkRFqG4ht439HknpuuCUujTphLGkUsng7/djhCS5c=;
        b=YBcLj8CEA/OTIjtVuGkKYyOKi+eG0rvhkhW+FdqTCwWOGMal9lkZmcNCO/5v1sQjIE
        G80VgPsFODWlAdVoZVAdANrm96ENiwdgGNWYIUj4Nuku24yfU1cL4Rps2Ue+r5ZFN3sh
        EGhyLfJku1fmByJ8BlVVusvKkB2kUUccD8oUdIrxCiZYmvB1X+ITCPfXPyUhR+lYyCPs
        yYz3uqDywayGtO5t9WLHb22FQfohKojlT118H9fEoy7SrAcOdmGxfA32UicWGh9G++ge
        B9OmpSchYEP4N8m+IfORLHUQoSPlyigmRDHcY7r5NpurMbYjvXXBnw7W4dj65Ws8uKtd
        GSEQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJV8h5kkxQ"
X-RZG-CLASS-ID: mo00
Received: from [192.168.40.202]
        by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
        with ESMTPSA id q0b361v3OAQTmEa
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 24 Apr 2019 12:26:29 +0200 (CEST)
Subject: Re: [PATCH v10 0/7] Add Fieldbus subsystem + support HMS Profinet
 card
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Sven Van Asbroeck <thesven73@gmail.com>
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
 <e07f7575-2617-a11a-fd78-d068b10a8171@metux.net>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <06024a8a-ad00-8062-215b-01b2f95a6e24@hartkopp.net>
Date:   Wed, 24 Apr 2019 12:26:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e07f7575-2617-a11a-fd78-d068b10a8171@metux.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Enrico!

On 24.04.19 11:40, Enrico Weigelt, metux IT consult wrote:
> On 18.04.19 19:34, Sven Van Asbroeck wrote:
> 
>> If you have a fieldbus device you want to add to mainline Linux, and> you wish to piggy-back onto the fieldbus_dev subsystem, then we can>
> discuss fieldbus API changes/additions/improvements during the> patch
> review stage.
> With those cases, piggy-backing wouldn't make much sense, as their
> semantics is pretty different.
> 
> My whole point here was just that it shouldn't be called "fieldbus",
> but iec61158 instead.
> 

Full ACK!

The Controller Area Network also belongs to the class of field busses 
and has its own networking subsystem in linux/net/can.

So using a 'class' of communication protocols as naming scheme doesn't 
fit IMHO.

Best regards,
Oliver
