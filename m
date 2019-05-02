Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36B7C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 06:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7211208C4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 06:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6sC+Alj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfEBGnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 02:43:12 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53910 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbfEBGnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 02:43:12 -0400
Received: by mail-it1-f194.google.com with SMTP id l10so1468985iti.3;
        Wed, 01 May 2019 23:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HSGbpAsjrEz+LSOl9dCHcdRZTgcOh3tw9dUTjuJ5J7c=;
        b=Z6sC+AljjqID+DmQtvIw7IEWj6jrkr+b/pA8gIJjXBCIYJGNT9O9mhXeLlW/Hvwdd7
         pgxjueuiS/4sbp6UXofiy9XKouVG97oq8Sfp9EEO4KBlLYwQjE+tDYyXLlj6AhOh+sB9
         UTHWDE2gCylbElM7ok5XrOCXFmZ6arFtKmanSTv1PzYbs+4+iwLFz0RZIokI+8bCk8aX
         w3tIsnE93BdPxqMuogGb1h2VZI8xMSrxtJfWHfy//lTbVgMo3jGf7bvAl7KFSFAGecD8
         Gerl7Vf0BzPRJl1DvBZ0gs3q20z9l1uwqpHsZVjX6kZunc2T98nGJukn2442QwlMRJZD
         i9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HSGbpAsjrEz+LSOl9dCHcdRZTgcOh3tw9dUTjuJ5J7c=;
        b=e2eenXrfnzXTb4jNtqNd/oOf77Fc5LOwQcs0nOTZz2/jB7h/rrshM2dni92HSgxfTD
         dHb/jxrTZvWK8rjopkn+yudbczkhLfNfYbwnQVQa9pYCPutnotArL4jvYUrWcpzvl/jL
         cczWlGXrL1Ek0y8FkLXpFmgY/TQIk1tx0upZCPlCnkSQahQKfCQgo12goKc4WBFZahwR
         xkjh7gU9jwmXEr1KKVQw/Id5TVLmb9xtln/DcEHKvbvCFt1TgLGWbSbS8UL39CkrnVeZ
         5PZZ0CV4DbEb05MLZNT1yNoeeuZYQLgPJSGcf0NhFV44wXupQPoE8/vBsE+NUlyviA6w
         2lEw==
X-Gm-Message-State: APjAAAWxhyT2qum/c8qEN1NS7X/ZnrDxTnvNxgyOckAejwDagma1EgVS
        Pl04BCc9NjYRIbE7fC47D0L7QWxHcxf+HBKsbmk=
X-Google-Smtp-Source: APXvYqzi4GjfCDD9m9k7bQbKF/7Y7zsn5hRA1XyrDMnGvfWAh7HOdO1UigTDRAyv6gqZWN7xir9YmAFC87lMnrHHyAo=
X-Received: by 2002:a05:6638:209:: with SMTP id e9mr1374960jaq.22.1556779390573;
 Wed, 01 May 2019 23:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190426164224.11327-1-pawel.mikolaj.chmiel@gmail.com>
 <20190426164224.11327-5-pawel.mikolaj.chmiel@gmail.com> <20190502015408.GA11612@bogus>
 <CA+Ln22HLqnbbY37FG6CwjZvZH7G35Z+0kNq7XFU4WtZyk_EqZQ@mail.gmail.com> <20190502083632.0ec0fb4e@collabora.com>
In-Reply-To: <20190502083632.0ec0fb4e@collabora.com>
From:   Tomasz Figa <tomasz.figa@gmail.com>
Date:   Thu, 2 May 2019 15:42:59 +0900
Message-ID: <CA+Ln22H4ua9Zuh4eKaWfHtqh8DieyiS=5s7wS6-TbmA5Dsop4A@mail.gmail.com>
Subject: Re: [PATCH 4/5] dt-binding: mtd: onenand/samsung: Add device tree support
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        bbrezillon@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        David Woodhouse <dwmw2@infradead.org>,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mtd@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019=E5=B9=B45=E6=9C=882=E6=97=A5(=E6=9C=A8) 15:36 Boris Brezillon <boris.b=
rezillon@collabora.com>:
>
> Hi Tomasz,
>
> On Thu, 2 May 2019 15:23:33 +0900
> Tomasz Figa <tomasz.figa@gmail.com> wrote:
>
> > 2019=E5=B9=B45=E6=9C=882=E6=97=A5(=E6=9C=A8) 10:54 Rob Herring <robh@ke=
rnel.org>:
> > >
> > > On Fri, Apr 26, 2019 at 06:42:23PM +0200, Pawe=C5=82 Chmiel wrote:
> > > > From: Tomasz Figa <tomasz.figa@gmail.com>
> > > >
> > > > This patch adds dt-bindings for Samsung OneNAND driver.
> > > >
> > > > Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> > > > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > > > ---
> > > >  .../bindings/mtd/samsung-onenand.txt          | 46 +++++++++++++++=
++++
> > > >  1 file changed, 46 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/mtd/samsung-o=
nenand.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/mtd/samsung-onenand.=
txt b/Documentation/devicetree/bindings/mtd/samsung-onenand.txt
> > > > new file mode 100644
> > > > index 000000000000..341d97cc1513
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/mtd/samsung-onenand.txt
> > > > @@ -0,0 +1,46 @@
> > > > +Device tree bindings for Samsung SoC OneNAND controller
> > > > +
> > > > +Required properties:
> > > > + - compatible : value should be either of the following.
> > > > +   (a) "samsung,s3c6400-onenand" - for onenand controller compatib=
le with
> > > > +       S3C6400 SoC,
> > > > +   (b) "samsung,s3c6410-onenand" - for onenand controller compatib=
le with
> > > > +       S3C6410 SoC,
> > > > +   (c) "samsung,s5pc100-onenand" - for onenand controller compatib=
le with
> > > > +       S5PC100 SoC,
> > > > +   (d) "samsung,s5pv210-onenand" - for onenand controller compatib=
le with
> > > > +       S5PC110/S5PV210 SoCs.
> > > > +
> > > > + - reg : two memory mapped register regions:
> > > > +   - first entry: control registers.
> > > > +   - second and next entries: memory windows of particular OneNAND=
 chips;
> > > > +     for variants a), b) and c) only one is allowed, in case of d)=
 up to
> > > > +     two chips can be supported.
> > > > +
> > > > + - interrupt-parent : phandle of interrupt controller to which the=
 OneNAND
> > > > +   controller is wired,
> > >
> > > This is implied and can be removed.
> > >
> > > > + - interrupts : specifier of interrupt signal to which the OneNAND=
 controller
> > > > +   is wired; should contain just one entry.
> > > > + - clock-names : should contain two entries:
> > > > +   - "bus" - bus clock of the controller,
> > > > +   - "onenand" - clock supplied to OneNAND memory.
> > >
> > > If the clock just goes to the OneNAND device, then it should be in th=
e
> > > nand device node rather than the controller node.
> > >
> >
> > (Trying hard to recall the details about this hardware.)
> > AFAIR the clock goes to the controller and the controller then feeds
> > it to the memory chips.
> >
> > Also I don't think we should have any nand device nodes here, since
> > the memory itself is only exposed via the controller, which offers
> > various queries to probe the memory at runtime, so there is no need to
> > describe it in DT.
>
> It's probably true, though not providing this controller/device
> separation for NAND controller/devices has proven to be a mistake for
> raw NAND controllers (some props apply to the controllers and others to
> the NAND device, not to mention that some controllers support
> interacting with several chips), so, if that's a new binding, I'd
> recommend having this separation even if it's not strictly required.
>

Note that OneNAND is a totally different thing than the typical NAND
memory with NAND interface. OneNAND chips have a NOR-like interface,
with internal controller and buffers inside, so technically they can
be even used without any special controller on the SoC, via a generic
parallel host interface and possibly some regular DMA engine for CPU
offload.

The controller design of the SoCs in question further abstracts the
OneNAND's programming interface into a number of high level operations
and attempts to hide the details of the underlying memory, so I don't
see the point of describing the memory in DT here, it would actually
defeat the purpose of this controller.

> >
> > > > + - clock: should contain list of phandles and specifiers for all c=
locks listed
> > > > +   in clock-names property.
> > > > + - #address-cells : must be 1,
> > > > + - #size-cells : must be 1.
> > >
> > > This implies some child nodes. What are the child nodes?
> > >
> >
> > I can't recall the reason for this unfortunately.
>
> Defining partitions I guess, but we ask people to use the new
> representation with a 'partitions' sub-node now, so this should
> probably be dropped.

Ah, that could be it indeed. Thanks!

Best regards,
Tomasz
