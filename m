Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A8EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48072075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0GQ7eTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfCKQjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:39:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35835 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbfCKQjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:39:14 -0400
Received: by mail-lj1-f193.google.com with SMTP id t13so4687381lji.2;
        Mon, 11 Mar 2019 09:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/l9agYG24ttd+pftcaaqtOMGEdAzL8zrUAxIKIuK968=;
        b=f0GQ7eTMH5sL0nOBdceav2GdcV8ZtFMhaIzEMUNQRHL7TuChJjgbIvHWVeKcvn1kEJ
         YbXNzpNz+XFbPLFZG0Yfe9fETm16uKxVeLpfk24+mK/9REK5N08BQmCDbvWKijXWc6Oh
         jDXB6dAbJtC6bOmikUVpnKvb7wdnt8jTBbjuKVN6TzRSTWsV1mXWE+Jq+TRXwZhjwG5+
         xPnoym9QcltB+HV3ZzT8RL61opVXbMh320sNZ546HYAlyzCxzLg0fvmN+3EfVfg7CNJq
         LfhiIPE8Ey8av1mnDc7am7EMpVQrwcOCc2GYP2cRoTmvUbnxumOISkX2rDmKh2WSynap
         DllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/l9agYG24ttd+pftcaaqtOMGEdAzL8zrUAxIKIuK968=;
        b=NqXdl8OeC9H1PoAtINCzVoit6DaJZ9E0YdhqsxTw+hQHgCB1aIdJcd1jVoxS4MVwGi
         Hg/dMc8NnuMzf/m8hBUWC5t/mAOvC8g7qq4DxS50DKafi1I8wjdiTTEoJvRGlvpOvy3p
         +xvI6ocCSsB9o74/qdc11LOYfREupJ2+ndUZoot1X1pQnbUH16t61e8C3xQrC+CuW7/d
         GeTXUtnGCjrEM+ePiTZqRaKxZODqUKSYWsNkF8ocO9SC6c2/+m5S/qSUWM/gQwZgN2kJ
         C+je7fKtBAc6NQPHIq5GaS2bLX0HnJc6DhTzUrKHOPbzATtEAahLekD2x72OyPt9nlO4
         akhw==
X-Gm-Message-State: APjAAAVPUJXNvxsOsyrna3l1bKyh0mFD2+ANnCfeTWWpSG4Mbscd4BUs
        QHGtJSkQWyefsSy/fz6qw87m0Owofp0WWqfVDek=
X-Google-Smtp-Source: APXvYqwIQywK5nIULbuCgIk9uf9m6ayw/gZDCiYv17b5lV1TSEWB/qhXONDIpYstGTPX7PzYtOTLqek9Kz1cbIiv+ZA=
X-Received: by 2002:a2e:964b:: with SMTP id z11mr15524581ljh.138.1552322352236;
 Mon, 11 Mar 2019 09:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <1552304271.2453.12.camel@pengutronix.de> <1552319997-24622-1-git-send-email-eric@nelint.com>
 <1552319997-24622-3-git-send-email-eric@nelint.com>
In-Reply-To: <1552319997-24622-3-git-send-email-eric@nelint.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 11 Mar 2019 13:39:21 -0300
Message-ID: <CAOMZO5AAz210dRw7aDD8SxVAh63RGN=sJsCGnPgY4xtnQoeLQA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx6q: remove references to PLL4_AUDIO_DIV
To:     Eric Nelson <eric@nelint.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Yongcai Huang <anson.huang@nxp.com>,
        Colin Didier <colin.didier@devialet.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, tiny.windzz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 1:02 PM Eric Nelson <eric@nelint.com> wrote:
>
> Since we removed the PLL4_AUDIO_DIV clock, we need to replace
> any references to it in the device tree with PLL4_POST_DIV to
> keep the proper parents.
>
> Signed-off-by: Eric Nelson <eric@nelint.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
