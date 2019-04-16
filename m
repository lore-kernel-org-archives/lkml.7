Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A687C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6324420821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9pC9tRC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbfDPVtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:49:36 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40911 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbfDPVtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:49:35 -0400
Received: by mail-ot1-f65.google.com with SMTP id t8so18922270otp.7;
        Tue, 16 Apr 2019 14:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2mderAK9pd3NdVPz4fhCgyoDtw5fkk6xRKblAFxCP30=;
        b=l9pC9tRCsMpumuVFS4G7KrWlb+2gud8SNzreoazjLFrsvuWUZ1EHJwtUbEXRTvoAsY
         ZvgNcgBQ9t/47XE3lSoH0Amq1dKf7bQ96JemZgPCOvCYAhRujFC65cqD+BotPPK7BPPy
         GcllWvjis9dkLiN6o9whUuVwtuRAnsM3W0O0ikYHM3+zu0A4cnitvPR7t3OMrf14wC5I
         pgkH6UMND4fLm6Wp3n3nwygYmTukjKK7y1zbKJ3ms31fFa7bGvvt37y/WsJGV0BuTZVg
         /ltZOcj/sNl3b6dZ8u3ffzHeWWwimKU8jtBRGQIXn/b7eMTSPWvDxcC8qP1ULngPAUdw
         803w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2mderAK9pd3NdVPz4fhCgyoDtw5fkk6xRKblAFxCP30=;
        b=VhlAJNJYjs5wejF3cNn37vGAsPzSnf0csUzIabHS8D5ysrp8UaT6IVu6VKnBjhzF1b
         nCNUir1Q6/6i9NSoVu8BzmWLWvZrr6sHa2g5ziu3s8RqiFPm0sWLHBnHXx+41Oiv/hL2
         mXP8S+ZaMtreNyb7yo6Y6MzzkNLuIR3X/AiDdfbyo2ZXNxVm20QapTGeCJxj+snTLXs9
         L/GkoUcesRLSvGVdcNskZUK3tSu93GLD/BYbrfJAjVgBiLkZzCt7RMu+NAsTP+ZWqI1/
         ECZl81JRc/QUAAgZjS6QQJCo0gS7DSNjSK3aOOQ81A8Hr8m9MZsnxjPjjDd2zOaIcwzx
         2UjQ==
X-Gm-Message-State: APjAAAVWkA9niOBDWF1bTW2sLh3tfpw3/I4DQUwG5abjLT8QYE51Ijy8
        w5sfxsZtLYCTSI8RMBcbz++DTl6gTPEZ7YYU52I=
X-Google-Smtp-Source: APXvYqxH3mSuzfXby3vahEfhWUP5z89UIH8/0Bbs9jOzATtlqmgslQPVLdi56D+6WvUwSw41gtHu/BRnzoYikQIrEJI=
X-Received: by 2002:a9d:7551:: with SMTP id b17mr50788867otl.172.1555451374371;
 Tue, 16 Apr 2019 14:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190409144250.7237-1-TheSven73@gmail.com> <982e69c6-4e68-6f62-8bed-cd5a1802272b@metux.net>
 <CAGngYiUTHZFFY=H7xXHzZnN4pS0jAqWBTrcw04hjf5S-ykxC9w@mail.gmail.com>
 <c1831703-a476-8870-0a5f-9060bda0f669@metux.net> <CAGngYiXx2eKR7DnHm9sNWVC+B1F2N6uUNXqZAq4rey2yjU1RyA@mail.gmail.com>
 <23a25601-ed98-5348-9bac-bf8fc2baea5e@metux.net>
In-Reply-To: <23a25601-ed98-5348-9bac-bf8fc2baea5e@metux.net>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 16 Apr 2019 17:49:23 -0400
Message-ID: <CAGngYiV4fj7TA1Apwc57oQMSjPW3mVKzfDoLbD2QJKw-GWNzBA@mail.gmail.com>
Subject: Re: [PATCH v10 0/7] Add Fieldbus subsystem + support HMS Profinet card
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 5:21 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> Yeah, that sounds logical. By the way: could we also mmap() that device?

AFAIK mmap only makes sense if you have actual device memory, accessible
through some memory controller. The process memory on anybus-s devices
is accessed through many layers of indirection, which includes a handshaking/
synchronization protocol over anybus-s.

In addition, you'd lose timing information about writes. The current API blocks
until the write to the remote PLC's process memory has been
successfully completed.

Perhaps if someone ever adds a fieldbus_dev driver for a device with mappable
process memory, we can consider mmap() as an optional extension ?

>
> Okay that's just a purely academical idea here, but I'm curious whether
> that would make a notable difference in performance.

Perhaps on a device with memory-mappable process memory.
But it would have to be an incredibly fast fieldbus device for the
difference between read()/write() and mmap() to matter...

>
> Yet another question: does each fieldbus_dev instance talk to exactly
> one plc process memory, or can there be many ?
>
> Having separate device nodes per plc process memory seems a good idea
> for finer access control (via chown+friends).
>

Good question ! I'll have to get back to you on that...
