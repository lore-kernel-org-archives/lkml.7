Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA104C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF0D206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W8eY0lMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfLPK1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:27:52 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40625 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfLPK1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:27:52 -0500
Received: by mail-lj1-f196.google.com with SMTP id s22so6184855ljs.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 02:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kc8cYBIPzK7WSX6Dhpknsv+Az7sG/90zzv4gmeMoX/I=;
        b=W8eY0lMy6Qgx6i4PCyCCiBvKfrdmAknD/ElHqjjw1MmaCLGGVpfqimMzwD1KrZptEq
         SmGOOMB6K3EOysXDm1NJibNn3lksuBlHSOBZrz7e9YSXZZ0/0O6PP09e6gPdiqPt3m5B
         Mzcdx5+SQBHVInfd1/jdFHaDUeTp0P1+OMJdM1fjj5O8gEMcfmVDBZX0mnqwtI0FHoC+
         +JUpPJrkD3KtCHDJhkPV8xNvd5tGBAAQXPgmTaEpRRoIKPhM13zRhxUl2XeCnablcB1K
         ZJsSS4yXSWQpyFNu04ukz20OTdBlqcQ4In2zbgGsTFzFdFnwdgDL7N3EYLh7dEwVzQDp
         aAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kc8cYBIPzK7WSX6Dhpknsv+Az7sG/90zzv4gmeMoX/I=;
        b=Un8m0PLnAqMFedN+SULwDMx8iX3hItqLjOnQp3vyWEbVqiXGXZVUv5I5cr7n8mU6bf
         Kh93ELB3CnKMe1+fJMdZc1LJ3rgiOi/KlalfA+j3VS6CUQs2shb79UT9FzZ0+LQjyu8L
         BVYY+gupRlL9SOWM0pRg3wJ/xM+QFiol4WWr0ItIb/z/ALJtqdX20ltmFVN81xKJgxDD
         5svhqXgoizIr/1b16E7r6BrjRTGEJ6K7FvTfhmvGttwa4I9Rw3JcCW/pd07gsIlGXYp6
         py06j1325/QU7905UNjXWExosPRpRH4oEKtOhdbhvUCqYeu5Ev5HRhEk+H7KdVPcKAcR
         5eXA==
X-Gm-Message-State: APjAAAXVwZOyPbK6wMrHfUMYiIrgcoWkWzrIjyeua6buDGGgVx/NWJIq
        4duE0goopSM/9x2+BWnzZsuqqG5CRem+PVYkNLYekg==
X-Google-Smtp-Source: APXvYqxyqyrkWKlQ1gXsP1WttRxjmUxJOJGIdWOtatnGZNr2dHpk3W2tQ6LrXKWaSo/Xkh46gNIkzci0Gfo9VddG5bc=
X-Received: by 2002:a2e:8045:: with SMTP id p5mr18792305ljg.251.1576492069993;
 Mon, 16 Dec 2019 02:27:49 -0800 (PST)
MIME-Version: 1.0
References: <20191215163810.52356-1-hdegoede@redhat.com> <20191215163810.52356-3-hdegoede@redhat.com>
In-Reply-To: <20191215163810.52356-3-hdegoede@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Dec 2019 11:27:38 +0100
Message-ID: <CACRpkdYWi5dX8jRBoJmrA3Mrig-JUKw+qq5gth2veY3EyUALqQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/i915/dsi: Move poking of panel-enable GPIO to intel_dsi_vbt.c
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

> On some older devices (BYT, CHT) which may use v2 VBT MIPI-sequences,
> we need to manually control the panel enable GPIO as v2 sequences do
> not do this.
>
> So far we have been carrying the code to do this on BYT/CHT devices
> with a Crystal Cove PMIC in vlv_dsi.c, but as this really is a shortcoming
> of the VBT MIPI-sequences, intel_dsi_vbt.c is a better place for this,
> so move it there.
>
> This is a preparation patch for adding panel-enable and backlight-enable
> GPIO support for BYT devices where instead of the PMIC the SoC is used
> for backlight control.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

The kernel looks prettier after than before and it seems correct so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
