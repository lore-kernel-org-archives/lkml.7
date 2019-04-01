Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4F4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7727120880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfDAPbB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:31:01 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41176 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfDAPbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:31:01 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2B8D7281FCB;
        Mon,  1 Apr 2019 16:30:59 +0100 (BST)
Date:   Mon, 1 Apr 2019 17:30:56 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Aditya Pakki <pakki001@umn.edu>, kjlu@umn.edu,
        Stefan Agner <stefan@agner.ch>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: vf610: Fix to check for NULL pointer
 dereference
Message-ID: <20190401173056.17604b54@collabora.com>
In-Reply-To: <20190401172651.158c05fe@xps13>
References: <20190318232434.9246-1-pakki001@umn.edu>
        <20190401172651.158c05fe@xps13>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2019 17:26:51 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Aditya,
> 
> Aditya Pakki <pakki001@umn.edu> wrote on Mon, 18 Mar 2019 18:24:34
> -0500:
> 
> > of_match_device can return NULL if there is no matching device is found.
> > The patch avoids a potential NULL pointer dereference by checking for the
> > return value and passing the error upstream.
> > 
> > Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> > ---
> >  drivers/mtd/nand/raw/vf610_nfc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
> > index a662ca1970e5..946abbb275c3 100644
> > --- a/drivers/mtd/nand/raw/vf610_nfc.c
> > +++ b/drivers/mtd/nand/raw/vf610_nfc.c
> > @@ -850,6 +850,8 @@ static int vf610_nfc_probe(struct platform_device *pdev)
> >  	}
> >  
> >  	of_id = of_match_device(vf610_nfc_dt_ids, &pdev->dev);
> > +	if (!of_id)
> > +		return -ENODEV;

For the record, this can't happen unless you have serious memory
corruption issues since you reached the ->probe() function (which means
a match was found before).

> >  	nfc->variant = (enum vf610_nfc_variant)of_id->data;
> >  
> >  	for_each_available_child_of_node(nfc->dev->of_node, child) {  
> 
> 
> Applied to git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
> on nand/next with the title changed to
> 
>         mtd: rawnand: vf610: Avoid a potential NULL pointer dereference
> 
> and a space after the return statement.
> 
> Thanks,
> Miquèl

