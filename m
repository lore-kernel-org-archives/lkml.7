Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BDDC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C159E20815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RbjLMkPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfEPOrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:47:46 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35200 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEPOrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:47:46 -0400
Received: by mail-lj1-f195.google.com with SMTP id h11so2011645ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 07:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f+AY9FGToF7XfqxomfQs9FiHIqAX8dYewdybhmeUoTA=;
        b=RbjLMkPZ/l16ccEaNtAkER7DjD5jYPDaLczLmzyh01O3rbUJDI7XLPByf3snj4wnW0
         /76OSaLm1g6x/DBvxSOlNwwxYL1ULO2QwoRV3hEsQvtaG4B19CEMo20TWT9wgsS8rgum
         BScXFRwbSRFVEFH1JXOuePQxZsiabMWvw784Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f+AY9FGToF7XfqxomfQs9FiHIqAX8dYewdybhmeUoTA=;
        b=mm+oLZ/tlx99ZrcVCueNaTCEEEH2sQfeAZpz6wvdsIKtni8OZBGWRrXg5C7TW/F5vs
         7KakG916ZyXSabn1UchPlTmEZf4eyqrDsgkHHLLF3+qI38kk/fqjZAtKcvBS1qbkoQox
         2TXJpbJYNntcqY97EwzJArC4fDT+J5BbDs0p86NgsPQKAFXX71mlZYzbeL/t9h5NxDSD
         6tqtt2sXZYeUN/SVOcgtrvvlEW3cgNOrMyaIzJXvP1MhTGIop4zTlXcT9gqONXq2HEJj
         1kAQdOtySKs1xnwCxAA9j00L9YCO0NmOkM6XEf62tCGqOZd3oFlkLeo/etOl9NdsJFl8
         /ejQ==
X-Gm-Message-State: APjAAAVFa9F3a3hdRZeqMUmE0Rw4mEBWBNC0G/sgHpS1tIOnd/X9hABj
        Hwyp1HYi+aLvoTtHec18DbJmLaFKieyk45ym8KopYw==
X-Google-Smtp-Source: APXvYqw0hDatqMLJ9zbTJnhnTT5oC+AytbihhJlbtmmhC0PCFw0n+jOkJep+hdoIObkawWGwDm8yCxILLdub7+DGlhc=
X-Received: by 2002:a2e:9bd2:: with SMTP id w18mr554571ljj.120.1558018064453;
 Thu, 16 May 2019 07:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <1556733121-20133-1-git-send-email-kdasu.kdev@gmail.com> <CAFLxGvy7B2K2AX0nSe549QF-gDMZcc5F4X0Y+yzRrnYfL9svEw@mail.gmail.com>
In-Reply-To: <CAFLxGvy7B2K2AX0nSe549QF-gDMZcc5F4X0Y+yzRrnYfL9svEw@mail.gmail.com>
From:   Kamal Dasu <kamal.dasu@broadcom.com>
Date:   Thu, 16 May 2019 10:47:07 -0400
Message-ID: <CAKekbeskaF90QecqArSd8xgsU3zpBMndeo3fbevRjUZRu=ZkMA@mail.gmail.com>
Subject: Re: [PATCH] mtd: nand: raw: brcmnand: When oops in progress use pio
 and interrupt polling
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        LKML <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 12:01 PM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> On Wed, May 1, 2019 at 7:52 PM Kamal Dasu <kdasu.kdev@gmail.com> wrote:
> >
> > If mtd_oops is in progress switch to polling for nand command completion
> > interrupts and use PIO mode wihtout DMA so that the mtd_oops buffer can
> > be completely written in the assinged nand partition. This is needed in
> > cases where the panic does not happen on cpu0 and there is only one online
> > CPU and the panic is not on cpu0.
>
> This optimization is highly specific to your hardware and AFAIK cannot
> be applied
> in general to brcmnand.
>
> So the problem you see is that depending on the oops you can no longer use dma
> or interrupts in the driver?
>
> How about adding a new flag to panic_nand_write() which tells the nand
> driver that
> this is a panic write?
> That way you can fall back to pio and polling mode without checking cpu numbers
> and oops_in_progress.
>

Thanks for your review  Richard. Will add flag to let low level
controller drivers know that that its a panic_write and make brcmnand
code more generic and simply fallback to pio and polling in such a
case. Will send a V2 patch with these recommended changes.

Thanks
Kamal

> --
> Thanks,
> //richard
