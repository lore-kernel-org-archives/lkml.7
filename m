Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4F2C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDB121848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 07:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbfJOH4q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 03:56:46 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:41503 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbfJOH4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:56:46 -0400
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 3654324000D;
        Tue, 15 Oct 2019 07:56:37 +0000 (UTC)
Date:   Tue, 15 Oct 2019 09:56:37 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     "Boris Brezillon" <boris.brezillon@collabora.com>,
        bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, frieder.schrempf@kontron.de,
        gregkh@linuxfoundation.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marcel.ziswiler@toradex.com, marek.vasut@gmail.com, richard@nod.at,
        tglx@linutronix.de, vigneshr@ti.com
Subject: Re: [PATCH RFC 3/3] mtd: rawnand: Add support Macronix power down
 mode
Message-ID: <20191015095637.142e6db7@xps13>
In-Reply-To: <OF6D5429CF.876DE422-ON48258494.000D641F-48258494.000E0D4C@mxic.com.tw>
References: <1568793387-25199-1-git-send-email-masonccyang@mxic.com.tw>
        <1568793387-25199-3-git-send-email-masonccyang@mxic.com.tw>
        <20191007104501.1b4ed8ed@xps13>
        <OF147D635A.8968CD6B-ON4825848D.00088AD5-4825848D.000B9D06@mxic.com.tw>
        <20191008092832.54492696@dhcp-172-31-174-146.wireless.concordia.ca>
        <OF6D5429CF.876DE422-ON48258494.000D641F-48258494.000E0D4C@mxic.com.tw>
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

masonccyang@mxic.com.tw wrote on Tue, 15 Oct 2019 10:33:29 +0800:

> Hi Boris,
> 
>  
> > > > > +   nand_select_target(chip, 0);   
> > > > 
> > > > On several NAND controllers there is no way to act on the CS line
> > > > without actually writing bytes to the NAND chip. So basically this
> > > > is very likely to not work.   
> > > 
> > > any other way to make it work ? GPIO ?
> > > or just have some comments description here.
> > > i.e,.
> > > 
> > > /* The NAND chip will exit the deep power down mode with #CS toggling,   
> 
> > >  * please refer to datasheet for the timing requirement of tCRDP and   
> tRDP.
> > >  */
> > >   
> > 
> > Good luck with that. As Miquel said, on most NAND controllers
> > select_target() is a dummy operation that just assigns nand_chip->target
> > to the specified value but doesn't assert the CS line. You could send a
> > dummy command here, like a READ_ID, but I guess you need CS to be
> > asserted for at least 20ns before asserting any other signals (CLE/ALE)
> > which might be an issue.  
> 
> okay, got it.
> But if possible, I think adding CS line control in nand_select_target()
> is a simple and generic way for MTD and all raw NAND controllers.

The problem is not that we do not want to; the problem is that
controllers are not capable of doing it reliably if no byte is sent
over the NAND bus.


Thanks,
Miquèl
