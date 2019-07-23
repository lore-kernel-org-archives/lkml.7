Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F44C76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3241B22387
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="aKhVimXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389575AbfGWWdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 18:33:38 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:32841 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfGWWdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 18:33:38 -0400
Received: by mail-qk1-f196.google.com with SMTP id r6so32386987qkc.0;
        Tue, 23 Jul 2019 15:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JH500Za/hvby+Ab7pkG8hgVXYLz6CfPDe+IpQp/0ssY=;
        b=aKhVimXJJykXiImkectG2QqNVWODjxTl3lihKDeVAAnK0AAnBorzB25U/8olMnXWn3
         01KiV0tltUF3gviW56zkXtuxLIjYw7r+/Tug450jTT3Q3psJn4fNDYp13UueSPoXQpKc
         U/F2SBkX9gB2ucfTL2I/by3eLM/TaAIqDlgNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JH500Za/hvby+Ab7pkG8hgVXYLz6CfPDe+IpQp/0ssY=;
        b=nF0BwUzGjn3lIRnuFbjfV7s+clY4S2j1s0JocsB4pzCuEm2yNwTJjxXBvVA5uGB2B4
         gp1+1YDNSUlQSa5iYgXxWz7LV6oKwlY7vG4w3Inl9hm9lcA0AKTvwO5VOtvYXiwhJ3Pk
         BRIVC4O4sLEy3RUuGw0/lsWNuBz5Tq35Od50Cpf6SJbNKjOBEj48jx+epyEiI3WyuWoz
         yAUf923Vfbf/go/zGZNnmGn0p9tZSfB61iuh0Esn5akumQpMrE/puso4KEfVNlF+Rdte
         dhMxq9Vsc/KneVmvdzSlMyxOGG8TIXenPNYZ3J6/WOV9Y0Z51vhrB7G/RI+BnT7sKmdd
         0SNA==
X-Gm-Message-State: APjAAAU12VNwY8YKx4OPt6fbx339bWFxs1WZuUE9twsZhy8sseXqwQP2
        sPhebr88OH+fhCGYkQA1IRilMjMOKPG97yZzDbE=
X-Google-Smtp-Source: APXvYqx4liwJSfc37h1jJX9a+TAgM+kLnIK+BhE01JSK8gVK15XKOFf65LR9nkeJuce6Gf8EfT86S2RpINzFZwA4BKU=
X-Received: by 2002:a05:620a:16d6:: with SMTP id a22mr52208761qkn.414.1563921216425;
 Tue, 23 Jul 2019 15:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190722192451.1947348-1-vijaykhemka@fb.com> <20190722192451.1947348-3-vijaykhemka@fb.com>
 <C9C6AC86-B353-4CDA-8B63-50587F48DF44@fb.com>
In-Reply-To: <C9C6AC86-B353-4CDA-8B63-50587F48DF44@fb.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 23 Jul 2019 22:33:24 +0000
Message-ID: <CACPK8Xc+1ZLoCQoERBjr7OQh3V0rV1g+mq+bPiJzCCzJix_13A@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: tiogapass: Add Riser card
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
        Sai Dasari <sdasari@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2019 at 17:22, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Team,
> This patch also needs review. I separated first patch with v2 and that wa=
s acked. Please review this as well.

Do you have a coworker who has access to the schematics and can review
the device tree? They would make a great reviewer.

If no reviewer steps forward I will merge it next time I'm merging patches.

Cheers,

Joel

>
> Regards
> -Vijay
>
> =EF=BB=BFOn 7/22/19, 12:41 PM, "Vijay Khemka" <vijaykhemka@fb.com> wrote:
>
>     Added i2c mux for riser card and multiple ava card and its sensor
>     components for Facebook Tiogapass platform
>
>     Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
>     ---
>      .../dts/aspeed-bmc-facebook-tiogapass.dts     | 230 ++++++++++++++++=
++
>      1 file changed, 230 insertions(+)
>
>     diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/ar=
ch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
>     index b7783833a58c..8d0bcb3cd419 100644
>     --- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
>     +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
>     @@ -12,6 +12,27 @@
>         aliases {
>                 serial0 =3D &uart1;
>                 serial4 =3D &uart5;
>     +
>     +           /*
>     +            * Hardcode the bus number of i2c switches' channels to
>     +            * avoid breaking the legacy applications.
>     +            */
>     +           i2c16 =3D &imux16;
>     +           i2c17 =3D &imux17;
>     +           i2c18 =3D &imux18;
>     +           i2c19 =3D &imux19;
>     +           i2c20 =3D &imux20;
>     +           i2c21 =3D &imux21;
>     +           i2c22 =3D &imux22;
>     +           i2c23 =3D &imux23;
>     +           i2c24 =3D &imux24;
>     +           i2c25 =3D &imux25;
>     +           i2c26 =3D &imux26;
>     +           i2c27 =3D &imux27;
>     +           i2c28 =3D &imux28;
>     +           i2c29 =3D &imux29;
>     +           i2c30 =3D &imux30;
>     +           i2c31 =3D &imux31;
>         };
>         chosen {
>                 stdout-path =3D &uart5;
>     @@ -124,6 +145,215 @@
>      &i2c1 {
>         status =3D "okay";
>         //X24 Riser
>     +   i2c-switch@71 {
>     +           compatible =3D "nxp,pca9544";
>     +           #address-cells =3D <1>;
>     +           #size-cells =3D <0>;
>     +           reg =3D <0x71>;
>     +
>     +           imux16: i2c@0 {
>     +                   #address-cells =3D <1>;
>     +                   #size-cells =3D <0>;
>     +                   reg =3D <0>;
>     +
>     +                   ina219@45 {
>     +                           compatible =3D "ti,ina219";
>     +                           reg =3D <0x45>;
>     +                   };
>     +
>     +                   tmp75@48 {
>     +                           compatible =3D "ti,tmp75";
>     +                           reg =3D <0x48>;
>     +                   };
>     +
>     +                   tmp421@49 {
>     +                           compatible =3D "ti,tmp75";
>     +                           reg =3D <0x49>;
>     +                   };
>     +
>     +                   eeprom@50 {
>     +                           compatible =3D "atmel,24c64";
>     +                           reg =3D <0x50>;
>     +                           pagesize =3D <32>;
>     +                   };
>     +
>     +                   i2c-switch@73 {
>     +                           compatible =3D "nxp,pca9546";
>     +                           #address-cells =3D <1>;
>     +                           #size-cells =3D <0>;
>     +                           reg =3D <0x73>;
>     +
>     +                           imux20: i2c@0 {
>     +                                   #address-cells =3D <1>;
>     +                                   #size-cells =3D <0>;
>     +                                   reg =3D <0>;
>     +                           };
>     +
>     +                           imux21: i2c@1 {
>     +                                   #address-cells =3D <1>;
>     +                                   #size-cells =3D <0>;
>     +                                   reg =3D <1>;
>     +                           };
>     +
>     +                           imux22: i2c@2 {
>     +                                   #address-cells =3D <1>;
>     +                                   #size-cells =3D <0>;
>     +                                   reg =3D <2>;
>     +                           };
>     +
>     +                           imux23: i2c@3 {
>     +                                   #address-cells =3D <1>;
>     +                                   #size-cells =3D <0>;
>     +                                   reg =3D <3>;
>     +                           };
>     +
>     +                   };
>     +
>     +           };
>     +
>     +           imux17: i2c@1 {
>     +                   #address-cells =3D <1>;
>     +                   #size-cells =3D <0>;
>     +                   reg =3D <1>;
>     +
>     +                   ina219@45 {
>     +                           compatible =3D "ti,ina219";
>     +                           reg =3D <0x45>;
>     +                   };
>     +
>     +                   tmp421@48 {
>     +                           compatible =3D "ti,tmp75";
>     +                           reg =3D <0x48>;
>     +                   };
>     +
>     +                   tmp421@49 {
>     +                           compatible =3D "ti,tmp75";
>     +                           reg =3D <0x49>;
>     +                   };
>     +
>     +                   eeprom@50 {
>     +                           compatible =3D "atmel,24c64";
>     +                           reg =3D <0x50>;
>     +                           pagesize =3D <32>;
>     +                   };
>     +
>     +                   i2c-switch@73 {
>     +                           compatible =3D "nxp,pca9546";
>     +                           #address-cells =3D <1>;
>     +                           #size-cells =3D <0>;
>     +                           reg =3D <0x73>;
>     +
>     +                           imux24: i2c@0 {
>     +                                   #address-cells =3D <1>;
>     +                                   #size-cells =3D <0>;
>     +                                   reg =3D <0>;
>     +                           };
>     +
>     +                           imux25: i2c@1 {
>     +                                   #address-cells =3D <1>;
>     +                                   #size-cells =3D <0>;
>     +                                   reg =3D <1>;
>     +                           };
>     +
>     +                           imux26: i2c@2 {
>     +                                   #address-cells =3D <1>;
>     +                                   #size-cells =3D <0>;
>     +                                   reg =3D <2>;
>     +                           };
>     +
>     +                           imux27: i2c@3 {
>     +                                   #address-cells =3D <1>;
>     +                                   #size-cells =3D <0>;
>     +                                   reg =3D <3>;
>     +                           };
>     +
>     +                   };
>     +
>     +           };
>     +
>     +           imux18: i2c@2 {
>     +                   #address-cells =3D <1>;
>     +                   #size-cells =3D <0>;
>     +                   reg =3D <2>;
>     +
>     +                   ina219@45 {
>     +                           compatible =3D "ti,ina219";
>     +                           reg =3D <0x45>;
>     +                   };
>     +
>     +                   tmp421@48 {
>     +                           compatible =3D "ti,tmp75";
>     +                           reg =3D <0x48>;
>     +                   };
>     +
>     +                   tmp421@49 {
>     +                           compatible =3D "ti,tmp75";
>     +                           reg =3D <0x49>;
>     +                   };
>     +
>     +                   eeprom@50 {
>     +                           compatible =3D "atmel,24c64";
>     +                           reg =3D <0x50>;
>     +                           pagesize =3D <32>;
>     +                   };
>     +
>     +                   i2c-switch@73 {
>     +                           compatible =3D "nxp,pca9546";
>     +                           #address-cells =3D <1>;
>     +                           #size-cells =3D <0>;
>     +                           reg =3D <0x73>;
>     +
>     +                           imux28: i2c@0 {
>     +                                   #address-cells =3D <1>;
>     +                                   #size-cells =3D <0>;
>     +                                   reg =3D <0>;
>     +                           };
>     +
>     +                           imux29: i2c@1 {
>     +                                   #address-cells =3D <1>;
>     +                                   #size-cells =3D <0>;
>     +                                   reg =3D <1>;
>     +                           };
>     +
>     +                           imux30: i2c@2 {
>     +                                   #address-cells =3D <1>;
>     +                                   #size-cells =3D <0>;
>     +                                   reg =3D <2>;
>     +                           };
>     +
>     +                           imux31: i2c@3 {
>     +                                   #address-cells =3D <1>;
>     +                                   #size-cells =3D <0>;
>     +                                   reg =3D <3>;
>     +                           };
>     +
>     +                   };
>     +
>     +           };
>     +
>     +           imux19: i2c@3 {
>     +                   #address-cells =3D <1>;
>     +                   #size-cells =3D <0>;
>     +                   reg =3D <3>;
>     +
>     +                   i2c-switch@40 {
>     +                           compatible =3D "ti,ina219";
>     +                           reg =3D <0x40>;
>     +                   };
>     +
>     +                   i2c-switch@41 {
>     +                           compatible =3D "ti,ina219";
>     +                           reg =3D <0x41>;
>     +                   };
>     +
>     +                   i2c-switch@45 {
>     +                           compatible =3D "ti,ina219";
>     +                           reg =3D <0x45>;
>     +                   };
>     +
>     +           };
>     +
>     +   };
>      };
>
>      &i2c2 {
>     --
>     2.17.1
>
>
>
