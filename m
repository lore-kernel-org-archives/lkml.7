Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A52FECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B74B2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bn3ZspUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732645AbfJNOR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:17:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37599 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732422AbfJNOR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:17:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id f22so16936890wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6RXqG5Af/3T765Lcjtvbk/UObYQwmVYQ6qNsUxXclLs=;
        b=bn3ZspUJJ5UmMi0EdqwKTRnQu9xyBbhCz62kjUH/dRTv/U+R0Vv2f7jH6o/xm9oWt7
         GrZzedImYwuSI/KfxNoprRt4yCQuF3UKoP8Qyte/eFQvbYUERKNpyuIDyDSrn4Nf5c/J
         sPDIrLKFSBrSPjHmjXTpBgDfnouc4tTux3Zdn1x4CX9W/+rgvyuEJu/eJ/H8FcsJE/Yx
         DZiuFmFpzQnvr5rzX4WRfc1Aaj4zKxFSkitfhirUs0RH6UJc2rGjH0aPkUGhozrJyn5K
         ce0OpYUP7iW9vepZyOLcc6bmxKYLOud9NWkFOtWHK6f378JF9mEZyWwI1oBz2h/KvqR1
         6HaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6RXqG5Af/3T765Lcjtvbk/UObYQwmVYQ6qNsUxXclLs=;
        b=SGPYW9DS/Gg5ob1ff7K3phqOTECT0O3z4dNfscLIrMmCEd9thqrFcr8fLaHRQast05
         ziQ0Csr6uVgJdyxQhsOnYl+d5B9wUGZDtdhFBK0B7rdRl/5TG9LjeOD8sN/poAhEW2nN
         w3qPGrQFQE/lPAShOLNS3uQCiUpQXKEPIlL+TMdIAhpxqC/WnkpS5MT5youKlBDHLmBR
         YjWf3+j9agc8rUum8/slu2YVblWAw00+ReNkXFNiGl8zHPWVG91mJlVAe3eimalkQNIL
         0PY58w0fBxqz/ZzyTPJhhx0lhlmLbo17BxkX+RQNsmdLKi9TNSOYe2HdhnondmUJExXK
         GR5w==
X-Gm-Message-State: APjAAAUii+FNuisDmtXsBx7iGvVsQrUJN4lo5qUbvmqJFMG+NxSDHMEb
        oUjkB0wRJN4IUOYS7WSMU0Ar2g==
X-Google-Smtp-Source: APXvYqw4IO9MRxbqhVYZiKfAMyWhC/RNKtuMVM/wLlGtJnmTIO2XZbkFlL27avwMAb+BYU5bynNS9Q==
X-Received: by 2002:a7b:c947:: with SMTP id i7mr15599951wml.53.1571062642161;
        Mon, 14 Oct 2019 07:17:22 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t83sm42708624wmt.18.2019.10.14.07.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 07:17:21 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     balbi@kernel.org, khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>, Tim <elatllat@gmail.com>
Subject: [PATCH 2/3] usb: dwc3: gadget: Add support for disabling SS instances in park mode
Date:   Mon, 14 Oct 2019 16:17:17 +0200
Message-Id: <20191014141718.22603-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191014141718.22603-1-narmstrong@baylibre.com>
References: <20191014141718.22603-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In certain circumstances, the XHCI SuperSpeed instance in park mode
can fail to recover, thus on Amlogic G12A/G12B/SM1 SoCs when there is high
load on the single XHCI SuperSpeed instance, the controller can crash like:
 xhci-hcd xhci-hcd.0.auto: xHCI host not responding to stop endpoint command.
 xhci-hcd xhci-hcd.0.auto: Host halt failed, -110
 xhci-hcd xhci-hcd.0.auto: xHCI host controller not responding, assume dead
 xhci-hcd xhci-hcd.0.auto: xHCI host not responding to stop endpoint command.
 hub 2-1.1:1.0: hub_ext_port_status failed (err = -22)
 xhci-hcd xhci-hcd.0.auto: HC died; cleaning up
 usb 2-1.1-port1: cannot reset (err = -22)

Setting the PARKMODE_DISABLE_SS bit in the DWC3_USB3_GUCTL1 mitigates
the issue. The bit is described as :
"When this bit is set to '1' all SS bus instances in park mode are disabled"

CC: Dongjin Kim <tobetter@gmail.com>
Cc: Jianxin Pan <jianxin.pan@amlogic.com>
Reported-by: Tim <elatllat@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/usb/dwc3/core.c | 5 +++++
 drivers/usb/dwc3/core.h | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 999ce5e84d3c..a36cf33330fb 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -993,6 +993,9 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		if (dwc->dis_tx_ipgap_linecheck_quirk)
 			reg |= DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS;
 
+		if (dwc->parkmode_disable_ss_quirk)
+			reg |= DWC3_GUCTL1_PARKMODE_DISABLE_SS;
+
 		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
 	}
 
@@ -1303,6 +1306,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				"snps,dis-del-phy-power-chg-quirk");
 	dwc->dis_tx_ipgap_linecheck_quirk = device_property_read_bool(dev,
 				"snps,dis-tx-ipgap-linecheck-quirk");
+	dwc->parkmode_disable_ss_quirk = device_property_read_bool(dev,
+				"snps,parkmode-disable-ss-quirk");
 
 	dwc->tx_de_emphasis_quirk = device_property_read_bool(dev,
 				"snps,tx_de_emphasis_quirk");
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 1c8b349379af..5fb557f24d38 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -249,6 +249,7 @@
 #define DWC3_GUCTL_HSTINAUTORETRY	BIT(14)
 
 /* Global User Control 1 Register */
+#define DWC3_GUCTL1_PARKMODE_DISABLE_SS	BIT(17)
 #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
 #define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW	BIT(24)
 
@@ -1022,6 +1023,8 @@ struct dwc3_scratchpad_array {
  *			change quirk.
  * @dis_tx_ipgap_linecheck_quirk: set if we disable u2mac linestate
  *			check during HS transmit.
+ * @parkmode_disable_ss_quirk: set if we need to disable all SuperSpeed
+ *			instances in park mode.
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
  * @tx_de_emphasis: Tx de-emphasis value
  * 	0	- -6dB de-emphasis
@@ -1213,6 +1216,7 @@ struct dwc3 {
 	unsigned		dis_u2_freeclk_exists_quirk:1;
 	unsigned		dis_del_phy_power_chg_quirk:1;
 	unsigned		dis_tx_ipgap_linecheck_quirk:1;
+	unsigned		parkmode_disable_ss_quirk:1;
 
 	unsigned		tx_de_emphasis_quirk:1;
 	unsigned		tx_de_emphasis:2;
-- 
2.22.0

