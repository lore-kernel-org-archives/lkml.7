Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860AAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55038206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfCDVIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 16:08:50 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45485 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDVIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 16:08:49 -0500
Received: by mail-qk1-f195.google.com with SMTP id v139so3604720qkb.12;
        Mon, 04 Mar 2019 13:08:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j+dpsq01gXpnnuEdJkGzxXdLppQrlMC3OLLYgfVVf7Y=;
        b=MVlnWQ/qYiMqllBmOCvA96ts8RrSIDCsSScwIUoEy954xyAKmDyegZAMQ058tW3W9j
         0qUiJ41LyOk/7jl4ozGi9wlx3zfJQ4vvRd15XNNa4CATTaMJG3a0pe/fJyOUu9MAoUOl
         g/Hsr1zhkEQ0lSvBmEJ4hQ5akGDxFKm+8p6mdUIxb1PMzffo+sESzsZJvXeSBfXS1qmT
         FXugdV15OW5iIg8n1ZuPh/Pq0fHyJYnVpTko6moxsOJfVc2VbWxqIx0TM3rbksRPNNq0
         0IZ1u6l6Y5YeblSpBdYLfb4t8kNiRXUC08KgoSB/FtuoVnPDPwgnMEarptsel9b2PsEv
         PiaQ==
X-Gm-Message-State: APjAAAUU7AxSfjLcAJ15ocjMAGMFh83raq07qnlmHBi6fLUn35MxXqPP
        j1tPbyvTgJCECX9E07DdX81bS/kuAle/iv8cDSg=
X-Google-Smtp-Source: APXvYqwIrgGiZV5Yy3iGAHdbCfRfY5tu1TIO+Dbc/Gilz4AtbVc9JUnRdmRTvQSi/56t1lW1Mb+wo3JGzRtOi2ZKJls=
X-Received: by 2002:a05:620a:12a5:: with SMTP id x5mr15287523qki.291.1551733728523;
 Mon, 04 Mar 2019 13:08:48 -0800 (PST)
MIME-Version: 1.0
References: <20190304203641.2052975-1-arnd@arndb.de> <50a3d69d-2096-a4d9-7c5f-54496671ec85@gmail.com>
In-Reply-To: <50a3d69d-2096-a4d9-7c5f-54496671ec85@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 4 Mar 2019 22:08:31 +0100
Message-ID: <CAK8P3a2TbA_KjR-sUNufhr=D0GD9PH91o0VB41VL+UB7tpfk6A@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: mv88e6xxx: fix unused function warning
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 9:42 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 04.03.2019 21:36, Arnd Bergmann wrote:
> > The newly introduced function is only used inside of an #ifdef
> > and causes a warning when that is disabled:
> >
> > drivers/net/dsa/mv88e6xxx/chip.c:4623:13: error: unused function 'mv88e6xxx_ports_cmode_init' [-Werror,-Wunused-function]
> >
> > Move it into the same #ifdef block to shut up the warning.
> >
> > Fixes: ed8fe20205ac ("net: dsa: mv88e6xxx: prevent interrupt storm caused by mv88e6390x_port_set_cmode")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> A fix has been submitted already. See discussion here:
> https://marc.info/?t=155170356600004&r=1&w=2
> and the fix here:
> https://patchwork.ozlabs.org/patch/1051275/

Ok, that looks good, thanks for the reply!

     Arnd
