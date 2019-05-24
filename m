Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CFAC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172FC2187F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h4/4vz3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391264AbfEXLuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:50:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42063 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390961AbfEXLuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:50:08 -0400
Received: by mail-lf1-f68.google.com with SMTP id y13so6896382lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AL2d0pjlVBmIWRs6fr455brLUAHkmqGB07RrA1F6UsQ=;
        b=h4/4vz3LD2ZII4MSJYVeGvEjd8RGbaXMRdluTLEVzPBGwfPTSo43vsYoHYH/xySLNX
         V3rGq013VRND/0yAuj7v5uqA7np6Ia3LuEJ6wQ25a8Wtm78bve/xXkyTWTs0vJJsXk7K
         PNhUmZcnHMsLAxNUFohIKBAKVFCyISAmeJe80Tox/KO2IeSu/8Jx4IWxl4SsrBCoU7CT
         AOyrklKJAz8x5PVopaL4hoIOkev5AbUTo1Jz/q03XW38IygBl/52Jwk3PZIfyKlRDDAU
         J81VG4MVmf005/SerSCAeZwN7SndZOQlGCaigSqqUn2XzmvwgxU/qS3+d0xxB1jItMgH
         8dNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AL2d0pjlVBmIWRs6fr455brLUAHkmqGB07RrA1F6UsQ=;
        b=l6c6UqFyuFWSyZi/rUQR2c6wBlJ7rmDBeQ3GYsM/0GaWZA3a/2kQHdaymDBnGJqE3U
         DoYrNiXVmRH8bgnloqOfxoIx+fN8duUMHf771EbfQOimXajpAX5o555FEFcptaPInGxf
         U4Qb9zvmXd1bsXDL/OsELq627Tr8cbniys2SICBFCFlOxjNV+LWy8X5i53kXI/fS6hqT
         rKH06yGRIe+a7JTCNGM4D/DrE91iK9aBMN53iZaYkA1qkV4grnyuoYBTNmfbV1G4QvD+
         T0ybJX1Rl/qKH1f4oz+k4aZ4YS241/MXBlln2MWEtPLoiVNQEZ2FqWX5k7c4YzGeJo2x
         0hzw==
X-Gm-Message-State: APjAAAXaojf38XjWFdPCnBSI3WigIjivmMat7K8uVgxf0qGV8H+SLbX0
        Cw9EJjhuTE8v9DBTkMaPTBA02Xf5L/Od2KpgNmRLPw==
X-Google-Smtp-Source: APXvYqwbOkonOaKhd8YCRIfmv8xAdTAD2vdgJCKAFZSw069Ovzk2VCRpvhyKKNBx3bpZuWAcz7AuNGltRgMJWnNejjw=
X-Received: by 2002:a19:4cd5:: with SMTP id z204mr5666594lfa.113.1558698606083;
 Fri, 24 May 2019 04:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190516151339.25846-1-jbrunet@baylibre.com> <20190516151339.25846-3-jbrunet@baylibre.com>
In-Reply-To: <20190516151339.25846-3-jbrunet@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 May 2019 13:49:54 +0200
Message-ID: <CACRpkdbxudSAD8rHbzpPFSAhxmd39=Jt62AKEXQV2CaDEZZQGA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: meson: add output support in pinconf
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 5:13 PM Jerome Brunet <jbrunet@baylibre.com> wrote:

> Add pinconf support for PIN_CONFIG_OUTPUT_ENABLE and PIN_CONFIG_OUTPUT
> in the meson pinctrl driver.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Patch applied.

Yours,
Linus Walleij
