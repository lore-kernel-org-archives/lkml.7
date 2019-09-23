Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F799C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C072089F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V0w1WyfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440278AbfIWSCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:02:42 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42783 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393421AbfIWSCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:02:41 -0400
Received: by mail-io1-f66.google.com with SMTP id n197so35664189iod.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 11:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VwjyBXRozExm0XpCeJELI5XTzLyPmFyoar9fwKTAON8=;
        b=V0w1WyfQqO30zshuIlBtIkPctR6ceCucPy15Vc+LaXGAi0s4BSl/LmDl6PbVBK/iLT
         2qh7ngpZiw8TpdiIrYjg5aOjoBaE1+AjlJ6iyNk8IOnJM7Wo3WjfHCBbMTJIRLUA8DGX
         Tr4AzF3Ya6j+1+KZRDPoJKBsRPX/oki0Jalag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VwjyBXRozExm0XpCeJELI5XTzLyPmFyoar9fwKTAON8=;
        b=ljv2MmfwX7s4mpiI6+JMF+sisLkRAHne0y61FFWcvPhzyAYobrIT21ZOF5tOcwLBip
         pm+4Z0Iuf146b/KUzh5GHh0HIFdKxIa71uc3u8mmVhVPQ/YpYcj74oAiYwY75SO/WjLa
         3235EMad3+UzD1SllEzu3r7pnD/KvFsGo0TUUgA6NhGbtqFe4l0OjMcbbyH5fYRgnrog
         xPzWXEUzzvVLwYPeL1nqbou9BmXkpLYo0t65PG0/011VKtjVvCkxtdsCS2l1oxbtCj7Z
         nZv6NWD7Ya+INIa1+sHiIXZbgeA6Z+OLoLIF7YX6+eNpc44GFfMGG5vdkQF6Wr0vfRxe
         Tafw==
X-Gm-Message-State: APjAAAWG9Q3wDUBrPDXk5PMt45HpCGooCBopyqySF804H+aL4ToivBK1
        rW44COaBdvCOHgXutyDWBa33hdR8R9Q=
X-Google-Smtp-Source: APXvYqydzTzzQHFrG02iBDWzJw979t/Q+A9W3DOXdlyjM+iqnKXOkEUtlU0AGjymLN+LqhTodZ0loQ==
X-Received: by 2002:a02:b09c:: with SMTP id v28mr708806jah.137.1569261760577;
        Mon, 23 Sep 2019 11:02:40 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id y23sm10364315iob.28.2019.09.23.11.02.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 11:02:39 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id v2so35642524iob.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 11:02:39 -0700 (PDT)
X-Received: by 2002:a5d:88c9:: with SMTP id i9mr563522iol.269.1569261758688;
 Mon, 23 Sep 2019 11:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190917154021.14693-1-m.felsch@pengutronix.de> <20190917154021.14693-2-m.felsch@pengutronix.de>
In-Reply-To: <20190917154021.14693-2-m.felsch@pengutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 23 Sep 2019 11:02:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W7M8mwQqnPyU9vsK5VAdqqJdQdyxcoe9FRRGTY8zjnFw@mail.gmail.com>
Message-ID: <CAD=FV=W7M8mwQqnPyU9vsK5VAdqqJdQdyxcoe9FRRGTY8zjnFw@mail.gmail.com>
Subject: Re: [PATCH 1/3] regulator: core: fix boot-on regulators use_count usage
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     zhang.chunyan@linaro.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, ckeepax@opensource.cirrus.com,
        LKML <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Tue, Sep 17, 2019 at 8:40 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> Since commit 1fc12b05895e ("regulator: core: Avoid propagating to
> supplies when possible") regulators marked with boot-on can't be
> disabled anymore because the commit handles always-on and boot-on
> regulators the same way.
>
> Now commit 05f224ca6693 ("regulator: core: Clean enabling always-on
> regulators + their supplies") changed the regulator_resolve_supply()
> logic a bit by using 'use_count'. So we can't just skip the
> 'use_count++' during set_machine_constraints(). The easiest way I found
> is to correct the 'use_count' just before returning the rdev device
> during regulator_register().
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/regulator/core.c | 5 +++++
>  1 file changed, 5 insertions(+)

I will freely admit my ignorance here, but I've always been slightly
confused by the "always-on" vs. "boot-on" distinction...

The bindings say:

  regulator-always-on:
    description: boolean, regulator should never be disabled

  regulator-boot-on:
    description: bootloader/firmware enabled regulator

For 'boot-on' that's a bit ambiguous about what it means.  The
constraints have a bit more details:

 * @always_on: Set if the regulator should never be disabled.
 * @boot_on: Set if the regulator is enabled when the system is initially
 *           started.  If the regulator is not enabled by the hardware or
 *           bootloader then it will be enabled when the constraints are
 *           applied.


What I would take from that is that "boot_on" means that we expect
that the firmware probably turned this regulator on but if it didn't
then the kernel should turn it on (and presumably leave it on?).  That
would mean that your patch is incorrect, I think?


...but then that begs the question of why we have two attributes?
Maybe this has already been discussed before and someone can point me
to a previous discussion?  We should probably make it more clear in
the bindings and/or the constraints.

===

NOTE: I'm curious why you even have the "regulator-boot-on" attribute
in your case to begin with.  Why not leave it off?


-Doug
