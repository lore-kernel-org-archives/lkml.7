Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9148C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF34822DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfH1N3r convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:29:47 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39373 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfH1N3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:29:47 -0400
Received: by mail-ed1-f65.google.com with SMTP id g8so26413edm.6;
        Wed, 28 Aug 2019 06:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l02jzc0gjHp1bXKxvkuGEA49qK2oKU/ON+JEnkF077U=;
        b=BsDrrANBhdAa1HgSK0NL3zaf+Zkz7RAp8La29KnnqFxeqxA32GpU34ltjaAlFYFwOA
         rXGWVJ0Ul0lGY6yN/qCHGJfmy/mQD4Ng7oxG5FPYRiT5vXpdU2DXyKAydepQCtRx0a1t
         h7iN8IgoR5uIZSI3RhOfTyN0JjJsFvpuf+raHWDSnCDSuaJChhCd0rejLI2v4OFxBZYN
         LzidBjFSNO/926IhnbbiUFbP9lcblBn5VMg331e6hOAodV9CTYLUZ4sAoRCoBaU/i8Gd
         QFlTSFuiF9jnjAp+V1W0C5AHJPPxf+Kx5tCl4HGG0TPQkvgND6pgt0wPzpxo21kpMNEM
         dm0Q==
X-Gm-Message-State: APjAAAU2GNqS8JjQ0gxxIXJdxQ74LsLyMRLKXB51SbqDOofrKtBAHAqj
        gTLX1AqchNcGPWbjO/+72Z+5ZYThWmk=
X-Google-Smtp-Source: APXvYqzhS8lI+wIRW0vrojXHLTvAzacKDtcZGYqZVUjeQhPNCRs/cUYs/QmWmXw6jh4jhXXh1LRdTg==
X-Received: by 2002:a50:9401:: with SMTP id p1mr3922520eda.189.1566998984720;
        Wed, 28 Aug 2019 06:29:44 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id ay8sm387712ejb.4.2019.08.28.06.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2019 06:29:44 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id z11so2524169wrt.4;
        Wed, 28 Aug 2019 06:29:43 -0700 (PDT)
X-Received: by 2002:adf:c613:: with SMTP id n19mr4678819wrg.109.1566998983470;
 Wed, 28 Aug 2019 06:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190825150558.15173-1-alejandro.gonzalez.correo@gmail.com> <CACRpkdazfe3gJr6Q+X05GzxPuKtUg0M780SPA_oR5bd+-xBPvA@mail.gmail.com>
In-Reply-To: <CACRpkdazfe3gJr6Q+X05GzxPuKtUg0M780SPA_oR5bd+-xBPvA@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 28 Aug 2019 21:29:32 +0800
X-Gmail-Original-Message-ID: <CAGb2v67e8EiS-LUuhAyPc57nWd4iOBEWC_SZbH801Lzi4QWGyg@mail.gmail.com>
Message-ID: <CAGb2v67e8EiS-LUuhAyPc57nWd4iOBEWC_SZbH801Lzi4QWGyg@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH] mmc: sunxi: fix unusuable eMMC on some
 H6 boards by disabling DDR
To:     =?UTF-8?Q?Alejandro_Gonz=C3=A1lez?= 
        <alejandro.gonzalez.correo@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 8:52 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Sun, Aug 25, 2019 at 5:06 PM Alejandro González
> <alejandro.gonzalez.correo@gmail.com> wrote:
>
> > Jernej Skrabec compared the BSP driver with this
> > driver, and found that the BSP driver configures pinctrl to operate at
> > 1.8 V when entering DDR mode (although 3.3 V operation is supported), while
> > the mainline kernel lacks any mechanism to switch voltages dynamically.

AFAIK The Pine H64 does not have the ability to switch I/O voltages. It is
fixed to either 1.8V (the default based on the schematics) or 3.3V.

> (...)
> > the kernel lacks the required
> > dynamic pinctrl control for now
>
> This is not a pin control thing, the I/O voltage level is usually
> controlled by a regulator called VCCQ, if the selection of the
> voltage rails is inside the pin control registers, see the solution
> in drivers/pinctrl/sh-pfc/pfc-sh73a0.c where we simply provide
> a regulator from inside the pinctrl driver to make things easy
> for the MMC core. Do this thing!

Or if it's simply voltage trimming for input, the a80 pinctrl driver
has something similar. Basically it registers a notifier on the
voltage rail supplying a set of pins, and toggles the register
to match the external voltage provided.

Unfortunately the user manual is quite vague on what it actually is.

> If you don't have time to fix it up properly right now I would slap
> in a big FIXME in the code so people know this needs
> to be fixed properly.

+1

ChenYu
