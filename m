Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DE7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BA721873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="usGMKa/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfCTRal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:30:41 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:32860 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbfCTRaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WAi+T+TuJkOY2/zypYL61QcvUuzQMK0U/Jt9Mgzl8ZE=; b=usGMKa/KfAjTnmwGxWEa3CgJo
        68164ovSYUuJpxhofjrDoWAjIZDC20HZHTo/1eLYSq4M/G+UNWKAseOjj40WvMRxfosWHS8G3Of88
        Fttsw+5BnTSMR9Ktm4Fhhb+S1Hc1rYI55MQFrP7VbIzW9P9Q9Vn7Hjy/cU69Anfzmez4lIIObx8fX
        lXw8yvje5LttAE1NnoHiCQTJpqQdd5wJMymVMMU7n0z3IDBu7zhcYuORNLiKe6lhuUauGRuAavI6V
        BgOnSqVIquWhOT2Z/WbDP9bpizJeeQqGuCFKFGWYN74vXhaKi8v0shCnzJuNbl5kWBm1IDfsIMhuO
        ms3++4rNw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51806)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1h6f2O-0005jt-Jp; Wed, 20 Mar 2019 17:30:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1h6f2L-0007WL-1r; Wed, 20 Mar 2019 17:29:57 +0000
Date:   Wed, 20 Mar 2019 17:29:56 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>, xuwei5@hisilicon.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, peter.griffin@linaro.org,
        guodong.xu@linaro.org, haojian.zhuang@linaro.org
Subject: Re: [PATCH 1/2] amba: Take device out of reset before reading pid
 and cid values
Message-ID: <20190320172956.lt4eq3vusq4traea@shell.armlinux.org.uk>
References: <20190309015635.5401-1-manivannan.sadhasivam@linaro.org>
 <20190309015635.5401-2-manivannan.sadhasivam@linaro.org>
 <20190312122711.b2ibipico2dgavl7@holly.lan>
 <20190320065658.GA22381@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320065658.GA22381@Mani-XPS-13-9360>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 12:26:58PM +0530, Manivannan Sadhasivam wrote:
> Hi Daniel,
> 
> On Tue, Mar 12, 2019 at 12:27:11PM +0000, Daniel Thompson wrote:
> > On Sat, Mar 09, 2019 at 07:26:34AM +0530, Manivannan Sadhasivam wrote:
> > > For the AMBA Primecell devices having the reset lines wired, it is
> > > necessary to take them out of reset before reading the pid and cid values.
> > > Earlier we were dependent on the bootloader to do this but a more cleaner
> > > approach would be to do it in the kernel itself. Hence, this commit
> > > deasserts the reset line just before reading the pid and cid values.
> > > 
> > > Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  drivers/amba/bus.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> > > index 41b706403ef7..da8f1aac5315 100644
> > > --- a/drivers/amba/bus.c
> > > +++ b/drivers/amba/bus.c
> > > @@ -21,6 +21,7 @@
> > >  #include <linux/limits.h>
> > >  #include <linux/clk/clk-conf.h>
> > >  #include <linux/platform_device.h>
> > > +#include <linux/reset.h>
> > >  
> > >  #include <asm/irq.h>
> > >  
> > > @@ -352,6 +353,7 @@ static void amba_device_release(struct device *dev)
> > >  
> > >  static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
> > >  {
> > > +	struct reset_control *rst;
> > >  	u32 size;
> > >  	void __iomem *tmp;
> > >  	int i, ret;
> > > @@ -388,6 +390,13 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
> > >  	if (ret == 0) {
> > >  		u32 pid, cid;
> > >  
> > > +		/* De-assert the reset line to take the device out of reset */
> > > +		rst = reset_control_get_optional_exclusive(&dev->dev, NULL);
> > > +		if (IS_ERR(rst))
> > > +			return PTR_ERR(rst);
> > 
> > It is really correct to propagate an error if we cannot get exclusive
> > ownership of the reset line.
> > 
> > With drivers for vendor specific cells it is ok to "just know" that the
> > reset line is never shared but we cannot know this for generic cells and
> > we certainly can't know this for the bus.
> > 
> > I think it *might* be OK to propagate an error if you used
> > reset_control_get_optional_shared() instead because if that reports an
> > error than arguably we have either a mistake in the DT or a bug in the
> > driver we are sharing a reset with.
> > 
> 
> Hmm. I'm not sure whether we can assume shared reset lines here or not! Maybe
> Russell can share his opinion here.

I've no reference to base an opinion on as I have no hardware that
would use this facility.

However, it seems obvious to me that if a reset line is shared between
several devices, and when the reset line is asserted, it blocks reading
the ID, then we do need a way for the AMBA primecell code to be able
to lift the reset to read the device ID, and we need to do it in a way
that is capable of being done even when another device/driver has
already bound and taken control of the reset line.

That said, if a reset line is shared between multiple devices, and a
driver wants to assert the reset line, it would disrupt the operation
of all those devices, so there would need to be some kind of
synchronisation between the drivers.

A different way to look at it though is that such a reset line is not
a property of the individual devices, but of the bus - in which case
it should be specified at bus level and controlled at bus level, not
at individual device level.

What is appropriate is entirely dependent on the hardware setup, and
as I said above, with no view of the hardware I am unable to give a
meaningful opinion.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
