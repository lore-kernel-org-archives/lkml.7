Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC71C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395D22087E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbfHZHXv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 03:23:51 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:39473 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbfHZHXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:23:50 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id AB25360002;
        Mon, 26 Aug 2019 07:23:45 +0000 (UTC)
Date:   Mon, 26 Aug 2019 09:23:44 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, frieder.schrempf@kontron.de,
        juliensu@mxic.com.tw, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, richard@nod.at, tglx@linutronix.de,
        vigneshr@ti.com
Subject: Re: [PATCH] Add support for Macronix NAND randomizer
Message-ID: <20190826092344.7b23ede1@xps13>
In-Reply-To: <OFF725800E.8B26D2E9-ON48258462.000B94B2-48258462.000FCB85@mxic.com.tw>
References: <1566280428-4159-1-git-send-email-masonccyang@mxic.com.tw>
        <20190824130329.68f310aa@xps13>
        <OFF725800E.8B26D2E9-ON48258462.000B94B2-48258462.000FCB85@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

masonccyang@mxic.com.tw wrote on Mon, 26 Aug 2019 10:52:31 +0800:

> Hi Miquel,
> > 
> > Mason Yang <masonccyang@mxic.com.tw> wrote on Tue, 20 Aug 2019 13:53:48
> > +0800:
> >   
> > > Macronix NANDs support randomizer operation for user data scrambled,
> > > which can be enabled with a SET_FEATURE.
> > > 
> > > User data written to the NAND device without randomizer is still   
> readable
> > > after randomizer function enabled.
> > > The penalty of randomizer are NOP = 1 instead of NOP = 4 and more time   
> period
> > 
> > please don't use 'NOP' here, use 'subpage accesses' instead, otherwise
> > people might not understand what it means while it has a real impact.
> >   
> 
> okay, understood. 
> will fix it by next submitting.
> 
> > > is needed in program operation and entering deep power-down mode.
> > > i.e., tPROG 300us to 340us(randomizer enabled)
> > > 
> > > If subpage write not available with hardware ECC, for example,
> > > NAND chip options NAND_NO_SUBPAGE_WRITE be set in driver and
> > > randomizer function is recommended for high-reliability.
> > > Driver checks byte 167 of Vendor Blocks in ONFI parameter page table
> > > to see if this high-reliability function is supported.
> > >   
> > 
> > You did not flagged this patch as a v2 and forgot about the changelog.  
> 
> will fix, thank you.
> 
> > You did not listen to our comments in the last version neither. I was
> > open to a solution with a specific DT property for warned users but I
> > don't see it coming.  
> 
> Sorry I missed the previous version of "read-retry and randomizer support" 
> patch. 
> Specific DT property is a good method to control it.
> 
> For more high-reliability concern, randomizer is recommended to enable by 
> default,
> but sub-page write is not allowed when randomizer is enabled.
> 
> Since most of HW ECC did not support sub-page write and we think driver to 
> check
> chip options flags is another simple and good way to enable randomizer.

Sorry but this is wrong. Several controllers and NAND chips support
subpages. And changing now the behavior with such chips would entirely
break the concerned setups (see Boris answer about UBI complaining if
the subpage size changes).

Thanks,
Miquèl
