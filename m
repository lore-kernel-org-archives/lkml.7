Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F174FC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97D22082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfCELYX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:24:23 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43361 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbfCELYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:24:23 -0500
Received: by mail-qt1-f195.google.com with SMTP id y4so8552235qtc.10;
        Tue, 05 Mar 2019 03:24:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YJH1wLrluoRdkTlZl+lhYs9H/9tfCwwki7ZSA416qHQ=;
        b=AzH5MdhIG8z2LAsxYoOwzbsVAYnAuHJazMCLq9wn4HMP8hUyrIQTRtCPcdx6/Iv9iQ
         5CSESIp3AWndNFLt8RSTdiQPCVgU9oX6V6wj+GWHguGc1eBDbEMrpZcse1EO0U4+lsRR
         LA5X0H77zH4asI9a9o9zweR6iONSNt3EoWZQ1vfM8yg7e+nsrc1hsmFyFr3+bqxr5tca
         OXWxrYdFySOdNP1W27B02pjWcf6XxP19kC9etffZWxvaZeR640Ep1K2COJ+sTpZQtyix
         bQdVt9KCfb4ZyAB4LJ20pm7j5pCCwf0uM4AzFBVMZt27OeNCbbSdS6nfXbB/CSc4TEnD
         4ZPA==
X-Gm-Message-State: APjAAAXkgT7xRe62u4BOrtNm9oyIQbIzypGBzYXSsqdyABq6o1Gzjmt2
        ElC46RXvNpHFzQ6aOesP6Vg6wyvioZTcpRGRxwo=
X-Google-Smtp-Source: APXvYqz9msH4L97q6K9bV5EUcCcrlEvIUF4YMRxn6NszTr2vzf8paisssLp/adENsXmC1tOB8DaJoQtpPaNdc+B6sgw=
X-Received: by 2002:ac8:445a:: with SMTP id m26mr972831qtn.212.1551785061905;
 Tue, 05 Mar 2019 03:24:21 -0800 (PST)
MIME-Version: 1.0
References: <20190301035852.26780-1-marek.behun@nic.cz> <20190301035852.26780-2-marek.behun@nic.cz>
In-Reply-To: <20190301035852.26780-2-marek.behun@nic.cz>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 Mar 2019 12:24:04 +0100
Message-ID: <CAK8P3a2gfj++xu9ZFFx_3KoYFEtOr3HfUk_u1zwQ_8ubQAPdag@mail.gmail.com>
Subject: Re: [PATCH v3 bus+gpio 1/5] bus: Add support for Moxtet bus
To:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 5:02 AM Marek Behún <marek.behun@nic.cz> wrote:
>
> On the Turris Mox router different modules can be connected to the main
> CPU board: currently a module with a SFP cage, a module with MiniPCIe
> connector, a 4-port switch module, an 8-port switch module, and a 4-port
> USB3 module.
>
> For example:
>   [CPU]-[PCIe]-[8-port switch]-[8-port switch]-[SFP]
>
> Each of this modules has an input and output shift register, and these
> are connected via SPI to the CPU board.
>
> Via SPI we are able to discover which modules are connected, in which
> order, and we can also read some information about the modules or
> configure them.
> From each module 8 bits can be read (of which low 4 bits identify the
> module) and 8 bits can be written.
>
> For example from the module with a SFP cage we can read the LOS,
> TX-FAULT and MOD-DEF0 signals, while we can write TX-DISABLE and
> RATE-SELECT signals.
>
> This driver creates a new bus type, called "moxtet". For each Mox module
> it finds via SPI, it creates a new device on the moxtet bus so that
> drivers can be written for them.
>
> The topology of how Mox modules are connected can then be read by
> listing /sys/bus/moxtet/devices.
>
> Signed-off-by: Marek Behún <marek.behun@nic.cz>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

This looks very nice! I looked through the driver now and found nothing
to comment on other than the debugging properties that Linus already
mentioned, so please add my

Acked-by: Arnd Bergmann <arnd@arndb.de>

and submit the next version to soc@kernel.org so we can pick it up
for linux-5.2.

     Arnd
