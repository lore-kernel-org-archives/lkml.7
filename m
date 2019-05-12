Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB454C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 18:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818F321019
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 18:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JIVmAKsl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfELS2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 14:28:31 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52906 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfELS2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 14:28:30 -0400
Received: by mail-it1-f195.google.com with SMTP id q65so16962202itg.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 11:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EF52YdVgI4AjVz2rWbfCjQjxB4bBcpwr8gdCDmEvRMM=;
        b=JIVmAKslIaptP97sT+JLAAOKjiRud4rjax0VdpRuD7V6Y+T+njTxkM2Kyk89m1aDN4
         9pt2Xr85DesiZ48jZ6afjb57cspF2aD2Jhfk4b+7bbwEZF5ZpT9feCYOcEo2RLvOwclA
         8QwJWBBOK3SSmNqzmn5XYwf9P/7y5m/k7TQ6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EF52YdVgI4AjVz2rWbfCjQjxB4bBcpwr8gdCDmEvRMM=;
        b=aDTax4QTHGmo7hHysXzgwtpsiDPdi00wmf9JOW/HIIkkYsXdMaZyGL+YWfrlqqLgCW
         tEJmfFy6pMjg5PGosbFPL5B7XGT5p+svotLFCZ9KkPqMvMij0WejJGcLfTBrdWZgDnSC
         GVw1clJizpC0XBUzOYRWczyrME6zSEVhTcUk0Z4OKXRNku1yZ0Q6wg451iVBJ1nWB3A5
         jjeU8coKwxwlzHKp6K9mn9rCJVgbKudly/KuP7qoqOLxkW0r2dOTedAbjX8OSlBJ6nVy
         DurfoL1bPoJ1SXgl6RzcTNjmR64XZBDJYkgKb1eqfL4Uo2Gg1K3xa+aNT/CysKnhz3Pp
         is2g==
X-Gm-Message-State: APjAAAVweHhqi2eny344gz4i9OOBoVhuSlaBZrFxtlDj4VKr944Hrf+H
        YmsCj7XNbQs23af6kvf+AGX9oFgC+aX4W+ysENEYyw==
X-Google-Smtp-Source: APXvYqxoZZ31n7p7DsRANkjUnS0uU4dF/+jejuqvVJfngZh1kMotrcwI/r2k8KpaBCLAP7sHgdKNC9IhCZC1L1ITf7I=
X-Received: by 2002:a02:b89:: with SMTP id 131mr16589728jad.58.1557685709583;
 Sun, 12 May 2019 11:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190512174608.10083-1-peron.clem@gmail.com> <20190512174608.10083-6-peron.clem@gmail.com>
In-Reply-To: <20190512174608.10083-6-peron.clem@gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Sun, 12 May 2019 23:58:18 +0530
Message-ID: <CAMty3ZBTO9+9HLikR8=KgWZQBp+1yVgxQ_rD-E8WeJ8VvpuAcA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v4 5/8] arm64: dts: allwinner: Add mali GPU
 supply for Pine H64
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 11:16 PM <peron.clem@gmail.com> wrote:
>
> From: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
>
> Enable and add supply to the Mali GPU node on the
> Pine H64 board.
>
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/=
arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> index 4802902e128f..e16a8c6738f9 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> @@ -85,6 +85,11 @@
>         status =3D "okay";
>  };
>
> +&gpu {
> +       mali-supply =3D <&reg_dcdcc>;
> +       status =3D "okay";
> +};

I think we can squash all these board dts changes into single patch.
