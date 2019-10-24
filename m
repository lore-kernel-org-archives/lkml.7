Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D094BCA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E0020684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="XhAqLnGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393715AbfJXUIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:08:43 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:47057 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfJXUIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 16:08:43 -0400
Received: by mail-ot1-f65.google.com with SMTP id 89so78898oth.13;
        Thu, 24 Oct 2019 13:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kd4rux9zK4/dM1SoU+NCgZWD5uCiq/LTC7LQfOYrfr0=;
        b=XhAqLnGm3J5Jx1lfeFRMdzlU0nfgbFU+iE1Zm2bKYj3FLDYtF1ll73kFibNsIash/e
         LiAtAgv3LFU+6O5pNwmOABP5Q8o8fWMMXn3k2nkHyhUiYIUm+GUTJo22elEo+guAHtPE
         TBKU9Tt+RMs1XWZfbjQEARoP4taKCy7aNJtMGmN/0keHFmoHOarA6qyupKoScvuzQMPu
         QYhNzVA3U0OSAjxYf4EHekwScAJoeZdehS6kdght/YPx2wWadiDZyEJcTQfAYv+vNS1Q
         n4u4szJc9tLXHeMRQ6aHq905bp8XVHbbuWyXYk46uzzto0V5th3DIzDm94efmXXcHzOG
         u5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kd4rux9zK4/dM1SoU+NCgZWD5uCiq/LTC7LQfOYrfr0=;
        b=udqnnggXxGwSqeiaOpJYfL/LAx6ELZX/P5woNirqSE1Rq+RqzZEFJfxgr3udox0Kc0
         RtscJ0WAiroS/McJElDjzM77ZKEfzMgU2o2xhN1dwredim5dakx3TVWUqrm+Ds4baxA+
         Bl/uQeP179MCSLVaN2dM6Y6pKXI/PlGmoIr3P8NrUXotlGDr6GuDru9X1EhFqJO3qWN6
         lrC39Oo8d/avU0kuCr045nzuSlyUG7VJpekaahXRr+L0N3nYnZmPVv7L3KF8vH1EUgPO
         NzEXjXVaQoZqJYZUVkuZQlKOCzcpJZ3ceryqC7e1HY/Rc8ndDRN5QwctxmI2200KqXn9
         T3Bg==
X-Gm-Message-State: APjAAAWGlniOl3k4TmghRG16RupiQoW/TcTSVviJv8eSPucxfbXDQNY9
        3tj4dHB6kdzanAYCrAC7PRiNOQNo2tYQcrxsQHE=
X-Google-Smtp-Source: APXvYqz84I0v7XTW8iDg6npWUg0bkWh5xFxmoF+OiWXABrvJLf217zrAxoylNNyEKiBYAHSZa6iAxuz1xcNzIGJY0b8=
X-Received: by 2002:a9d:3675:: with SMTP id w108mr13346820otb.81.1571947722161;
 Thu, 24 Oct 2019 13:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191021133950.30490-1-narmstrong@baylibre.com>
In-Reply-To: <20191021133950.30490-1-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 24 Oct 2019 22:08:31 +0200
Message-ID: <CAFBinCBFPLx0KTGb8D5FRus=hYMriYQ-jKSENyVpzwWpT+g2yw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: soc: amlogic: canvas: convert to yaml
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     robh+dt@kernel.org, mjourdan@baylibre.com,
        devicetree@vger.kernel.org, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 3:40 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Now that we have the DT validation in place, let's convert the device tree
> bindings for the Amlogic Canvas over to a YAML schemas.
>
> Cc: Maxime Jourdan <mjourdan@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
one nit-pick below, but I leave it up to Maxime to decide whether it's needed:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
> diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.yaml b/Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.yaml
> new file mode 100644
> index 000000000000..4322f876753d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 BayLibre, SAS
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/amlogic/amlogic,canvas.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic Canvas
personally I prefer "Amlogic Canvas Video Lookup Table" because that's
also what we use (abbreviated as video-lut) for the node name


Martin
