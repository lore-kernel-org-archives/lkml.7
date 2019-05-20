Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548BFC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2733E206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FiXpYT81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfETR4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:56:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34656 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfETR4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:56:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id n19so7604061pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3sdiqccgDJXtFrjjl4K/P/M1SmaN+5PXQCYKXAqHDcE=;
        b=FiXpYT81ZnLjNm2EkX/LKALMKY0iF/oE+2o+nrgvF0uGX/0EEkeEeU5tM5EoIC1L9J
         yJ7P0aF9BL7bVJUMit3At2Fx3tKAXnmRbW+K36MW/9sDUNaGnd/skuQgNfjMrPJnnTZg
         ssB85hNIZHc8N+6KtyEBpXMuA0P8RzGk7xmhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3sdiqccgDJXtFrjjl4K/P/M1SmaN+5PXQCYKXAqHDcE=;
        b=qzsT0MV0oOb759BJw4m7OFaXprS28Ly9AABJrgTiRcYjT12PKUPI748+q7UnUXoCmi
         M70qmhBndfLY2YdFQSYOQZ+JrfaDbGzic3VVOleweaycPsrvc1ckPJJNU97FGQDZkY81
         e9TkvbXXWMYqRwpVoPAHMT7WxV7yUgU9y6vP0GRMAAxivQrkcfdkWn/dRTp6rZDf24G8
         WAQXn1t6Lg5ToIxly7CPI5pf/KXsba4+t15F2Gr34c6ED8xrXVb/69UWLBt2BaWg/w5X
         gI6nHEn6gXXHM8KbMrUvlhG+Pn89j2rwXmV2AIgszsUD6n6aPtAcKbPxfDB81J2av8Lm
         fzlQ==
X-Gm-Message-State: APjAAAWf/HFLn1UQSPZ1YDjJTG8/sEGZNZ4dqa8tz+5kZOq5zsFfDkEN
        wYR24Kx2lqqPmMb4axeisu10UA==
X-Google-Smtp-Source: APXvYqyesrrZw3c6wnWIYKskRfQzbmGey2GoXlGuQ2obakNmbEU9VplgKM4DwUU5orVX5Nf76vXgJw==
X-Received: by 2002:a62:2703:: with SMTP id n3mr81869816pfn.199.1558374975284;
        Mon, 20 May 2019 10:56:15 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id o2sm16852723pgq.1.2019.05.20.10.56.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 10:56:14 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>, heiko@sntech.de
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        amstan@chromium.org, linux-rockchip@lists.infradead.org,
        William Wu <william.wu@rock-chips.com>,
        linux-usb@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Randy Li <ayaka@soulik.info>, zyw@rock-chips.com,
        mka@chromium.org, ryandcase@chromium.org,
        Amelie Delaunay <amelie.delaunay@st.com>, jwerner@chromium.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] USB: dwc2: Don't turn off the usbphy in suspend if wakeup is enabled
Date:   Mon, 20 May 2019 10:56:04 -0700
Message-Id: <20190520175605.2405-3-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190520175605.2405-1-dianders@chromium.org>
References: <20190520175605.2405-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the 'snps,need-phy-for-wake' is set in the device tree then:

- We know that we can wakeup, so call device_set_wakeup_capable().
  The USB core will use this knowledge to enable wakeup by default.
- We know that we should keep the PHY on during suspend if something
  on our root hub needs remote wakeup.  This requires the patch (USB:
  Export usb_wakeup_enabled_descendants()).  Note that we don't keep
  the PHY on at suspend time if it's not needed because it would be a
  power draw.

If we later find some users of dwc2 that can support wakeup without
keeping the PHY on we may want to add a way to call
device_set_wakeup_capable() without keeping the PHY on at suspend
time.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---
For relevant prior discussion of this idea, see:

https://lkml.kernel.org/r/1436207224-21849-4-git-send-email-dianders@chromium.org

If I'm reading all the responses correctly folks were of the opinion
that this patch is still the right way to go.

Changes in v3:
- Fixed kbuild test robot error.

Changes in v2:
- Rebased to mainline atop rk3288 remote wake quirk series.

 drivers/usb/dwc2/core.h     |  8 ++++++++
 drivers/usb/dwc2/hcd.c      | 19 +++++++++++++++++++
 drivers/usb/dwc2/platform.c | 23 ++++++++++++++++++++---
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 152ac41dfb2d..d08d070a0fb6 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -861,6 +861,9 @@ struct dwc2_hregs_backup {
  * @hibernated:		True if core is hibernated
  * @reset_phy_on_wake:	Quirk saying that we should assert PHY reset on a
  *			remote wakeup.
+ * @phy_off_for_suspend: Status of whether we turned the PHY off at suspend.
+ * @need_phy_for_wake:	Quirk saying that we should keep the PHY on at
+ *			suspend if we need USB to wake us up.
  * @frame_number:       Frame number read from the core. For both device
  *			and host modes. The value ranges are from 0
  *			to HFNUM_MAX_FRNUM.
@@ -1049,6 +1052,8 @@ struct dwc2_hsotg {
 	unsigned int ll_hw_enabled:1;
 	unsigned int hibernated:1;
 	unsigned int reset_phy_on_wake:1;
+	unsigned int need_phy_for_wake:1;
+	unsigned int phy_off_for_suspend:1;
 	u16 frame_number;
 
 	struct phy *phy;
@@ -1438,6 +1443,7 @@ int dwc2_restore_host_registers(struct dwc2_hsotg *hsotg);
 int dwc2_host_enter_hibernation(struct dwc2_hsotg *hsotg);
 int dwc2_host_exit_hibernation(struct dwc2_hsotg *hsotg,
 			       int rem_wakeup, int reset);
+bool dwc2_host_can_poweroff_phy(struct dwc2_hsotg *dwc2);
 static inline void dwc2_host_schedule_phy_reset(struct dwc2_hsotg *hsotg)
 { schedule_work(&hsotg->phy_reset_work); }
 #else
@@ -1463,6 +1469,8 @@ static inline int dwc2_host_enter_hibernation(struct dwc2_hsotg *hsotg)
 static inline int dwc2_host_exit_hibernation(struct dwc2_hsotg *hsotg,
 					     int rem_wakeup, int reset)
 { return 0; }
+static inline bool dwc2_host_can_poweroff_phy(struct dwc2_hsotg *dwc2)
+{ return false; }
 static inline void dwc2_host_schedule_phy_reset(struct dwc2_hsotg *hsotg) {}
 
 #endif
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index b50ec3714fd8..cc918fe7ddb8 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -5578,3 +5578,22 @@ int dwc2_host_exit_hibernation(struct dwc2_hsotg *hsotg, int rem_wakeup,
 	dev_dbg(hsotg->dev, "Host hibernation restore complete\n");
 	return ret;
 }
+
+bool dwc2_host_can_poweroff_phy(struct dwc2_hsotg *dwc2)
+{
+	struct usb_device *root_hub = dwc2_hsotg_to_hcd(dwc2)->self.root_hub;
+
+	/* If the controller isn't allowed to wakeup then we can power off. */
+	if (!device_may_wakeup(dwc2->dev))
+		return true;
+
+	/*
+	 * We don't want to power off the PHY if something under the
+	 * root hub has wakeup enabled.
+	 */
+	if (usb_wakeup_enabled_descendants(root_hub))
+		return false;
+
+	/* No reason to keep the PHY powered, so allow poweroff */
+	return true;
+}
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index d10a7f8daec3..3e6c3c8a32ff 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -447,6 +447,10 @@ static int dwc2_driver_probe(struct platform_device *dev)
 	if (retval)
 		goto error;
 
+	hsotg->need_phy_for_wake =
+		of_property_read_bool(dev->dev.of_node,
+				      "snps,need-phy-for-wake");
+
 	/*
 	 * Reset before dwc2_get_hwparams() then it could get power-on real
 	 * reset value form registers.
@@ -478,6 +482,14 @@ static int dwc2_driver_probe(struct platform_device *dev)
 		hsotg->gadget_enabled = 1;
 	}
 
+	/*
+	 * If we need PHY for wakeup we must be wakeup capable.
+	 * When we have a device that can wake without the PHY we
+	 * can adjust this condition.
+	 */
+	if (hsotg->need_phy_for_wake)
+		device_set_wakeup_capable(&dev->dev, true);
+
 	hsotg->reset_phy_on_wake =
 		of_property_read_bool(dev->dev.of_node,
 				      "snps,reset-phy-on-wake");
@@ -516,13 +528,17 @@ static int dwc2_driver_probe(struct platform_device *dev)
 static int __maybe_unused dwc2_suspend(struct device *dev)
 {
 	struct dwc2_hsotg *dwc2 = dev_get_drvdata(dev);
+	bool is_device_mode = dwc2_is_device_mode(dwc2);
 	int ret = 0;
 
-	if (dwc2_is_device_mode(dwc2))
+	if (is_device_mode)
 		dwc2_hsotg_suspend(dwc2);
 
-	if (dwc2->ll_hw_enabled)
+	if (dwc2->ll_hw_enabled &&
+	    (is_device_mode || dwc2_host_can_poweroff_phy(dwc2))) {
 		ret = __dwc2_lowlevel_hw_disable(dwc2);
+		dwc2->phy_off_for_suspend = true;
+	}
 
 	return ret;
 }
@@ -532,11 +548,12 @@ static int __maybe_unused dwc2_resume(struct device *dev)
 	struct dwc2_hsotg *dwc2 = dev_get_drvdata(dev);
 	int ret = 0;
 
-	if (dwc2->ll_hw_enabled) {
+	if (dwc2->phy_off_for_suspend && dwc2->ll_hw_enabled) {
 		ret = __dwc2_lowlevel_hw_enable(dwc2);
 		if (ret)
 			return ret;
 	}
+	dwc2->phy_off_for_suspend = false;
 
 	if (dwc2_is_device_mode(dwc2))
 		ret = dwc2_hsotg_resume(dwc2);
-- 
2.21.0.1020.gf2820cf01a-goog

