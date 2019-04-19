Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4D7C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89A82171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfDSUCh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:02:37 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:53232 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfDSUCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:02:37 -0400
X-Greylist: delayed 4785 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Apr 2019 16:02:35 EDT
Received: from relay7-d.mail.gandi.net (unknown [217.70.183.200])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 08C973AC227
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 09:00:50 +0000 (UTC)
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id A093720011;
        Fri, 19 Apr 2019 09:00:46 +0000 (UTC)
Date:   Fri, 19 Apr 2019 11:00:44 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        linux-amlogic@lists.infradead.org, linux-mtd@lists.infradead.org,
        richard@nod.at, linux-arm-kernel@lists.infradead.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        bbrezillon@kernel.org, jianxin.pan@amlogic.com
Subject: Re: [PATCH 4/4] mtd: rawnand: meson: only initialize the RB
 completion once
Message-ID: <20190419110044.6a2d7d86@xps13>
In-Reply-To: <CAFBinCB9Z_H4wX3_g2hVL-XnS6Oq-KtPHa4Z1ws79FGp5jCapQ@mail.gmail.com>
References: <20190411220056.19109-1-martin.blumenstingl@googlemail.com>
        <20190411220056.19109-5-martin.blumenstingl@googlemail.com>
        <bd1900db-7ca1-a6e5-39f9-db54e0b570dd@amlogic.com>
        <CAFBinCB9Z_H4wX3_g2hVL-XnS6Oq-KtPHa4Z1ws79FGp5jCapQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote on Thu,
18 Apr 2019 21:44:05 +0200:

> Hi Liang,
> 
> On Mon, Apr 15, 2019 at 8:04 AM Liang Yang <liang.yang@amlogic.com> wrote:
> >
> >
> > On 2019/4/12 6:00, Martin Blumenstingl wrote:  
> > > Documentation/scheduler/completion.txt states:
> > >    Calling init_completion() on the same completion object twice is
> > >    most likely a bug as it re-initializes the queue to an empty queue and
> > >    enqueued tasks could get "lost" - use reinit_completion() in that case,
> > >    but be aware of other races.
> > >
> > > Initialize nfc->completion in meson_nfc_probe using init_completion and
> > > change the call in meson_nfc_queue_rb to reinit_completion so the logic
> > > matches what the documentation suggests.
> > >
> > > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > > ---
> > >   drivers/mtd/nand/raw/meson_nand.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> > > index 57cc4bd3f665..ea57ddcec41e 100644
> > > --- a/drivers/mtd/nand/raw/meson_nand.c
> > > +++ b/drivers/mtd/nand/raw/meson_nand.c
> > > @@ -400,7 +400,7 @@ static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
> > >       cfg |= NFC_RB_IRQ_EN;
> > >       writel(cfg, nfc->reg_base + NFC_REG_CFG);
> > >
> > > -     init_completion(&nfc->completion);
> > > +     reinit_completion(&nfc->completion);  
> > Tested-by:Liang Yang <liang.yang@amlogic.com>
> > Acked-by: Liang Yang <liang.yang@amlogic.com>  
> thank you for reviewing and testing my patches!
> 
> [...]
> > Tested-by:Liang Yang <liang.yang@amlogic.com>
> > Acked-by: Liang Yang <liang.yang@amlogic.com>  
> please consider the following note for future code-reviews:
> most maintainers take the patch from patchwork and apply it to their git tree.
> however, patchwork is not smart enough to detect when the same
> Tested-by/Acked-by is sent multiple times.
> this results in the same Tested-by/Acked-by being listed multiple
> times in the final commit: [0]
> 
> what I do instead is to reply with one set of Tested-by/Acked-by
> (below the author's Signed-off-by) which is then valid for the whole
> patch.
> There's no problem to have Tested-by and Acked-by at the same time,
> the issue only shows up if you send Acked-by (or any other tag) for
> the same patch multiple times.

Crap, I did not noticed that.

Thanks for pointing it. I don't have time right now to fix it and send
a new PR, I'll see in one week.


Thanks,
Miquèl
