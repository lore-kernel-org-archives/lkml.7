Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF530C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C4D2073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575355276;
	bh=+7fslhszV7K2Omo1jDYceinaZZe39tXZaFis9U579jA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xexgnUPoAM/d447Tzy8iX+r1ZUvDITFyIQu/ANRoL2hTuJ7HBHD0FIyB/8xrszvoI
	 HcKzTUretyASrdX4EG53PZ+IDob2CzDCpMgXSTgYeP9IHfIoTHnuJoLqi0lpu5PPqi
	 TrX7yQzj8vMZZn9n6FQWtK36G02b23bnZEkgjlfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfLCGlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 01:41:15 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:34232 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfLCGlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 01:41:14 -0500
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id xB36emIw001528
        for <linux-kernel@vger.kernel.org>; Tue, 3 Dec 2019 15:40:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com xB36emIw001528
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1575355249;
        bh=GmXrWvhOttxlHCjX9wBisNRIMAo1vtJVcSCFg0ZfW/E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eQfEAHxN/nyufxxHjUgeAqfUWRF9N56N6laRBYIa9ZUPDx+oXOlkXeU7KxqPwuQzo
         pSrn1TZMHRowWTRqGBXYN2AANUfHl5vYyyXnnkfQLRj/UxYbQwcUe06/pcP9/5pI/v
         jCYcFWZHB5NA8Jj9QXLSGDVJNjzwRalDB/SROx4QLfA7fv7qX7qGIEkO6305O9AtVz
         86nMvnH5KzB0HRgM40Dp+axd9d+ayIRZ2zLK0fjXKD2wK0L+uwCgFIJwUtLd8RxoEu
         t9I8bNCFI0J635yawOfhmbAUpYhg+5dsS7/vMhZkkznnSQHOftcRL7E3CtYtHdccrf
         mR12BCMLCqmMg==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id d6so908180uam.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 22:40:48 -0800 (PST)
X-Gm-Message-State: APjAAAWvtsV5lUEfWhOz+gfXXsgg7XzwcXp/CDgoxwItCfqSml1lvxir
        Vto1yWeXTsDR4ea4jFgoqciB0tsaqAU5HUXCx94=
X-Google-Smtp-Source: APXvYqwRi6dH3+fcClvqz37Ap3nH0SRDXHHJ5azuwG10OEJ40DOOd6/KUMOAaiwkuJFBpVyZafygaqHFxR9pXXHM82Y=
X-Received: by 2002:ab0:6418:: with SMTP id x24mr2561736uao.40.1575355247780;
 Mon, 02 Dec 2019 22:40:47 -0800 (PST)
MIME-Version: 1.0
References: <1575001159-19648-1-git-send-email-hayashi.kunihiko@socionext.com>
 <12f11e521a41d9f1e0e916fcbe413f6d0390bb3c.camel@pengutronix.de> <20191203151149.52A8.4A936039@socionext.com>
In-Reply-To: <20191203151149.52A8.4A936039@socionext.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 3 Dec 2019 15:40:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQvsw-bgXm5u-z0gtSZ078RvPFU10yqyhBRi2Oaq4bqdA@mail.gmail.com>
Message-ID: <CAK7LNAQvsw-bgXm5u-z0gtSZ078RvPFU10yqyhBRi2Oaq4bqdA@mail.gmail.com>
Subject: Re: [PATCH] reset: uniphier: Add SCSSI reset control for each channel
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 3:14 PM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> Hi Philipp,
>
> On Mon, 2 Dec 2019 14:06:20 +0100 <p.zabel@pengutronix.de> wrote:
>
> > On Fri, 2019-11-29 at 13:19 +0900, Kunihiko Hayashi wrote:
> > > SCSSI has reset controls for each channel in the SoCs newer than Pro4,
> > > so this adds missing reset controls for channel 1, 2 and 3. And more, this
> > > moves MCSSI reset ID after SCSSI.
> >
> > Just to be sure, there are no device trees in circulation that already
> > use the MCSSI reset?
>
> Yes, currently no device trees refer to MCSSI reset,
> so I think MCSSI reset ID can be moved.
>
> Thank you,
>
> ---
> Best Regards,
> Kunihiko Hayashi
>


Fixes: 6b39fd590aeb ("reset: uniphier: add reset control support for SPI")

Assuming you tested it this time,
Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>




-- 
Best Regards
Masahiro Yamada
