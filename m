Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F91C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FEC2175B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbfGAPCK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 11:02:10 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39988 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbfGAPCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 11:02:10 -0400
Received: by mail-qt1-f196.google.com with SMTP id a15so14943426qtn.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 08:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fq004zebmgtTzmnwbWXTcWPMH7zP0e/OuuIiaISYIRI=;
        b=Ki8ZHLhSYvH7jBJ/YOLJPzmSgyLCa6ky2QP2VyUvDVE0R5YX47T9EtUYL3caIHxo2u
         7l82LNiit4xYGk3b0i8MNrJhB2hfwLBlTHeHfwgFiElUBYN3y8exzQ3XuL3xkONAnayo
         a2TLA+fwpe9yru4LQob9Il/QvpiRuJL2eTHqCSBRxiZyv1Y3eO3KVIDjxiCVN6h2d9bo
         XletR39GGkE3P+D+TtWiso1hHJRJ/ns1t/1EUlfsD1e93Mlc6zez1lTN2GFry8Y7JES8
         iL/K+qYY4qIlmGUbNV1vaC/jxCFHb8XqepAM7bZ7qmWuMjfs+vsTl5m/LeTj1SmpFq81
         tPhQ==
X-Gm-Message-State: APjAAAVYL0eiM6EmBuR/PkcVblsokbzy0zavxhb+Tvqctt+Pv7iY1Srj
        R2H5N+fORA4nRcVYPPRJObGpTajqDj2qbMeTp8ZGqsPa
X-Google-Smtp-Source: APXvYqz8wuFavBSHd4/mfaUyYtg+NKCI8hh7m6mnAhjCIO6aC5Ab5xB+rwLaf3yLQWe9nTm0/W7OWAhICNYCBc0LL/Q=
X-Received: by 2002:aed:2bc1:: with SMTP id e59mr20866803qtd.7.1561993328905;
 Mon, 01 Jul 2019 08:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190617111110.2103786-1-arnd@arndb.de> <1560770644.1774.0@crapouillou.net>
 <CAK8P3a28NrvLP1nE7TQUCqwYXVwrSnVUJoH0yTSqRpz93f4g2Q@mail.gmail.com>
 <20190617141659.376c0271@xps13> <20190627184047.6faa058a@xps13> <1561751588.1914.0@crapouillou.net>
In-Reply-To: <1561751588.1914.0@crapouillou.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 1 Jul 2019 17:01:52 +0200
Message-ID: <CAK8P3a3sa16_zx-otkH8KrZFhOqKP_mx0vFrLyhPjPD3exeptg@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: ingenic: fix ingenic_ecc dependency
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 9:53 PM Paul Cercueil <paul@crapouillou.net> wrote:
> Le jeu. 27 juin 2019 à 18:40, Miquel Raynal
> <miquel.raynal@bootlin.com> a écrit :

> > Miquel Raynal <miquel.raynal@bootlin.com> wrote on Mon, 17 Jun 2019
> > 14:16:59 +0200:
> >>  I personally have a preference for this one.
> >
> > Would you mind sending the above change? I forgot about it but I would
> > like to queue it for the next release. Preferably the last version
> > Arnd
> > proposed.
>
> It does change the module name from 'ingenic_nand' to 'jz4780_nand',
> though.
> That's not really ideal...

Any other suggestion for the name? If the module keeps getting called
ingeneric_nand.ko, then the source file has to get renamed to something
else instead.

      Arnd
