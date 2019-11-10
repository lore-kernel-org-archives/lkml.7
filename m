Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1287C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 11:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FED20818
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 11:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfKJLjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 06:39:24 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52796 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfKJLjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 06:39:24 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 716C828DA46;
        Sun, 10 Nov 2019 11:39:22 +0000 (GMT)
Date:   Sun, 10 Nov 2019 12:39:19 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     gerg@kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        neil@brown.name, linux-mediatek@lists.infradead.org,
        blogic@openwrt.org
Subject: Re: [PATCH] mtd: rawnand: driver for Mediatek MT7621 SoC NAND flash
 controller
Message-ID: <20191110123919.5c998839@collabora.com>
In-Reply-To: <20191107084007.GA1203521@kroah.com>
References: <20191107073521.11413-1-gerg@kernel.org>
        <20191107084007.GA1203521@kroah.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2019 09:40:07 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Thu, Nov 07, 2019 at 05:35:21PM +1000, gerg@kernel.org wrote:
> > From: Greg Ungerer <gerg@kernel.org>
> > 
> > Add a driver to support the NAND flash controller of the MediaTek MT7621
> > System-on-Chip device. (This one is the MIPS based parts from Mediatek).
> > 
> > This code is a re-working of the earlier patches for this hardware that
> > have been floating around the internet for years:
> > 
> > https://github.com/ReclaimYourPrivacy/cloak/blob/master/target/linux/ramips/patches-3.18/0045-mtd-add-mt7621-nand-support.patch
> > 
> > This is a much cleaned up version, put in staging to start with.
> > It does still have some problems, mainly that it still uses a lot of the
> > mtd raw nand legacy support.  
> 
> Is that an issue?

Well, yes that's an issue since we decided that all new drivers should
implement ->exec_op() instead of the legacy hooks. But that would be an
issue even if we were merging the driver in staging.

> Why not just put it in the "real" part of the kernel
> then, if those apis are still in use?
> 
> > The driver not only compiles, but it works well on the small range of
> > hardware platforms that it has been used on so far. I have been using
> > for quite a while now, cleaning up as I get time.
> > 
> > So... I am looking for comments on the best approach forward with this.
> > At least in staging it can get some more eyeballs going over it.  
> 
> staging will just nit-pick it to death for coding style issues, it's not
> going to be get any major api changes/cleanups there usually.  I'd
> recommend just merging this to the "real" part of the kernel now if it's
> working for you.

I agree on that point: we should merge this driver directly in the NAND
framework after it's been reworked to implement ->exec_op() instead of
the legacy hooks.
