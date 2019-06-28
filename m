Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3801C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1AA208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxCcngHc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfF1KZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:25:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56240 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfF1KZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:25:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so8562625wmj.5;
        Fri, 28 Jun 2019 03:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+gSDQlprC3wNVZJTkEDEwtkD07MIUVX5qMZNbzm3ynQ=;
        b=PxCcngHcfZRARVD6NmZbBJD4QlvgXY6SEXWfEYyJypBHAtTPANXPXiB0N778DL4zG5
         /6tf2wO9OHv+aH1YOdgfj5j4OsFTc5jZPNRAEzsCHN45rF4yDVTMWTL7UJpaEukHjOff
         PryTnfTmZC95X9cgOK8ky/KSdrCi3SyuYjbE5qtZOMk2332CNK4/UDKCkHSYbRZGwmsr
         Jjgq1TMLfUOn5wNKSpo4oQU7/Yg5QKFJjkFPTL9LZLUjBPqtjVsIqs+CtS1MHoXSyNv7
         x2GzJQSiMZbmcV/Vfcuuxbgkscrj14UApQqt1b4bYgcWNTC2WoXKrnsjaBWB033xS8Fa
         JZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+gSDQlprC3wNVZJTkEDEwtkD07MIUVX5qMZNbzm3ynQ=;
        b=DWMvbtWuTjriENYfrVWOMxDynAouJSoDsLdSY/7bKWwDn380AM5YHS4xp8kaQmP07w
         c65Z5C3rJ2lCdAn+Pl9nSEU9j1nth49lUwJ3bYaT1kEmlZiPpHTwezcuGcG1gKKDsAiV
         nkbRLhh8hlmpHyTPoQ7ocS29T5QXxbzbFoB6OlSTsXqAHv1qQdn399EebeXsVsIWI5Hp
         wUIpI1VfUgJK+oQ7StJTNcC+brPPrjSSqwpim6GUXEU/J5K4ephquzXsA4Oide7QXzUr
         SDYiuOoSg3za1cHmw9dXQ/SnhJ1wwMdWQma/fJJcS8nCoB9EGcvp6pE1c7ugfvkoc5TG
         EaOQ==
X-Gm-Message-State: APjAAAWA62FuNpZAO4VoVVNt4br0FXqaYnohK3arvbLSI6ANj80gmBQa
        IyK3hKUU/y5P8Y+G28S/rKbNC4HvBlVxKHZefAQ=
X-Google-Smtp-Source: APXvYqxM13BhXdAFu5qp47wTYBemlGsB9zTErhcOOBhxiB0lkff6jlFmCfZ1EdLSkLO+KM5c9OxqtFufIMjqnL37XcM=
X-Received: by 2002:a1c:96c7:: with SMTP id y190mr6191140wmd.87.1561717504973;
 Fri, 28 Jun 2019 03:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190614081650.11880-1-daniel.baluta@nxp.com> <20190614081650.11880-3-daniel.baluta@nxp.com>
 <CAL_JsqJKgMB1PNA33gmFju4AQTc2WaSBoOGQExVaGd9LZRmk_g@mail.gmail.com>
 <CAEnQRZBNA4ndSL1vMStHemYkzt9TxqjgdWWjqFwnBFQ+ha+egA@mail.gmail.com>
 <CAL_JsqJQRbuWKgON+ukZ3GRwyq8SvTZ=PRGwMhQjAxKPSP-Fkw@mail.gmail.com>
 <CAEnQRZCjp9dUt0JTjhN0CnV0+Xzc+q1EHCnJn_TNOQoUWZBTsg@mail.gmail.com> <CAL_Jsq+rWn+vVfBGdAB23Xu0RaFV1HwSdBbfj9F4M3W1EUo9_A@mail.gmail.com>
In-Reply-To: <CAL_Jsq+rWn+vVfBGdAB23Xu0RaFV1HwSdBbfj9F4M3W1EUo9_A@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 28 Jun 2019 13:24:53 +0300
Message-ID: <CAEnQRZCLUKxWD31bMS_Smc-dj0W0qWz7YsO6txftWX9nm9R_6Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: arm: fsl: Add DSP IPC binding support
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 6:59 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Jun 27, 2019 at 1:40 AM Daniel Baluta <daniel.baluta@gmail.com> w=
rote:
> >
> > <snip>
> >
> > > > > > +  mboxes:
> > > > > > +    description:
> > > > > > +      List of phandle of 2 MU channels for TXDB, 2 MU channels=
 for RXDB
> > > > > > +      (see mailbox/fsl,mu.txt)
> > > > > > +    maxItems: 1
> > > > >
> > > > > Should be 4?
> > > >
> > > > Actually is just a list with 1 item. I think is the terminology:
> > > >
> > > > You can have an example here of the mboxes defined for SCU.
> > > > https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/f=
reescale/imx8qxp.dtsi#L123
> > >
> > > mboxes =3D <&lsio_mu1 0 0
> > > &lsio_mu1 0 1
> > > &lsio_mu1 0 2
> > > &lsio_mu1 0 3
> > > &lsio_mu1 1 0
> > > &lsio_mu1 1 1
> > > &lsio_mu1 1 2
> > > &lsio_mu1 1 3
> > > &lsio_mu1 3 3>;
> > >
> > > Logically, this is 9 entries and each entry is 3 cells ( or phandle
> > > plus 2 cells). More below...
> >
> > Ok..
> >
> > >
> > > > > > +
> > > > > > +  mbox-names
> > >
> > > Also, missing a ':' here. This won't build. Make sure you build this
> > > (make dt_binding_check). See
> > > Documentation/devicetree/writing-schemas.md.
> > >
> > Fixed in v2. Awesome!
> >
> > I thought that Documentation/devicetree/bindings/dsp/fsl,dsp_ipc.yaml
> > is purely decorative and used as an example. But it's actually the sche=
ma for
> > the newly yaml dts, right?
>
> Yes, that's the point. Enforcing that dts files contain what the
> binding docs say.
>
> >
> > Used make dt_binding_check everything looks OK now.
> >
> > > > > > +    description:
> > > > > > +      Mailboxes names
> > > > > > +    allOf:
> > > > > > +      - $ref: "/schemas/types.yaml#/definitions/string"
> > > > >
> > > > > No need for this, '*-names' already has a defined type.
> > > > So, should I remove the above two lines ?
> > >
> > > Actually, all 4. There's no need to describe what 'mbox-names' is.
> > >
> > > > > > +      - enum: [ "txdb0", "txdb1", "rxdb0", "rxdb1" ]
> > > > >
> > > > > Should be an 'items' list with 4 entries?
> > > >
> > > > Let me better read the yaml spec. But "items" list indeed sounds be=
tter.
> > >
> > > What you should end up with is:
> > >
> > > items:
> > >   - const: txdb0
> > >   - const: txdb1
> > >   - const: rxdb0
> > >   - const: rxdb1
> > >
> > > This is saying you have 4 strings in the listed order. The enum you
> > > had would be a single string of one of the 4 values.
> > >
> > I see! Thanks.
> >
> > > > > > +required:
> > > > > > +  - compatible
> > > > > > +  - mboxes
> > > > > > +  - mbox-names
> > > > >
> > > > > This seems incomplete. How does one boot the DSP? Load firmware? =
No
> > > > > resources that Linux has to manage. Shared memory?
> > > >
> > > > This is only the IPC mailboxes used by DSP to communicate with Linu=
x. The
> > > > loading of the firmware, the resources needed to be managed by Linu=
x, etc
> > > > are part of the DSP node.
> > >
> > > You should just add the mailboxes to the DSP node then. I suppose you
> > > didn't because you want 2 drivers? If so, that's the OS's problem and
> > > not part of DT. A Linux driver can instantiate devices for other
> > > drivers.
> >
> > Yes, I want the DSP IPC driver to be separated. And then the SOF Linux
> > driver that needs
> > to communicate with DSP just gets a handle to DSP IPC driver and does
> > the communication.
> >
> > dts relevant nodes look like this now:
> >
> > =C2=BB       dsp_ipc: dsp_ipc {
> > =C2=BB       =C2=BB       compatible =3D "fsl,imx8qxp-dsp";
> > =C2=BB       =C2=BB       mbox-names =3D "txdb0", "txdb1",
> > =C2=BB       =C2=BB       =C2=BB            "rxdb0", "rxdb1";
> > =C2=BB       =C2=BB       mboxes =3D <&lsio_mu13 2 0>,
> > =C2=BB       =C2=BB       =C2=BB        <&lsio_mu13 2 1>,
> > =C2=BB       =C2=BB       =C2=BB        <&lsio_mu13 3 0>,
> > =C2=BB       =C2=BB       =C2=BB        <&lsio_mu13 3 1>;
> > =C2=BB       };
> >
> > =C2=BB       adma_dsp: dsp@596e8000 {
> > =C2=BB       =C2=BB       compatible =3D "fsl,imx8qxp-sof-dsp";
> > =C2=BB       =C2=BB       reg =3D <0x596e8000 0x88000>;
> > =C2=BB       =C2=BB       reserved-region =3D <&dsp_reserved>;
> > =C2=BB       =C2=BB       ipc =3D <&dsp_ipc>;
> > =C2=BB       };
> >
> > Your suggeston would be to have something like this:
> >
> > =C2=BB       adma_dsp: dsp@596e8000 {
> > =C2=BB       =C2=BB       compatible =3D "fsl,imx8qxp-sof-dsp";
> > =C2=BB       =C2=BB       reg =3D <0x596e8000 0x88000>;
> > =C2=BB       =C2=BB       reserved-region =3D <&dsp_reserved>;
> > =C2=BB                mbox-names =3D "txdb0", "txdb1",
> > =C2=BB       =C2=BB       =C2=BB            "rxdb0", "rxdb1";
> > =C2=BB       =C2=BB       mboxes =3D <&lsio_mu13 2 0>,
> > =C2=BB       =C2=BB       =C2=BB        <&lsio_mu13 2 1>,
> > =C2=BB       =C2=BB       =C2=BB        <&lsio_mu13 3 0>,
> > =C2=BB       =C2=BB       =C2=BB        <&lsio_mu13 3 1>;
> > =C2=BB       };
> >
> > Not sure exactly how to instantiate IPC DSP driver then.
>
> DT is not the only way to instantiate drivers. A driver can create a
> platform device itself which will then instantiate a 2nd driver.
>
> Presumably the DSP needs to be booted, resources enabled, and firmware
> loaded before IPC will work. The DSP driver controlling the lifetime
> of the IPC driver is the right way to manage the dependencies.

I see your point. This way I will resolve the dependency problem. So far
SOF driver was probed before IPC driver and I needed to return -EPROBE_DEFF=
ER.

The "sad" part is that SOF driver also needs in the same way the
System Controller
Firmware driver to be probed.

But the SC driver is already accepted with an interface that looks
like my old approach.

https://elixir.bootlin.com/linux/v5.2-rc6/source/drivers/firmware/imx/imx-s=
cu.c#L93

Oh, well.
>
> >
> > I already have prepared v2 with most of your feedback incorporated,
> > but not this latest
> > change with moving mboxes inside dsp driver.
> >
> > More than that I have followed the model of SCFW IPC and having to
> > different approach
> > for similar IPC mechanism is a little bit confusing.
>
> SC is system controller? Maybe I missed it, but I don't think system
> controllers usually have 2 nodes. You only have the communications
> interface exposed as the SC provides services to Linux and Linux
> doesn't manage the SC resources.

Yes, SC is the system controller.

https://elixir.bootlin.com/linux/v5.2-rc6/source/drivers/firmware/imx/imx-s=
cu.c

I see your point of only have 1 node and I will implement it like that.
