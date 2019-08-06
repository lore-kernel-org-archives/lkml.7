Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D34C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A616520651
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732260AbfHFIJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 04:09:29 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45007 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfHFIJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:09:29 -0400
Received: by mail-ot1-f65.google.com with SMTP id b7so40188330otl.11;
        Tue, 06 Aug 2019 01:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqMzHVpDgAOeonwqolEAexQrNRkRWUmsMZx6uc5Di+U=;
        b=ncTnZ643a6F6/xp7C4uOVK+6KbeNgPn9gNgcJf7vG+uXSvns3V5UXQsVE89o+4nJ0B
         ej7lG5JEgwrvEuEK/MGRpgOX8pW7BF/cQ7oEbQnIZQOEvLP31VZPK2DRAml4bSOmRgL0
         NTi0wE7rRWNeFg+sV1kzZRFLb9a5QK12C2tyOVNVbP4aCv0HLeo/GsOtSKPxVCgdKAlC
         nUhMRvKafaDansoPNHHNHQYRJTZc42izS7PRqLCo3mhmguFHt0ELsBkdf1ZVH8+YuUG3
         9TXRtJ/ChZXKInqaSsFZ5FPsIohuz0oi+zK4RKxLZsCn0iQusa86iIdKCKCVIGFymjCT
         h2bA==
X-Gm-Message-State: APjAAAVXi/GWjde0GnCJY1G4fBLrKzpJzCtxPEJr7S/e1VHcKqmiuvQC
        +IkAyhkHvfHVfKYFMgph2cD5aeHIxTajxJtc/0mH3A==
X-Google-Smtp-Source: APXvYqyxyt+Zm9XpZFQ3yabtEsQoWuW6uuAYo0QQEQY3CgXVLXrqXiHwww1RAwfouKG1y4E2IuOgL/omHPxmr9xrqjg=
X-Received: by 2002:a9d:5c11:: with SMTP id o17mr1832302otk.107.1565078968223;
 Tue, 06 Aug 2019 01:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190802100349.8659-1-frieder.schrempf@kontron.de>
In-Reply-To: <20190802100349.8659-1-frieder.schrempf@kontron.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Aug 2019 10:09:17 +0200
Message-ID: <CAMuHMdXp9GAgWE7Ea_oA08PdPc8+J_wGVhM7L5B466OSbr7D_A@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] serial: mctrl_gpio: Avoid probe failures in case
 of missing gpiolib
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 2, 2019 at 12:04 PM Schrempf Frieder
<frieder.schrempf@kontron.de> wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> If CONFIG_GPIOLIB is not enabled, mctrl_gpio_init() and
> mctrl_gpio_init_noauto() will currently return an error pointer with
> -ENOSYS. As the mctrl GPIOs are usually optional, drivers need to
> check for this condition to allow continue probing.
>
> To avoid the need for this check in each driver, we return NULL
> instead, as all the mctrl_gpio_*() functions are skipped anyway.
> We also adapt mctrl_gpio_to_gpiod() to be in line with this change.
>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
