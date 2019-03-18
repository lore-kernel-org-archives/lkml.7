Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4739EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7C720857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZThueQky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfCRT5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:57:32 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39696 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfCRT5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:57:32 -0400
Received: by mail-ot1-f68.google.com with SMTP id f10so8146371otb.6;
        Mon, 18 Mar 2019 12:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0p8gYDpd7YrV8ybeAAOUxyt+BLOwQuu/NEHKvIZfe2o=;
        b=ZThueQkybG+BfXb3iWjfRnaJBh3Ra+r50JK3rf83Z+GZ+fdr/cO2oM0BkLqAOQCNhG
         pX9IN+GRMRxn0zV/8a9yjZ1fZk8wZy4Ki2yFokZNcOfvBEvznZMPx/5wtUF3M74ugrQK
         jp6VQxYIxDhdn4Ouq0WBvyiLG/fFCiY3aeb3WB9qL4Os+ETqMUmh+JsNVhQR92qIL2aK
         hu6qSG600uodPmBxjXyA+efmXwwAa635hGmLYCf1ZjeDeSvq9DH2k2T4KN7FKDBgGIXY
         474oFjKTLdBwng2Q1zLZde1DRZfsmxDWuhAG1beJKIQ1byrzvkuzuvbyLVnUVcvqzL8c
         ZwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0p8gYDpd7YrV8ybeAAOUxyt+BLOwQuu/NEHKvIZfe2o=;
        b=qDK96zDGggzPI2gz7Q5hSduBH/kgF1GqRkr8wUnNLORApXVwWFfJ9OT2gCck9bygjl
         /auOGdBiNQkrG0/nI5BheaKmVScyU8X74Igc1YKdG3Fg6xG8KcTHb9sq5nQgymknObCW
         aeMZ6M/E3HSa6JwpJJnI+vIUoeJPCApOUWjzvY/3akOM3W2NxpHoZZttnJ69Z+Ep3DYN
         toeH4qGK39ekEUZOWX+9vftwTP+ALGwu5Pti9v+nFURNYVyXS+pp9KDiD/Op3zkPqG2S
         WLSzSyPODcGagZtMN/qBjqe5cd1wNYOEaLbqWRY7Amz6PoxzoHMutXV3YzMF423azo3j
         Tnhg==
X-Gm-Message-State: APjAAAUjtf+GtRCst72m6lrgfYHsSASwDX21aTKYk0k6TkfbDUAIlMhs
        l1N6aTM6WLxTysFZ+OvIs5oNw3yQPaI1AgXXFU8=
X-Google-Smtp-Source: APXvYqyyvxIO6pD9izhEnsXhJSu+xQaJVK+1ROEnE/N4Xsw7DUyXqyQ1fKNnbLM50FEj1YScOuhY8LZtDhUyKZ5gP40=
X-Received: by 2002:a9d:6306:: with SMTP id q6mr11285345otk.86.1552939051103;
 Mon, 18 Mar 2019 12:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190318132655.30040-1-narmstrong@baylibre.com> <20190318132655.30040-9-narmstrong@baylibre.com>
In-Reply-To: <20190318132655.30040-9-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 18 Mar 2019 20:57:20 +0100
Message-ID: <CAFBinCCLrL3p=h2pXrbAnyLPiDt_3mfK4pkUhprghzbj826p6w@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] usb: dwc3: Add Amlogic G12A DWC3 glue
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, Mar 18, 2019 at 2:29 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Adds support for Amlogic G12A USB Control Glue HW.
>
> The Amlogic G12A SoC Family embeds 2 USB Controllers :
> - a DWC3 IP configured as Host for USB2 and USB3
> - a DWC2 IP configured as Peripheral USB2 Only
>
> A glue connects these both controllers to 2 USB2 PHYs, and optionnally
> to an USB3+PCIE Combo PHY shared with the PCIE controller.
>
> The Glue configures the UTMI 8bit interfaces for the USB2 PHYs, including
> routing of the OTG PHY between the DWC3 and DWC2 controllers, and
> setups the on-chip OTG mode selection for this PHY.
>
> This drivers supports the on-probe setup of the OTG mode, and manually
> via a debugfs interface. The IRQ mode change detect is yet to be added
> in a future patchset, mainly due to lack of hardware to validate on.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
with the small issue fixed (see below) you can add my:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

my opinion is that the whole driver is looking great now!
I hope that it will be queued for v5.2 soon because there's no NACK
from the USB / dwc3 maintainers yet.

[...]
> +       ret = of_platform_populate(np, NULL, NULL, dev);
> +       if (ret) {
> +               clk_disable_unprepare(priv->clk);
> +               clk_put(priv->clk);
clk_disable_unprepare is called automatically since there's now an
devm_add_action_or_reset for that a few lines above
clk_put is also unnecessary because priv->clk is obtained with devm_clk_get()


Regards
Martin
