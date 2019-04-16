Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97467C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC9A206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IjV8HYyk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbfDPVyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:54:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43129 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730669AbfDPVyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:54:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id c8so11039934pfd.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 14:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NhuTBkbvTznNaFrq+/UUrhs6fQWEX2O1Uah2moqJDlM=;
        b=IjV8HYykawLHC7qSQF8ZCPMx2iXuKBbg6BrwsSdi/sqT47SwXT7yS/1daiZcQbYyEQ
         KAvZU3uR3Rj9qST+yJTgRatoMZxGub6HGOfObi6/qchoOc/cycdo2i3ljJ0AUIc3N4bk
         n1XYDraCquh0eaM6EmEVthxg/KhawnI/5vy4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NhuTBkbvTznNaFrq+/UUrhs6fQWEX2O1Uah2moqJDlM=;
        b=lZFADwP6slzUuu1yFFwVlLLxGWuyB1nJkd7sym9ty33Y17BZ1Ouks203g96/qQoBzc
         vCPL4F3UzpWfE/4Axsu59wYFhCboz56pT9oJqDnpY//iinZ9iG4jaOTKDhYSzrvcsUCK
         hywfjhZ63EJpSANPXPp++UwuaiSbvjvUyOLLEBOXFXN3DIWlmOZr8WNpb54s4wOvbaoU
         9zZM8d0OKH2kYqM6PpYzKuz2fCbeQk2j1gTneEJaJcCDAG8hERMtzLDs1rQZ3Yd/QnMA
         eGxsk2ggxz0j23xX7F74DpGqrOsz+tDhdiqqfxoh0kFmrNv+81bhfXBaRvZyItZJiqV3
         5Xig==
X-Gm-Message-State: APjAAAVG1piQblho52v4jWReq7kTxdq053QJs+oRscomGNwaBCAhtpzf
        QBCU3MnmbujoGvcKmDpa7iXdHg==
X-Google-Smtp-Source: APXvYqwWfoKWZsdXqWpwL1pK8HNiauVy7bRxPDqc5xd2wCgGg0sCdZsMJe7mMKv0YKBeuGVe0i7uyg==
X-Received: by 2002:a63:ef0a:: with SMTP id u10mr61563309pgh.199.1555451654170;
        Tue, 16 Apr 2019 14:54:14 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id b6sm8156770pgt.58.2019.04.16.14.54.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 14:54:13 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     amstan@chromium.org, linux-rockchip@lists.infradead.org,
        linux-usb@vger.kernel.org, Randy Li <ayaka@soulik.info>,
        mka@chromium.org, ryandcase@chromium.org, jwerner@chromium.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Yunzhi Li <lyz@rock-chips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] usb: dwc2: optionally assert phy reset when waking up
Date:   Tue, 16 Apr 2019 14:53:49 -0700
Message-Id: <20190416215351.242246-3-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190416215351.242246-1-dianders@chromium.org>
References: <20190416215351.242246-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the rk3288 USB host-only port (the one that's not the OTG-enabled
port) the PHY can get into a bad state when a wakeup is asserted (not
just a wakeup from full system suspend but also a wakeup from
autosuspend).

We can get the PHY out of its bad state by asserting its "port reset",
but unfortunately that seems to assert a reset onto the USB bus so it
could confuse things if we don't actually deenumerate / reenumerate the
device.

We can also get the PHY out of its bad state by fully resetting it using
the reset from the CRU (clock reset unit), which does a more full
reset.  The CRU-based reset appears to actually cause devices on the bus
to be removed and reinserted, which fixes the problem (albeit in a hacky
way).

It's unfortunate that we need to do a full re-enumeration of devices at
wakeup time, but this is better than alternative of letting the bus get
wedged.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Yunzhi Li <lyz@rock-chips.com>
---

Changes in v2:
- Cancel the work when dwc2 is freed (Matthias).

 drivers/usb/dwc2/core.h      |  5 +++++
 drivers/usb/dwc2/core_intr.c | 12 ++++++++++++
 drivers/usb/dwc2/hcd.c       | 18 +++++++++++++++---
 drivers/usb/dwc2/platform.c  |  9 +++++++++
 4 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 30bab8463c96..f30748f4fe7e 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -859,6 +859,8 @@ struct dwc2_hregs_backup {
  * @gadget_enabled:	Peripheral mode sub-driver initialization indicator.
  * @ll_hw_enabled:	Status of low-level hardware resources.
  * @hibernated:		True if core is hibernated
+ * @reset_phy_on_wake:	Quirk saying that we should assert PHY reset on a
+ *			remote wakeup.
  * @frame_number:       Frame number read from the core. For both device
  *			and host modes. The value ranges are from 0
  *			to HFNUM_MAX_FRNUM.
@@ -972,6 +974,7 @@ struct dwc2_hregs_backup {
  * @status_buf_dma:     DMA address for status_buf
  * @start_work:         Delayed work for handling host A-cable connection
  * @reset_work:         Delayed work for handling a port reset
+ * @phy_reset_work:     Work structure for doing a PHY reset
  * @otg_port:           OTG port number
  * @frame_list:         Frame list
  * @frame_list_dma:     Frame list DMA address
@@ -1045,6 +1048,7 @@ struct dwc2_hsotg {
 	unsigned int gadget_enabled:1;
 	unsigned int ll_hw_enabled:1;
 	unsigned int hibernated:1;
+	unsigned int reset_phy_on_wake:1;
 	u16 frame_number;
 
 	struct phy *phy;
@@ -1147,6 +1151,7 @@ struct dwc2_hsotg {
 
 	struct delayed_work start_work;
 	struct delayed_work reset_work;
+	struct work_struct phy_reset_work;
 	u8 otg_port;
 	u32 *frame_list;
 	dma_addr_t frame_list_dma;
diff --git a/drivers/usb/dwc2/core_intr.c b/drivers/usb/dwc2/core_intr.c
index 19ae2595f1c3..16ff33574116 100644
--- a/drivers/usb/dwc2/core_intr.c
+++ b/drivers/usb/dwc2/core_intr.c
@@ -435,6 +435,18 @@ static void dwc2_handle_wakeup_detected_intr(struct dwc2_hsotg *hsotg)
 			/* Restart the Phy Clock */
 			pcgcctl &= ~PCGCTL_STOPPCLK;
 			dwc2_writel(hsotg, pcgcctl, PCGCTL);
+
+			/*
+			 * If we've got this quirk then the PHY is stuck upon
+			 * wakeup.  Assert reset.  This will propagate out and
+			 * eventually we'll re-enumerate the device.  Not great
+			 * but the best we can do.  We can't call phy_reset()
+			 * at interrupt time but there's no hurry, so we'll
+			 * schedule it for later.
+			 */
+			if (hsotg->reset_phy_on_wake)
+				schedule_work(&hsotg->phy_reset_work);
+
 			mod_timer(&hsotg->wkp_timer,
 				  jiffies + msecs_to_jiffies(71));
 		} else {
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 3f087962f498..e272d020012e 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4376,6 +4376,17 @@ static void dwc2_hcd_reset_func(struct work_struct *work)
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 }
 
+static void dwc2_hcd_phy_reset_func(struct work_struct *work)
+{
+	struct dwc2_hsotg *hsotg = container_of(work, struct dwc2_hsotg,
+						phy_reset_work);
+	int ret;
+
+	ret = phy_reset(hsotg->phy);
+	if (ret)
+		dev_warn(hsotg->dev, "PHY reset failed\n");
+}
+
 /*
  * =========================================================================
  *  Linux HC Driver Functions
@@ -5130,6 +5141,8 @@ static void dwc2_hcd_free(struct dwc2_hsotg *hsotg)
 		destroy_workqueue(hsotg->wq_otg);
 	}
 
+	cancel_work_sync(&hsotg->phy_reset_work);
+
 	del_timer(&hsotg->wkp_timer);
 }
 
@@ -5271,11 +5284,10 @@ int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
 		hsotg->hc_ptr_array[i] = channel;
 	}
 
-	/* Initialize hsotg start work */
+	/* Initialize work */
 	INIT_DELAYED_WORK(&hsotg->start_work, dwc2_hcd_start_func);
-
-	/* Initialize port reset work */
 	INIT_DELAYED_WORK(&hsotg->reset_work, dwc2_hcd_reset_func);
+	INIT_WORK(&hsotg->phy_reset_work, dwc2_hcd_phy_reset_func);
 
 	/*
 	 * Allocate space for storing data on status transactions. Normally no
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index c0b64d483552..9b65b766e0b9 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -481,6 +481,15 @@ static int dwc2_driver_probe(struct platform_device *dev)
 		hsotg->gadget_enabled = 1;
 	}
 
+	hsotg->reset_phy_on_wake =
+		of_property_read_bool(dev->dev.of_node,
+				      "snps,reset-phy-on-wake");
+	if (hsotg->reset_phy_on_wake && !hsotg->phy) {
+		dev_warn(hsotg->dev,
+			 "Quirk reset-phy-on-wake only supports generic PHYs\n");
+		hsotg->reset_phy_on_wake = false;
+	}
+
 	if (hsotg->dr_mode != USB_DR_MODE_PERIPHERAL) {
 		retval = dwc2_hcd_init(hsotg);
 		if (retval) {
-- 
2.21.0.593.g511ec345e18-goog

