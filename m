Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABA8C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1332084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfDKWKR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:10:17 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:52985 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfDKWKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:10:16 -0400
X-Originating-IP: 81.185.166.150
Received: from xps13 (150.166.185.81.rev.sfr.net [81.185.166.150])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 5F6C924000B;
        Thu, 11 Apr 2019 22:10:11 +0000 (UTC)
Date:   Fri, 12 Apr 2019 00:10:09 +0200
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
Message-ID: <20190412001009.2db358b7@xps13>
In-Reply-To: <ce33f949-48c8-b32a-028e-ee68afc08e8f@embeddedor.com>
References: <20190128181520.GA25887@embeddedor>
        <20190205135521.622f82c2@xps13>
        <ce33f949-48c8-b32a-028e-ee68afc08e8f@embeddedor.com>
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
2019 13:30:31 -0500:

> Hi Miquel,
> 
> On 2/5/19 6:55 AM, Miquel Raynal wrote:
> [..]
> >> @@ -3280,12 +3280,14 @@ static void onenand_check_features(struct mtd_info *mtd)
> >>  			if ((this->version_id & 0xf) == 0xe)
> >>  				this->options |= ONENAND_HAS_NOP_1;
> >>  		}
> >> +		/* fall through */
> >>  
> >>  	case ONENAND_DEVICE_DENSITY_2Gb:
> >>  		/* 2Gb DDP does not have 2 plane */
> >>  		if (!ONENAND_IS_DDP(this))
> >>  			this->options |= ONENAND_HAS_2PLANE;
> >>  		this->options |= ONENAND_HAS_UNLOCK_ALL;
> >> +		/* fall through */  
> > 
> > This looks strange.
> > 
> > In ONENAND_DEVICE_DENSITY_2Gb:
> > ONENAND_HAS_UNLOCK_ALL is set unconditionally.
> > 
> > But then, under ONENAND_DEVICE_DENSITY_1Gb, the same option is set only
> > if process is evaluated to true.
> > 
> > Same problem with ONENAND_HAS_2PLANE:
> > - it is set in ONENAND_DEVICE_DENSITY_4Gb only if ONENAND_IS_DDP()
> > - it is unset in ONENAND_DEVICE_DENSITY_2Gb only if !ONENAND_IS_DDP()
> > 
> > Maybe this portion should be reworked because I am unsure if this is a
> > missing fall through or a bug.
> >   
> 
> I wonder if you had the chance to take a look into this piece of code.
> 
> Thanks
> --
> Gustavo

What do you mean?


Thanks,
Miquèl
