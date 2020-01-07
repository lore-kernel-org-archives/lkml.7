Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E3AC33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC997207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VtGCkan5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgAGKWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:22:02 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46923 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgAGKWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:22:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id m26so51661173ljc.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 02:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=feoOXtnj/48eID5q4+nHQx+NhKQCedVmAZE1CGkwypE=;
        b=VtGCkan5np3byUChW4aFxnm5yaN4zsovrbrrNL2pV3TXPJ8ug9aSzneEr0kuM1Tj0P
         edzvWeTniw0GUWQofo54Pp1v4q8dV8I68CAwW2CuiGggie2uyBCFnBJNFXABB/wFknWN
         aHv6ds9bHX7S8mm+0nC+ZNjKMsuF0rQ+cVM+sSOHXBaIob0AVlMAA6GpBALgkvTJfIbP
         jJ285SLdjWpvbeYjQ4VK8HZgyKPdySbY5rr5DSjF4q8dsImHeDow2p8j7M6s6Hs0VnAe
         tmf4/r7N14nCP0rjiRyD6k3uq9pQJBEracEo9Mz1Q/jiJXL0gQbJtosbb02O2M+Zk3rP
         K2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=feoOXtnj/48eID5q4+nHQx+NhKQCedVmAZE1CGkwypE=;
        b=bGDK1WxYab/PY5uHwXnQ2KMhV8RzL8g5HtEzPEuvOS+RXGtE6QWpNk7vGlhF0CVJ3a
         vyo9oTGkcqKZndFHdH5FvThj+RWO88eCaRtidpX92rh1RPACPAU7gCwp1NmWOzgpMQqK
         mBJ4q+VYNdiQqYQSAalVkgKW8824KTkZCLsusEQ5Q26d/72DtBL47nfmaVaCyxOKNvcp
         xnpany0oJb3pG6k1MSqacdqR5J9W514sjkpyk0YPpSxcA+7lTFIrYtGPZSCxyF4ioiVp
         b1Ly4nYPo/OeD3/6E5J/l1QsIwivcgF+AAC+JvL6GBeRidHPZE0JRNGu8W6QuL2aOY6y
         o3mw==
X-Gm-Message-State: APjAAAWRhiTL4WGLm2o8xtVKuo+HSEQu0VISU4eCxcQkdncOshCETnLv
        +rS6eSo3rVRKldsu1WbmOODiM+QBA071Snu8WcedKA==
X-Google-Smtp-Source: APXvYqxXuZipIZnMlieWvK5RQa1ocYuWDkqnEH6fOTVKgMsnd3pBbW5G5g/YQfew1w9JZF43RyZBTUs4rRB/hKpVxec=
X-Received: by 2002:a05:651c:1049:: with SMTP id x9mr61861878ljm.233.1578392519784;
 Tue, 07 Jan 2020 02:21:59 -0800 (PST)
MIME-Version: 1.0
References: <20191226023734.9631-1-qianggui.song@amlogic.com>
In-Reply-To: <20191226023734.9631-1-qianggui.song@amlogic.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 11:21:48 +0100
Message-ID: <CACRpkdYCGcUNuDOG2qSjRhZm-3c8eTUE4ib-tVAxsaCzU-RqfQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: meson: Fix wrong shift value when get drive-strength
To:     Qianggui Song <qianggui.song@amlogic.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2019 at 3:37 AM Qianggui Song <qianggui.song@amlogic.com> wrote:

> In meson_pinconf_get_drive_strength, variable bit is calculated by
> meson_calc_reg_and_bit, this value is the offset from the first pin of a
> certain bank to current pin, while Meson SoCs use two bits for each pin
> to depict drive-strength. So a left shift by 1 should be done or node
> pinconf-pins shows wrong message.
>
> Fixes: 6ea3e3bbef37 ("pinctrl: meson: add support of drive-strength-microamp")
>
> Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>

Patch applied.

Yours,
Linus Walleij
