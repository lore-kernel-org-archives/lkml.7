Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6924DC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5C6214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NEeZ+uUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404205AbfGXT4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:56:25 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32864 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404628AbfGXT4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:56:22 -0400
Received: by mail-io1-f65.google.com with SMTP id z3so92266208iog.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 12:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XZt1VFBsfyDW8nwLopR3h8XPP4tphNg4YLYc8AkW2ho=;
        b=NEeZ+uUa6lhQAWD9vkktfpJZVl4pMOSxYJSXNt2bByMieaXwfzGB10mfQ6B2Li1wNw
         T4ZeKK3COOk1QFOqYMlmOLF4sOFI7nhmu+ImME1jtsxAS6J4BoCFBhU62jYMBtSqHVp7
         P2xLgUNJJoxlvGHXSm6CvOipxxbi6Jik9Btus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XZt1VFBsfyDW8nwLopR3h8XPP4tphNg4YLYc8AkW2ho=;
        b=LmbRLUKTaI7yRt/vGIX7YIdMWpKF15qFBCJtKPBrWM5P2xQ+sxP5C9eNF+JmAEI3fM
         zX3bYC6YyluBihUaumpXcVZt5xBva35kmxGycanhfUXum/xl68rff8CralDRNm+iCGS8
         prwPzhxZimNdOX0pVtgdExB2iec4JLybaZUCkQ4J9AYezufUdpv05hMPKaK4hmLBuiy5
         pQV4fPzjkERfXpdqvZaLD9QIJ+mMb3UN8aOZRIYtbwKPmNOceTmT6DBe9t2OUpitiB4x
         2m/EsD7bPj2plKKA7wAvJh6ym57xGhmj+jx+hVAdrAMFm7BC1GP8SyubG4FGgpo7gYID
         Uy3A==
X-Gm-Message-State: APjAAAUGzmveElqnjIsWaMBK6T/VCGPTQt1GqyZ4oR6jONRYME/h0w9g
        MEhzsFRQQ7ZrD2SJYoiEtRSZ4RSGTS8=
X-Google-Smtp-Source: APXvYqyJuaBLqCmzYhiiGjaUUiNJ0Ew1rGFY0G4F/tzNqehLmQxAokZ+kpNF4qntd+g4oCI3UfmfkA==
X-Received: by 2002:a02:13c3:: with SMTP id 186mr85329078jaz.30.1563998181709;
        Wed, 24 Jul 2019 12:56:21 -0700 (PDT)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id c23sm39411896iod.11.2019.07.24.12.56.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 12:56:21 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id g20so92183302ioc.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 12:56:20 -0700 (PDT)
X-Received: by 2002:a02:c6a9:: with SMTP id o9mr30860288jan.90.1563998180575;
 Wed, 24 Jul 2019 12:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190723225258.93058-1-mka@chromium.org>
In-Reply-To: <20190723225258.93058-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 24 Jul 2019 12:56:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wk2meLxa6AszjFs=Mfp_wML_7OMsn81FLA5tcdEx=1kg@mail.gmail.com>
Message-ID: <CAD=FV=Wk2meLxa6AszjFs=Mfp_wML_7OMsn81FLA5tcdEx=1kg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: rockchip: Limit WiFi TX power on rk3288-veyron-jerry
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 23, 2019 at 3:53 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> The downstream Chrome OS 3.14 kernel for jerry limits WiFi TX power
> through calibration data in the device tree [1]. Add a DT node for
> the WiFi chip and use the downstream calibration data.
>
> Not all calibration data entries have the length specified in the
> binding (Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt),
> however this is the data used by the downstream ('official') kernel
> and the binding mentions that "the length can vary between hw
> versions".
>
> [1] https://crrev.com/c/271237
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/arm/boot/dts/rk3288-veyron-jerry.dts | 147 ++++++++++++++++++++++
>  1 file changed, 147 insertions(+)

I agree that this matches what's downstream and seems right.

As you pointed out the bindings are a bit on the sketchy side,
claiming a certain length in one place but then saying that the length
depends on the HW version in another place.  I'll also point out that
the bindings are inconsistent about the name that should be used.
AKA:

marvell,caldata-txpwrlimit-2g
 -vs-
marvell,caldata_00_txpwrlimit_2g_cfg_set

...but I think the answer is that it doesn't matter at all from a
practical point of view.  The code seems to just find everything that
starts with "marvell,caldata" and send the binary blindly to the WiFi
card.  Presumably there is enough of a header in the opaque binary
data that the card can make sense of what it's being sent.


So it seems like this is the best we can do given the current state of
the world.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
