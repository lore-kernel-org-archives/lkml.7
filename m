Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2DEC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 14:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793572175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 14:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfEJOSM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 10:18:12 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:35241 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbfEJOSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 10:18:12 -0400
X-Originating-IP: 90.88.28.253
Received: from xps13 (aaubervilliers-681-1-86-253.w90-88.abo.wanadoo.fr [90.88.28.253])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id EC9C460016;
        Fri, 10 May 2019 14:18:06 +0000 (UTC)
Date:   Fri, 10 May 2019 16:18:05 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Mason Yang <masonccyang@mxic.com.tw>, bbrezillon@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com,
        linux-mtd@lists.infradead.org, juliensu@mxic.com.tw
Subject: Re: [PATCH v1] mtd: rawnand: Add Macronix NAND read retry support
Message-ID: <20190510161805.202e6aea@xps13>
In-Reply-To: <20190510153704.33de9568@windsurf.home>
References: <1557474062-4949-1-git-send-email-masonccyang@mxic.com.tw>
        <20190510153704.33de9568@windsurf.home>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thomas Petazzoni <thomas.petazzoni@bootlin.com> wrote on Fri, 10 May
2019 15:37:04 +0200:

> Hello,
> 
> Some purely cosmetic suggestions below.
> 
> On Fri, 10 May 2019 15:41:02 +0800
> Mason Yang <masonccyang@mxic.com.tw> wrote:
> 
> > +	if (ret)
> > +		pr_err("set feature failed to read retry moded:%d\n", mode);    
> 
> I don't know what is the policy in the MTD/NAND subsystem, but
> shouldn't you be using dev_err() instead of pr_err() here to have a
> nice prefix for the message ?
> 
> 		dev_err(&nand_to_mtd(chip)->dev, "set feature ..", mode);

Actually, no, manufacturer initializations happens in
nand_scan_tail() which runs before mtd_device_register(). At this
point, mtd->dev is not yet populated so dev_err() cannot be used. You
should keep a pr_err().


Thanks,
Miquèl
