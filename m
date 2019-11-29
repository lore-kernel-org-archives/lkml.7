Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92978C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 08:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6543C21774
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 08:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JYgDLrUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfK2I3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 03:29:30 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34603 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2I3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 03:29:30 -0500
Received: by mail-lj1-f195.google.com with SMTP id m6so23671423ljc.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 00:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cWGIyDGedrBpqvnGEcfpuSqDBvTplOuqKnHOt1z2nZY=;
        b=JYgDLrUje5DKLKp+k3Oade2QQs94WUDe1/8QVxUb7fsNTk/l6626+oRlXD3e/bpqq8
         3rXVOCn0W8WeVVi211CVf31RgRAvuuS0547r4rO7b8Qtqnt42ewe9w+v0yZ6ApeYS/pT
         AhaSF/3el3gdmRajOhieiokp6NWpp5KDmsg4Vy+O4Ndx/X8ZiUvvtr9MvUBytVXKX6nq
         4lzl2ls4ows7n0x+hLyiowSg7RcF2HUUiqvfF/iFHV13scJqOdo55G8+ne3TV9wbPt7D
         i4KUysQTFkRwCs7GHaAge7IXW0GhQ3iI5+IFlsuloczcM77XNCDWJsEqmETJcstMZeix
         tDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cWGIyDGedrBpqvnGEcfpuSqDBvTplOuqKnHOt1z2nZY=;
        b=fbLldQ7G0Z34nkZlnxo6Z2PZVJA3yuXPdVsoXjGW3pQaFkip1cCj6XmT01w6Fpf/pw
         SEq8L4U+dC83gZpq+vOXTDRvut81ZRkqGqbPdHJcLLOritDfC0ro6R0OJPyeLy6FXjiB
         lY4fyjn3L4ztFiLKmTIhrAqMyztUJ8e5J74MNAFia0jOMgPj8N8OjYsKXoqn9atwmi08
         IMfkKNli77053/1c9IcbKc3g6XmhWZSxy/pWBSPXwQhSVsHp0OHArSNuJWkxUoYbjREa
         mlBDv/THQY8ZmqGtrQPGJp2NmOwxQ6lBgd92jGVipe+gb77YGQw8kI27qK7N7R2N/T2u
         767g==
X-Gm-Message-State: APjAAAVX5mbn/63Sijl78ZYFQkPi+8i6fbV0JZWmYl/QIRUGTSdDAhcF
        B62QGOe2SfEEllMpXnkJOAwYY7I9ZCmAk2ftfH0A0Q==
X-Google-Smtp-Source: APXvYqyFVu1QDHRAEXN8klwjdP572QLZkNK+IG5v4PcKoUa4g8y93kq9uXa8jHwJNaDlWusiqugi2HpACqmUZgN4wsY=
X-Received: by 2002:a2e:9a12:: with SMTP id o18mr36798466lji.191.1575016168447;
 Fri, 29 Nov 2019 00:29:28 -0800 (PST)
MIME-Version: 1.0
References: <20191127135932.7223-1-m.felsch@pengutronix.de> <20191127135932.7223-4-m.felsch@pengutronix.de>
In-Reply-To: <20191127135932.7223-4-m.felsch@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Nov 2019 09:29:16 +0100
Message-ID: <CACRpkdbw_R2Lu1G8ZqV8vMCQL+A7XUV7qAb=gC-je6dzPC2rzw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] regulator: da9062: add voltage selection gpio support
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, stwiss.opensource@diasemi.com,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 2:59 PM Marco Felsch <m.felsch@pengutronix.de> wrote:

> The DA9062/1 devices can switch their regulator voltages between
> voltage-A (active) and voltage-B (suspend) settings. Switching the
> voltages can be controlled by ther internal state-machine or by a gpio
> input signal and can be configured for each individual regulator. This
> commit adds the gpio-based voltage switching support.
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> Changelog:
>
> v2:
> - use new public api gpiod_to_offset()

OK this is better in my opinion, at least it is a lesser evil than
the hacks I've seen.

> +       struct reg_field vsel_gpi;

Again add some comments to the code describing what this is
about please. A general purpose input that can be configured
such that it is not a general purpose input anymore, but instead
looped back internally to control a voltage on the DA9062.

Part of me wonder if these lines are really "general purpose"
but I suppose software could use them.

Yours,
Linus Walleij
