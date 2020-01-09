Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFF5C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594442067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731973AbgAIPD4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 10:03:56 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:34135 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbgAIPD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:03:56 -0500
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 38014200005;
        Thu,  9 Jan 2020 15:03:53 +0000 (UTC)
Date:   Thu, 9 Jan 2020 16:03:52 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: set mtd partition panic write flag
Message-ID: <20200109160352.6080e1e5@xps13>
In-Reply-To: <1718371158.75883.1572995022606.JavaMail.zimbra@nod.at>
References: <20191021193343.41320-1-kdasu.kdev@gmail.com>
        <20191105200344.1e8c3eab@xps13>
        <1718371158.75883.1572995022606.JavaMail.zimbra@nod.at>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Richard Weinberger <richard@nod.at> wrote on Wed, 6 Nov 2019 00:03:42
+0100 (CET):

> ----- Ursprüngliche Mail -----
> > Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
> > An: "Kamal Dasu" <kdasu.kdev@gmail.com>
> > CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "bcm-kernel-feedback-list" <bcm-kernel-feedback-list@broadcom.com>,
> > "linux-kernel" <linux-kernel@vger.kernel.org>, "David Woodhouse" <dwmw2@infradead.org>, "Brian Norris"
> > <computersforpeace@gmail.com>, "Marek Vasut" <marek.vasut@gmail.com>, "richard" <richard@nod.at>, "Vignesh Raghavendra"
> > <vigneshr@ti.com>
> > Gesendet: Dienstag, 5. November 2019 20:03:44
> > Betreff: Re: [PATCH] mtd: set mtd partition panic write flag  
> 
> > Hi Kamal,
> > 
> > Richard, something to look into below :)  
> 
> I'm still recovering from a bad cold. So my brain is not fully working ;)
>  
> > Kamal Dasu <kdasu.kdev@gmail.com> wrote on Mon, 21 Oct 2019 15:32:52
> > -0400:
> >   
> >> Check mtd panic write flag and set the mtd partition panic
> >> write flag so that low level drivers can use it to take
> >> required action to ensure oops data gets written to assigned
> >> mtd partition.  
> > 
> > I feel there is something wrong with the current implementation
> > regarding partitions but I am not sure this is the right fix. Is this
> > something you detected with some kind of static checker or did you
> > actually experience an issue?
> > 
> > In the commit log you say "check mtd (I suppose you mean the
> > master) panic write flag and set the mtd partition panic write flag"
> > which makes sense, but in reality my understanding is that you do the
> > opposite: you check mtd->oops_panic_write which is the partitions'
> > structure, and set part->parent->oops_panic_write which is the master's
> > flag.  
> 
> IIUC the problem happens when you run mtdoops on a mtd partition.
> The the flag is only set for the partition instead for the master.
> 
> So the right fix would be setting the parent's oops_panic_write in
> mtd_panic_write().
> Then we don't have to touch mtdpart.c
> 

This issue is still open, right? Kamal can you send an updated version?


Thanks,
Miquèl
