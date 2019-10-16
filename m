Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA4BFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658CD21835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="MW+sMuq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437387AbfJPVGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:06:51 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:45128 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437357AbfJPVGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:06:49 -0400
Received: by mail-yb1-f194.google.com with SMTP id q143so651ybg.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 14:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kn9kClYfIjMlLMagVsf7O1jgmGEjbDUjXt8o0wKyeA8=;
        b=MW+sMuq6Y9qrP0acv8qEivB67behGKZEpyPRPODPpJik/T8wUY6SFwrl4SbmV5JSii
         c/fAssXNhAURnnHERFaecM5FPDISVOX2dAMFMl6FOPU2ad3vm8S5O96clQAbmYvaOpOK
         9Xt2YOwWbhqiKK3mMqK/3TKZ9IztqcBCHVzNOU+98JpvHZe99z7Snhkq/fwusi2/tGMI
         0YT95AvtyjpE6PNW9xtWk4OWvhs+L8XK5JmhA1oKtNR/QkKw59clevqzV+EwQ8ny5ohz
         L0rBBmgZCkODDlJ2epNSm7wmv3s82uYAy0Ejmx0+HzGUcg8E4P5XZ+EySSeDlZDXi1kD
         U2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kn9kClYfIjMlLMagVsf7O1jgmGEjbDUjXt8o0wKyeA8=;
        b=aHfaha9zHpxvmXfF2bg6pXAh0K7sFRc1RrT2A62E/PYB1gKlw9OnfJDpKuaVHQ3qOE
         /3lf4NVoo2mdT+rqIljWOh7MO2YfSviQaV4eaptTiryOSMUcnSPMyFssNDzkK9nUmWkN
         7oXQ+8/mz2CYseO/w72dE2QwBQsn33HH53bxdPtFmH7mCZcX1tIJVlIzSXO3JLJN703f
         cnmuTWgEnf/prhvfJof3w7I48+BWW592HBa74waZbItj4qAR+uVki/y4Ew2Koy3WoHlx
         1LNU38xx2lO9JQPzDdgxDGm1oiXGv/BeY7qFuIZSo2TL88QIHoZ8RIH85Y1fK5a2QXp+
         DEkQ==
X-Gm-Message-State: APjAAAUJKqb7FGKTjJOLW5cqDSpaM7FFraSOHuQgf1cYCgW0FnuS69xR
        B59CmkHTKhxQiD0rDNiBh1+agYb18/gtWoMdhFSM2MCL
X-Google-Smtp-Source: APXvYqxu5GBkccY4WdK2iDDUA7D2q8HiB4K/u7G+ap2c79C1tbteJwfc3KKqH97NEgtgjyyUiBtZg6c+czBJGTUnfag=
X-Received: by 2002:a25:348e:: with SMTP id b136mr441806yba.159.1571260008543;
 Wed, 16 Oct 2019 14:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190910075913.17650-1-wen.he_1@nxp.com>
In-Reply-To: <20190910075913.17650-1-wen.he_1@nxp.com>
From:   Sean Paul <sean@poorly.run>
Date:   Wed, 16 Oct 2019 17:06:12 -0400
Message-ID: <CAMavQKLx4QoA4+JCiERY02i+O44yYH7u7BK07R4z7stjWtps3A@mail.gmail.com>
Subject: Re: [v5 1/2] dt/bindings: display: Add optional property node define
 for Mali DP500
To:     Wen He <wen.he_1@nxp.com>
Cc:     linux-devel@linux.nxdi.nxp.com, Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, leoyang.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 4:10 AM Wen He <wen.he_1@nxp.com> wrote:
>
> Add optional property node 'arm,malidp-arqos-value' for the Mali DP500.
> This property describe the ARQoS levels of DP500's QoS signaling.
>
> Signed-off-by: Wen He <wen.he_1@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Liviu, I see you applied 2/2, but didn't apply this patch. Any
particular reason, or just missed it?

Thanks,

Sean

> ---
>  Documentation/devicetree/bindings/display/arm,malidp.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/arm,malidp.txt b/Documentation/devicetree/bindings/display/arm,malidp.txt
> index 2f7870983ef1..7a97a2b48c2a 100644
> --- a/Documentation/devicetree/bindings/display/arm,malidp.txt
> +++ b/Documentation/devicetree/bindings/display/arm,malidp.txt
> @@ -37,6 +37,8 @@ Optional properties:
>      Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt)
>      to be used for the framebuffer; if not present, the framebuffer may
>      be located anywhere in memory.
> +  - arm,malidp-arqos-high-level: integer of u32 value describing the ARQoS
> +    levels of DP500's QoS signaling.
>
>
>  Example:
> @@ -54,6 +56,7 @@ Example:
>                 clocks = <&oscclk2>, <&fpgaosc0>, <&fpgaosc1>, <&fpgaosc1>;
>                 clock-names = "pxlclk", "mclk", "aclk", "pclk";
>                 arm,malidp-output-port-lines = /bits/ 8 <8 8 8>;
> +               arm,malidp-arqos-high-level = <0xd000d000>;
>                 port {
>                         dp0_output: endpoint {
>                                 remote-endpoint = <&tda998x_2_input>;
> --
> 2.17.1
>
