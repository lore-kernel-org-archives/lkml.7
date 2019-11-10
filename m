Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB243C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 11:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6B320818
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 11:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfKJLfh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 06:35:37 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52722 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfKJLfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 06:35:37 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E02CE28A10C;
        Sun, 10 Nov 2019 11:35:34 +0000 (GMT)
Date:   Sun, 10 Nov 2019 12:35:31 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     =?UTF-8?B?UmVuw6k=?= van Dorst <opensource@vdorst.com>
Cc:     gerg@kernel.org, devel@driverdev.osuosl.org,
        Weijie Gao <hackpascal@gmail.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        DENG Qingfang <dengqf6@mail2.sysu.edu.cn>,
        linux-mediatek@lists.infradead.org, neil@brown.name,
        linux-mtd@lists.infradead.org, Chuanhong Guo <gch981213@gmail.com>,
        blogic@openwrt.org, Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] mtd: rawnand: driver for Mediatek MT7621 SoC NAND flash
 controller
Message-ID: <20191110123531.5a27206a@collabora.com>
In-Reply-To: <20191107092053.Horde.i3MVcW9RqZDOQBMADZX9fuc@www.vdorst.com>
References: <20191107073521.11413-1-gerg@kernel.org>
        <20191107092053.Horde.i3MVcW9RqZDOQBMADZX9fuc@www.vdorst.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Richard and Miquel

On Thu, 07 Nov 2019 09:20:53 +0000
René van Dorst <opensource@vdorst.com> wrote:

> Quoting gerg@kernel.org:
> 
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
> >
> > The driver not only compiles, but it works well on the small range of
> > hardware platforms that it has been used on so far. I have been using
> > for quite a while now, cleaning up as I get time.
> >
> > So... I am looking for comments on the best approach forward with this.
> > At least in staging it can get some more eyeballs going over it.
> >
> > There is a mediatek nand driver already, mtk_nand.c, for their ARM based
> > System-on-Chip devices. That hardware module looks to have some hardware
> > similarities with this one. At this point I don't know if that can be
> > used on the 7621 based devices. (I tried a quick and dirty setup and had
> > no success using it on the 7621).
> >
> > Thoughts?  
> 
> +CC DENG Qingfang, Chuanhong Guo, Weijie Gao to the list.
> 
> Hi Greg,
> 
> Thanks for posting this driver.
> 
> But I would like to mention that the openwrt community is currently  
> working on a
> new version which is based a newer version of the MediaTek vendor driver.
> That version is currently targeted for the openwrt 4.19 kernel.
> See full pull request [1] and NAND driver patch [2]
> 
> It would be a shame if duplicate work has been done.

Sorry, but if there's duplicate effort that's kinda your (OpenWRT folks)
fault: since when OpenWRT is the central point for kernel drivers?
Correct me if I'm wrong, but I don't remember seeing this driver posted
to the MTD ML. Plus, the driver you're pointing to still implements the
legacy hooks and is based on 4.19, and it has been decided that all new
NAND controller drivers should implement the new ->exec_op() hook
instead.

> 
> Greats,
> 
> René
> 
> [1]: https://github.com/openwrt/openwrt/pull/2385
> [2]:  
> https://github.com/openwrt/openwrt/pull/2385/commits/b2569c0a5943fe8f94ba07c9540ecd14006d729a
> 
> <snip>
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

