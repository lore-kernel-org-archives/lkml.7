Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C47C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 06:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD192089E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 06:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQE+pYv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfEBGXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 02:23:45 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44806 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbfEBGXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 02:23:45 -0400
Received: by mail-io1-f67.google.com with SMTP id r71so1052351iod.11;
        Wed, 01 May 2019 23:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZhEnpCiK38dEYBr2uzx8FJBZlmYQCiMhky3F4FoA1gQ=;
        b=BQE+pYv7YdStjjZYwA3VXk0sjcHeVCvkicQKlA2YUgZgPegb7+25JLDs5Sy5rMwvSZ
         OhP6Je0CtJR6DVV/sp1CbcyNrST3IbvYuXboU0plXYtOKxt/GBRpB2raZCZ/7DeBGr0E
         p0CTmS1qUc10v0a1KMkiyKb2H7hapQm3i8gmHmM+rpU2Lkt/YgLnzSoFGrbDUs2P1S80
         UGYb7M8pDZa1EMHMqzLE1cQIHNmpDxlD/+cDlWRHuyQLPjT5NafBgOI7o+pE6eUPZK9E
         WuoTB+yIFScSYctxgzSwrnc5HPuWHn2pzv3nInu4M7MSRKpZPkrj7itDwkNBQTyJW+Mi
         G9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZhEnpCiK38dEYBr2uzx8FJBZlmYQCiMhky3F4FoA1gQ=;
        b=OmmvcH7vyxcHAZFX3KIfGuK9pP7Mbo+5Ew57Apk7G0BD41syCFOgRprM38OZz8+QOP
         UkU3QaDNkqpyDzJENXJmJp1rmFHAiHicyonV3Yyp11rn7OjNbgw6ceuwqU/1cMYXRtJb
         YrccGuk5ag21id2bl7tnFiGl3iBMvk83NI9nwXU9yT56NNlMfmO6yKe8ySaTDtrt8zin
         bp4syU8Px4hmhTohxru4HRh4Or+Zw/lLIRhbGGr3LmFzpHMxuzBpeYvkhbhhny0XasBx
         KhT96FDyTXJltdc0yBDF+aXXXPWvtxUI3dwjEcaWFjLaOY8OnDo7HCnWt1vY91fw2ACO
         fexw==
X-Gm-Message-State: APjAAAX5YYw4nvZQOAgiGmGvv+VzmSNH8SKg8eFvgh1XdijalfJx3wbB
        sSrwmd9SOP4weHTHoSVBLF+laNMxNEKStH/gFW8=
X-Google-Smtp-Source: APXvYqxoAwhRx+e3Wq+/p+L/aiuaPbf2PkVB26huHmGBGPw0izOihcwI/g4G+h/PSSTN0vAD/uVmLCKioGLA6a5P0GI=
X-Received: by 2002:a05:6602:12:: with SMTP id b18mr1290631ioa.224.1556778224306;
 Wed, 01 May 2019 23:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190426164224.11327-1-pawel.mikolaj.chmiel@gmail.com>
 <20190426164224.11327-5-pawel.mikolaj.chmiel@gmail.com> <20190502015408.GA11612@bogus>
In-Reply-To: <20190502015408.GA11612@bogus>
From:   Tomasz Figa <tomasz.figa@gmail.com>
Date:   Thu, 2 May 2019 15:23:33 +0900
Message-ID: <CA+Ln22HLqnbbY37FG6CwjZvZH7G35Z+0kNq7XFU4WtZyk_EqZQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] dt-binding: mtd: onenand/samsung: Add device tree support
To:     Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
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

2019=E5=B9=B45=E6=9C=882=E6=97=A5(=E6=9C=A8) 10:54 Rob Herring <robh@kernel=
.org>:
>
> On Fri, Apr 26, 2019 at 06:42:23PM +0200, Pawe=C5=82 Chmiel wrote:
> > From: Tomasz Figa <tomasz.figa@gmail.com>
> >
> > This patch adds dt-bindings for Samsung OneNAND driver.
> >
> > Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> >  .../bindings/mtd/samsung-onenand.txt          | 46 +++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/samsung-onena=
nd.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/samsung-onenand.txt =
b/Documentation/devicetree/bindings/mtd/samsung-onenand.txt
> > new file mode 100644
> > index 000000000000..341d97cc1513
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/samsung-onenand.txt
> > @@ -0,0 +1,46 @@
> > +Device tree bindings for Samsung SoC OneNAND controller
> > +
> > +Required properties:
> > + - compatible : value should be either of the following.
> > +   (a) "samsung,s3c6400-onenand" - for onenand controller compatible w=
ith
> > +       S3C6400 SoC,
> > +   (b) "samsung,s3c6410-onenand" - for onenand controller compatible w=
ith
> > +       S3C6410 SoC,
> > +   (c) "samsung,s5pc100-onenand" - for onenand controller compatible w=
ith
> > +       S5PC100 SoC,
> > +   (d) "samsung,s5pv210-onenand" - for onenand controller compatible w=
ith
> > +       S5PC110/S5PV210 SoCs.
> > +
> > + - reg : two memory mapped register regions:
> > +   - first entry: control registers.
> > +   - second and next entries: memory windows of particular OneNAND chi=
ps;
> > +     for variants a), b) and c) only one is allowed, in case of d) up =
to
> > +     two chips can be supported.
> > +
> > + - interrupt-parent : phandle of interrupt controller to which the One=
NAND
> > +   controller is wired,
>
> This is implied and can be removed.
>
> > + - interrupts : specifier of interrupt signal to which the OneNAND con=
troller
> > +   is wired; should contain just one entry.
> > + - clock-names : should contain two entries:
> > +   - "bus" - bus clock of the controller,
> > +   - "onenand" - clock supplied to OneNAND memory.
>
> If the clock just goes to the OneNAND device, then it should be in the
> nand device node rather than the controller node.
>

(Trying hard to recall the details about this hardware.)
AFAIR the clock goes to the controller and the controller then feeds
it to the memory chips.

Also I don't think we should have any nand device nodes here, since
the memory itself is only exposed via the controller, which offers
various queries to probe the memory at runtime, so there is no need to
describe it in DT.

> > + - clock: should contain list of phandles and specifiers for all clock=
s listed
> > +   in clock-names property.
> > + - #address-cells : must be 1,
> > + - #size-cells : must be 1.
>
> This implies some child nodes. What are the child nodes?
>

I can't recall the reason for this unfortunately.

Best regards,
Tomasz
