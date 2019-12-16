Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B55C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F012082E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kiHB4903"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfLPK2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:28:23 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44312 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfLPK2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:28:23 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19so6164985lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 02:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cu1+Hou8B++1NEwHbXDIcfHUJVKmIeBKoDLkmWPOXCI=;
        b=kiHB4903z0YwS4JpJ1gi73s6446AzmG+vycJ0iyY97WttaKy2iGzEj3edupk5Ytma4
         sCWlfm/Rxehb/LtxMP5pO00Ufe/6xX1+VMPoaDeUggEsVuap1N9u4sw7ssD3nbDI/zFh
         dN0zfPlhE1/4zMCaBTzL/gd9KQ3DvH4mEM32gjjNxRSpoB6R1nRyhA3M6oK/nQo8S0NQ
         IxawwPGhTYhsIrtUIcc1o6o8DCCkp8JVlAAqXKt4UrN8hIBxIyWOi9e1SeoGO6OAwRyX
         KOtMAorX9TkHU5jRK9asVCmhp7qr+l3dHawUJqq667yore78GofGrl8Kxmz4Z39tnvKd
         72fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cu1+Hou8B++1NEwHbXDIcfHUJVKmIeBKoDLkmWPOXCI=;
        b=AXum59s4mJex2YYSvtlvLJhHXoBKNPuf8d3TSb4Go3lT5MOgb+Fk2ICN9xfqQWTmn9
         aF87dMvh7IjgJcI6+k0L8bcufvwt9wihZJK9fWvyI3V89pMNWzuHQEsgMn4mK0xQ7xHx
         1EHQVorpfvAFYqnTv3CmnO0guMRqfUThZesvpxC5msWtNGCGxt7jD7pxC3ZYwGcWvii9
         9UsWyX7P2MY4nLrVv/wcGPjyOCmt5/BwEfo1GIuRRj3eJJAPgw9LU+W8m+NFBeWvMzJO
         nY77wk5iOd9D++sWqtVU1xgOf99xA9jRrxRo5rqOcEzzRPkhWqgr+aNMPtAlgI10lCmE
         L4Hw==
X-Gm-Message-State: APjAAAVwCgVe0HCotHXkRp4FzwPVNdngqVeXj8ns8Im60A2qV6NMB94a
        Q2L+GJ+M6XP/8aNp1v1rDoTFXKKnsX0YYjZA/fQL0Q==
X-Google-Smtp-Source: APXvYqzIK3/hH2FPyLoT1jp9cAXyv3Rqw/xnQY9Cr/V3d9Y+7lqo0CgT1RLffzK4WqPw4AE1exyAkY88bA5xiNu7h+g=
X-Received: by 2002:a2e:9587:: with SMTP id w7mr18088445ljh.42.1576492100956;
 Mon, 16 Dec 2019 02:28:20 -0800 (PST)
MIME-Version: 1.0
References: <20191215163810.52356-1-hdegoede@redhat.com> <20191215163810.52356-4-hdegoede@redhat.com>
In-Reply-To: <20191215163810.52356-4-hdegoede@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Dec 2019 11:28:09 +0100
Message-ID: <CACRpkdYpg-fE3Kf=VSKpC1VaCzHjt5n31jfqOgRgWzFZ9HYtsA@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm/i915/dsi: Init panel-enable GPIO to low when the
 LCD is initially off
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

On Sun, Dec 15, 2019 at 5:38 PM Hans de Goede <hdegoede@redhat.com> wrote:

> When the LCD has not been turned on by the firmware/GOP, because e.g. the
> device was booted with an external monitor connected over HDMI, we should
> not turn on the panel-enable GPIO when we request it.
>
> Turning on the panel-enable GPIO when we request it, means we turn it on
> too early in the init-sequence, which causes some panels to not correctly
> light up.
>
> This commits adds a panel_is_on parameter to intel_dsi_vbt_gpio_init()
> and makes intel_dsi_vbt_gpio_init() set the initial GPIO value accordingly.
>
> This fixes the panel not lighting up on a Thundersoft TST168 tablet when
> booted with an external monitor connected over HDMI.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
