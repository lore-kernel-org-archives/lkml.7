Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A33CC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A93214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fjPy0z87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfETSEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 14:04:25 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40165 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbfETSEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 14:04:25 -0400
Received: by mail-ot1-f66.google.com with SMTP id u11so13820565otq.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 11:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sa417ZNxztSzV34gBCNtKBCrm39utqje6hlLc0wW990=;
        b=fjPy0z87voFVjd4LRHXwBJv1E0lIJRbAa1BuCPTXEjgF4pASSXLtA1JnLIa6eMgspy
         Ocql0kvac07s40F0Odx66ZcpIy9vBxjYN6pH7/uiDEeVx98GkP4r5bWnFK6IYqUOSLMc
         Lc7zPn52zxg08H03xTsUOiTDyHFBcC3lqW2dzKy0EHRppHFN02bQa9gHEu6LkdZQjqlV
         AuIBvwliPWNcJaiAECWKo4ihWOT/5a6AAqIERiROQF0YkthY89TlV+9l0v5uOwN95BU1
         mKFOAFlzz2o0vxtj06zhgCdukmvgI7Phr5jC6PZL1x7XOcqwdJnPd+dxH/jBYKa82CJQ
         WggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sa417ZNxztSzV34gBCNtKBCrm39utqje6hlLc0wW990=;
        b=iwsQ9M55mt9Qi1fRuTLPD59JvcaKsO9kbyIMWwRUT5X0X2dBTmo05lzCt7VwNAdRIy
         NREXNgRgpMuyU5nTZyNO0Ltg5oaCiBlHl/rk1JzxX8y/SXoK5xgfRmsZ3/mpMUaRkSK6
         Ryo0KIkt9xn1DPNLM6nlQf/o5ghwgwB5NCeJD3nOdVbrBIKHx4JuPlmHUaLkqfpu6p57
         qSeXFXMqchqerIGkC1kOMUdp/F+A4TqlVLu4jsULjbfkhweO00uCskN6JrUrOqa043Qt
         trZ2OLMhhrY2CV2FgTdEOEzesxK018AHAbM5xzUx4V5L9GmTZ1TVgjCn93jLXW26EWFK
         MxJA==
X-Gm-Message-State: APjAAAWLXJyiYb8Gs6Uq+VdPlQXx8HrZ9rbIjG0X5YIcNMrKJYycyZXY
        900gBPFYxtkq8DOXOEKbCj9b+axxpA09ICHrQLI=
X-Google-Smtp-Source: APXvYqxnZAE3XgjrCLfuG5LdXQoHW0DgI+PUYOXuxiszmOJE0G57IH/zBq9juUtuCXpiHhya+YGcobYFC7w6J355qwM=
X-Received: by 2002:a9d:2f08:: with SMTP id h8mr45271608otb.42.1558375464251;
 Mon, 20 May 2019 11:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190520143812.2801-1-narmstrong@baylibre.com> <20190520143812.2801-6-narmstrong@baylibre.com>
In-Reply-To: <20190520143812.2801-6-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 May 2019 20:04:13 +0200
Message-ID: <CAFBinCCL=44M33gf4Qn5wij6XEq=WR-_ttCPB8XW1zbt_xNKvg@mail.gmail.com>
Subject: Re: [PATCH 05/10] ARM: dts: meson8: update with SPDX Licence identifier
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, May 20, 2019 at 4:39 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm/boot/dts/meson8.dtsi | 42 +----------------------------------
>  1 file changed, 1 insertion(+), 41 deletions(-)
>
> diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
> index 7ef442462ea4..fd8d57d0a3af 100644
> --- a/arch/arm/boot/dts/meson8.dtsi
> +++ b/arch/arm/boot/dts/meson8.dtsi
> @@ -1,46 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0 OR X11
I believe this should be GPL-2.0+ OR MIT as explained in [0]


Martin


[0] https://patchwork.kernel.org/patch/10951479/
