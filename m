Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9180AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6020C2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t4SepFwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbfCKUB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:01:59 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36926 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbfCKUB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:01:57 -0400
Received: by mail-ot1-f68.google.com with SMTP id b3so358389otp.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 13:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LKmRRe/TG/rwjTmD1hFHYCTcvGKG8Q7HIt+Pu52PNYg=;
        b=t4SepFwm7MJII2vlP/crkbZzbn6V4YAob8oRRiaa74KOKCIzta3PoLlOrrbD4M6BfS
         KG8r0h4Ckalk0hfsaw743kEpUOIBtCeNPeqRSjLbeUrkboJnkOKz8hFSA688/uXHWEHR
         X6CsKm8QheoeBe41TpjPa6W6ADMHAlpNAvpM3hAhywncMCI84Nlm43Rz1r41acllSZnh
         hYHXHPvlyywUDBAkJN9XD32NtiXXCSjJdltkBKVIZgS2HdpPQc539m0Mp6ZoP3QM0Xwe
         VuM7ErDzqB12wzw2qrWZo08GqJP+dUflORW5IVwFrlToeBlFm13VErWd3DNctYcxY8zl
         Ga3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LKmRRe/TG/rwjTmD1hFHYCTcvGKG8Q7HIt+Pu52PNYg=;
        b=OK1KepdBSjljm8aXzp0OoPFDfDwRDcP3cjyhfD0JT2eHkiOYP8rp/aBICD7Sr7GXmU
         T2D3vvfOpH8NfyNjGfCeS5MXB3LXThOuGRpdWJXqJc/JqD9ykEQ/ol7V1xb4GM7xOuHe
         X6UZw/tbDD56aWoypgokyn2XcX/20YwqVRiYoqb+x3diQcqrU9yuG8Nq4CFXeu3WSJii
         /kCBo4zAGVUAyXo/SPeiGKO+sALWQ/GqQL0OPUUc8Wud6jG7YvDMFC4oKL70/xMnmq2Z
         R4V+dEwDz4hgF6oySP+4pf+NIIR4U6eYBxr5AclCufOV5abphnZRqw5n9g7i3YCn1MZh
         ygZA==
X-Gm-Message-State: APjAAAXbQeOKaJ6l7achmS2BpeGAczIUz0jNK2wy092BYIv1xmy5WKl+
        8r4uUQVfuy7i7bVKZPxw5bLxoevJ09BtV8LUIIg=
X-Google-Smtp-Source: APXvYqzNSGQESYOlpMDImQh3Lvx1WQMyidE/xkPdEf8G5j39yrOCPf9VZoTb3ZleCY/xcrN964SctfrJ7R0Nt6IQznA=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr20398541oti.95.1552334515634;
 Mon, 11 Mar 2019 13:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190124201251.15159-1-TheSven73@googlemail.com>
 <CAGngYiWFU-VnG=ODLWaUf0yp69qaU2GSd9exdHvyi6Ko1ib9qw@mail.gmail.com>
 <20190208121916.GE23483@kroah.com> <CAGngYiVVNitd5SDLah-kxP69W6XHYHOQrOz=DnevuGnqoHD7HA@mail.gmail.com>
 <20190208141400.GA22162@kroah.com> <CAGngYiXZtNcqQ3JGgavBxypo75WtAT7T-X4DQFNWD8kQcifU8g@mail.gmail.com>
 <c8632a8c-dd3b-6b16-3fb2-5a1b381ca29a@suse.de>
In-Reply-To: <c8632a8c-dd3b-6b16-3fb2-5a1b381ca29a@suse.de>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 11 Mar 2019 16:01:44 -0400
Message-ID: <CAGngYiVuh16dzSUvjZN0EcnaMy_n4_8Zzzth1M9XJTRQU6D8Ag@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] Add Fieldbus subsystem + support HMS Profinet card
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Mon, Mar 11, 2019 at 1:25 PM Andreas F=C3=A4rber <afaerber@suse.de> wrot=
e:
>
> I have two unfinished drivers that might benefit, for Hilscher netX 52
> (multi-protocol) and Microchip LAN9252 (EtherCAT), as well as a Linux
> port for Infineon XMC4500 that might be expanded to XMC4800 (EtherCAT).
>
> But currently -ENOTIME for review or development, sorry.
>
> Staging sounds like a plan, if that allows us to still break the ABI.

Those devices have very similar functionality to the h/w we use.
It would be awesome if we could find common ground here.
And the userspace ABI design could definitely benefit from 2-3 extra
supported devices to verify it against.

>
> Are you at Netdev 0x13 later this month? That might be an opportunity to
> discuss the network-related parts such as Profinet and EtherCAT.

Will send you an off-list message.

Cheers,
Sven
