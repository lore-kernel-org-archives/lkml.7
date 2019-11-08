Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9E3FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0319E222C5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="L1r9uYB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389622AbfKHLlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:41:47 -0500
Received: from vps.xff.cz ([195.181.215.36]:46878 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732905AbfKHLll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1573213299; bh=DTFELkY0GJEkB2dfExMBAyshl9VFk13qMOSBa5R8u4o=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=L1r9uYB1CgSwNl9LXzNO62rthSHIe/gMXCu/3zCOzUnXu9jtABcZOiGkCRdIBBXQ3
         p709SVqoWgeWqfqkUYRVnP79lTFH0l2ONEfdVLhK+M8gou89gfL0kLVV3sQKXwyxBN
         Qr52LP/xxXm00qR9AW+tn/NHI5FtWtHt88AMDIDw=
Date:   Fri, 8 Nov 2019 12:41:38 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>, arnd@arndb.de,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        kishon@ti.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        mark.rutland@arm.com, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, robh+dt@kernel.org,
        tglx@linutronix.de, wens@csie.org
Subject: Re: [PATCH] phy: allwinner: Fix GENMASK misuse
Message-ID: <20191108114138.snghk5n7kwuw7zz3@core.my.home>
Mail-Followup-To: Icenowy Zheng <icenowy@aosc.io>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>, arnd@arndb.de,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        kishon@ti.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        mark.rutland@arm.com, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, robh+dt@kernel.org,
        tglx@linutronix.de, wens@csie.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20191020134229.1216351-3-megous@megous.com>
 <20191107204645.13739-1-rikard.falkeborn@gmail.com>
 <20191107214514.kcz42mcehyrrif4o@core.my.home>
 <F563E52E-72BF-4297-A14F-DDE2B490DADB@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F563E52E-72BF-4297-A14F-DDE2B490DADB@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 07:29:21PM +0800, Icenowy Zheng wrote:
> 
> 
> 于 2019年11月8日 GMT+08:00 上午5:45:14, "Ondřej Jirman" <megous@megous.com> 写到:
> >Hello Rikard,
> >
> >On Thu, Nov 07, 2019 at 09:46:45PM +0100, Rikard Falkeborn wrote:
> >> Arguments are supposed to be ordered high then low.
> >> 
> >> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> >> ---
> >> Spotted while trying to add compile time checks of GENMASK arguments.
> >> Patch has only been compile tested.
> >
> >thank you!
> >
> >Tested-by: Ondrej Jirman <megous@megous.com>
> 
> Does it affect or fix the performance?

See here: https://forum.armbian.com/topic/10131-orange-pi-lite2-usb3-now-working/?do=findComment&comment=88904

Quote:

> It may or may not help. On Opi3 I see no change, probably because HUB is
> really close to the SoC, but on boards without a HUB, SoC's USB3 phy will
> have to drive the signal over the longer cable and this patch might benefit
> those boards. 

Maybe someone with boards without PHY will test it more.

regards,
	o.

> >
> >regards,
> >	o.
> >
> >>  drivers/phy/allwinner/phy-sun50i-usb3.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/phy/allwinner/phy-sun50i-usb3.c
> >b/drivers/phy/allwinner/phy-sun50i-usb3.c
> >> index 1169f3e83a6f..b1c04f71a31d 100644
> >> --- a/drivers/phy/allwinner/phy-sun50i-usb3.c
> >> +++ b/drivers/phy/allwinner/phy-sun50i-usb3.c
> >> @@ -49,7 +49,7 @@
> >>  #define SUNXI_LOS_BIAS(n)		((n) << 3)
> >>  #define SUNXI_LOS_BIAS_MASK		GENMASK(5, 3)
> >>  #define SUNXI_TXVBOOSTLVL(n)		((n) << 0)
> >> -#define SUNXI_TXVBOOSTLVL_MASK		GENMASK(0, 2)
> >> +#define SUNXI_TXVBOOSTLVL_MASK		GENMASK(2, 0)
> >>  
> >>  struct sun50i_usb3_phy {
> >>  	struct phy *phy;
> >> -- 
> >> 2.24.0
> >> 
