Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8636C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B865C2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfJHPCz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:02:55 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:44027 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbfJHPCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:02:54 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id DB95C24000F;
        Tue,  8 Oct 2019 15:02:50 +0000 (UTC)
Date:   Tue, 8 Oct 2019 17:02:49 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, frieder.schrempf@kontron.de,
        gregkh@linuxfoundation.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marcel.ziswiler@toradex.com, marek.vasut@gmail.com, richard@nod.at,
        tglx@linutronix.de, vigneshr@ti.com
Subject: Re: [PATCH RFC 2/3] mtd: rawnand: Add support Macronix Block
 Protection function
Message-ID: <20191008170249.06bd45ce@xps13>
In-Reply-To: <OFEDE76FEE.8BC48D9E-ON4825848D.000BCC94-4825848D.000E0643@mxic.com.tw>
References: <1568793387-25199-1-git-send-email-masonccyang@mxic.com.tw>
        <1568793387-25199-2-git-send-email-masonccyang@mxic.com.tw>
        <20191007104511.5aa7b8f2@xps13>
        <20191007112442.783e4fbe@xps13>
        <OFEDE76FEE.8BC48D9E-ON4825848D.000BCC94-4825848D.000E0643@mxic.com.tw>
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

masonccyang@mxic.com.tw wrote on Tue, 8 Oct 2019 10:33:11 +0800:

> Hi Miquel,
> 
> > >   
> > > > Macronix AC series support using SET/GET_FEATURES to change
> > > > Block Protection and Unprotection.
> > > > 
> > > > MTD default _lock/_unlock function replacement by manufacturer
> > > > postponed initialization.   
> > > 
> > > Why would we do that?
> > > 
> > > Anyway your solution looks overkill, if we ever decide to
> > > implement these hooks for raw nand, it is better just to not
> > > overwrite them in nand_scan_tail() if they have been filled
> > > previously (ie. by the manufacturer code).  
> > 
> > Actually you should add two NAND hooks that do the interface with the
> > MTD hooks. In the NAND hooks, check that the request is to lock all the
> > device, otherwise return -ENOTSUPP.  
> 
> sorry, can't get your point.
> 
> Because the NAND entire chip will be protected if PT(protection) pin 
> is active high at power-on.

In your implementation of the locking, you should check that the
locking request is over the entire device, unless you can lock a
smaller portion of course.

> 
> > 
> > Then fill-in these two hooks from the manufacturer code, without the
> > postponed init.
> >   
> 
> But in the final of nand_scan_tail(), mtd->_lock/_unlock will be
> filled by NULL, right ?

The NAND core should set mtd->_lock/_unlock() to NAND specific hooks so
that the MTD layer is abstracted and and drivers do not see it. Then,
in the NAND helper, either there is no specific hook defined by a
manufacturer driver and you return -ENOTSUPP, or you execute the
defined hook.

Thanks,
Miquèl
