Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF0EC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C90EE21848
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=antmicro-com.20150623.gappssmtp.com header.i=@antmicro-com.20150623.gappssmtp.com header.b="v2HHfNAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbfJCJXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 05:23:42 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43145 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfJCJXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 05:23:41 -0400
Received: by mail-io1-f65.google.com with SMTP id v2so3823912iob.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 02:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ql/E6rc9A3I9gyABQHLE52Zd4X9REf/kICDg7XOYGik=;
        b=v2HHfNAp37tUO/97CLX3Y+b++M4et7dddSBiL/xijFHG7gL94qkdnPb+jIPpIit9Lt
         jUS3ZbL7wNWxPMTfXACVJY5iEVWfk3/vF7SqJEL/bvszyrNkaidmxHCBrvktmDjAEzdH
         jODFetEB7zurunTHadEiSGp3S9TlkRurEM59Oo74PepRKXk+gxE98IgSfG6DsZQYSNnb
         mOct/FQOKHZSMv3bTGr8HfMQrsnEL/nVyy/so7FmEKIhxCgmsrFUAMkLqQV8gNI6qSBI
         ss1cFOwMwGX7Za4fWh/t7Hp59IFOC3CysJ06L7e2TQ5gE2j6GOQPZAsF8d8E/QmrMarQ
         YKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ql/E6rc9A3I9gyABQHLE52Zd4X9REf/kICDg7XOYGik=;
        b=gpkt3NWtvBV2HxS9HZmr9MjwVNMlq9Fg4M4WVoLNMbD3vzH2GGaNEydlh6TJjBzSWy
         aJyghtNA63JgQYkj36kuZ9YKAGQ4yCZclDOU1PxubDB5uhEigunODp4hqkA10wjKspEe
         vgIAzfWR1kj4dR+KNO/cytY2hMYb98R2tRcZRD8t9KKQLHSaPy/F9KrucXoU/aWb+pUd
         mn5isqnLXb+PNCcbLkETwCEHe1QxzD7qNtVkZoWhIBDd49qzb01h9TZd0QTjyudS4bct
         iE9pFUKQvPMMDvQgPiIjEZH2m3Jtf3giBiDai7ZOmCKZSiix/vjnhG3kK1BJlRfZT2Hh
         q3rg==
X-Gm-Message-State: APjAAAV7I7uXCq2ZDAdOMNNqr/hFrfrqUVFGlIfsrgGSKetXvEw/IDGM
        6a0i9OlN1YnPk9axYNaNEi3sZTjxscMh8Nbqe20e1w==
X-Google-Smtp-Source: APXvYqyUWQDTtRK7c6efFYlHvTMYZ7aqw49DiGoJ0MGOHHVAFeJLFQBS5DcQQQeNz9L3GUaf79MpX/kCKWynfsMpuuE=
X-Received: by 2002:a5e:990f:: with SMTP id t15mr7352985ioj.270.1570094620200;
 Thu, 03 Oct 2019 02:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190930130430.GA9080@localhost.localdomain> <CAL_JsqLXJNvWOOajS4JVVek=h+v_Fxrx58ogQ0Cz+5n5Sh0+=g@mail.gmail.com>
In-Reply-To: <CAL_JsqLXJNvWOOajS4JVVek=h+v_Fxrx58ogQ0Cz+5n5Sh0+=g@mail.gmail.com>
From:   Mateusz Holenko <mholenko@antmicro.com>
Date:   Thu, 3 Oct 2019 11:23:29 +0200
Message-ID: <CAPk366QHtjL9qJV3RRwa=3tW-GB5PfLC1qzc0WgYbRzdMcZrYQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: serial: document LiteUART bindings
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, Karol Gugala <kgugala@antmicro.com>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 30 wrz 2019 o 23:32 Rob Herring <robh+dt@kernel.org> napisa=C5=82(a):
>
> On Mon, Sep 30, 2019 at 8:04 AM Mateusz Holenko <mholenko@antmicro.com> w=
rote:
> >
> > From: Filip Kokosinski <fkokosinski@internships.antmicro.com>
> >
> > Add documentation for LiteUART devicetree bindings.
> >
> > Signed-off-by: Filip Kokosinski <fkokosinski@internships.antmicro.com>
> > Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> > ---
> >  .../devicetree/bindings/serial/litex,liteuart.txt    | 12 ++++++++++++
> >  MAINTAINERS                                          |  6 ++++++
> >  2 files changed, 18 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/serial/litex,lite=
uart.txt
>
> Please make this a schema. See
> Documentation/devicetree/writing-schema.rst (or .md before 5.4).

Ok. We will rewrite it.

> >
> > diff --git a/Documentation/devicetree/bindings/serial/litex,liteuart.tx=
t b/Documentation/devicetree/bindings/serial/litex,liteuart.txt
> > new file mode 100644
> > index 000000000..13c71a0c9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/litex,liteuart.txt
> > @@ -0,0 +1,12 @@
> > +LiteUART serial controller
> > +
> > +Required properties:
> > +- compatible: should be "litex,liteuart"
>
> Only 1 version?

For the time being there is only one flavor.

> > +- reg: base address and length of the register set for this device
>
> Is there really no interrupt line? That should be added if there's h/w
> support even if the driver doesn't yet support it.
>
> > +
> > +Example:
> > +
> > +uart0: serial@f0001000 {
>
> Wrong unit address. Should be "@e0001800".

Right, address should be consistent with the one in 'reg'.

>
> > +       compatible =3D "litex,liteuart";
> > +       reg =3D <0xe0001800 0x100>;
> > +};
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index b2326dece..65a6cf296 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9462,6 +9462,12 @@ F:       Documentation/misc-devices/lis3lv02d.rs=
t
> >  F:     drivers/misc/lis3lv02d/
> >  F:     drivers/platform/x86/hp_accel.c
> >
> > +LITEX PLATFORM
> > +M:     Karol Gugala <kgugala@antmicro.com>
> > +M:     Mateusz Holenko <mholenko@antmicro.com>
> > +S:     Maintained
> > +F:     Documentation/devicetree/bindings/serial/litex,liteuart.txt
> > +
> >  LIVE PATCHING
> >  M:     Josh Poimboeuf <jpoimboe@redhat.com>
> >  M:     Jiri Kosina <jikos@kernel.org>
> > --
> > 2.23.0
> >

Thanks for your comments.
I'll address the remarks in V2 of the patchset after receiving a
response on the rest of the patches.

--
Mateusz Holenko
mobile: +48 606 791 789
Antmicro Ltd | www.antmicro.com
Zwierzyniecka 3, 60-813 Poznan, Poland
