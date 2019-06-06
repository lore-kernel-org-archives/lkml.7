Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4EFC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EEBB206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SD1fhWau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfFFT5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:57:07 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35159 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfFFT5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:57:06 -0400
Received: by mail-ot1-f65.google.com with SMTP id j19so3169709otq.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 12:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M3lsHhmjhpNKOZxIxhHlrNdlPeU2n5HAjTzLl7Wh06g=;
        b=SD1fhWauXkc9V9EOEpK6A+zOyK9nmCipJqTTSXXhCfXaNOCmq5QX716zkpJacPJ7tm
         uxS76fdR2z0Gm0kjFYP4+v5tSPc9Ft1WPb/CD/7p1Ajri1LT5gs/O2Vo0mZPkERnLScx
         LcS/5Gjv6UkmVa5cOAGui+89+iyzltsgtEcYv0R+EWwi/4WB65eiIgk6ufajiKInfBn2
         nNjDf20yFe07Yc7JvUN6XWw467ZkIxAH9R/xUfPeqagPIYWbgbFDaj1D4ecy+kYiLl0Y
         FyKqNQx1exHR9kIiHUHbX5tu0tpnyD1zobxuUom11uGEY1KbADSrPIGzDdyteOKdW7Fk
         CsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M3lsHhmjhpNKOZxIxhHlrNdlPeU2n5HAjTzLl7Wh06g=;
        b=PFMuNmMIZu/CffKngK3Y5wb6Oz4E7Y8x1J4dST7/QDHfTlr0h+UFcDHm2KYLWCl3/M
         GUIasM/2g7FR7gpOTGyNzpqOny9ns619YtnywD3WcQ049EIy7PwvrqdN+KsJ0If1qpnV
         GWkBHmQk1ntEKcEKgD6FMMuJu35LX97tZmmcZZDSR1ZbBqYknk+g6S+UAYhLlmD6NNxE
         CPhWipBJxILT6clkz+ZOA71+B83tqxnPqojJ0daMw//QtfUPnjBdNUef96i7aTgBVS5E
         TlLk/kw9u/h6tMaN4d8AHTokjXEF4fJvvLOw7XFN9Edqos6JL5JOturmfaZa78mW32dR
         AEGA==
X-Gm-Message-State: APjAAAW4QkKtGoDz7HfXJgvzCubEg3Ucyr+5x7FXZ78ADVFb+BirrmIT
        +4bt+YkIs+vb0gaU3XG4zkyJ5X7ICRLoEkV8Fahyaw4f
X-Google-Smtp-Source: APXvYqxlFxwKjyzQ3FMcMwqoXbCExfbLfeX6ekhBTjoxZ58lba6psbc/9xJJ4+PN7DvuxdCB9t/KgYhNVtrP5cb/2Po=
X-Received: by 2002:a9d:32a6:: with SMTP id u35mr16585007otb.81.1559851026166;
 Thu, 06 Jun 2019 12:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190603100357.16799-1-narmstrong@baylibre.com> <20190603100357.16799-3-narmstrong@baylibre.com>
In-Reply-To: <20190603100357.16799-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 6 Jun 2019 21:56:55 +0200
Message-ID: <CAFBinCC66zaf2KhSbgDdTxynOVeOOVajoOqk0GxiQW0MSXiG_A@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: dts: meson-g12a-x96-max: add support for
 sdcard and emmc
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        Guillaume La Roque <glaroque@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 12:04 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> From: Guillaume La Roque <glaroque@baylibre.com>
>
> Add nodes to support SDCard and onboard eMMC on the X96 Max.
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
