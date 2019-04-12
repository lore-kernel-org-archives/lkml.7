Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13D6C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DCF205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfDLHYY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:24:24 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:59515 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfDLHYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 03:24:23 -0400
X-Originating-IP: 90.88.18.121
Received: from xps13 (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 4408BFF80F;
        Fri, 12 Apr 2019 07:24:19 +0000 (UTC)
Date:   Fri, 12 Apr 2019 09:24:19 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] mtd: rawnand: mark expected switch fall-throughs
Message-ID: <20190412092419.6f5a6432@xps13>
In-Reply-To: <017bdd52-8d1f-f746-6e1c-4d38491b2d6a@embeddedor.com>
References: <20190128181520.GA25887@embeddedor>
        <20190205135521.622f82c2@xps13>
        <ce33f949-48c8-b32a-028e-ee68afc08e8f@embeddedor.com>
        <20190412001009.2db358b7@xps13>
        <017bdd52-8d1f-f746-6e1c-4d38491b2d6a@embeddedor.com>
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

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote on Thu, 11 Apr
2019 17:20:31 -0500:

> On 4/11/19 5:10 PM, Miquel Raynal wrote:
> > Hi Gustavo,
> > 
> > "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote on Thu, 11 Apr
> > 2019 13:30:31 -0500:
> >   
> >> Hi Miquel,
> >>
> >> On 2/5/19 6:55 AM, Miquel Raynal wrote:
> >> [..]  
> >>>> @@ -3280,12 +3280,14 @@ static void onenand_check_features(struct mtd_info *mtd)
> >>>>  			if ((this->version_id & 0xf) == 0xe)
> >>>>  				this->options |= ONENAND_HAS_NOP_1;
> >>>>  		}
> >>>> +		/* fall through */
> >>>>  
> >>>>  	case ONENAND_DEVICE_DENSITY_2Gb:
> >>>>  		/* 2Gb DDP does not have 2 plane */
> >>>>  		if (!ONENAND_IS_DDP(this))
> >>>>  			this->options |= ONENAND_HAS_2PLANE;
> >>>>  		this->options |= ONENAND_HAS_UNLOCK_ALL;
> >>>> +		/* fall through */    
> >>>
> >>> This looks strange.
> >>>
> >>> In ONENAND_DEVICE_DENSITY_2Gb:
> >>> ONENAND_HAS_UNLOCK_ALL is set unconditionally.
> >>>
> >>> But then, under ONENAND_DEVICE_DENSITY_1Gb, the same option is set only
> >>> if process is evaluated to true.
> >>>
> >>> Same problem with ONENAND_HAS_2PLANE:
> >>> - it is set in ONENAND_DEVICE_DENSITY_4Gb only if ONENAND_IS_DDP()
> >>> - it is unset in ONENAND_DEVICE_DENSITY_2Gb only if !ONENAND_IS_DDP()
> >>>
> >>> Maybe this portion should be reworked because I am unsure if this is a
> >>> missing fall through or a bug.
> >>>     
> >>
> >> I wonder if you had the chance to take a look into this piece of code.
> >>
> >> Thanks
> >> --
> >> Gustavo  
> > 
> > What do you mean?
> >   
> 
> You commented that the piece of code above should be reworked. So, it wasn't
> clear to me who was going to do that; and that's why I'm asking if you took
> a look into it and finally determine whether we are dealing with an actual
> bug or a false positive.

Yes please do it, I don't have the time and I don't plan to do it
myself.


Thanks,
Miquèl
