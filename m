Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CFEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C5221871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iZ8BTifh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfCOVmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:42:42 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43558 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfCOVmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:42:42 -0400
Received: by mail-oi1-f194.google.com with SMTP id 67so8523303oif.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 14:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wCtk3aXt0Yk6toX/gAFR9+fxygQzQO4SiBLOx7sFfow=;
        b=iZ8BTifhTEFX51Zn899jDENWT9BuurPS045AAH97doS77Pr+ovLEc4i2gAYOyc4cSx
         r/B6MhXGDN0BY0Ee08O+E2aDrUHJKbgeEQ/h6KwqF/dn6MOSw1Khw6Cccq3aupUUdver
         cMBvqYRSkmsBMZ6OSsjv+fuTP+hRwNzm5+4X29Z/LhxcszvnPN+VgMuY2eAizaQaIGlL
         E7pXt8bTZryzqyYWMlCbCBDB0HLh/SDZOAhmh28QH2CjT1Bp7CQL6vdNVyLwnEybaPG8
         wYGe+gRiO+BVR1lMk96/2pC7+rZIFKFwzHRiprGGbY1obY0Y18h+tzbWGj2ei6HD547B
         iPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wCtk3aXt0Yk6toX/gAFR9+fxygQzQO4SiBLOx7sFfow=;
        b=DaO/VvE2w7b62Z2WRQGAJZvOqm2drvrRgjEQjjPMcISviTBMZCH0xI/ys+wFM2g02p
         iyuzLyvralWkY2X80aqPIrf1j1PX1qIK2QFst9koo5tpVgctuEIz4YZuNCzUBNSJdODz
         3FlPNruU5n6i41dTB2PQeUUZqEH5UvXmikkzd5YAs3myjitdtL4aAiC6ENGyQ6UcBKwu
         UXCUyqE0mYySbinH7+MyIFX+R4M+NBKxnQSfRP5JuR3DqBMPRgikOlHgLQYZ/jUpUicZ
         R2DaFWruHex6/K4QJd8LYY3l64DBzWZrhApj7CHZ/yUo6HJjsjaq5LqExSigYTpN0PNU
         YLrA==
X-Gm-Message-State: APjAAAUgtGY5/MfMPq2oA/eDN+HR+poCJDazA+Zyy+X0SOF0jEKCxgxr
        j697hKwzF8qhN9AGfaSX4ZKMPWYB2CMfUIVQnei5kEih
X-Google-Smtp-Source: APXvYqxBaBq3VYbfG7CF7XmaCLLGwiZ9+0qqC8BEWY5vEx11GoQ3gEDnspE+CVC+Ms9AOnUy8NaVYj+ghZvPBGzZ2mI=
X-Received: by 2002:aca:4808:: with SMTP id v8mr2958837oia.129.1552686161894;
 Fri, 15 Mar 2019 14:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190311095613.11371-1-narmstrong@baylibre.com> <20190311095613.11371-3-narmstrong@baylibre.com>
In-Reply-To: <20190311095613.11371-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 15 Mar 2019 22:42:31 +0100
Message-ID: <CAFBinCCX2CqYXJgDzQX-cocKGCk00_rrV9Jvbisf2PL+HtrqYg@mail.gmail.com>
Subject: Re: [PATCH 02/11] arm64: dts: meson-g12a-sei510: add uart_AO pinctrl
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 10:56 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add pinctrl on the always-enabled debug UART AO.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
