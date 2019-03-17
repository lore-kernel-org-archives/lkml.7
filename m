Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BBEC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B5A20896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="urdAeGrk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfCQPok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 11:44:40 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:38374 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfCQPok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 11:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TXjh1EmjMZUyn0MmjNS92pRTVSN7NyiZGgkOQuptyIk=; b=urdAeGrkBx4LvK6dyvhtobCiU
        hAieAdI+imP3Lrsm0NWr/Rwj/R6ufMDkxWpYwF6CZlH7shaqMKJcFdc4rUgOuyi9Lyg1RvILLI+yT
        lRzTMJWpfRzzU47Qtnj31FTX9otauIHL828/pqNysk2mVdi/4HSwIdGZ+jEH4myUary6V4yhro6qf
        nTrzfsGtuEUr+M3n4whWStCBV3QivYz6zQ86RWiE0hvbnYSJ6gARHqxgt1yPkJdU+bYFoqGpzuAfh
        TN7RJmUz0vwAwURSAxgERPhQshOByHT4GH4VNRHkSIO30Gpqx4gUBJcEbMMmcAvpm29BixNEXuelq
        KOQA0HXjQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:37426)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1h5XxP-00027d-Oc; Sun, 17 Mar 2019 15:44:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1h5Xx1-0004y3-31; Sun, 17 Mar 2019 15:43:51 +0000
Date:   Sun, 17 Mar 2019 15:43:50 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Stefan Agner <stefan@agner.ch>
Cc:     Marek Vasut <marex@denx.de>, Mark Rutland <mark.rutland@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
        Heiko Stuebner <heiko@sntech.de>,
        devicetree-spec@vger.kernel.org, shawn.lin@rock-chips.com,
        Douglas Anderson <dianders@chromium.org>,
        vbyravarasu@nvidia.com, Jisheng Zhang <jszhang@marvell.com>,
        Lars-Peter Clausen <lars@metafoo.de>, jonathanh@nvidia.com,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-rockchip@lists.infradead.org, chaotian.jing@mediatek.com,
        devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        grundler@chromium.org, Tim Harvey <tharvey@gateworks.com>,
        sudeep.holla@arm.com, lporzio@micron.com,
        Rob Herring <robh+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Kumar Gala <galak@codeaurora.org>,
        Brian Norris <computersforpeace@gmail.com>,
        zhonghui.fu@linux.intel.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk
 numbering w/ device tree
Message-ID: <20190317154350.esbhdx4huzqe2jxy@shell.armlinux.org.uk>
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
 <yw1x5zsx5wc7.fsf@mansr.com>
 <CAJ+vNU1PxK-B63Dc3AgzYb9POyxxoF-xPOWBEpxJ+3eVNK8xqw@mail.gmail.com>
 <d5310138-7fdd-973d-5210-3fc91c4686ee@denx.de>
 <yw1xftrn2em9.fsf@mansr.com>
 <1fcd4dad-1e00-67cc-ac5d-24640ae34340@denx.de>
 <20190316153900.xqi55awrockovmsi@shell.armlinux.org.uk>
 <c23d6c4edf92d58aec86da811eaa97a5@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c23d6c4edf92d58aec86da811eaa97a5@agner.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 04:05:14PM +0100, Stefan Agner wrote:
> On 16.03.2019 16:39, Russell King - ARM Linux admin wrote:
> > On Sat, Mar 16, 2019 at 01:33:58PM +0100, Marek Vasut wrote:
> >> If you have a FS or partition table there, it does.
> >> If you don't, I agree ... that's a problem.
> > 
> > eMMC boot partitions are called mmcblkXbootY, and unless you have more
> > than one eMMC device on the system, they can be found either by looking
> > for /dev/mmcblk*boot* or by querying udev.  The advantage of using udev
> > is you can discover the physical device behind it by looking at DEVPATH,
> > ID_PATH, etc, but you may not have that installed on an embedded device.
> > 
> > However, as I say, just looking for /dev/mmcblk*boot* is sufficient to
> > find the eMMC boot partitions where there is just one eMMC device
> > present (which seems to be the standard setup.)
> > 
> >> > I don't care the slightest what the numbering is, as long as it is
> >> > stable.  On some hardware, with an unpatched kernel, the mmc device
> >> > numbering changes depending on whether or not an SD card is inserted on
> >> > boot.  Getting rid of that behaviour is really all I want.
> >>
> >> Agreed, that would be an improvement.
> > 
> > The mmc device numbering was tied to the mmc host numbering a while back
> > and the order that the hosts are probed should be completely independent
> > of whether a card is inserted or not:
> > 
> >         snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
> >                  "mmcblk%u%s", card->host->index, subname ? subname : "");
> > 
> >         snprintf(rpmb_name, sizeof(rpmb_name),
> >                  "mmcblk%u%s", card->host->index, subname ? subname : "");
> > 
> > I suspect that Mans is quoting something from the dim and distant past
> > to confuse the issue - as shown above, it is now dependent on the host
> > numbering order not the order in which cards are inserted.
> 
> Commit 9aaf3437aa72 ("mmc: block: Use the mmc host device index as the
> mmcblk device index") which came in with v4.6 enables constant mmc block
> device numbering. I can confirm that it works nicely, and it improved
> the situation a lot.
> 
> That being said, we still use a patch downstream which allows
> renumbering using an alias. We deal with a bunch of different boards
> with different SoC's. I have a couple of SD cards with various rootfs
> and use internal eMMC boot quite often as well. Remembering which board
> uses which numbering is a pain. Maintaining a patch is just easier...
> Furthermore, U-Boot allows reordering and all boards I deal with use mmc
> 0 for the internal eMMC. The aliases allow consistency.

Maybe eMMC should've been given a different block device name?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
