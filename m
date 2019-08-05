Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1484C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888912087B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h7hSXRNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfHEKPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 06:15:23 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37924 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbfHEKPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:15:22 -0400
Received: by mail-lj1-f195.google.com with SMTP id r9so78816431ljg.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 03:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EVUakBz4HVrBvU5WozBP9zRGYaZ2u063yCbTr8IH9wg=;
        b=h7hSXRNhw+BgWJVjsm3CUTt+gZ14IRMN5LjwbEypK2d6eMw0PVs2ntw/YUTNTo6K5c
         YvYdlQu43bwvSdSCHbk9ALOWXZGSYh2Z6De9g/Su7n1CVvElbTYf5Sk4V3CWU/t6arn5
         QL5v+l4NitaSIZfsmJrgpY7tfjio4lzr/M6up+lXW9V3Ps9ZuOirB94gxrz8x1FG8GQs
         RttJ3Vra50Bu2sxlntxYoVh4k7IcugIs4VJCZaH9TonMZSuJSrbdbZTXGgz+gcjtPoyh
         AP/Ox8IvhETub7PSCfZSGGX1tuRPisg0IWmhPaXV0jTRZ/ydreArtzV03pszTkbXybr9
         hJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EVUakBz4HVrBvU5WozBP9zRGYaZ2u063yCbTr8IH9wg=;
        b=afpKD6Jo78wx/Nb3mPMtifNCze73h61LxEzRsFtUHxFZvwUed8iy/2kNs9GSycJebf
         FwVyrqKjqP1ltJNeYFFRtw+AAwIOwjcnf6VaGJqiGxtCgcSdnYl+S5UF0dK4O/1flzdq
         W3229sZjb5Ibo1p6zRjB1OjqwNqWVtnlvlSHwXC3XWsKM6fxjKSG5nZ2F8Km0XkDvoMk
         rgNxEsIQj0+9ZHslnezV3iu+heqzu5qT0XEnhaMBWRskvh5436CI9nO3x8mbKQGrfGtJ
         yBF0+bCq6dxhDt5OlOiLtLOFyO0z3ZAq7x6BlLp0iWtR2xkq324by5xIdVxwi+y38ulm
         y1Tw==
X-Gm-Message-State: APjAAAX+1jRW2GSrQfF3n4pXCrisRNZn0M8hREKQvIE0KjEfqJzbWLry
        RccnwztLhl7bP3MukpmvIFr3AaR/rv8ySJHxn6qc8A==
X-Google-Smtp-Source: APXvYqySHuR6d+bEQrsbTHzEENtYOVUi+8awDm/vDpXZ3zt3zWFIJstQGj1Z5v+QGxwqmgpUNdelEqXuxOip7mnqSPc=
X-Received: by 2002:a2e:8195:: with SMTP id e21mr9719149ljg.62.1565000120908;
 Mon, 05 Aug 2019 03:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <1564053416-32192-1-git-send-email-amelie.delaunay@st.com>
In-Reply-To: <1564053416-32192-1-git-send-email-amelie.delaunay@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Aug 2019 12:15:09 +0200
Message-ID: <CACRpkdbeTQE1SGFeU0NQzgYxz_rjA_6Lw=3WLmeAF7pyEw7aLA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: stmfx: update pinconf settings
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 1:16 PM Amelie Delaunay <amelie.delaunay@st.com> wrote:

> From: Alexandre Torgue <alexandre.torgue@st.com>
>
> According to the following tab (coming from STMFX datasheet), updates
> have to done in stmfx_pinconf_set function:
>
> -"type" has to be set when "bias" is configured as "pull-up or pull-down"
> -PIN_CONFIG_DRIVE_PUSH_PULL should only be used when gpio is configured as
>  output. There is so no need to check direction.
>
> DIR | TYPE | PUPD | MFX GPIO configuration
> ----|------|------|---------------------------------------------------
> 1   | 1    | 1    | OUTPUT open drain with internal pull-up resistor
> ----|------|------|---------------------------------------------------
> 1   | 1    | 0    | OUTPUT open drain with internal pull-down resistor
> ----|------|------|---------------------------------------------------
> 1   | 0    | 0/1  | OUTPUT push pull no pull
> ----|------|------|---------------------------------------------------
> 0   | 1    | 1    | INPUT with internal pull-up resistor
> ----|------|------|---------------------------------------------------
> 0   | 1    | 0    | INPUT with internal pull-down resistor
> ----|------|------|---------------------------------------------------
> 0   | 0    | 1    | INPUT floating
> ----|------|------|---------------------------------------------------
> 0   | 0    | 0    | analog (GPIO not used, default setting)
>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

Patch applied.

Yours,
Linus Walleij
