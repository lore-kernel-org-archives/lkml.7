Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B7BC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A2F218AE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573118124;
	bh=LVUkd/2G54+1KXm08ED6qubBP8aaj3nvMWjP08nx11E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GVorA0b+aV8T61XLDRDwC94/W1WHbASrYGRBrAE0vDsMdStNj5pn7dVqgGqhUDHos
	 SFb7fY+E8dzVcbNghROz3yPAWYG+Kz3EVzK9lfkUXRec2PPYyUYu0/o5LiQdTWGuj3
	 gm3ygA4xS/ZWsinVCnq5WhdIY7VT/ER3lnXLZav4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387740AbfKGJPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:15:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:58126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727300AbfKGJPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:15:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A0342187F;
        Thu,  7 Nov 2019 09:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573118120;
        bh=LVUkd/2G54+1KXm08ED6qubBP8aaj3nvMWjP08nx11E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nnqItDtECDcwqXALukQ7aBRBStegYVy9/g4f5HqaJPWGk7yOV0lxo6bAmGk+J2+3r
         ShrOrP1jivuxxN/SIGsOcMJmxbIkpy+2KpqKH8wRhw/D8TLzIl2ZwIflRv/y2oGpbQ
         ot3NcBhh/02RsDSOqw/bwzQxetjG66gCBaVVFthI=
Date:   Thu, 7 Nov 2019 10:15:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: no need to check return value of debugfs_create
 functions
Message-ID: <20191107091518.GA1328892@kroah.com>
References: <20191107085111.GA1274176@kroah.com>
 <20191107100923.7c94820e@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107100923.7c94820e@xps13>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 10:09:44AM +0100, Miquel Raynal wrote:
> Hi Greg,
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote on Thu, 7 Nov
> 2019 09:51:11 +0100:
> 
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> 
> I didn't know about this. Is this something new or has it been the rule
> since the beginning? In the  case, don't we need a Fixes tag here?

It's been the way always, but as of a few kernel releases ago, debugfs
is even more "fault-tolerant" of stuff like this.

And there's no need for a "Fixes:" as this is just work to clean up the
debugfs api and usage (I have a lot more work to do after these types of
changes.)

> 
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Cc: Brian Norris <computersforpeace@gmail.com>
> > Cc: Marek Vasut <marek.vasut@gmail.com>
> > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > Cc: Richard Weinberger <richard@nod.at>
> > Cc: Vignesh Raghavendra <vigneshr@ti.com>
> > Cc: Artem Bityutskiy <dedekind1@gmail.com>
> > Cc: linux-mtd@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> [...]
> 
> > +
> > +	d->dfs_emulate_io_failures = debugfs_create_file("tst_emulate_io_failures",
> > +							 S_IWUSR, d->dfs_dir,
> > +							 (void *)ubi_num,
> > +							 &dfs_fops);
> > +
> > +	d->dfs_emulate_power_cut = debugfs_create_file("tst_emulate_power_cut",
> > +						       S_IWUSR, d->dfs_dir,
> > +						       (void *)ubi_num,
> > +						       &dfs_fops);
> 
> Nitpick: I think we miss an empty line here. I can fix it when applying.

Ah, oops, sorry about that.

thanks,

greg k-h
