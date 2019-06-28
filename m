Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E96C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A272083B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LpBzdV3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfF1Iq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:46:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42575 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfF1Iq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:46:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id t28so5154014lje.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 01:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lQNaKSJYVO+SBfhaRTd+ObgB+axwBGKUKZwAi5fi5AM=;
        b=LpBzdV3DdCgI12TYlbjXRnT2CgY9b7ToRmHBIC2H6bjhKPSz1XhedsQivDv9ZCFlo0
         x/RZj+DG0L5MS7QwKo3vx9AB0bQVZKUyDvM1d4RLV65hkoRS07x50oEqd56ghXPp1aMT
         yc1Aml6llp192DO7H7nz5YU1Og/Li6VqEtg9Iix/DA7kNYY41wrxANScMvWiC+w1gpLG
         HKWDL/E1p8OlH9CEwDjU9sGQ0pVe8gu7TuscxNRFR9aLJzwrt4s22+9mUBiS5pPxe3N4
         ZWjO0mJ3TwID3DKeegQDd49Yw69IOT4Apurk7LWuwnDk3KxZQsPNrOreu0yGYjcsEqyt
         hRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lQNaKSJYVO+SBfhaRTd+ObgB+axwBGKUKZwAi5fi5AM=;
        b=KdKR0ncDXTmwOYt+5q/mKe9N1i82gsSeYvtW5BPMOErGyydo/dzlS7bcYfTTKvJ5rZ
         SyFS9aahyjnkVwXmGhP0qg5xnmggoJ768lgnzjLIsJkFah5xMEnef6OGCJyAeILZtuyI
         j/m22QrGRwL6LqTpX7d4mUlaWjWw8rti2qAWgS8B6NeAsSLBza+a+ga1bUyOZZupseYa
         CP/C1sniCbn9RBJWU5vcZMEPot7/IMW1gyFO6qQINUNewvQdSyGt/Rq9z0P9fJSVON0M
         Nx6B+LzPQxgI+QB7qSxn7g3TiY4ZehRhChwAXw6/DvVeTdierF2pnwoBFwgONPqAdre6
         rj3g==
X-Gm-Message-State: APjAAAWo8wny8v+Lv8qEYdLpzQup7Lmy4JXNEU+ISS74Xz+OLorXagfh
        0OeB0uSAaaZf5t09AHjBik+9CT8XEEJzr8HsVWP/Ng==
X-Google-Smtp-Source: APXvYqzc5ofASQo8XlbqJgoQuOO8xPB1ETbBcPY7tE1jHcs9PNbLzQhP0le41W253nzsHWKxeEpUBcvYWJY2K+Tgzbg=
X-Received: by 2002:a2e:2c14:: with SMTP id s20mr5415213ljs.54.1561711586591;
 Fri, 28 Jun 2019 01:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190609190803.14815-1-jacek.anaszewski@gmail.com> <20190609190803.14815-6-jacek.anaszewski@gmail.com>
In-Reply-To: <20190609190803.14815-6-jacek.anaszewski@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Jun 2019 09:46:14 +0100
Message-ID: <CACRpkdYdqKZVKSaQB0THi=iZcRT04EKX2-85__Hw1f53o8vsuw@mail.gmail.com>
Subject: Re: [PATCH v5 05/26] leds: core: Add support for composing LED class
 device names
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Linux LED Subsystem <linux-leds@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>,
        Dmitry Torokhov <dtor@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Dan Murphy <dmurphy@ti.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 9, 2019 at 8:08 PM Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:

> Add generic support for composing LED class device name. The newly
> introduced led_compose_name() function composes device name according
> to either <color:function> or <devicename:color:function> pattern,
> depending on the configuration of initialization data.
>
> Backward compatibility with in-driver hard-coded LED class device
> names is assured thanks to the default_label and devicename properties
> of newly introduced struct led_init_data.
>
> In case none of the aforementioned properties was found, then, for OF
> nodes, the node name is adopted for LED class device name.
>
> At the occassion of amending the Documentation/leds/leds-class.txt
> unify spelling: colour -> color.
>
> Alongside these changes added is a new tool - tools/leds/get_led_device_info.sh.
> The tool allows retrieving details of a LED class device's parent device,
> which proves that using vendor or product name for devicename part
> of LED name doesn't convey any added value since that information had been
> already available in sysfs. The script performs also basic validation
> of a LED class device name.
>
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Dan Murphy <dmurphy@ti.com>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Simon Shields <simon@lineageos.org>

This is good progress on trying to bring order in chaos.

A problem with LEDs is that it invites bikeshedding because it is too
relateable.

So by the motto "rough consensus and running code":
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
