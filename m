Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D850CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2FD21783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="r6zvZjTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbfJVOxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 10:53:41 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44558 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfJVOxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 10:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5lyp11EpflVtsKl6EfIpqjOJ+yKJETl+1sVjz6fUMPA=; b=r6zvZjTRlMtVe+21zuRuAik6D
        3BdY4LbbV0QBZBNQrcnolAvMd5fPEXScS165OzafP6+UNg8ukjCut2iq7EPZE1kyh4Ef9CDhoi12C
        D660N5hPjxXDqO8QHNCMR1ZKJmEz4VVAiypAofdfHi16lXbCN4+4ERLJPI7FAPRu4NLbuCyBnwAyL
        Uawx/FqHPqUHjOrTKC6oYIZt4veFdqz8eCmBWkbSF6I4ky87NJ/98y5Q3MoJ9ZAi807w/MK/xEw17
        ZCmpi+qGKQ471DQzKwqTMkkJGU94tYiKxfK15V3m/FS4lglOpEyZtsNh6A/0TED2eP0nBDR3ldBVl
        sfzSCz9HQ==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:46028)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iMvXP-0007ry-Cr; Tue, 22 Oct 2019 15:53:31 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iMvXN-0004fF-1f; Tue, 22 Oct 2019 15:53:29 +0100
Date:   Tue, 22 Oct 2019 15:53:29 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Brian Starkey <Brian.Starkey@arm.com>, nd <nd@arm.com>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        Sean Paul <sean@poorly.run>
Subject: Re: [RFC,3/3] drm/komeda: Allow non-component drm_bridge only
 endpoints
Message-ID: <20191022145328.GW25745@shell.armlinux.org.uk>
References: <20191016162206.u2yo37rtqwou4oep@DESKTOP-E1NTVVP.localdomain>
 <20191017030752.GA3109@jamwan02-TSP300>
 <20191017082043.bpiuvfr3r4jngxtu@DESKTOP-E1NTVVP.localdomain>
 <20191017102055.GA8308@jamwan02-TSP300>
 <20191017104812.6qpuzoh5bx5i2y3m@DESKTOP-E1NTVVP.localdomain>
 <20191017114137.GC25745@shell.armlinux.org.uk>
 <20191022084210.GX11828@phenom.ffwll.local>
 <20191022084826.GP25745@shell.armlinux.org.uk>
 <CAKMK7uHZ1Lw03LhZVH=oAa92WxZXucqooH1w6SG8HG20+g0Rbg@mail.gmail.com>
 <20191022144207.GV25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022144207.GV25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 03:42:07PM +0100, Russell King - ARM Linux admin wrote:
> On Tue, Oct 22, 2019 at 10:50:42AM +0200, Daniel Vetter wrote:
> > On Tue, Oct 22, 2019 at 10:48 AM Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > > I had a patches, which is why I raised the problem with the core:
> > >
> > > 6961edfee26d bridge hacks using device links
> > >
> > > but it never went further than an experiment at the time because of the
> > > problems in the core.  As it was a hack, it never got posted.  Seems
> > > that kernel tree (for the cubox) is still 5.2 based, so has a lot of
> > > patches and might need updating to a more recent base before anything
> > > can be tested.
> > 
> > 
> > For reference, the panel patch:
> > 
> > https://patchwork.kernel.org/patch/10364873/
> > 
> > And the huge discussion around bridges, that resulted in Rafael
> > Wyzocki fixing all the core issues:
> > 
> > https://www.spinics.net/lists/dri-devel/msg201927.html
> > 
> > James, do you want to look into this for bridges?
> 
> I can now confirm that it does work.

Something like this - it's based off an older kernel, so may be missing
some of the bridge drivers, but should be sufficient for people to test
with.

8<====
From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH] drm/bridge: add support for device links to bridge

Bridge devices have been a potential for kernel oops as their lifetime
is independent of the DRM device that they are bound to.  Hence, if a
bridge device is unbound while the parent DRM device is using them, the
parent happily continues to use the bridge device, calling the driver
and accessing its objects that have been freed.

This can cause kernel memory corruption and kernel oops.

To control this, use device links to ensure that the parent DRM device
is unbound when the bridge device is unbound, and when the bridge
device is re-bound, automatically rebind the parent DRM device.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c  |  1 +
 drivers/gpu/drm/bridge/analogix-anx78xx.c     |  1 +
 drivers/gpu/drm/bridge/dumb-vga-dac.c         |  1 +
 drivers/gpu/drm/bridge/lvds-encoder.c         |  1 +
 .../bridge/megachips-stdpxxxx-ge-b850v3-fw.c  |  1 +
 drivers/gpu/drm/bridge/nxp-ptn3460.c          |  1 +
 drivers/gpu/drm/bridge/panel.c                |  1 +
 drivers/gpu/drm/bridge/parade-ps8622.c        |  1 +
 drivers/gpu/drm/bridge/sii902x.c              |  1 +
 drivers/gpu/drm/bridge/sii9234.c              |  1 +
 drivers/gpu/drm/bridge/sil-sii8620.c          |  1 +
 drivers/gpu/drm/bridge/tc358767.c             |  1 +
 drivers/gpu/drm/bridge/ti-tfp410.c            |  1 +
 drivers/gpu/drm/drm_bridge.c                  | 48 ++++++++++++++-----
 drivers/gpu/drm/i2c/tda998x_drv.c             |  1 +
 include/drm/drm_bridge.h                      |  4 ++
 16 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index f6d2681f6927..6a5906da58ea 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1217,6 +1217,7 @@ static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 		goto err_unregister_cec;
 
 	adv7511->bridge.funcs = &adv7511_bridge_funcs;
+	adv7511->bridge.device = dev;
 	adv7511->bridge.of_node = dev->of_node;
 
 	drm_bridge_add(&adv7511->bridge);
diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix-anx78xx.c
index 3c7cc5af735c..77ff17c38037 100644
--- a/drivers/gpu/drm/bridge/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix-anx78xx.c
@@ -1323,6 +1323,7 @@ static int anx78xx_i2c_probe(struct i2c_client *client,
 
 	mutex_init(&anx78xx->lock);
 
+	anx78xx->bridge.device = &client->dev;
 #if IS_ENABLED(CONFIG_OF)
 	anx78xx->bridge.of_node = client->dev.of_node;
 #endif
diff --git a/drivers/gpu/drm/bridge/dumb-vga-dac.c b/drivers/gpu/drm/bridge/dumb-vga-dac.c
index d32885b906ae..40169920560e 100644
--- a/drivers/gpu/drm/bridge/dumb-vga-dac.c
+++ b/drivers/gpu/drm/bridge/dumb-vga-dac.c
@@ -202,6 +202,7 @@ static int dumb_vga_probe(struct platform_device *pdev)
 	}
 
 	vga->bridge.funcs = &dumb_vga_bridge_funcs;
+	vga->bridge.device = &pdev->dev;
 	vga->bridge.of_node = pdev->dev.of_node;
 	vga->bridge.timings = of_device_get_match_data(&pdev->dev);
 
diff --git a/drivers/gpu/drm/bridge/lvds-encoder.c b/drivers/gpu/drm/bridge/lvds-encoder.c
index 2ab2c234f26c..5012be35a5fb 100644
--- a/drivers/gpu/drm/bridge/lvds-encoder.c
+++ b/drivers/gpu/drm/bridge/lvds-encoder.c
@@ -115,6 +115,7 @@ static int lvds_encoder_probe(struct platform_device *pdev)
 	 * to look up.
 	 */
 	lvds_encoder->bridge.of_node = dev->of_node;
+	lvds_encoder->bridge.device = dev;
 	lvds_encoder->bridge.funcs = &funcs;
 	drm_bridge_add(&lvds_encoder->bridge);
 
diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
index 79311f8354bd..e211c57f6f56 100644
--- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
+++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
@@ -304,6 +304,7 @@ static int stdp4028_ge_b850v3_fw_probe(struct i2c_client *stdp4028_i2c,
 
 	/* drm bridge initialization */
 	ge_b850v3_lvds_ptr->bridge.funcs = &ge_b850v3_lvds_funcs;
+	ge_b850v3_lvds_ptr->bridge.device = dev;
 	ge_b850v3_lvds_ptr->bridge.of_node = dev->of_node;
 	drm_bridge_add(&ge_b850v3_lvds_ptr->bridge);
 
diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/nxp-ptn3460.c
index 98bc650b8c95..00097e314575 100644
--- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
+++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
@@ -323,6 +323,7 @@ static int ptn3460_probe(struct i2c_client *client,
 	}
 
 	ptn_bridge->bridge.funcs = &ptn3460_bridge_funcs;
+	ptn_bridge->bridge.device = dev;
 	ptn_bridge->bridge.of_node = dev->of_node;
 	drm_bridge_add(&ptn_bridge->bridge);
 
diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index b12ae3a4c5f1..eab7126f0d61 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -168,6 +168,7 @@ struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel,
 	panel_bridge->panel = panel;
 
 	panel_bridge->bridge.funcs = &panel_bridge_bridge_funcs;
+	panel_bridge->bridge.device = panel->dev;
 #ifdef CONFIG_OF
 	panel_bridge->bridge.of_node = panel->dev->of_node;
 #endif
diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bridge/parade-ps8622.c
index 2d88146e4836..ff79df0ff183 100644
--- a/drivers/gpu/drm/bridge/parade-ps8622.c
+++ b/drivers/gpu/drm/bridge/parade-ps8622.c
@@ -589,6 +589,7 @@ static int ps8622_probe(struct i2c_client *client,
 	}
 
 	ps8622->bridge.funcs = &ps8622_bridge_funcs;
+	ps8622->bridge.device = dev;
 	ps8622->bridge.of_node = dev->of_node;
 	drm_bridge_add(&ps8622->bridge);
 
diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index dd7aa466b280..ef768b149bee 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -991,6 +991,7 @@ static int sii902x_probe(struct i2c_client *client,
 	}
 
 	sii902x->bridge.funcs = &sii902x_bridge_funcs;
+	sii902x->bridge.device = dev;
 	sii902x->bridge.of_node = dev->of_node;
 	sii902x->bridge.timings = &default_sii902x_timings;
 	drm_bridge_add(&sii902x->bridge);
diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/sii9234.c
index 25d4ad8c7ad6..824ffaeff16e 100644
--- a/drivers/gpu/drm/bridge/sii9234.c
+++ b/drivers/gpu/drm/bridge/sii9234.c
@@ -936,6 +936,7 @@ static int sii9234_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, ctx);
 
 	ctx->bridge.funcs = &sii9234_bridge_funcs;
+	ctx->bridge.device = dev;
 	ctx->bridge.of_node = dev->of_node;
 	drm_bridge_add(&ctx->bridge);
 
diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index bd3165ee5354..5bc56c5f6826 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -2333,6 +2333,7 @@ static int sii8620_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, ctx);
 
 	ctx->bridge.funcs = &sii8620_bridge_funcs;
+	ctx->bridge.device = dev;
 	ctx->bridge.of_node = dev->of_node;
 	drm_bridge_add(&ctx->bridge);
 
diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 13ade28a36a8..d62c6925c5fe 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1526,6 +1526,7 @@ static int tc_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return ret;
 
 	tc->bridge.funcs = &tc_bridge_funcs;
+	tc->bridge.device = dev;
 	tc->bridge.of_node = dev->of_node;
 	drm_bridge_add(&tc->bridge);
 
diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index dbf35c7bc85e..2f9899d7d4b4 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -326,6 +326,7 @@ static int tfp410_init(struct device *dev, bool i2c)
 	dev_set_drvdata(dev, dvi);
 
 	dvi->bridge.funcs = &tfp410_bridge_funcs;
+	dvi->bridge.device = dev;
 	dvi->bridge.of_node = dev->of_node;
 	dvi->bridge.timings = &dvi->timings;
 	dvi->dev = dev;
diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index cba537c99e43..b4561ce63a49 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -26,6 +26,7 @@
 #include <linux/mutex.h>
 
 #include <drm/drm_bridge.h>
+#include <drm/drm_device.h>
 #include <drm/drm_encoder.h>
 
 #include "drm_crtc_internal.h"
@@ -463,6 +464,32 @@ void drm_atomic_bridge_enable(struct drm_bridge *bridge,
 EXPORT_SYMBOL(drm_atomic_bridge_enable);
 
 #ifdef CONFIG_OF
+static struct drm_bridge *drm_bridge_find(struct drm_device *dev,
+					  struct device_node *np, bool link)
+{
+	struct drm_bridge *bridge, *found = NULL;
+	struct device_link *dl;
+
+	mutex_lock(&bridge_lock);
+
+	list_for_each_entry(bridge, &bridge_list, list)
+		if (bridge->of_node == np) {
+			found = bridge;
+			break;
+		}
+
+	if (found && link) {
+		dl = device_link_add(dev->dev, found->device,
+				     DL_FLAG_AUTOPROBE_CONSUMER);
+		if (!dl)
+			found = NULL;
+	}
+
+	mutex_unlock(&bridge_lock);
+
+	return found;
+}
+
 /**
  * of_drm_find_bridge - find the bridge corresponding to the device node in
  *			the global bridge list
@@ -474,21 +501,16 @@ EXPORT_SYMBOL(drm_atomic_bridge_enable);
  */
 struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 {
-	struct drm_bridge *bridge;
-
-	mutex_lock(&bridge_lock);
-
-	list_for_each_entry(bridge, &bridge_list, list) {
-		if (bridge->of_node == np) {
-			mutex_unlock(&bridge_lock);
-			return bridge;
-		}
-	}
-
-	mutex_unlock(&bridge_lock);
-	return NULL;
+	return drm_bridge_find(NULL, np, false);
 }
 EXPORT_SYMBOL(of_drm_find_bridge);
+
+struct drm_bridge *of_drm_find_bridge_devlink(struct drm_device *dev,
+					      struct device_node *np)
+{
+	return drm_bridge_find(dev, np, true);
+}
+EXPORT_SYMBOL(of_drm_find_bridge_devlink);
 #endif
 
 MODULE_AUTHOR("Ajay Kumar <ajaykumar.rs@samsung.com>");
diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index e79507fb225f..5d4122bcf7ff 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -2201,6 +2201,7 @@ static int tda998x_create(struct device *dev)
 	}
 
 	priv->bridge.funcs = &tda998x_bridge_funcs;
+	priv->bridge.device = dev;
 #ifdef CONFIG_OF
 	priv->bridge.of_node = dev->of_node;
 #endif
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 7616f6562fe4..f8a3af42a382 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -382,6 +382,8 @@ struct drm_bridge {
 	struct drm_encoder *encoder;
 	/** @next: the next bridge in the encoder chain */
 	struct drm_bridge *next;
+	/** @device: Linux driver model device */
+	struct device *device;
 #ifdef CONFIG_OF
 	/** @of_node: device node pointer to the bridge */
 	struct device_node *of_node;
@@ -403,6 +405,8 @@ struct drm_bridge {
 void drm_bridge_add(struct drm_bridge *bridge);
 void drm_bridge_remove(struct drm_bridge *bridge);
 struct drm_bridge *of_drm_find_bridge(struct device_node *np);
+struct drm_bridge *of_drm_find_bridge_devlink(struct drm_device *dev,
+					      struct device_node *np);
 int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 		      struct drm_bridge *previous);
 
-- 
2.20.1


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
