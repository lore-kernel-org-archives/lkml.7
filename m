Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DAAC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03FA22CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/ZkTZmH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfH1Mwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 08:52:44 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43302 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfH1Mwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 08:52:43 -0400
Received: by mail-lf1-f68.google.com with SMTP id q27so2054094lfo.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 05:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XVqiZEbVUqIzK5hY9HIE+w9Yw4YCnwVUWn8KQwWEJ/o=;
        b=j/ZkTZmHKtb+C6yykay6Lk89TOZ2nUMHdfIDdtlO3/glkjnfikIYS28NL2SG8TTJgs
         zaFgS4RwSSejdCGrhsS4ul+I8b6oSeCtpK4UBcERRoeQn1cs6AYlz+EbRcAN+fD38Vwi
         uNGYpuHx5n5iVdfhs38LAFPqeS9CaugquJL9Up1fPrU1vDd5RVAH2Sz0oKDHDqMQ3UU4
         r5KZS01C8wSJUawPbF/GeSys7s02FLBfU70H6f0Rz0LziJuBQNUyKBIppFqFqCPi4/XB
         xv2nnTa6+37DxCcKyOOhHTeKyCepv77Atwv/mavdOHSUq9IIS6QjbQwDuqf5bIbFCIl6
         is4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XVqiZEbVUqIzK5hY9HIE+w9Yw4YCnwVUWn8KQwWEJ/o=;
        b=V1Pp2mupwTuKN1DGROW6sPC1aJLcccUX+F/CKtarQRBD2gNvK7wSmGvkLpjt2ZqbCj
         mE5Kjp8jbW5caq1t/vJq05ZJSX3/vjsFUCGGo+F+6eYKK6fYC6a9fGawPG2LK8rEf638
         ncODZ9HSfSgJX6EbKFow9gmjL/GRfCuRVLwQ7Aet4nR0L6+w8ANfT+57vizXFig4qiYZ
         t5ZcDnyNC7+aCXAQmYyeO+bgxZ1HrniWsqcdPR9FM+c8rdUaUWOxPsbNyOcxY3IOYB8M
         CZW7g6doXDjVQXFBn4djhHBXMyRESF2IFG6E7LAMmWaZTZ9rfZqXZx5aUF15PbKZtjO1
         ia0w==
X-Gm-Message-State: APjAAAWXeVDlG7LghtHSx06OTNRXDNg5qDM1183ydlPp7FomRh9AR5uX
        /dQhrnUgBAK/cOtu4gkxcHaJ+Wl/TARI63oFLZUBmw==
X-Google-Smtp-Source: APXvYqxhh7npR4DKD02urqAfnNma90KEuSilcS60X5kI+BR0cS5y3dkj2v9FsecupCFIorgjCH8a/URG0YasbPxugp4=
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr1699777lfp.61.1566996761734;
 Wed, 28 Aug 2019 05:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190825150558.15173-1-alejandro.gonzalez.correo@gmail.com>
In-Reply-To: <20190825150558.15173-1-alejandro.gonzalez.correo@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 28 Aug 2019 14:52:30 +0200
Message-ID: <CACRpkdazfe3gJr6Q+X05GzxPuKtUg0M780SPA_oR5bd+-xBPvA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sunxi: fix unusuable eMMC on some H6 boards by
 disabling DDR
To:     =?UTF-8?Q?Alejandro_Gonz=C3=A1lez?= 
        <alejandro.gonzalez.correo@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2019 at 5:06 PM Alejandro Gonz=C3=A1lez
<alejandro.gonzalez.correo@gmail.com> wrote:

> Jernej Skrabec compared the BSP driver with this
> driver, and found that the BSP driver configures pinctrl to operate at
> 1.8 V when entering DDR mode (although 3.3 V operation is supported), whi=
le
> the mainline kernel lacks any mechanism to switch voltages dynamically.
(...)
> the kernel lacks the required
> dynamic pinctrl control for now

This is not a pin control thing, the I/O voltage level is usually
controlled by a regulator called VCCQ, if the selection of the
voltage rails is inside the pin control registers, see the solution
in drivers/pinctrl/sh-pfc/pfc-sh73a0.c where we simply provide
a regulator from inside the pinctrl driver to make things easy
for the MMC core. Do this thing!

If you don't have time to fix it up properly right now I would slap
in a big FIXME in the code so people know this needs
to be fixed properly.

Yours,
Linus Walleij
