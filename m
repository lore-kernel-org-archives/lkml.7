Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB52C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B298720873
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXyWAN1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731174AbfJDVwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 17:52:15 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41390 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbfJDVwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:52:15 -0400
Received: by mail-io1-f68.google.com with SMTP id n26so16661973ioj.8;
        Fri, 04 Oct 2019 14:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2NHwB5wF7rQTeZnawydpHnEae0UNUyf0umbpqxfApS4=;
        b=UXyWAN1netWXO8wzokqz7oMK4zAnqa67+noXFlYnXYSonxedyWNQjaX2lle7O9oaWg
         6E+0JogNPSEJQtEwNYtIrpV3DhqBgW0XyLesAKNODdziIGBgAT0Kcz3r5nuGMJOVgybs
         UW4NMndkYjmyyZBxWAh0LXThYbAaNZhfWipzcZh4dUvnt1XiWJvNeLxp9vH/I+d1rhLa
         00HKW6A9C6NttJlIYVMNvccLvoiu+q15fK3IERPjagcF65Xgk63CyeUDr974f9XAs2rN
         Ic04LIv7bZZn921L892ldiGsvnsiIPmz/dJbsWZNyODKkC7W++cS9LL/dB522pwdWjxw
         OKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2NHwB5wF7rQTeZnawydpHnEae0UNUyf0umbpqxfApS4=;
        b=sZhxnoMtEUQoyE1kHeeFvJsIkOnZkG181yzDIvhe7LWBV6uYj5Ve2ZLXMtIRo22+Yc
         3y16VfSkgLssaiL6EvG5GGwsI2OW6pHBj45OCvP0qznHPpjhJcWlXuJUqb5CItWuwZre
         090U+CJg7ED3S5Z4uqhz5kxoPT0oC42kI7klDmHoXUgwf4FHUvG9HfxEPLtxTp1s4EJJ
         UyEY1Nu/7GC9bUKMwG9bUN5yaZR+BfRfcehosHZUti4Wn8Qw05xJV/AurV8KZDioiy5L
         K+O62CHMwXTyk/YnRzEkEoHITxJg27LEB2aK4rLyB8sx1LKoFV3RjQiBRGdERDeFXHlP
         ae0Q==
X-Gm-Message-State: APjAAAX+ki8tUMPAVWM5/Q2WOwLlhhXkZwKjX3zO8burDRwd5MMbpvfc
        wRaqn6XTnrLHxE+1bZhL83lSftQlcx06lJ7iFwNjTw==
X-Google-Smtp-Source: APXvYqyExmJsuNOtxdeWwb/yncB5aTD63s1eVIhDHJxOm8bm3sqKxM0SlP7iLrhf5X7HN3FkMnHeqslK6bBbYF2mSak=
X-Received: by 2002:a92:ca84:: with SMTP id t4mr18199133ilo.171.1570225934327;
 Fri, 04 Oct 2019 14:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191004054115.26082-1-andrew.smirnov@gmail.com>
In-Reply-To: <20191004054115.26082-1-andrew.smirnov@gmail.com>
From:   Chris Healy <cphealy@gmail.com>
Date:   Fri, 4 Oct 2019 14:52:03 -0700
Message-ID: <CAFXsbZq6MQk1DyUVGjC5g6jmsOdmG=1Q=4fX=9n3amSjLW1Maw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610-zii-scu4-aib: Specify 'i2c-mux-idle-disconnect'
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Cory Tusar <cory.tusar@zii.aero>,
        Jeff White <jeff.white@zii.aero>,
        Rick Ramstetter <rick@anteaterllc.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 10:41 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Specify 'i2c-mux-idle-disconnect' for both I2C switches present on the
> board, since both are connected to the same parent bus and all of
> their children have the same I2C address.
>
> Fixes: ca4b4d373fcc ("ARM: dts: vf610: Add ZII SCU4 AIB board")
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Cory Tusar <cory.tusar@zii.aero>
> Cc: Jeff White <jeff.white@zii.aero>
> Cc: Rick Ramstetter <rick@anteaterllc.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Shawn:
>
> If this is possible, I'd like this one to go into 5.4.
>
> Thanks,
> Andrey Smirnov
>
>  arch/arm/boot/dts/vf610-zii-scu4-aib.dts | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
> index dc8a5f37a1ef..c8ebb23c4e02 100644
> --- a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
> +++ b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
> @@ -602,6 +602,7 @@
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 reg = <0x70>;
> +               i2c-mux-idle-disconnect;
>
>                 sff0_i2c: i2c@1 {
>                         #address-cells = <1>;
> @@ -640,6 +641,7 @@
>                 reg = <0x71>;
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> +               i2c-mux-idle-disconnect;
>
>                 sff5_i2c: i2c@1 {
>                         #address-cells = <1>;
> --
> 2.21.0
>

On an SCU4 AIB, this series is:

Tested-by: Chris Healy <cphealy@gmail.com>
