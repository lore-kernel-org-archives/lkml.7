Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599E0C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2470520880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RT1NF72z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730634AbfDPWMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 18:12:53 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45015 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfDPWMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 18:12:53 -0400
Received: by mail-oi1-f195.google.com with SMTP id i21so18343370oib.11;
        Tue, 16 Apr 2019 15:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NyKcBBFFHBSCWRfWOZJFD9fDiNalkHlRy8goLyKtRyQ=;
        b=RT1NF72zlI1gmTng8YXqf44en1YQwu5qdA9d+Yyefi/zJeCGvJPE2WIUNp/tHX7zb1
         XCVOxhchspmvyD9+nI9fXzpO1YUpFyoVPdoj9BJrzDOPDrierfrLoZhKaA7KQYcuOD9F
         ztvtUk2NGMh+VIgPKk6vBajs959F+vY+vZqf2ArzzwbeD+DIog1EiBlxxuaBiifqHmob
         AI/7s+dhcYWWHiRzZRXQF98GlMFS/JAnxajXQu6+/p69TVCqsgq5GG8wdBmdMyI8++rl
         83UDgXyilJH0mXDhDhlHDul00BfIWj+0+jJDS6sthVHF6kdw6s4WhiUvUAS4MFIo1xjJ
         oUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NyKcBBFFHBSCWRfWOZJFD9fDiNalkHlRy8goLyKtRyQ=;
        b=uDX7DZgquk7GptlrDARBo6IH6sIy89o99Y30K64KafqFMeRUrg06n8aHt2hl3TlteY
         jLbY1V+Eseh1JyQq5vH6UbuPids35IvKwyU1LinZSCFIB/O4DMbGpRy/VurnJb4SK5r/
         nf6RRl5TtJpvUIdSK7Wpzsa0v+nfInnJN1VupupUymLVFk8YXQSYsDkLpuwHDTE1v1JP
         8cXNmjEAoop8JQRqjKu/Vas88GMZlwhSKhUC/nnTM4V5UPzXklNBuarN36oBQPNKeodh
         uIu99wW5rXnIdsm7SBQwz2K58Jh4+A8YaZHMHLXbEgIu4LUdqdF8/KTiMQm8TycJudHp
         4lXg==
X-Gm-Message-State: APjAAAVnfG41bnJYLBVTsRRQvFpKbPKAA1nK4LFQHKz6PCQt3OH7Udpf
        C7mOkDsOfw+KgWfHFW0PP1ccn71w+UO3jr0jYQQ=
X-Google-Smtp-Source: APXvYqyOgkdmPawPcF5ek+c7K54m9smC68N61NZlptZXmyl7lZx+ktR4RAx7uEUN8135qhShSUBXgrPv/FxUsyb6SoE=
X-Received: by 2002:aca:be46:: with SMTP id o67mr24164790oif.92.1555452772469;
 Tue, 16 Apr 2019 15:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190409144250.7237-1-TheSven73@gmail.com> <982e69c6-4e68-6f62-8bed-cd5a1802272b@metux.net>
 <CAGngYiUTHZFFY=H7xXHzZnN4pS0jAqWBTrcw04hjf5S-ykxC9w@mail.gmail.com>
 <c1831703-a476-8870-0a5f-9060bda0f669@metux.net> <CAGngYiXx2eKR7DnHm9sNWVC+B1F2N6uUNXqZAq4rey2yjU1RyA@mail.gmail.com>
 <23a25601-ed98-5348-9bac-bf8fc2baea5e@metux.net>
In-Reply-To: <23a25601-ed98-5348-9bac-bf8fc2baea5e@metux.net>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 16 Apr 2019 18:12:41 -0400
Message-ID: <CAGngYiVJwRh_ESLfSYWak4RU60T2D1HW0-3Hg1CZbRjWhaSN5Q@mail.gmail.com>
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
>
> Yet another question: does each fieldbus_dev instance talk to exactly
> one plc process memory, or can there be many ?
>
> Having separate device nodes per plc process memory seems a good idea
> for finer access control (via chown+friends).
>

PS do you have a specific fieldbus device in mind which could be added
to Linux? Would it support multiple plc process memories?

Sven
