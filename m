Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159CAC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6C82080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cjBKRspf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgAGJrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:47:21 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46077 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgAGJrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:47:20 -0500
Received: by mail-lj1-f194.google.com with SMTP id j26so53986545ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 01:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GKAgR/S5tBz772raWFJYIXfn8TDQH+brFFCBErQ1zuE=;
        b=cjBKRspfACIPeQVMLJLGEfJDGZNyVnna+Twaa3iVAAHS8U+oy2m9Nb9/ySkIfP+83o
         6Nd+hf5KKEqfByAC7lMtKr9MvuGv4ZYfIANPqsQW1zPiN5oxYMfRen8GL8vHrREQCf5P
         fYFZ94xQTN2WhdOAGXCHEi1T/VuirSxPZ6wRmCw0bCG5HY6x4Sze6nl/zikjeqkOFPAg
         UbCPoMUGD0dJ2CrJo+iVFMjdnIbuI1koYD3fO6igDmWt304aS6EprJ/qmbHAXwZABxbW
         oJaq9ofupn1axmEw/P6QHZ/7dsm+wYsFMYfHNSOgbT6x3HPRZCo0hphOZb+D2FfMEDmI
         Ml6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GKAgR/S5tBz772raWFJYIXfn8TDQH+brFFCBErQ1zuE=;
        b=U7dkGpDlG0MkRO/XWIM7MQu2pzm+VpBYMl3q8rD+YCRdNyqSyBc0EmMZnNK4jKzM7F
         CYZ8fTC1ACQHwfi8dDiJCBJVWCcuc+wpWoJXRbyNQw5fuR5jeUs0iTLc/vITXxDKMXy4
         XiBgCFV8DKaBRmPzRPVcp8pgqxCJ2h/Xr0Jk9RSc/HjmY8WVLYmVSBEPpW1uN/KmAgpw
         9lyl0+IvkKwJpFj8SQoNUsV892BvMhQQ6xYQsTBxgCOqCUN5ydDt89l5lz5LWGIU2imR
         Bxbbmp9REyhw+aDWPAQuebmONp44Yb0jJxD+BPp0xVxuGMIl3GSuTjFAlSJ52S1hzNbk
         +QGA==
X-Gm-Message-State: APjAAAU7hmIdT5UaPE+QfpqT/3wrcvYbXbrL6RCQBwkm5U3NkHBn/ETZ
        AaZpZLu41bjkkyBl/FCl/s4XOdH01EfbNZVjszb1iYscFig=
X-Google-Smtp-Source: APXvYqz0CNhEmsacDTRcEPmfxQ/oGL27kQqghbLjNnpafVZ5FskeP2/QqmHESgY8kC+PmcK3Ux3RyArBjry1NP4YanU=
X-Received: by 2002:a2e:85cd:: with SMTP id h13mr61135533ljj.191.1578390438453;
 Tue, 07 Jan 2020 01:47:18 -0800 (PST)
MIME-Version: 1.0
References: <20191219103153.14875-1-srinivas.kandagatla@linaro.org> <20191219103153.14875-9-srinivas.kandagatla@linaro.org>
In-Reply-To: <20191219103153.14875-9-srinivas.kandagatla@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jan 2020 10:47:07 +0100
Message-ID: <CACRpkdYc-kB4Kx690FnU=3CwnjFdQhdxofGguFAAs_j==C=nmQ@mail.gmail.com>
Subject: Re: [PATCH v6 08/11] dt-bindings: gpio: wcd934x: Add bindings for gpio
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Vinod Koul <vinod.koul@linaro.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        spapothi@codeaurora.org, bgoswami@codeaurora.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 11:33 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:

> Qualcomm Technologies Inc WCD9340/WCD9341 Audio Codec has integrated
> gpio controller to control 5 gpios on the chip. This patch adds
> required device tree bindings for it.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Tell me if you want me to merge this patch through the GPIO tree.

Yours,
Linus Walleij
