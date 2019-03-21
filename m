Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBB9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B94E218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="a07YkhAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfCUTsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 15:48:47 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38705 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbfCUTsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 15:48:46 -0400
Received: by mail-oi1-f195.google.com with SMTP id w137so5612277oiw.5;
        Thu, 21 Mar 2019 12:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5zcWU2dTLuAsgRn/uaCWzV93GDxkM/l9+qmdryQUun4=;
        b=a07YkhAS3QDm+zZApgI0JQFpYazXYES4DeY36RKnfRsB7vhGXdxt/1g+XHEWWO4pRP
         psGhf65geakQWJyOrs6JbEMyUcIGTx/dRFYqqnTwJTgW5TjdmNfl21NJDG5lSxZP5Fzb
         3lUNCyFxc19TIcry3xz0h0ntpdIGDPElhwmLxG9eVR8wDRwjjQp9Bv8szPbgbjqszdAw
         OTaVd8bKBBKkF545L+zmkaWN0s+JNb2XNtvS/iL/9zu9/UvMtJigTLgsxG1YIfai42MO
         YXpt/va1gYeqhNvR497pGVcwPPpzoH1/YZaGGv11dMpeqmjmSxFDxQRDwpy4/65OwwxY
         x5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5zcWU2dTLuAsgRn/uaCWzV93GDxkM/l9+qmdryQUun4=;
        b=QFb88hLo60EFLaRlfXWYkN5A8h1QcDtoN9dJE4qZUKYGjyHtJaGu45oOL6GgMdA/+N
         CaXC0I2+yAMF8D7uELZ8pGLSnRWhoeN1EKEiUTaUuZqIZXYYcfqwO6gasE8aH16dgRGA
         6E9pz7cYel2nePfCmBsSygeViwKK5XMVji/hREVwyRu3NDTOUXRrNaIwLpchQx7IFKU6
         NS1NYGkQw37SpgtGfE6gB/BnVM7oRv1PNdFHP0Elys2/HSuJFXAdQP3kKO84bGeJ9nVe
         wesCYUIeqH7OqefKLXw9pPpmncKl8rgIAlKG4PKszXdsUwGafXd99n955eUaomqwGWGK
         6jYA==
X-Gm-Message-State: APjAAAW2EU2zzWPrzM8GkzYvtw9mExWRRkGRJ3aixQdc4sfNlaAeq4Rv
        DxVDFjn5VPKDyGQg0aHb5sA0Ne+qYSfrblBDJBs=
X-Google-Smtp-Source: APXvYqw8cxN35ECNqg92hsr7x3jP3Ry906VaP5u+ReWx8iRv0dqXSon10OTu2dRKboRYnxFDs7LSIn8boqYnzZ/GbbM=
X-Received: by 2002:aca:6209:: with SMTP id w9mr789176oib.47.1553197725400;
 Thu, 21 Mar 2019 12:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <1553170441-23448-1-git-send-email-liang.yang@amlogic.com>
In-Reply-To: <1553170441-23448-1-git-send-email-liang.yang@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 21 Mar 2019 20:48:34 +0100
Message-ID: <CAFBinCD65-e2Kx3vw60FGFJvauof7ADV3e=bt6A4jUNC0K64Ng@mail.gmail.com>
Subject: Re: [PATCH 1/1] mtd: rawnand: meson: set oob layout ops
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 1:14 PM Liang Yang <liang.yang@amlogic.com> wrote:
>
> Specify the oob layout operation to avoid no oob scheme defined for
> some nand flash.
>
> Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
this patch solves the "No oob scheme defined for oobsize 1280" on my
Meson8m2 M8S board, so:
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

to give a bit of context on my Tested-by:
I tested this with my work-in-progress series and a hack to make the
kzalloc() in meson_nfc_read_buf() return an aligned address (by
allocating PAGE_SIZE instead of PER_INFO_BYTE) on my Meson8m2 M8S
board.
it's now progressing to the state where Linux tries to find the BBT
which it can't (because the vendor kernel which was used to format the
NAND flash is shipping a custom BBT format).
before this patch I couldn't get past the "No oob scheme defined for
oobsize 1280" error.


Regards
Martin
