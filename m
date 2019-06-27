Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB37C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388E9205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfY73UsM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfF0Hke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:40:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44924 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfF0Hke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:40:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16so1273136wrl.11;
        Thu, 27 Jun 2019 00:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/CusHUsM6XBNBHQs7MdEGbKPt4N56lsbxJiB8DbM+Z0=;
        b=ZfY73UsMmYZTZ2IIzZqyeoW3A47H0VdM45mnwO6/FEXr5+5BtJVHRSJ1voTQIb7jB1
         dMJg3oTHwqtDy/ky1rX86bB4DVIetXwUx+n/UJO2uw9pY+5Fn1bTZsxYthM2M0Zin1tm
         +pUZ1Md2wrkEqr/cQm3qfCgF4ZAY0+M4N8gi6hj54wGbz0uzYYFJJZuPw3mNulbgNVcn
         7e4Rg+o7J4qQwLe2HSxhFJER1qjgbuaZV4SLyR2RgtCH05C/aNf/uz5wn+blxi6+9+g6
         ss59sET0yCb+LUPAEWa2CifGp/oUGoulOFzEWREf/ok+o+LpVg3PMtSEJ+usQhYgvOmm
         8lbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/CusHUsM6XBNBHQs7MdEGbKPt4N56lsbxJiB8DbM+Z0=;
        b=lSriAhLgz38FN556xe6KNOCxvEVRXEzdvHS2kRvY4uOfQvupBo4kEB8emoy9l0YeDB
         dmbktkSxTDMFaOwqM85O7pfoFX7lLQDegUmjUPS0OYDVpZNFd1P+Wv9L39H+GJDCc8My
         jCEyHEJVyuasBAVZS52kb/jQx0NuwAvIHALMDn4D0xIkL/MTkSUUbKUR0iVftIPx/nuI
         UfltYINZSYOiS0F2bEFkkg6rMCj1HBTCZcgFHFXHzzDtJE8zembfcYqCmvUjhupVZHw4
         hSRCpUjgzGFBkojgqA74U3pWTDG4h+jsl+TzpVoXRfNqIW+CNfEt+8JJU6Y1iBUrrpE7
         zm9Q==
X-Gm-Message-State: APjAAAU0pnYfH5sYtB/XQ7ym5PKYU1I2oOCmWVciMBVeYcuRsWbud/OA
        Gy/m93J3JeL8VmGAt9PkO23gu+ebZxjZ4yl3MpY=
X-Google-Smtp-Source: APXvYqwEX7xmuzgZaxM1cTe6YGW6FKOn1KskW1Shqf2w0aTgNW3SDIZUqgip+czOjj7Yuoue0KQMw3jRSKKqFQPLI/s=
X-Received: by 2002:adf:db12:: with SMTP id s18mr1535921wri.335.1561621231319;
 Thu, 27 Jun 2019 00:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190614081650.11880-1-daniel.baluta@nxp.com> <20190614081650.11880-3-daniel.baluta@nxp.com>
 <CAL_JsqJKgMB1PNA33gmFju4AQTc2WaSBoOGQExVaGd9LZRmk_g@mail.gmail.com>
 <CAEnQRZBNA4ndSL1vMStHemYkzt9TxqjgdWWjqFwnBFQ+ha+egA@mail.gmail.com> <CAL_JsqJQRbuWKgON+ukZ3GRwyq8SvTZ=PRGwMhQjAxKPSP-Fkw@mail.gmail.com>
In-Reply-To: <CAL_JsqJQRbuWKgON+ukZ3GRwyq8SvTZ=PRGwMhQjAxKPSP-Fkw@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 27 Jun 2019 10:40:19 +0300
Message-ID: <CAEnQRZCjp9dUt0JTjhN0CnV0+Xzc+q1EHCnJn_TNOQoUWZBTsg@mail.gmail.com>
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

<snip>

> > > > +  mboxes:
> > > > +    description:
> > > > +      List of phandle of 2 MU channels for TXDB, 2 MU channels for=
 RXDB
> > > > +      (see mailbox/fsl,mu.txt)
> > > > +    maxItems: 1
> > >
> > > Should be 4?
> >
> > Actually is just a list with 1 item. I think is the terminology:
> >
> > You can have an example here of the mboxes defined for SCU.
> > https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/frees=
cale/imx8qxp.dtsi#L123
>
> mboxes =3D <&lsio_mu1 0 0
> &lsio_mu1 0 1
> &lsio_mu1 0 2
> &lsio_mu1 0 3
> &lsio_mu1 1 0
> &lsio_mu1 1 1
> &lsio_mu1 1 2
> &lsio_mu1 1 3
> &lsio_mu1 3 3>;
>
> Logically, this is 9 entries and each entry is 3 cells ( or phandle
> plus 2 cells). More below...

Ok..

>
> > > > +
> > > > +  mbox-names
>
> Also, missing a ':' here. This won't build. Make sure you build this
> (make dt_binding_check). See
> Documentation/devicetree/writing-schemas.md.
>
Fixed in v2. Awesome!

I thought that Documentation/devicetree/bindings/dsp/fsl,dsp_ipc.yaml
is purely decorative and used as an example. But it's actually the schema f=
or
the newly yaml dts, right?

Used make dt_binding_check everything looks OK now.

> > > > +    description:
> > > > +      Mailboxes names
> > > > +    allOf:
> > > > +      - $ref: "/schemas/types.yaml#/definitions/string"
> > >
> > > No need for this, '*-names' already has a defined type.
> > So, should I remove the above two lines ?
>
> Actually, all 4. There's no need to describe what 'mbox-names' is.
>
> > > > +      - enum: [ "txdb0", "txdb1", "rxdb0", "rxdb1" ]
> > >
> > > Should be an 'items' list with 4 entries?
> >
> > Let me better read the yaml spec. But "items" list indeed sounds better=
.
>
> What you should end up with is:
>
> items:
>   - const: txdb0
>   - const: txdb1
>   - const: rxdb0
>   - const: rxdb1
>
> This is saying you have 4 strings in the listed order. The enum you
> had would be a single string of one of the 4 values.
>
I see! Thanks.

> > > > +required:
> > > > +  - compatible
> > > > +  - mboxes
> > > > +  - mbox-names
> > >
> > > This seems incomplete. How does one boot the DSP? Load firmware? No
> > > resources that Linux has to manage. Shared memory?
> >
> > This is only the IPC mailboxes used by DSP to communicate with Linux. T=
he
> > loading of the firmware, the resources needed to be managed by Linux, e=
tc
> > are part of the DSP node.
>
> You should just add the mailboxes to the DSP node then. I suppose you
> didn't because you want 2 drivers? If so, that's the OS's problem and
> not part of DT. A Linux driver can instantiate devices for other
> drivers.

Yes, I want the DSP IPC driver to be separated. And then the SOF Linux
driver that needs
to communicate with DSP just gets a handle to DSP IPC driver and does
the communication.

dts relevant nodes look like this now:

=C2=BB       dsp_ipc: dsp_ipc {
=C2=BB       =C2=BB       compatible =3D "fsl,imx8qxp-dsp";
=C2=BB       =C2=BB       mbox-names =3D "txdb0", "txdb1",
=C2=BB       =C2=BB       =C2=BB            "rxdb0", "rxdb1";
=C2=BB       =C2=BB       mboxes =3D <&lsio_mu13 2 0>,
=C2=BB       =C2=BB       =C2=BB        <&lsio_mu13 2 1>,
=C2=BB       =C2=BB       =C2=BB        <&lsio_mu13 3 0>,
=C2=BB       =C2=BB       =C2=BB        <&lsio_mu13 3 1>;
=C2=BB       };

=C2=BB       adma_dsp: dsp@596e8000 {
=C2=BB       =C2=BB       compatible =3D "fsl,imx8qxp-sof-dsp";
=C2=BB       =C2=BB       reg =3D <0x596e8000 0x88000>;
=C2=BB       =C2=BB       reserved-region =3D <&dsp_reserved>;
=C2=BB       =C2=BB       ipc =3D <&dsp_ipc>;
=C2=BB       };

Your suggeston would be to have something like this:

=C2=BB       adma_dsp: dsp@596e8000 {
=C2=BB       =C2=BB       compatible =3D "fsl,imx8qxp-sof-dsp";
=C2=BB       =C2=BB       reg =3D <0x596e8000 0x88000>;
=C2=BB       =C2=BB       reserved-region =3D <&dsp_reserved>;
=C2=BB                mbox-names =3D "txdb0", "txdb1",
=C2=BB       =C2=BB       =C2=BB            "rxdb0", "rxdb1";
=C2=BB       =C2=BB       mboxes =3D <&lsio_mu13 2 0>,
=C2=BB       =C2=BB       =C2=BB        <&lsio_mu13 2 1>,
=C2=BB       =C2=BB       =C2=BB        <&lsio_mu13 3 0>,
=C2=BB       =C2=BB       =C2=BB        <&lsio_mu13 3 1>;
=C2=BB       };

Not sure exactly how to instantiate IPC DSP driver then.

I already have prepared v2 with most of your feedback incorporated,
but not this latest
change with moving mboxes inside dsp driver.

More than that I have followed the model of SCFW IPC and having to
different approach
for similar IPC mechanism is a little bit confusing.

Anyhow, will try to address your further feedback, will send v2 now to
have more feedback from
Oleksij.

thanks,
Daniel.
