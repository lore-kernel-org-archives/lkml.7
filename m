Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1D7C48BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DDD2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TtS7/2F/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732086AbfFTQnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 12:43:51 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41191 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfFTQnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 12:43:51 -0400
Received: by mail-vs1-f65.google.com with SMTP id 2so1956074vso.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 09:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OeFgssC06Ca4X3IXaHWlew+6T79MlwgCU07uMivbM10=;
        b=TtS7/2F/OTZGse3QP1Ezkd7+vMwTgyaEqyIgOAtPig7D5aPJz70bKNReyIUkk7+On6
         UWVf+T8HfAS8IFEMpSLgAMqz+HQoyrcztrkZ54szcGOHzusNg5Fw0O9cWtDmQmMLZwJE
         SE7nqQdAv/L+QXxO/PwU7I4Nw3N5EnBJEPuVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OeFgssC06Ca4X3IXaHWlew+6T79MlwgCU07uMivbM10=;
        b=ER1HIyaAutTYkc26ioRzZQ7Ir1MxdvX9CTaVKcgLHexBDwQPg8j+1fOzv7HLeR21JM
         vPHRzx4hHyOAGLm+27oXHkUHbbsjSmOFtZvUJm3W+N5gUDfwKOWQ3UnP3d7pi9Q+wWHj
         j10f+k+vUIaQR4uqqRsNA9R/KV7awdBjID7j6fMG1E4pjPHWAkws7xP+wwNII2Uo6qiG
         DcZjkd4++yBV7FE9MN2Kcq5NCJWGmThcOPWeLd7WpbSWDWIur2mb2q4AcFH10wY0tpJu
         4kDceFPjhxXawy3HRYWurz5pwTSaX2Xv908BAu3vHBdRjhM71gvIhFH12hzya/YFjvII
         WyHA==
X-Gm-Message-State: APjAAAXs304L4NDcpGe9pKh8SNpu37jjRR7ZsG+gxkUmfZq5vbTYK2EJ
        VuL9NOs+3d15GK7fYOYQ7rOyScIlC1o=
X-Google-Smtp-Source: APXvYqz7BCi0ldYxCixrg6KlyUa1mwwX5gH08Vl2IbAcuOwyeIcKH4NdOSGrkFNrUr6WI2REqttNnA==
X-Received: by 2002:a05:6102:105a:: with SMTP id h26mr43892023vsq.185.1561049030536;
        Thu, 20 Jun 2019 09:43:50 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id f66sm62112vkh.9.2019.06.20.09.43.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 09:43:49 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id u3so1946780vsh.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 09:43:49 -0700 (PDT)
X-Received: by 2002:a67:fd91:: with SMTP id k17mr58238625vsq.121.1561049028723;
 Thu, 20 Jun 2019 09:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190618213406.7667-1-ezequiel@collabora.com> <20190618213406.7667-2-ezequiel@collabora.com>
In-Reply-To: <20190618213406.7667-2-ezequiel@collabora.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 Jun 2019 09:43:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UpZAjrWkQ7qj5Wo2tf2wkg5Q-34Sun0MOtYLBAwY731Q@mail.gmail.com>
Message-ID: <CAD=FV=UpZAjrWkQ7qj5Wo2tf2wkg5Q-34Sun0MOtYLBAwY731Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: display: rockchip: document VOP gamma
 LUT address
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 18, 2019 at 2:43 PM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> Add the register specifier description for an
> optional gamma LUT address.
>
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  .../bindings/display/rockchip/rockchip-vop.txt         | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
> index 4f58c5a2d195..97ad78cc7e03 100644
> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop.txt
> @@ -20,6 +20,13 @@ Required properties:
>                 "rockchip,rk3228-vop";
>                 "rockchip,rk3328-vop";
>
> +- reg: Must contain one entry corresponding to the base address and length
> +       of the register space. Can optionally contain a second entry
> +       corresponding to the CRTC gamma LUT address.
> +
> +- reg-names: "base" for the base register space. If present, the CRTC
> +       gamma LUT name should be "lut".

As per Rob Herring, current suggestion is to avoid reg-names when
possible.  The code should just look for the presence of a 2nd entry
and assume that if it's there that it's the lut range.  Full context:

https://lore.kernel.org/lkml/CAL_Jsq+MMunmVWqeW9v2RyzsMKP+=kMzeTHNMG4JDHM7Fy0HBg@mail.gmail.com/

-Doug
