Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F98C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 22:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADFD206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 22:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L0evPFMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391599AbfHBWba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 18:31:30 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37415 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729919AbfHBWb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 18:31:29 -0400
Received: by mail-lf1-f68.google.com with SMTP id c9so53918002lfh.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 15:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8tQh191xW5z/uqwcXTQaR6iRlPu4dlS4JjUPIzXI1i0=;
        b=L0evPFMisUlfcr0ejK8sxz3FR7curgkYcXNQl3aE8Ndyo6Zm2gmWpA/JzsTVoihGhw
         5EWCzMH8dJbIdO1VXDSeK4S7EczFoV0sHOraDsX4ap9t9qaaHuD0ePuJc1eAHsLsr1YQ
         93BJ8OPQo7AMtWpR1+drmfGGbZarfaW6MBebCodaismcPLqwfsmajV/wb30d7Gf9czUp
         I+H4GL3RuxEU3PZjX2tgCZWhqug0csI/AbnfHt23mFD2x/rk8o2RROuPF/BesU+faH3L
         UBBl/diHpYUBcbJvSpH6gin/E/MeAvwEW3Sp9OZoqR+PXIHTtSL7SpfS63Aehyic2Bu2
         9gUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8tQh191xW5z/uqwcXTQaR6iRlPu4dlS4JjUPIzXI1i0=;
        b=HvwbcJwPQ5DQtvL1rbIG3HauCxE7JqmUDUaIZPMZ3N2CAjjmJUT+gUScDDo3rALG0q
         vDmYVGBUcVNJS8ESDUMBAI+2nQLrTIvHbzTQ8sHhvuC/CwDJjSQ1ZqFPcqC2AdOgeqBp
         GMMuhnj1LBC12X9rMuncp0d1NjTStGbGPsL5nuC+fr9e6jdMRi4o4igxE4ydjbokdbqJ
         uBWzK6rk5eYqLbEAcemw0J4hasmnivyFi8msRktEpZRBr9rMoha5AevKPm03kGR+EseP
         km9ReoCSn4Y2R1gJBovSkhTl9ZW7/a3Yg9FeNx4hs+yAAQrOoH2bXuSQj2T/Xr3u6yGy
         TlzA==
X-Gm-Message-State: APjAAAX69cnMHqcSW1ufO7nA3YgYcFZpOp7QjYoicVok/v2gmJaQ6klS
        KJhaZO+I6mO6X5MA0HHFCVfLNMM7srJvV5/HFUzvsg==
X-Google-Smtp-Source: APXvYqwDIwDheD+gFq+O5TZV6dJSFLuMVgoQGjhj+lZ8eLAYET/6IhmSX9+fvFrFVscVAgKHzz0hjQPV7iYVurKwj74=
X-Received: by 2002:a19:7616:: with SMTP id c22mr1677508lff.115.1564785087648;
 Fri, 02 Aug 2019 15:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190716215618.29757-1-robh@kernel.org>
In-Reply-To: <20190716215618.29757-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 3 Aug 2019 00:31:16 +0200
Message-ID: <CACRpkdYsYH_z55+OeHzAp9bjj+0WrnH8LoXcEahVcX=in6TTEQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: stm32: Fix missing 'clocks'
 property in examples
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 11:56 PM Rob Herring <robh@kernel.org> wrote:

> Now that examples are validated against the DT schema, an error with
> required 'clocks' property missing is exposed:
>
> Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.example.dt.yaml: \
> pinctrl@40020000: gpio@0: 'clocks' is a required property
> Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.example.dt.yaml: \
> pinctrl@50020000: gpio@1000: 'clocks' is a required property
> Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.example.dt.yaml: \
> pinctrl@50020000: gpio@2000: 'clocks' is a required property
>
> Add the missing 'clocks' properties to the examples to fix the errors.
>
> Fixes: 2c9239c125f0 ("dt-bindings: pinctrl: Convert stm32 pinctrl bindings to json-schema")
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Signed-off-by: Rob Herring <robh@kernel.org>

This seems to already be upstream, but I have no memory of applying it.
Less work for me :)

Yours,
Linus Walleij
