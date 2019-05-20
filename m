Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C01BC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E321221773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LKTBBoJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfETX3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 19:29:30 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41566 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfETX33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 19:29:29 -0400
Received: by mail-vs1-f68.google.com with SMTP id g187so10015420vsc.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 16:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CQeZYzD9s3oOBXBqpcz3upzW+HnTQAvaSuAunctoyUw=;
        b=LKTBBoJnF7WkULGQxYRtktRyp16+r2Gr0GC86jOnsS5RT3Wx9ZuGBDEItu79R4p99p
         vAFX/U3chWHezKYIkoxL/MVdaASdEIItymbmrFUUVIacAs0Lnbhz+9Jj3d0vRx0zoZLH
         gTG72w3rwFRZVgtpgcRRnnrJYF5tIVag+zGCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CQeZYzD9s3oOBXBqpcz3upzW+HnTQAvaSuAunctoyUw=;
        b=kkUntCuF2u06m1Cmy/HEH+JTQupo2ar8rRXRB1HWgJZeeH9Cbu7TcySNcP6UaMtv8l
         wrkm83aNYdrKzPVepXvyxoYSXiurqqIdNvaJ+50MRMcYoKeFxBK3EgEYRQUaPSCNDZrr
         V/IAkw01rfoVfXDXY+AGaZSC1q4qyBVkzqg82aqKouu4jo10SpepvKKRmus19x1noHSd
         N4rrshYktazB1rdqXSqPzPWoMszCQpJuRTXSHMq42qiLeFOKVCQMjqPSUE9RhVPh30wj
         AxHQkU1smCSQHsg5+Syw3CkbUgomym3zvLYoEECbrJVpYr5qB6S/iJG5Du679NQXeQSh
         GrAg==
X-Gm-Message-State: APjAAAWSOmMp6X6aTpmvdPSxsXs3rHaWiCxGv6uxcQPw9Zx+SHQQrIoX
        1AeEhTjoRlKUzrMNdkEAvRY/0MUmHeo=
X-Google-Smtp-Source: APXvYqwjsfEnK+N8gL/KdgEkQHu5EeUEA794SWvPi2v5GqdRWVigjj7cK3+ekxuYQrkCFlzTpP6S/g==
X-Received: by 2002:a67:dc01:: with SMTP id x1mr2526229vsj.153.1558394968726;
        Mon, 20 May 2019 16:29:28 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id p70sm1480470vsd.25.2019.05.20.16.29.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 16:29:27 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id x8so6106293vsx.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 16:29:27 -0700 (PDT)
X-Received: by 2002:a67:ebd6:: with SMTP id y22mr22498929vso.87.1558394966905;
 Mon, 20 May 2019 16:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190520220051.54847-1-mka@chromium.org> <20190520220051.54847-3-mka@chromium.org>
In-Reply-To: <20190520220051.54847-3-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 20 May 2019 16:29:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WOpBWapjiz7zq-X7JUG3AaZOcN3Q-Z5XG9md4ZvMCtBw@mail.gmail.com>
Message-ID: <CAD=FV=WOpBWapjiz7zq-X7JUG3AaZOcN3Q-Z5XG9md4ZvMCtBw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: rockchip: Configure the GPU thermal zone
 for mickey
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 20, 2019 at 3:01 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> mickey crams a lot of hardware into a tiny package, which requires
> more aggressive thermal throttling than for devices with a larger
> footprint. Configure the GPU thermal zone to throttle the GPU
> progressively at temperatures >=3D 60=C2=B0C. Heat dissipated by the
> CPUs also affects the GPU temperature, hence we cap the CPU
> frequency to 1.4 GHz for temperatures above 65=C2=B0C. Further throttling
> of the CPUs may be performed by the CPU thermal zone.
>
> The configuration matches that of the downstream Chrome OS 3.14
> kernel, the 'official' kernel for mickey.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - specify all CPUs as cooling devices
> - s/downstram/downstream/ in commit message
>
> Note: this patch depends on "ARM: dts: rockchip: Add #cooling-cells
> entry for rk3288 GPU" (https://lore.kernel.org/patchwork/patch/1075005/)
> ---
>  arch/arm/boot/dts/rk3288-veyron-mickey.dts | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
