Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3780C47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 16:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96264218AC
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 16:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rpEtxSVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfJEQf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 12:35:57 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38819 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfJEQf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 12:35:56 -0400
Received: by mail-lf1-f68.google.com with SMTP id u28so6531701lfc.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 09:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pn6mxtcEEEc3owMIwbkt2TQL3Wmbd6NRz2v8eZ+RVTk=;
        b=rpEtxSVEvEX2HhDQUFGyl3RdGfgjIagn3D9aobXi/wZtjscUnA1mkJD0kM3fiNupTG
         AfnKtyqJeYJ2uOTaQs6ySZeaNTCqFfo0/LKAfsZG6XIHVgRQWHGjbI4X+8tR86xbgh58
         UxZZo2Z8FOTYmp7b39uIYNs66Brkx9UEIKIyeGX7lge6cL6kKDMj9FaHEFKuhUJoIrou
         aEWJ35sYx+gYXF4Ss9Yohhnn31dOWy2cV94C52WosfyCgY4tR3/6M6q+HpHrqtJkL9IN
         V7orx4r/DU5hbKtRoeY/W3lxfG/Iy2raEXipla9KnUlwGY2BgV32P1ctLRpxvIGgWLm1
         qLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pn6mxtcEEEc3owMIwbkt2TQL3Wmbd6NRz2v8eZ+RVTk=;
        b=mNB0rkIs/x9dlHwzWk97uhxPNhsCLnd7aExGA6IwGM9EllhD/H16D7E9HefULNSSCJ
         xTpe3TbSCH8vPP6fJzrOERkh+/yMRckgLepf2az6Yn4WjKJEMOepgK8EH5FxIEFk8UY/
         3F8630s/QB9AcZSgCvfWvly0u6ko0OoKGuRSKHS/wKzvYfoF8QmPpa7z0FgndLZrcyU0
         yjyzCzyExDPAfG0i8KyXxaU1+ELNVr5cl1phThL5M7ZQRIBa4AQR4y0zQkSTHqH+AAg+
         vCuEID1leftSBIJ4SjfpudHgttcH065MIYvUJAhdDg6CurVP2cZ75NExThGGSSX78oiT
         WUlQ==
X-Gm-Message-State: APjAAAVGCl1Ck9qlskLNu6YS6PxdvExaieNO2UMSnPvBVo4Nxl59SsFc
        Qyn7w9BG5JiXZnQF+yX631BsyJIYZuZxLP+6rxbvrA==
X-Google-Smtp-Source: APXvYqy99lBsuY63SZm1Hovkzqrn5mNe5uNYRXbJEe6kopZaSTzsWTlUs5zAiyKhJwvIMM8Ytt5JplveuThrYIBo6hg=
X-Received: by 2002:a05:6512:25b:: with SMTP id b27mr12485234lfo.60.1570293354605;
 Sat, 05 Oct 2019 09:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191003000310.17099-1-chris.packham@alliedtelesis.co.nz> <20191003000310.17099-2-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20191003000310.17099-2-chris.packham@alliedtelesis.co.nz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 5 Oct 2019 18:35:43 +0200
Message-ID: <CACRpkdbQapKs5f7=7U-=jRYN_CYQ4Rtrwrk_1nLwZJHD26bw2A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl: iproc: allow for error from platform_get_irq()
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Li Jin <li.jin@broadcom.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 2:03 AM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:

> platform_get_irq() can return an error code. Allow for this when getting
> the irq.
>
> Fixes: 6f265e5d4da7 ("pinctrl: bcm-iproc: Pass irqchip when adding gpiochip")
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Patch applied for fixes.

Yours,
Linus Walleij
