Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D2FC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1213820665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565731696;
	bh=8jkWiBOKvCTyXhGYCXnRrjcLUKDEnMsamSfGEyFzJoE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fi7xUlBrjPty0dHhssjM9/dXH4Ys1vfUCCg75A6Zl7HUs0EBqIvgKV7I70HkHgBcZ
	 TRl64ainBs7cl/rHMtlm7F8sji34fl/czP+IlPOxQyBEgHMKrAC/rFtLtNspdCsbNt
	 B8pVSN+d0PkvqC7DSGGULLkSls0hr5/me6Ubl8lM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfHMV2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:28:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfHMV2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:28:14 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F82320874;
        Tue, 13 Aug 2019 21:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565731693;
        bh=8jkWiBOKvCTyXhGYCXnRrjcLUKDEnMsamSfGEyFzJoE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ViIAHHfDhraiK9pWAosKVYxwPNkGeqD7S5Bbuu6clK4kisNhTvyqtC+iJ0BZ1pZ+A
         zIRkcDQz94IJO0DTa9v57Nv8OzvoDXDkgYDbm8dJ3p1CL+SLlo0Mo9SxJ52aOtzcJy
         5B3a2RvT8Kbk9fqAn4Syh5XpFPO508kamqR/eAV4=
Received: by mail-qk1-f175.google.com with SMTP id m10so5733870qkk.1;
        Tue, 13 Aug 2019 14:28:13 -0700 (PDT)
X-Gm-Message-State: APjAAAXFqKjHlOND4qZNeq1BfPbvtDSswX3TrYL/vuIF/gyBSX+JEu2S
        TQbx28FVxmipnFxKQAmNoGJ2xpQbyAHapQo8Ig==
X-Google-Smtp-Source: APXvYqzaipedO3/eiAs1OzzKcswroOaLDbbRD4qdZTpHO5+hp1kjxBebIssMQ25LK/FM3EF2avxUcojclBfrohsZkQY=
X-Received: by 2002:a37:a44a:: with SMTP id n71mr34614965qke.393.1565731692535;
 Tue, 13 Aug 2019 14:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190813124744.32614-1-mripard@kernel.org>
In-Reply-To: <20190813124744.32614-1-mripard@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 13 Aug 2019 15:28:01 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+QxsxxCsaJ8GjSQhKVHnas3WqjOPnv86=-fWs143CUQg@mail.gmail.com>
Message-ID: <CAL_Jsq+QxsxxCsaJ8GjSQhKVHnas3WqjOPnv86=-fWs143CUQg@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: mfd: Convert Allwinner GPADC bindings to
 a schema
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 6:47 AM Maxime Ripard <mripard@kernel.org> wrote:
>
> From: Maxime Ripard <maxime.ripard@bootlin.com>
>
> The Allwinner SoCs have an embedded GPADC that is doing thermal reading as
> well, supported in Linux, with a matching Device Tree binding.
>
> Now that we have the DT validation in place, let's convert the device tree
> bindings for that controller over to a YAML schemas.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  .../iio/adc/allwinner,sun8i-a33-ths.yaml      | 43 +++++++++++
>  .../bindings/mfd/allwinner,sun4i-a10-ts.yaml  | 76 +++++++++++++++++++
>  .../devicetree/bindings/mfd/sun4i-gpadc.txt   | 59 --------------
>  3 files changed, 119 insertions(+), 59 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/allwinner,sun8i-a33-ths.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/allwinner,sun4i-a10-ts.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt

Reviewed-by: Rob Herring <robh@kernel.org>
