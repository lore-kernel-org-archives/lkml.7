Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FE2C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C722075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndqW3mP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfEBIlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:41:35 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53630 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfEBIle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:41:34 -0400
Received: by mail-it1-f193.google.com with SMTP id l10so1919753iti.3;
        Thu, 02 May 2019 01:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K4OgCJhQf1RCHc0gxAMiXKeGdaGGkpYQYrG1YDmor08=;
        b=ndqW3mP7X943elO5hRn0uw7A31GJKR2oll9etmkipUU13uQqA2X4QpeLianjJ5kKfT
         B7rgoaPIqDWpyUyKem90TcR9pOtBxZpymis61LhpDPb5jE3PBbmnc3unKmYwIMUfw8vv
         LjXGqSz1LIq3aQhfiH0AbtX2jqETFmIr447sudysjnNECd4frWClaHo7HzyQ7CrlD29t
         QgKHBKFh9c9Sdq+HH4OieGn6E2D2f+z+Xx9C8Dyfn13WnH97OKjzbJAx0YjzAcVB7VXT
         Ss87nq+ExVddDAM3F4jLvIxdA+lN1wazRQFVGxz6+WLqoVzUXQf6PcnDB5FJWSrjRCVp
         v8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K4OgCJhQf1RCHc0gxAMiXKeGdaGGkpYQYrG1YDmor08=;
        b=M9DaoKEdJ/xW5/Yj7MejBL7GcLnVprNcLyGNblfjhLtcu03YNdHCldBa6jHHG3Vp/O
         fAp+pl1YTAmXFdo2lIj+vKtkAvPIoInrFJbwgW+OL/+sBbWKZKIvieoK59XeIhJbI1IM
         aJd8+GkTl5jQc1CzuvYsY4pa8+8yvgsiyxZTxGi+AvQKZnViC77ZjovdN/4Z52XAIYL0
         CsccnHztTmwmyjNfWTeLLc/Q25HVOspknXTnK8pmE2bQJb33Hg622JYvC/W1VSr+ooF2
         yQ4GGmjSlLDOiUhMb304UEKt7nY+yYgM8J6BfNZuII/c/pXYJEbAD/v+Tzz7IZ0UmCRU
         Wr7w==
X-Gm-Message-State: APjAAAWcoVLNAIGh9ZzjhO1alIl8j0Ksix9pz+lwru2eZa8ts41Xwa9Z
        d5V8Sp7LPWKm2a93X8EzwldHuVMbjzXc5arYex4=
X-Google-Smtp-Source: APXvYqwlzMfIDeeLnxvg8F8pQApRYPFkN5K6jYDokW3XadTir4RTT4tXnwv+PS8fCCKpMM1zl63D4nV8dxK7nwrEX1Q=
X-Received: by 2002:a24:c488:: with SMTP id v130mr1625014itf.96.1556786492758;
 Thu, 02 May 2019 01:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190426164224.11327-1-pawel.mikolaj.chmiel@gmail.com>
 <20190426164224.11327-5-pawel.mikolaj.chmiel@gmail.com> <20190502015408.GA11612@bogus>
 <CA+Ln22HLqnbbY37FG6CwjZvZH7G35Z+0kNq7XFU4WtZyk_EqZQ@mail.gmail.com>
 <20190502083632.0ec0fb4e@collabora.com> <CA+Ln22H4ua9Zuh4eKaWfHtqh8DieyiS=5s7wS6-TbmA5Dsop4A@mail.gmail.com>
 <20190502085518.5d248167@collabora.com> <CA+Ln22EJ3G9ez4XZ3ysZBt6thsqDYDtik8fw-gfExR9Y7wFN9A@mail.gmail.com>
 <20190502092126.22f1ace5@collabora.com>
In-Reply-To: <20190502092126.22f1ace5@collabora.com>
From:   Tomasz Figa <tomasz.figa@gmail.com>
Date:   Thu, 2 May 2019 17:41:20 +0900
Message-ID: <CA+Ln22Es-P9J5unVYwH2kM-+3Zz6Jb9GtsL=HcHsgbjwmi5sMw@mail.gmail.com>
Subject: Re: [PATCH 4/5] dt-binding: mtd: onenand/samsung: Add device tree support
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     computersforpeace@gmail.com, marek.vasut@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        bbrezillon@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019=E5=B9=B45=E6=9C=882=E6=97=A5(=E6=9C=A8) 16:21 Boris Brezillon <boris.b=
rezillon@collabora.com>:
>
> On Thu, 2 May 2019 15:58:24 +0900
> Tomasz Figa <tomasz.figa@gmail.com> wrote:
>
> > 2019=E5=B9=B45=E6=9C=882=E6=97=A5(=E6=9C=A8) 15:55 Boris Brezillon <bor=
is.brezillon@collabora.com>:
> > >
> > > On Thu, 2 May 2019 15:42:59 +0900
> > > Tomasz Figa <tomasz.figa@gmail.com> wrote:
> > >
> > > > 2019=E5=B9=B45=E6=9C=882=E6=97=A5(=E6=9C=A8) 15:36 Boris Brezillon =
<boris.brezillon@collabora.com>:
> > > > >
> > > > > Hi Tomasz,
> > > > >
> > > > > On Thu, 2 May 2019 15:23:33 +0900
> > > > > Tomasz Figa <tomasz.figa@gmail.com> wrote:
> > > > >
> > > > > > 2019=E5=B9=B45=E6=9C=882=E6=97=A5(=E6=9C=A8) 10:54 Rob Herring =
<robh@kernel.org>:
> > > > > > >
> > > > > > > On Fri, Apr 26, 2019 at 06:42:23PM +0200, Pawe=C5=82 Chmiel w=
rote:
> > > > > > > > From: Tomasz Figa <tomasz.figa@gmail.com>
> > > > > > > >
> > > > > > > > This patch adds dt-bindings for Samsung OneNAND driver.
> > > > > > > >
> > > > > > > > Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> > > > > > > > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmai=
l.com>
> > > > > > > > ---
> > > > > > > >  .../bindings/mtd/samsung-onenand.txt          | 46 +++++++=
++++++++++++
> > > > > > > >  1 file changed, 46 insertions(+)
> > > > > > > >  create mode 100644 Documentation/devicetree/bindings/mtd/s=
amsung-onenand.txt
> > > > > > > >
> > > > > > > > diff --git a/Documentation/devicetree/bindings/mtd/samsung-=
onenand.txt b/Documentation/devicetree/bindings/mtd/samsung-onenand.txt
> > > > > > > > new file mode 100644
> > > > > > > > index 000000000000..341d97cc1513
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/Documentation/devicetree/bindings/mtd/samsung-onenand=
.txt
> > > > > > > > @@ -0,0 +1,46 @@
> > > > > > > > +Device tree bindings for Samsung SoC OneNAND controller
> > > > > > > > +
> > > > > > > > +Required properties:
> > > > > > > > + - compatible : value should be either of the following.
> > > > > > > > +   (a) "samsung,s3c6400-onenand" - for onenand controller =
compatible with
> > > > > > > > +       S3C6400 SoC,
> > > > > > > > +   (b) "samsung,s3c6410-onenand" - for onenand controller =
compatible with
> > > > > > > > +       S3C6410 SoC,
> > > > > > > > +   (c) "samsung,s5pc100-onenand" - for onenand controller =
compatible with
> > > > > > > > +       S5PC100 SoC,
> > > > > > > > +   (d) "samsung,s5pv210-onenand" - for onenand controller =
compatible with
> > > > > > > > +       S5PC110/S5PV210 SoCs.
> > > > > > > > +
> > > > > > > > + - reg : two memory mapped register regions:
> > > > > > > > +   - first entry: control registers.
> > > > > > > > +   - second and next entries: memory windows of particular=
 OneNAND chips;
> > > > > > > > +     for variants a), b) and c) only one is allowed, in ca=
se of d) up to
> > > > > > > > +     two chips can be supported.
> > > > > > > > +
> > > > > > > > + - interrupt-parent : phandle of interrupt controller to w=
hich the OneNAND
> > > > > > > > +   controller is wired,
> > > > > > >
> > > > > > > This is implied and can be removed.
> > > > > > >
> > > > > > > > + - interrupts : specifier of interrupt signal to which the=
 OneNAND controller
> > > > > > > > +   is wired; should contain just one entry.
> > > > > > > > + - clock-names : should contain two entries:
> > > > > > > > +   - "bus" - bus clock of the controller,
> > > > > > > > +   - "onenand" - clock supplied to OneNAND memory.
> > > > > > >
> > > > > > > If the clock just goes to the OneNAND device, then it should =
be in the
> > > > > > > nand device node rather than the controller node.
> > > > > > >
> > > > > >
> > > > > > (Trying hard to recall the details about this hardware.)
> > > > > > AFAIR the clock goes to the controller and the controller then =
feeds
> > > > > > it to the memory chips.
> > > > > >
> > > > > > Also I don't think we should have any nand device nodes here, s=
ince
> > > > > > the memory itself is only exposed via the controller, which off=
ers
> > > > > > various queries to probe the memory at runtime, so there is no =
need to
> > > > > > describe it in DT.
> > > > >
> > > > > It's probably true, though not providing this controller/device
> > > > > separation for NAND controller/devices has proven to be a mistake=
 for
> > > > > raw NAND controllers (some props apply to the controllers and oth=
ers to
> > > > > the NAND device, not to mention that some controllers support
> > > > > interacting with several chips), so, if that's a new binding, I'd
> > > > > recommend having this separation even if it's not strictly requir=
ed.
> > > > >
> > > >
> > > > Note that OneNAND is a totally different thing than the typical NAN=
D
> > > > memory with NAND interface. OneNAND chips have a NOR-like interface=
,
> > > > with internal controller and buffers inside, so technically they ca=
n
> > > > be even used without any special controller on the SoC, via a gener=
ic
> > > > parallel host interface and possibly some regular DMA engine for CP=
U
> > > > offload.
> > >
> > > Yes, I know that.
> > >
> > > >
> > > > The controller design of the SoCs in question further abstracts the
> > > > OneNAND's programming interface into a number of high level operati=
ons
> > > > and attempts to hide the details of the underlying memory, so I don=
't
> > > > see the point of describing the memory in DT here, it would actuall=
y
> > > > defeat the purpose of this controller.
> > >
> > > I don't see how having a subnode for the NAND chip would change
> > > anything on how the controller interacts with the NAND device. My poi=
nt
> > > is, if we ever need to add props that apply to the device rather than
> > > the controller itself, having a single node to represent both element=
s
> > > is not that great.
> >
> > You mean, just having a very generic onenand@0 node that doesn't
> > really include any information, except maybe the partition table?
>
> Yes.
>
> > I
> > guess that wouldn't have any negative side effects indeed.
> >
> > My point was that we don't want to put things like chip vendor, size,
> > etc. in DT, since that's enumerable.
>
> Oh, definitely not, and that's exactly how we do it for NAND devices.
> Everything that's discoverable is not described in the DT, but some
> things can't be discovered this way (like when you want to override the
> ECC strength and use SW-based implem instead of the HW-based one). I
> know none of this applies to OneNAND yet, I'm just over-cautious about
> that since DT bindings changes are hard to make once the bindings are
> in use.

Makes sense. Thanks for clarifying!
