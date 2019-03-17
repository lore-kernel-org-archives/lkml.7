Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C31C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F418320896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="i+EK5p36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfCQPFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 11:05:19 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:54658 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfCQPFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 11:05:19 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 4A1775C2373;
        Sun, 17 Mar 2019 16:05:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1552835115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aTFARbxGgUnGdBTdGFzJcGORmSzLrU3aqVGd+shVha0=;
        b=i+EK5p36bYXbmTY/YB8sk1sW6cWJ2VKK7qnxgKbXn3rpp93NKtVmk1M/Dpe+N2kxvawtSb
        AEL/gbFdbd+LRh8b1xPKtETPYS6xbP5By32MeOkga1GLs9VgLjP9gTR4XNFi5AfEmuvNhT
        Dx+OGsVWlRoMvoAekAu8Yj2rjyBn1bE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Sun, 17 Mar 2019 16:05:14 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Marek Vasut <marex@denx.de>
Cc:     =?UTF-8?Q?M=C3=A5ns_Rullg=C3=A5rd?= <mans@mansr.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@marvell.com>,
        linux-rockchip@lists.infradead.org,
        devicetree-spec@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        vbyravarasu@nvidia.com, Lars-Peter Clausen <lars@metafoo.de>,
        jonathanh@nvidia.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        grundler@chromium.org, Kumar Gala <galak@codeaurora.org>,
        lporzio@micron.com, Rob Herring <robh+dt@kernel.org>,
        chaotian.jing@mediatek.com,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        sudeep.holla@arm.com, zhonghui.fu@linux.intel.com,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering
 w/ device tree
In-Reply-To: <20190316153900.xqi55awrockovmsi@shell.armlinux.org.uk>
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
 <yw1x5zsx5wc7.fsf@mansr.com>
 <CAJ+vNU1PxK-B63Dc3AgzYb9POyxxoF-xPOWBEpxJ+3eVNK8xqw@mail.gmail.com>
 <d5310138-7fdd-973d-5210-3fc91c4686ee@denx.de> <yw1xftrn2em9.fsf@mansr.com>
 <1fcd4dad-1e00-67cc-ac5d-24640ae34340@denx.de>
 <20190316153900.xqi55awrockovmsi@shell.armlinux.org.uk>
Message-ID: <c23d6c4edf92d58aec86da811eaa97a5@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.03.2019 16:39, Russell King - ARM Linux admin wrote:
> On Sat, Mar 16, 2019 at 01:33:58PM +0100, Marek Vasut wrote:
>> If you have a FS or partition table there, it does.
>> If you don't, I agree ... that's a problem.
> 
> eMMC boot partitions are called mmcblkXbootY, and unless you have more
> than one eMMC device on the system, they can be found either by looking
> for /dev/mmcblk*boot* or by querying udev.  The advantage of using udev
> is you can discover the physical device behind it by looking at DEVPATH,
> ID_PATH, etc, but you may not have that installed on an embedded device.
> 
> However, as I say, just looking for /dev/mmcblk*boot* is sufficient to
> find the eMMC boot partitions where there is just one eMMC device
> present (which seems to be the standard setup.)
> 
>> > I don't care the slightest what the numbering is, as long as it is
>> > stable.  On some hardware, with an unpatched kernel, the mmc device
>> > numbering changes depending on whether or not an SD card is inserted on
>> > boot.  Getting rid of that behaviour is really all I want.
>>
>> Agreed, that would be an improvement.
> 
> The mmc device numbering was tied to the mmc host numbering a while back
> and the order that the hosts are probed should be completely independent
> of whether a card is inserted or not:
> 
>         snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
>                  "mmcblk%u%s", card->host->index, subname ? subname : "");
> 
>         snprintf(rpmb_name, sizeof(rpmb_name),
>                  "mmcblk%u%s", card->host->index, subname ? subname : "");
> 
> I suspect that Mans is quoting something from the dim and distant past
> to confuse the issue - as shown above, it is now dependent on the host
> numbering order not the order in which cards are inserted.

Commit 9aaf3437aa72 ("mmc: block: Use the mmc host device index as the
mmcblk device index") which came in with v4.6 enables constant mmc block
device numbering. I can confirm that it works nicely, and it improved
the situation a lot.

That being said, we still use a patch downstream which allows
renumbering using an alias. We deal with a bunch of different boards
with different SoC's. I have a couple of SD cards with various rootfs
and use internal eMMC boot quite often as well. Remembering which board
uses which numbering is a pain. Maintaining a patch is just easier...
Furthermore, U-Boot allows reordering and all boards I deal with use mmc
0 for the internal eMMC. The aliases allow consistency.

--
Stefan
