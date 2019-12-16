Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C161C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE2B206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ACbNbFsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfLPMQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:16:36 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34527 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbfLPMQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:16:33 -0500
Received: by mail-ua1-f67.google.com with SMTP id w20so1990613uap.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 04:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g6hMK4zvmiSQXDEVIro/DLpNW8Dnq2eeAYZqmv+C7n4=;
        b=ACbNbFswU1bSLXpKw7frBiJCD6yT6A648nS5mwhOnzZ/oCoWad3p+XghmD1WWzlVJm
         txMzHtwXkBDWokJ/qZ+h2NJNPo9VbjuBgNeD2ooLabCNucUnCK0laHcbbaDut7vIo027
         DGIbWg5yK8l48N2llclSO2ZAL85UBWtMaooZlHhG8lnHmOvHVcS+QEgB/B532FqJdWQh
         Ud6qSt1MTC7AD4yTbOkjMO5VSHEg7XmLrE6VGezhugDqk9s7SNpN9mJC+dL9rWjyTL+v
         ag2YGxtfHBMl2JzSpFfkRk+npQR6zGCl2dRnuhF+/nv3CFHdQT4l5R3tgcRsFnEci7bQ
         ONyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g6hMK4zvmiSQXDEVIro/DLpNW8Dnq2eeAYZqmv+C7n4=;
        b=eLge88J+WPYP/JilcoqZB1zi9JTiODSM2BTvH9tnho6/hMUdzwE8fCQc9zTopbl71d
         fVpKknonkpv5A7rc+oDWkRdYwuu2haXntw0T5o7Elh8KJ+/oT5j04uK12rGXKDDwnkgM
         h54TymXp187ASq7ouIo3aX6+4+0cDqQnXByV0V8YbEsrwfEVxPflrKQtgxS0Pt8dK/zE
         VF9a4e2uAqjZTZd3BWcpbCFbwTkZgTInyGkTm6KDiUD/WajAd2mNUUeVk3MeJXmjipc8
         sooXbmiBIYEArGDv/0U/10La35FbUYyQlIm5zf+FxEEd0P3Q49GEwLrxvF17wmuItO/J
         iYaA==
X-Gm-Message-State: APjAAAV8r79swpY23S/dQ+XwYInhG7zC3B/lgaIT2FZCBSVK6p5K1Opo
        4aCnV7Y2xTHEXi7SVAGqQFbHhaMnSSWvZ7bPrhNkUg==
X-Google-Smtp-Source: APXvYqxgrIn4al26ZnFpKqCL0TxyFBEwhX8AWXeCD4bBS7Ttf4sGA8fJ1Pg64Ke5L5GoUz3YDXkMxfaBaYcspaOS/YE=
X-Received: by 2002:ab0:1c0a:: with SMTP id a10mr22825812uaj.140.1576498591580;
 Mon, 16 Dec 2019 04:16:31 -0800 (PST)
MIME-Version: 1.0
References: <20191215163810.52356-1-hdegoede@redhat.com> <CACRpkdarJ5chDfgc5F=ntzG1pw7kchtzp0Upp+OH9CH6WLnvXw@mail.gmail.com>
 <1474a983-3e22-d59b-255a-edd3a41f0967@redhat.com>
In-Reply-To: <1474a983-3e22-d59b-255a-edd3a41f0967@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Dec 2019 13:16:20 +0100
Message-ID: <CACRpkdaYgpY=Anem00tPS=HPCD5XUrfWmWjvPkszggnHCpgK2Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] drm/i915/dsi: Control panel and backlight enable
 GPIOs from VBT
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 12:11 PM Hans de Goede <hdegoede@redhat.com> wrote:

> Ugh, taking one last look at the "pinctrl: Export pinctrl_unregister_mappings"
> patch it is no good, sorry.

Ooops!

> Linus, can you please drop this from your -next ?

Sure, done.

> So I see 2 options:
> 1) Add an orig_map member to maps_node and use that in the comparison,
> this is IMHO somewhat ugly
>
> 2) Add a new pinctrl_register_mappings_no_dup helper and document in
> pinctrl_unregister_mappings kdoc that it can only be used together
> with the no_dup variant.
>
> I believe that 2 is by far the best option. Linus do you agree or
> do you have any other suggestions?

What about (3) look for all calls to pinctrl_register_mappings()
in the kernel.

Hey it is 2 places in total:
arch/arm/mach-u300/core.c:      pinctrl_register_mappings(u300_pinmux_map,
drivers/pinctrl/cirrus/pinctrl-madera-core.c:           ret =
pinctrl_register_mappings(pdata->gpio_configs,

Delete  __initdata from the u300 table, the other one seems
safe. Fold this into your patch.

Go with the original idea.

Yours,
Linus Walleij
