Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65225C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424E6217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbfJHH2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 03:28:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41316 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730180AbfJHH2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:28:37 -0400
Received: from dhcp-172-31-174-146.wireless.concordia.ca (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2A6D028F59E;
        Tue,  8 Oct 2019 08:28:35 +0100 (BST)
Date:   Tue, 8 Oct 2019 09:28:32 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     masonccyang@mxic.com.tw
Cc:     "Miquel Raynal" <miquel.raynal@bootlin.com>, bbrezillon@kernel.org,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        frieder.schrempf@kontron.de, gregkh@linuxfoundation.org,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, marcel.ziswiler@toradex.com,
        marek.vasut@gmail.com, richard@nod.at, tglx@linutronix.de,
        vigneshr@ti.com
Subject: Re: [PATCH RFC 3/3] mtd: rawnand: Add support Macronix power down
 mode
Message-ID: <20191008092832.54492696@dhcp-172-31-174-146.wireless.concordia.ca>
In-Reply-To: <OF147D635A.8968CD6B-ON4825848D.00088AD5-4825848D.000B9D06@mxic.com.tw>
References: <1568793387-25199-1-git-send-email-masonccyang@mxic.com.tw>
        <1568793387-25199-3-git-send-email-masonccyang@mxic.com.tw>
        <20191007104501.1b4ed8ed@xps13>
        <OF147D635A.8968CD6B-ON4825848D.00088AD5-4825848D.000B9D06@mxic.com.tw>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2019 10:06:50 +0800
masonccyang@mxic.com.tw wrote:
   
> > > +   nand_select_target(chip, 0);  
> > 
> > On several NAND controllers there is no way to act on the CS line
> > without actually writing bytes to the NAND chip. So basically this
> > is very likely to not work.  
> 
> any other way to make it work ? GPIO ?
> or just have some comments description here.
> i.e,.
> 
> /* The NAND chip will exit the deep power down mode with #CS toggling, 
>  * please refer to datasheet for the timing requirement of tCRDP and tRDP.
>  */
> 

Good luck with that. As Miquel said, on most NAND controllers
select_target() is a dummy operation that just assigns nand_chip->target
to the specified value but doesn't assert the CS line. You could send a
dummy command here, like a READ_ID, but I guess you need CS to be
asserted for at least 20ns before asserting any other signals (CLE/ALE)
which might be an issue.

> >   
> > > +   ndelay(20);  
> > 
> > Is this delay known somewhere? Is this purely experimental?  
> 
> it's timing requirement tCRDP 20 ns(min) to release device
> from deep power-down mode. 
> You may download datasheet at
> https://www.macronix.com/zh-tw/products/NAND-Flash/SLC-NAND-Flash/Pages/spec.aspx?p=MX30LF4G28AD&m=SLC%20NAND&n=PM2579 

Just looked at the datasheet, and there's actually more than tCRDP:

- you have to make sure you entered power-down state for at least tDPDD
  before you try to wake up the device
- the device goes back to stand-by state tRDP after the CS pin has been
  deasserted.

I guess we can use ndelay() for those, since they happen before/after
the CS pin is asserted/de-asserted. Be careful with ndelay() though,
it's not guaranteed to wait the the time you pass, it can return
before (maybe we should add a helper to deal with that).
Another solution would be to describe CS assertion/de-assertion in
the instruction flow, but that requires patching all exec_op() drivers.

For the tCRDP timing, I think we should use a nand_operation, this way
we can check if the controller is able to deal with dummy CS-assertion
before entering deep-power mode.
In order to do that you'll have to add a NAND_OP_DUMMY_INSTR (or
NAND_OP_DELAY_INSTR), and then have something like:

struct nand_op_instr instrs[] = {
	NAND_OP_DUMMY(tCRDP),
};
