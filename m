Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18013C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE4E21951
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Oq3bWQYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387611AbfGYQs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:48:56 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38313 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387552AbfGYQsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:48:55 -0400
Received: by mail-io1-f67.google.com with SMTP id j6so23508202ioa.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y98fApz06JAWtv7lUwUx5g2Y+VKbfux7cYr11jtX85M=;
        b=Oq3bWQYZfePc311A34AbLZpfdLSyWQ9zAmOxY8w/LT5D3Z7amPYgg7slXVnLbaYT5s
         dApXuC+dvlXm4a7wKv0nZdbyayoNVDZ4t5PoK8tbVG3OE7LmMafdc1Ctd/dWKEzxKHln
         xwxF9Q7T9eZPyvnh7tT9vMxAjquvbNlDsV/PY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y98fApz06JAWtv7lUwUx5g2Y+VKbfux7cYr11jtX85M=;
        b=mQhtQPc2ZZhj08ZBv8t4d4jIBndMRPyuHCifGOm7cBO7QK8x1vsrXbouv/356ufAEi
         tuMkGorxyjEuQWpPF+CGlmz3e1l7PfcBv05gECvulP3cyRgVbMzY/MfVfZvhQ8e0CA/M
         iNrdeByJJl7ux+Mgs534WyCZlem/xTLvvWluuWvHwFn3/bpqSwKCCRsvT1Rcfy3H9gvy
         wo64ECwh78+cK1NrUGs8rWXs8j0xxH8mUxwn1bgIchUS1F1Q+tuHZEX2GZlOJgSBlrvF
         XC8ycSWR0GVPv4jqg11WcaBgz3yKRBQaAvjGPUr2P/Fb2C4OKMbFDdvfwz8B2frmL+KY
         se1Q==
X-Gm-Message-State: APjAAAWYtcbk18qJqWQXqtfwk1oxhj+ECfsECcj2hZ/GMZibCggT/j+L
        T3RUe8t+A9eoCpBHhiufd+Q54GY0etU=
X-Google-Smtp-Source: APXvYqyC//IXmOT51l/MKfGcpu/ZEwFJVHIbgm8yZPiy6FRLyCkrm97d04F5zpKlMnPpquGvRdM+Sg==
X-Received: by 2002:a6b:fb0f:: with SMTP id h15mr84612565iog.266.1564073334072;
        Thu, 25 Jul 2019 09:48:54 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id t14sm41569976ioi.60.2019.07.25.09.48.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 09:48:53 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id i10so98590226iol.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:48:52 -0700 (PDT)
X-Received: by 2002:a02:ac03:: with SMTP id a3mr94891125jao.132.1564073332377;
 Thu, 25 Jul 2019 09:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190725162642.250709-1-mka@chromium.org> <20190725162642.250709-2-mka@chromium.org>
In-Reply-To: <20190725162642.250709-2-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 Jul 2019 09:48:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X85ACbN79foy_f4qQ=9a+8XFf0a3cE7S4BMn6pWvMmPA@mail.gmail.com>
Message-ID: <CAD=FV=X85ACbN79foy_f4qQ=9a+8XFf0a3cE7S4BMn6pWvMmPA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] ARM: dts: rockchip: move rk3288-veryon display
 settings into a separate file
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 25, 2019 at 9:26 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> The chromebook .dtsi file contains common settings for veyron
> Chromebooks with eDP displays. Some veyron devices with a display
> aren't Chromebooks (e.g. 'tiger' aka 'AOpen Chromebase Mini'), move
> display related bits from the chromebook .dtsi into a separate file
> to avoid redundant DT settings.
>
> The new file is included from the chromebook .dtsi and can be
> included by non-Chromebook devices with a display.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v3:
> - allow MIT license
> - move pinctrl section to the bottom
>
> Changes in v2:
> - rebased on v5.4-armsoc/dts32 (0d19541e3b45)
> ---
>  .../boot/dts/rk3288-veyron-chromebook.dtsi    | 115 +---------------
>  arch/arm/boot/dts/rk3288-veyron-edp.dtsi      | 124 ++++++++++++++++++
>  2 files changed, 125 insertions(+), 114 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
