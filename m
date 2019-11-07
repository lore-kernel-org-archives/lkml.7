Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E199FC6197
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7692166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHfIIwuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387789AbfKGJZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:25:46 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33075 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfKGJZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:25:46 -0500
Received: by mail-ot1-f65.google.com with SMTP id u13so1443448ote.0;
        Thu, 07 Nov 2019 01:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U8p26XYqH5TPqHeQad7U65Znhq7tW+I3xCdiHZkPSpw=;
        b=QHfIIwuD2yv6I76g8JQ2D3pTFBro5Jhl/JMGULBBB3QmkDldjRx8CNGkL31TzAll6b
         7TH0ng15f4+P1S53c69OJTrUGN5DKrZNCO/hNdEiuGf8E9akHxAu1UUgCV33PMhyipjK
         wqqP7AVEBCrNUYL+rxd2BEmDqFEXCKjVD3QieWTN5PwpxJJZUvy8+7QX2n5PnVAmOjyZ
         qyjjtFO+GELGo1jcBkXENU3vVcVOTlGAouLwupNRtg7i6iaqw1YKIiN5eTjIHfwNWmj/
         DSVz7qYjs4qHromtabMMTi8NHJB4CG/9hJC/gI1kS8VbG5fznQRTrKhM+fCeU5R0f8RB
         FP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8p26XYqH5TPqHeQad7U65Znhq7tW+I3xCdiHZkPSpw=;
        b=glaSilsWVl26zXCBCx50dhZA8RVejdbG1nHly8lG7i87FqZLJaOLPMdw7qEHs6raf2
         l0ZzTCfsWSwm3rKDV6n11+XaOa/BGm9QzMudMz6Qf4biVK6w4auPk0v1/Xgilv4/1fWa
         gaKbyzDNgHE86sr5z381rDfYms2pXXXLbLH6c1YMSij0UNp32FOtunm0wIUfa16nOGcT
         i+Gy2GkiULmAWm5sgh0ckjLFTd16Gl4srOLoto7IBrKaZueNqglJwPqKe5wrnJh9g2+P
         UEWKxQSL91A0XbsN2gvYR2feK8sLF6DVTYVKCOTwUoXUyHv186qF0uJmFi55/BZFXREr
         tAQA==
X-Gm-Message-State: APjAAAUP7/zozF2ESYq6zFEr7ctTJxE4L0cM/5dzVsvEUMA+ZWav02a4
        +G613muWmdsxIw8TL0TRLq3GimiDOZZeBDtXMfeYs3en
X-Google-Smtp-Source: APXvYqytqNiv5noMGnzCkM3rhghUIUChzKwN8or6v9tCbNWgAONdjfZGD/sKd5quAzzGMSJy96OxTz6jDoGYY1aFd9Q=
X-Received: by 2002:a9d:1b0d:: with SMTP id l13mr171271otl.84.1573118743606;
 Thu, 07 Nov 2019 01:25:43 -0800 (PST)
MIME-Version: 1.0
References: <20191106140748.13100-1-gch981213@gmail.com> <20191106140748.13100-3-gch981213@gmail.com>
 <20191107010928.GA14186@bogus>
In-Reply-To: <20191107010928.GA14186@bogus>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Thu, 7 Nov 2019 17:25:32 +0800
Message-ID: <CAJsYDV+M4kH5aCcJxxLB7UMhT7VsRXJW+RYcykHMTZW+1ftC9w@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: mtd: mtk-quadspi: update bindings for
 mmap flash read
To:     Rob Herring <robh@kernel.org>
Cc:     linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, Nov 7, 2019 at 9:09 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Nov 06, 2019 at 10:07:48PM +0800, Chuanhong Guo wrote:
> > update register descriptions and add an example binding using it.
> >
> > Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> > ---
> >  .../devicetree/bindings/mtd/mtk-quadspi.txt   | 21 ++++++++++++++++++-
> >  1 file changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> > index a12e3b5c495d..4860f6e96f5a 100644
> > --- a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> > +++ b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
> > @@ -12,7 +12,10 @@ Required properties:
> >                 "mediatek,mt7623-nor", "mediatek,mt8173-nor"
> >                 "mediatek,mt7629-nor", "mediatek,mt8173-nor"
> >                 "mediatek,mt8173-nor"
> > -- reg:                 physical base address and length of the controller's register
> > +- reg:                 Contains one or two entries, each of which is a tuple consisting of a
> > +               physical address and length. The first entry is the address and length
> > +               of the controller register set. The optional second entry is the address
> > +               and length of the area where the nor flash is mapped to.
>
> All the compatibles support 2 entries? If not, which ones?

It should be. I implemented it as an optional feature only because I
don't know the mapped address space for all these chips and can't
update every device trees.

Regards,
Chuanhong Guo
