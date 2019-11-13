Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF54C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BDD222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DntvAiim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfKMO6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 09:58:24 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39668 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfKMO6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 09:58:24 -0500
Received: by mail-vs1-f65.google.com with SMTP id x21so1519081vsp.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 06:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P0gOVwnr8RZ3Od+Q+Wt9xsj7qG4zJHYItky1OrLz/7Q=;
        b=DntvAiimaxy5eO8WmD5HKsaq8paiLEDN0gZRqng+Xx9VyAUgIR4AjdrfvQMMtiSy+c
         kzIT1vF4PL6dW0q4lybAHUTIe/fZzxIfPJN9RiZYhS7TtFC33OI9cLMC+p8J1NFNgr+S
         WZjtZx1j7LqChx64foynsNatq1nK0axjAIv7cDN2Qi3ahX7gnhLFxIaefxu8Zl2L1/Bu
         cm/hKxxW2E7gV0/llr8hOWDu2HTnj3y3VD+Z0wLlyeGdgupdyArE1NA7g2xNoI7Z1i25
         aKclClidbXBgBWKKlVODU4ZNnkr4+R2uaHhlOkkhZqSP8r1MhySo2WiOit311x1n+NJV
         r9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P0gOVwnr8RZ3Od+Q+Wt9xsj7qG4zJHYItky1OrLz/7Q=;
        b=tEQnt0l6StKNx6XJ6k2bfjLNniewcV1TrTcqiSB+HxIO4NbBsAz0t8wrcK1vC3hsno
         WmZeb7bVmdO7SAfob56AfUWesPy2INMeU0WisMk18IqgvcNPLvBGvMyXwCnPQkMMpPY5
         f4zeY4nx5OpMqMAPi1n/WA1fVnJH3r4cHSdFT8Ox3mF+FRW0z3XdIDpeJqntIA29Fp0j
         VDNiG8cwQPlUcam63ee8no1eys8kN0DQ3FxNEkQntywDQQHdcaDLj67dwrYRU+xJEZr3
         3wpU+cQGgb1bEoJjmml4cg/I7Zm946xeM72wwiFXPm9M1j7RDSjLfP6cKKiZxDO7w1sa
         4uvw==
X-Gm-Message-State: APjAAAVNK/bSNEHRBXvnfr4WJhFcSRgtNqSf2B5QqM2Ibf5paFW79ygY
        c8ECPV0bi0fuT+ahv/Fnw8Edduvy3NzoSDhT2yw=
X-Google-Smtp-Source: APXvYqxOKdMQmyVzBi5/m0j44R6MDEw4mJPbYG+meE9Q68qt41BmgvfQGKrtpZllT36/0ae1bMdzT/KICvdwYOGzTAE=
X-Received: by 2002:a05:6102:20d1:: with SMTP id i17mr2197246vsr.186.1573657102968;
 Wed, 13 Nov 2019 06:58:22 -0800 (PST)
MIME-Version: 1.0
References: <20191106163031.808061-1-adrian.ratiu@collabora.com> <20191106163031.808061-2-adrian.ratiu@collabora.com>
In-Reply-To: <20191106163031.808061-2-adrian.ratiu@collabora.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Wed, 13 Nov 2019 14:57:55 +0000
Message-ID: <CACvgo51sNzSHCcix89giYEq=iGJa_-nYbgpOKY-MxPRGCM_cRQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm: bridge: dw_mipi_dsi: access registers via a regmap
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     LAKML <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-rockchip <linux-rockchip@lists.infradead.org>,
        kernel@collabora.com,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2019 at 16:30, Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
>
> Convert the common bridge code and the two rockchip & stm drivers
> which currently use it to the regmap API in anticipation for further
> changes to make it more generic and add older DSI host controller
> support as found on i.mx6 based devices.
>
> The regmap becomes an internal state of the bridge. No functional
> changes other than requiring the platform drivers to use the
> pre-configured regmap supplied by the bridge after its probe() call
> instead of ioremp'ing the registers themselves.
>
> In subsequent commits the bridge will become able to detect the
> DSI host core version and init the regmap with different register
> layouts. The platform drivers will continue to use the regmap without
> modifications or worrying about the specific layout in use (in other
> words the layout is abstracted away via the regmap).
>
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

I should have been clearer earlier - I didn't quite review the patch.
Is is now though.
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

Admittedly a couple of nitpicks (DRIVER_NAME, zero initialize of val)
could have been left out.
It's not a big deal, there's no need to polish those.

-Emil
