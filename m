Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0046C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A841A206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfCMVCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:02:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42352 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfCMVCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:02:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id u7so3645355qtg.9;
        Wed, 13 Mar 2019 14:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hcVB9ZPQVNAh3hkhw8BED7HrVmjyGMC9sq93d0ay0fU=;
        b=nmxGBPph4ZBQXjewmxIe6tShB6w1hkAqcpTQiXEcX+nmICXxRaTXLMP8mnfLUYliog
         T76qBRg1rffGkf2l3K+gOyFLubXOVQEVaw6Fh5IzJPB0CVOwKPmnsbblR0U8+GEwHHJL
         OyKdE3gtmNQS6XbjKWcPaEcWZHyxZ6a76cpjFagSnMUWiIq3r+BcfsHnTVKE7/SPR19o
         Ra5q7U4aR+Eq+O1MHgoX9H049sm1xh2cXxwrpk2Zqrm4UAU0ILbMuUx/onJBZjpD7cHD
         WgUpbtZxSAOPim5iJdim1YbY80gnjTHrMGlj78tMyg/mfQOyTL3l+lzrzLPyTk2mHdjp
         uw2A==
X-Gm-Message-State: APjAAAVOCgFYjJ++WQ8PnXyu6/FK5l2S2w67niwDusJG5Pw8mGTC9LK6
        jE5ZQuwDF9cxgLIFcnTA4EkVMaJVj6rrGlR345c=
X-Google-Smtp-Source: APXvYqxdKgcChKQF3tKar3zzPhcyqSAwjZRX2+1wwh273jZmdwFL/CZAATjJ3ZmtUV6GijQptYkIWo5jP83gL6tsxfo=
X-Received: by 2002:ac8:1e17:: with SMTP id n23mr14285545qtl.152.1552510922858;
 Wed, 13 Mar 2019 14:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190307155506.2993868-1-arnd@arndb.de> <20190311172421.275811128896@debutante.sirena.org.uk>
 <CAMuHMdXeuHwF2y1S=bpvQ_qXn+DYacUSS-uP2Zj9yKiHzghhqQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXeuHwF2y1S=bpvQ_qXn+DYacUSS-uP2Zj9yKiHzghhqQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Mar 2019 22:01:46 +0100
Message-ID: <CAK8P3a3UDhJLh9o1A-EEouP58L9H_uZO=e8L0JZsmGToQH0dAQ@mail.gmail.com>
Subject: Re: Applied "spi: work around clang bug in SPI_BPW_RANGE_MASK()" to
 the spi tree
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 8:15 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> > -#define SPI_BIT_MASK(bits) (((bits) == 32) ? ~0U : (BIT(bits) - 1))
> > -#define SPI_BPW_RANGE_MASK(min, max) (SPI_BIT_MASK(max) - SPI_BIT_MASK(min - 1))
> > +#define SPI_BPW_RANGE_MASK(min, max) GENMASK((min) - 1, (max) - 1)
>
> This is not correct: GENMASK() order is from msb to lsb.
> So it should it:
>
> +#define SPI_BPW_RANGE_MASK(min, max) GENMASK((max) - 1, (min) - 1)

Sorry about the mess, I've sent a fixup now.

       Arnd
