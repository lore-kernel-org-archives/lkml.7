Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F05CC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6992084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfFQMNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:13:07 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46631 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFQMNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:13:07 -0400
Received: by mail-qt1-f196.google.com with SMTP id h21so10291427qtn.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 05:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PjXXRz5jYVZd3qCDenzBwlj9PiRYwfU0XHUt+TN6Glw=;
        b=jjvU2Nlcl/BrMJE/uDgK/W6xDsq0s0glSuZWHDuOu31w6jbQkoUk+e04977EcShysP
         tzNgqRWw/Eik7dfebkDj1A/S32xPmRDcnDG7orG3+EHoVTPmgBX11aelQmRBp802W3tZ
         PDTjoUvm7MNxnxVHVGXtI0qJsB5xVY3o5imNDuVEYkCQ1Tf+6hQNSj1E1+XpVnm5rnnT
         zzu7rjbtICeg0xC7K9mwNIEVRAnJdf7VQ2jZ+GFuMi6ZYhbvRTHvn/m2hXddUK/W0h4Y
         uxCZZV6qt6UL6OPKPH9bixB9qFCV047nXzpGTBXYegjsPwEBRVsURSxrUoMlA3/ESOR9
         jp2w==
X-Gm-Message-State: APjAAAUNYsUjnLN1ADrC2Y2aTwlQHFZYsPJYpG5cILq1TxX7wr6x9wa7
        YXytoeDkT8sxK33eMoK0/X0+M80tRi7qXffy3Vw=
X-Google-Smtp-Source: APXvYqxndSVnNHlL+RyfC6xL5ZB+R7JYlnaPpJzde64TsayAdYnpDAGSwR/DHJMRVgWmalLzoXslfJHDmsbKAGqFZsQ=
X-Received: by 2002:ac8:8dd:: with SMTP id y29mr28170568qth.304.1560773586412;
 Mon, 17 Jun 2019 05:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190617111110.2103786-1-arnd@arndb.de> <1560770644.1774.0@crapouillou.net>
In-Reply-To: <1560770644.1774.0@crapouillou.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 17 Jun 2019 14:12:48 +0200
Message-ID: <CAK8P3a28NrvLP1nE7TQUCqwYXVwrSnVUJoH0yTSqRpz93f4g2Q@mail.gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 1:24 PM Paul Cercueil <paul@crapouillou.net> wrote:

> I think there's a better way to fix it, only in Kconfig.
>
> * Add a bool symbol MTD_NAND_INGENIC_USE_HW_ECC
> * Have the three ECC/BCH drivers select this symbol instead of
>   MTD_NAND_INGENIC_ECC
> * Add the following to the MTD_NAND_JZ4780 config option:
>   "select MTD_NAND_INGENIC_ECC if MTD_NAND_INGENIC_USE_HW_ECC"

I don't see much difference to my approach here, but if you want
to submit that version with 'Reported-by: Arnd Bergmann <arnd@arndb.de>',
please do so.

Yet another option would be to use Makefile code to link both
files into one module, and remove the EXPORT_SYMBOL statements:

obj-$(CONFIG_MTD_NAND_JZ4780) += jz4780_nand.o
jz4780_nand-y += ingenic_nand.o
jz4780_nand-$(CONFIG_MTD_NAND_INGENIC_ECC) += ingenic_ecc.o

        Arnd
