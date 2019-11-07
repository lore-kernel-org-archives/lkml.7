Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCD9C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306FD2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387756AbfKGKNT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:13:19 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:39395 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfKGKNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:13:19 -0500
X-Originating-IP: 86.206.246.123
Received: from xps13 (lfbn-tou-1-421-123.w86-206.abo.wanadoo.fr [86.206.246.123])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 14DDB2412FB;
        Thu,  7 Nov 2019 10:09:27 +0000 (UTC)
Date:   Thu, 7 Nov 2019 11:09:26 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: no need to check return value of debugfs_create
 functions
Message-ID: <20191107110042.13acd6f5@xps13>
In-Reply-To: <20191107091518.GA1328892@kroah.com>
References: <20191107085111.GA1274176@kroah.com>
        <20191107100923.7c94820e@xps13>
        <20191107091518.GA1328892@kroah.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote on Thu, 7 Nov
2019 10:15:18 +0100:

> On Thu, Nov 07, 2019 at 10:09:44AM +0100, Miquel Raynal wrote:
> > Hi Greg,
> > 
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote on Thu, 7 Nov
> > 2019 09:51:11 +0100:
> >   
> > > When calling debugfs functions, there is no need to ever check the
> > > return value.  The function can work or not, but the code logic should
> > > never do something different based on this.  
> > 
> > I didn't know about this. Is this something new or has it been the rule
> > since the beginning? In the  case, don't we need a Fixes tag here?  
> 
> It's been the way always, but as of a few kernel releases ago, debugfs
> is even more "fault-tolerant" of stuff like this.
> 
> And there's no need for a "Fixes:" as this is just work to clean up the
> debugfs api and usage (I have a lot more work to do after these types of
> changes.)

Ok, thanks for the clarification.

Cheers!
Miquèl

> 
> >   
> > > Cc: David Woodhouse <dwmw2@infradead.org>
> > > Cc: Brian Norris <computersforpeace@gmail.com>
> > > Cc: Marek Vasut <marek.vasut@gmail.com>
> > > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > > Cc: Richard Weinberger <richard@nod.at>
> > > Cc: Vignesh Raghavendra <vigneshr@ti.com>
> > > Cc: Artem Bityutskiy <dedekind1@gmail.com>
> > > Cc: linux-mtd@lists.infradead.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>  
> > 
> > [...]
> >   
> > > +
> > > +	d->dfs_emulate_io_failures = debugfs_create_file("tst_emulate_io_failures",
> > > +							 S_IWUSR, d->dfs_dir,
> > > +							 (void *)ubi_num,
> > > +							 &dfs_fops);
> > > +
> > > +	d->dfs_emulate_power_cut = debugfs_create_file("tst_emulate_power_cut",
> > > +						       S_IWUSR, d->dfs_dir,
> > > +						       (void *)ubi_num,
> > > +						       &dfs_fops);  
> > 
> > Nitpick: I think we miss an empty line here. I can fix it when applying.  
> 
> Ah, oops, sorry about that.
> 
> thanks,
> 
> greg k-h

