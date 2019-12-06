Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77257C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F9D24685
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="fCADfeHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfLFIFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 03:05:00 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:31900 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfLFIE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 03:04:59 -0500
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id xB684ujw021333;
        Fri, 6 Dec 2019 17:04:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com xB684ujw021333
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1575619496;
        bh=5HkglI0EKjnLXCnlt94Q9XbXoUC156pTW0gJif8WsLM=;
        h=From:Date:Subject:To:Cc:From;
        b=fCADfeHV0pHWJfJJZReqYgrFWALqlNHJo4mhghcMnzY+qcFsW7i/T3WSK24ScT7Iy
         dLN32NZkjERwIWiqpD6nV2aZduYg5CKr6dFWewRNvdMoKtHqrCqTwfUED1D4AQZa8r
         +7zCdPbukVAygKyeaw31rJ+shCyWECyp1dsqKEqrtxgbb1WNCElPVs779xujmQ9G1Y
         Q1fmoVO+I2KiZB3CGAtSgqGHUy0+T7zSCSqT20VzTKJ46qnaIn7575Cmltlu9kfuSX
         Ltq8puz7u/G4nFsErrsyaLCPMonLBx9naBmnwBYdaOS3E0NjNUN7Bxfv+J6LxXZD9y
         9uRI4N4PwMCdg==
X-Nifty-SrcIP: [209.85.222.54]
Received: by mail-ua1-f54.google.com with SMTP id f7so2464123uaa.8;
        Fri, 06 Dec 2019 00:04:56 -0800 (PST)
X-Gm-Message-State: APjAAAWo2ND7LJG/OUHYzSHyEO5OPsPx5RUSI6ibhFjGOVhmRJpjKg1z
        1kqQqT83wNvxagVB96pJPKic0L6I7gFGW592pmM=
X-Google-Smtp-Source: APXvYqy3+OU+tXwm9mApi3095nPuMim4hayi3qQUxbwWEblDDMPQ+2LojXhJOLXlE5A6bcurl/xkESk2ulBMZ17+6e4=
X-Received: by 2002:ab0:3487:: with SMTP id c7mr9347188uar.25.1575619495354;
 Fri, 06 Dec 2019 00:04:55 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 6 Dec 2019 17:04:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ29tXAFZaYODFyd4iAx9UhyjhyEtXxk+ZC+yUtXsqMMQ@mail.gmail.com>
Message-ID: <CAK7LNAQ29tXAFZaYODFyd4iAx9UhyjhyEtXxk+ZC+yUtXsqMMQ@mail.gmail.com>
Subject: About DT binding of reset control
To:     Rob Herring <robh+dt@kernel.org>, DTML <devicetree@vger.kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Rob, DT folks,

I am trying to add the reset control into
the Denali NAND controller driver:
Documentation/devicetree/bindings/mtd/denali-nand.txt
drivers/mtd/nand/raw/denali_dt.c

I'd like to get some advice about the DT binding
before the detailed implementation.



The IP datasheet clearly says
two separate reset lines, like this:

rst_n :           controller core reset
reg_rst_n:     register flip-flop reset


But, in actual SoC integration,
the two reset signals are often tied up together, and
the reset controller only provides 1-bit control.

(The upstream platforms, SoCFPGA, UniPhier,
 both are this case.)


In this case, which is more preferred for the
DT binding?


[1] Define two resets explicitly according to the IP spec

Optional properties:
  reset-names :  contain "nand", "reg"
  resets: phandles to the controller core reset, the register reset

Example:

   nand {
         ....
         reset-names = "nand", "reg";
         resets = <&nand_rst>, <&nand_rst>;
         ...
   };



[2] Allow arbitrary number of reset lines


Optional properties:
     resets: phandle(s) to reset(s)

   The number of reset lines is SoC-dependent.


Examples:

      nand {

               resets = <&nand>;
                ...
       };





I guess [1] is more precise as the hardware specification.
But, DT files will end up with giving the same phandle
to both of the two resets.
I think it is OK, but anyway better to ask
before proceeding.

Thanks.

--
Best Regards
Masahiro Yamada
