Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFA8C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3670F214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="098imhfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504143AbfIXJUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 05:20:53 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36497 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405138AbfIXJUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 05:20:52 -0400
Received: by mail-oi1-f195.google.com with SMTP id k20so1011331oih.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 02:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t63WI6jnEVUeiSnM61KUP9eWloPNpDRUCDwDuMDDoVg=;
        b=098imhfXUnWyUFSKUmzK25160O/img3eT5gYzMnSulDsq5DpyYfnq0WE8Mzkwnk/SB
         b6UE1jvvMPLEeShXakMQBKcKxtkD4r+cdYynG1yrLvpikA9s/3EZqeMYL4nmVn1xoCDK
         1KX3ZlcR6pFUIAfqJ8cS8yftBxxG4vuxF3jFfG8pQX89VdmfTaAtGnnVhvmSD8uAUcJC
         dHSzZtbuoNY4r/a41bQXNNhs8gPGBj4XdZObMZvN8C0iVHBWuQm+DpBdGWuyq+QyPi1Z
         gAdt92wruxr4QXqO0gkH/gT5lOJqjsHqQ3EFkFtvAky7b/8zK0q8awCRfq54nOefPTdm
         AXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t63WI6jnEVUeiSnM61KUP9eWloPNpDRUCDwDuMDDoVg=;
        b=EclBwcKn5ryPGeLd8oA7QQxeM8qTyJQTNuMto7chz1Ud27qcTSmS0QG153MrvPUDze
         RpAtQdAyCrmyS1swj9adfk7wOhwuaGvEUugdva/qE4ncZe23770hwvQIFUGueobnARo0
         YI0h8xjXxgPWInE8FF4Uux862uhnzIS9N0qQqwv4nVMP0e4Cvyd4aA4+TGgjKPPDha0A
         jsWX2ghTa8l7BuGq6kdylRK0V901dudfIwKTotqlbwhPpSq2/xJom8SAXKeS2uwZOlTF
         UbC8f8XjkFHe70d9Iv49KsyGQfqY+KnujEpb0SjmH+uMMVwlpniqAiMe9VxJolcHU3k8
         wDhA==
X-Gm-Message-State: APjAAAXFWiscrrLOmAwcun/l1ju283y3HbxMAXhkMvTwsbtqMXOtnF/v
        PadpuYnbUWI2HTL+lK4PhiKHcMVNAFCrxXXytqc+tuq0
X-Google-Smtp-Source: APXvYqxVUXxEwWWRw3DeXIcBvN1WnJ5y+L/y+uMjcWYYPzubyms6LUqyOC5Htl5jD2a2NgXsY2NXGHxWaA10vo2/74s=
X-Received: by 2002:aca:4406:: with SMTP id r6mr1269018oia.175.1569316849530;
 Tue, 24 Sep 2019 02:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190923175211.2060-1-brgl@bgdev.pl> <CAL_JsqJ7w0rvzMLePgz-g+HERhuEJ3F9uDpKcwE241FpumZxfA@mail.gmail.com>
In-Reply-To: <CAL_JsqJ7w0rvzMLePgz-g+HERhuEJ3F9uDpKcwE241FpumZxfA@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 24 Sep 2019 11:20:38 +0200
Message-ID: <CAMpxmJUffRsAw9sMr2KqgqSp+houehBdpaSSG2UweYyUo5hNRw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: at24: convert the binding document to yaml
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 23 wrz 2019 o 22:38 Rob Herring <robh+dt@kernel.org> napisa=C5=82(a):
>
> On Mon, Sep 23, 2019 at 12:52 PM Bartosz Golaszewski <brgl@bgdev.pl> wrot=
e:
> >
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Convert the binding document for at24 EEPROMs from txt to yaml. The
> > compatible property uses a regex pattern to address all the possible
> > combinations of "vendor,model" strings.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  .../devicetree/bindings/eeprom/at24.txt       |  90 +--------------
> >  .../devicetree/bindings/eeprom/at24.yaml      | 107 ++++++++++++++++++
> >  MAINTAINERS                                   |   2 +-
> >  3 files changed, 109 insertions(+), 90 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/eeprom/at24.yaml
>
> [...]
>
> > diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Docum=
entation/devicetree/bindings/eeprom/at24.yaml
> > new file mode 100644
> > index 000000000000..28c8b068c8a1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
> > @@ -0,0 +1,107 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright 2019 BayLibre SAS
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/eeprom/at24.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: I2C EEPROMs compatible with Atmel's AT24
> > +
> > +maintainers:
> > +  - Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > +
> > +properties:
> > +  compatible:
>
> Did you run this thru 'make dt_bindings_check' and is dt-schema up to
> date? I don't think it will pass and if it does I want to fix that.
>

I couldn't get the dt_binding_check target to work, but I ran it
through dt-doc-validate directly until it didn't complain.

> > +    additionalItems: true
>
> We pretty much never allow this.
>
> > +    maxItems: 2
>
> This applies to arrays...
>
> > +    pattern: "^(atmel|catalyst|microchip|nxp|ramtron|renesas|rohm|st),=
24(c|cs|mac)[0-9]+$"
>
> And this to strings which is non-sense. What you want is something like t=
his:
>
> minItems: 1
> maxItems: 2
> items:
>   - pattern: "^(atmel|catalyst|microchip|nxp|ramtron|renesas|rohm|st),24(=
c|cs|mac)[0-9]+$"
>   - pattern: "^atmel,24(c|cs|mac)[0-9]+$"
>
> This would allow 'atmel' twice, but entries have to be unique already.
> It doesn't enforce the part numbers matching though. For that, you'd
> need either a bunch of these under a oneOf instead:
>
> items:
>   - pattern: "^(atmel|catalyst|microchip|nxp|ramtron|renesas|rohm|st),24c=
00$"
>   - const: atmel,24c00
>
> Or just add this to the above with an 'allOf':
>
> items:
>   pattern: "(c00|c01|mac402|...)$"
>

I'm lost here - what do you mean add this to the above with an
'allOf'? I can't really imagine an example for that.

> Note the lack of '-' under items. That means the schema applies to all en=
tries.
>
> > +    oneOf:
> > +      - const: nxp,se97b
> > +      - const: renesas,r1ex24002
> > +      - const: renesas,r1ex24016
> > +      - const: renesas,r1ex24128
> > +      - const: rohm,br24t01
>
> For this part, you probably want:
>
> oneOf:
>   - items:
>       - const: nxp,se97b
>       - const: atmel,24c02
>   - items:
>       ...
>
> And for the spd cases...
>
> > +    contains:
> > +      enum:
>
> allOf:
>   - oneOf:
>       # all the above stuff
>   - contains:
>       enum:
>

I'm not sure I follow the entire thing. I'll try to prepare a v2 but I
don't really expect it to be right already.

> > +        - atmel,24c00
> > +        - atmel,24c01
> > +        - atmel,24cs01
> > +        - atmel,24c02
> > +        - atmel,24cs02
> > +        - atmel,24mac402
> > +        - atmel,24mac602
> > +        - atmel,spd
> > +        - atmel,24c04
> > +        - atmel,24cs04
> > +        - atmel,24c08
> > +        - atmel,24cs08
> > +        - atmel,24c16
> > +        - atmel,24cs16
> > +        - atmel,24c32
> > +        - atmel,24cs32
> > +        - atmel,24c64
> > +        - atmel,24cs64
> > +        - atmel,24c128
> > +        - atmel,24c256
> > +        - atmel,24c512
> > +        - atmel,24c1024
> > +        - atmel,24c2048
> > +
> > +  reg:
> > +    description:
> > +      The I2C slave address of the EEPROM.
> > +    maxItems: 1
> > +
> > +  pagesize:
> > +    description:
> > +      The length of the pagesize for writing. Please consult the
> > +      manual of your device, that value varies a lot. A wrong value
> > +      may result in data loss! If not specified, a safety value of
> > +      '1' is used which will be very slow.
> > +    type: integer
>
> Other than boolean, you need to reference a type in types.yaml.
>
> Does it really vary too much to list out possible values?
>

Nobody is using anything other than 1, 8, 16, 32 and 64, so I guess we
can limit ourselves to those for now.

> > +
> > +  read-only:
> > +    description:
> > +      This parameterless property disables writes to the eeprom.
> > +    type: boolean
> > +
> > +  size:
> > +    description:
> > +      Total eeprom size in bytes.
> > +    type: integer
> > +
> > +  no-read-rollover:
> > +    description:
> > +      This parameterless property indicates that the multi-address
> > +      eeprom does not automatically roll over reads to the next slave
> > +      address. Please consult the manual of your device.
> > +    type: boolean
> > +
> > +  wp-gpios:
> > +    description:
> > +      GPIO to which the write-protect pin of the chip is connected.
> > +    maxItems: 1
> > +
> > +  address-width:
> > +    description:
> > +      Number of address bits (one of 8, 16).
>
> Sounds like a constraint...

Right.

>
> > +    type: integer
> > +
> > +  num-addresses:
> > +    description:
> > +      Total number of i2c slave addresses this device takes.
>
> 2^32 addresses okay?
>

Nope, I'll fix it.

Thanks for the review!

Bart

> > +    type: integer
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +examples:
> > +  - |
> > +    eeprom@52 {
> > +        compatible =3D "microchip,24c32", "atmel,24c32";
> > +        reg =3D <0x52>;
> > +        pagesize =3D <32>;
> > +        wp-gpios =3D <&gpio1 3 0>;
> > +        num-addresses =3D <8>;
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a400af0501c9..3c7ced686966 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2698,7 +2698,7 @@ M:        Bartosz Golaszewski <bgolaszewski@bayli=
bre.com>
> >  L:     linux-i2c@vger.kernel.org
> >  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.gi=
t
> >  S:     Maintained
> > -F:     Documentation/devicetree/bindings/eeprom/at24.txt
> > +F:     Documentation/devicetree/bindings/eeprom/at24.yaml
> >  F:     drivers/misc/eeprom/at24.c
> >
> >  ATA OVER ETHERNET (AOE) DRIVER
> > --
> > 2.23.0
> >
