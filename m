Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A5EC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5562089E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JXj2zIOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfFFTrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:47:20 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43615 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfFFTrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:47:19 -0400
Received: by mail-ot1-f65.google.com with SMTP id i8so3099590oth.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 12:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8wGfAmKyoK9bVApTeJ1ikTLIPBAYdTrgDhJ6H/YeNVg=;
        b=JXj2zIOFKEDcuxGqOXtaHzoMslRkH8F57wmo6Zg/C6Z48YMAJJzLyoK0y6q78VFXce
         sdIPp8OqGlBPq3V7mf87QV2UbHH7BIm1Fc3aHqwzCA+oljMlGYlHfkc3TI0I484O1K1S
         OXOMxDp8X8FWBYd/ysRIABwzI1ccbF3aeS12gtq8RJ0gFh57xBlSAoFVpPOzPKUEw+nG
         KtQmVAhtVZFxD6tK91fpiuOjaUaptaq/Q5Ev9mslUgwgexLbnMK5+ugOd7rQ7C1RqPlX
         xDPvBzguKkH0bAG2BPJA6lYOrrj/kAtz+rZsKRLu43r3SFAQxC7HLLwcCN35PWjP9wmm
         z7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8wGfAmKyoK9bVApTeJ1ikTLIPBAYdTrgDhJ6H/YeNVg=;
        b=T2hm4KBzA7a81YEmRbvfUEGZx78vd4yivlXxv/Lqfhz8/Is5y8EydJnxdUFqmXzh3B
         8SGTBKzxZIYTi3ZJVqFth9mbFdWWshxIz/YGKRo0v6cH6kHHVSP71r1c4SdR7jgseTs5
         RAc2xUGPwO7j5zszQwGD/plBwLPqqETOWRGZtsGUo6N1dxvTxSZlo1ryfHJRt2HKqfVE
         Mgdy6xTFxuyOFZ+LAh1YsKNDk2N1eNaIgH2ggjjTG6hJhIr40rriO5G+tL/s+3LYi8Xa
         4oRpg/6fy5WUNb2pwZ5z9d11mfiokQjlRl5WlR5r0Rjgov440jk+qYQiF+BLMc0TvqzA
         spTw==
X-Gm-Message-State: APjAAAWjlk8UisVOvzj1pISgZiV7KvNYwCPNYzk6T2jGtvkoKK9U3N5S
        0Nd+mafbNJmHys0flIov0YIZGTgKXxqPqslLCHKuGdVx
X-Google-Smtp-Source: APXvYqzuT2RwZC2LIrDFehW31R9jvGbrmRuApk42Pg+UA3g4byiNms1PcIULKfXunwPAiHdFS6Np+7uvtr1uGqZj/+s=
X-Received: by 2002:a9d:14a:: with SMTP id 68mr15424609otu.96.1559850438867;
 Thu, 06 Jun 2019 12:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190603094740.12255-1-narmstrong@baylibre.com> <20190603094740.12255-3-narmstrong@baylibre.com>
In-Reply-To: <20190603094740.12255-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 6 Jun 2019 21:47:07 +0200
Message-ID: <CAFBinCAR47VuoDoWerX4YZ4=v2G4+L0MW9kP0bEhrLWaWOPdfA@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: dts: meson-g12a-x96-max: add 32k clock to
 bluetooth node
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 11:48 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The 32k low power clock is necessary for the bluetooth part of the
> combo module to initialize correctly, simply add the same clock we
> use for the sdio pwrseq.
>
> Fixes: c5c9c7cff269 ("arm64: dts: meson-g12a-x96-max: Enable BT Module")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
with the correct fixes tag:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
