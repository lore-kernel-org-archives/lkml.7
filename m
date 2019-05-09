Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F3AC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 06:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DB921744
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 06:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfEIGxY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 02:53:24 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:45191 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfEIGxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 02:53:23 -0400
X-Originating-IP: 90.88.28.253
Received: from xps13 (aaubervilliers-681-1-86-253.w90-88.abo.wanadoo.fr [90.88.28.253])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id CA35D1C0006;
        Thu,  9 May 2019 06:53:19 +0000 (UTC)
Date:   Thu, 9 May 2019 08:53:18 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] mtd: cfi_util: mark expected switch fall-throughs
Message-ID: <20190509085318.34a9d4be@xps13>
In-Reply-To: <cf70787e-5c3a-d639-1025-7fa15d935732@embeddedor.com>
References: <20190208180202.GA16603@embeddedor>
        <69083203-0720-1943-8549-ddf3cea6060e@embeddedor.com>
        <71df15e7-af2e-0326-78fe-0271a1e240fe@embeddedor.com>
        <20190415104458.7faeec57@xps13>
        <ee1f8c4a-92b0-db9d-6110-3acadeb9e457@embeddedor.com>
        <20190416192408.0e321563@xps13>
        <8df20a3a-3068-1fb7-0421-e6c417550125@embeddedor.com>
        <3034821c-3cd0-b0c5-a6fd-548fd87486a4@embeddedor.com>
        <785015370.48464.1557244145722.JavaMail.zimbra@nod.at>
        <cf70787e-5c3a-d639-1025-7fa15d935732@embeddedor.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote on Tue, 7 May 2019
10:59:38 -0500:

> On 5/7/19 10:49 AM, Richard Weinberger wrote:
> 
> >> Hi all,
> >>
> >> Thanks a lot for this, Richard:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/log/?h=mtd%2Fnext&qt=grep&q=fall-through
> >>
> >> There are only two of these warnings left to be addressed in
> >> MTD[1]:
> >>  
> >>        > @@ -3280,12 +3280,14 @@ static void onenand_check_features(struct mtd_info *mtd)
> >>        >                       if ((this->version_id & 0xf) == 0xe)
> >>        >                               this->options |= ONENAND_HAS_NOP_1;
> >>        >               }
> >>        > +             /* fall through */
> >>        >
> >>        >       case ONENAND_DEVICE_DENSITY_2Gb:
> >>        >               /* 2Gb DDP does not have 2 plane */
> >>        >               if (!ONENAND_IS_DDP(this))
> >>        >                       this->options |= ONENAND_HAS_2PLANE;
> >>        >               this->options |= ONENAND_HAS_UNLOCK_ALL;
> >>        > +             /* fall through */  
> >>
> >>        This looks strange.
> >>
> >>        In ONENAND_DEVICE_DENSITY_2Gb:
> >>        ONENAND_HAS_UNLOCK_ALL is set unconditionally.
> >>
> >>        But then, under ONENAND_DEVICE_DENSITY_1Gb, the same option is set only
> >>        if process is evaluated to true.
> >>
> >>        Same problem with ONENAND_HAS_2PLANE:
> >>        - it is set in ONENAND_DEVICE_DENSITY_4Gb only if ONENAND_IS_DDP()
> >>        - it is unset in ONENAND_DEVICE_DENSITY_2Gb only if !ONENAND_IS_DDP()
> >>
> >>        Maybe this portion should be reworked because I am unsure if this is a
> >>        missing fall through or a bug.
> >>
> >>
> >> Thanks
> >> --
> >> Gustavo
> >>
> >> [1] https://lore.kernel.org/patchwork/patch/1036251/  
> > 
> > Did we miss this patch? AFAICT it is in -next too.
> >   
> 
> What is pending to be resolved are these warnings:
> 
> drivers/mtd/nand/onenand/onenand_base.c: In function ‘onenand_check_features’:
> drivers/mtd/nand/onenand/onenand_base.c:3264:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (ONENAND_IS_DDP(this))
>       ^
> drivers/mtd/nand/onenand/onenand_base.c:3284:2: note: here
>   case ONENAND_DEVICE_DENSITY_2Gb:
>   ^~~~
> drivers/mtd/nand/onenand/onenand_base.c:3288:17: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    this->options |= ONENAND_HAS_UNLOCK_ALL;
> drivers/mtd/nand/onenand/onenand_base.c:3290:2: note: here
>   case ONENAND_DEVICE_DENSITY_1Gb:
>   ^~~~
> 
> The final version of the patch in -next does not address them.
> 

Send a commit for these two warnings stating very clearly close to
the top of the commit log that we don't know whether we need
fallthroughs or breaks there and that this is just a change to avoid
having new warnings when switching to -Wimplicit-fallthrough but this
change might be entirely wrong.


Thanks,
Miquèl
