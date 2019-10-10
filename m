Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA744C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DFD20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWRKwkWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfJJN5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:57:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41165 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfJJN5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:57:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id q9so8027192wrm.8;
        Thu, 10 Oct 2019 06:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BI+X9/23+Lvr8h9vJlp7cjBXaJiIevfv3xHjpHNIvrc=;
        b=AWRKwkWrp/jPWpCQAuNyzR/eF5h9hIwxFlb5RXrN521n9DPGGRADph3yS+BfIGqF+Z
         2P/9yq5kzVo0QKGSijDzI8HYBVVMQyiNQ8GlySyCqExxqQFMLdwMcwc3N7KRD7NcMpJH
         tAHV20qsYM0IC+TyFSHB4L13ZjGhdwFxYPBg1GX0BQa7eVSOo+QQXD/zHDosRM1Bs/EY
         QhannvF7eHGqrYp58PPhC+nREvnJ0oqjuoid3xS9+kGkgiJClwHBqlseaKYcR3mnqT+1
         lpvsM2gjOKzdZyxVJJMgHZCnAjBiqp0Uf2eW7pOuc6WMvHp8VmK21T571LYOEtWD4/G3
         VF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BI+X9/23+Lvr8h9vJlp7cjBXaJiIevfv3xHjpHNIvrc=;
        b=JcJHeyUYQiEAKbUERbTJwdehB85jfFDdONbu2ZySyuh7gyNsX3Eam46oaGJtUY2me8
         UT2aCzSII8hH8ON7rpkLYrnKr8E7goG9Osf21ZV/X6Nql5S2Mf3bD4q9kXHLq+Gah4f6
         Uh5lH8Y0uF5lDJLAbvYntkpW1BMiYeppcJ33lz9KcR3TpDDea2MIohVuDfK84L2Ypw0E
         LqIOCg6dnuL8Cr9VETszItZB5QhZY0zci7VYLt3Xp26ysmwEAdOY7QhoGQmvaIMnciDr
         f1P7Zl+4KYp+bXX0Ylgq3i2RO0PHfF25Iq2ASMZ5isYOq5ukmPmXb99Bs+kjCOvzfJQp
         EA+Q==
X-Gm-Message-State: APjAAAUl1P+Py5paYXk2Xxgo1KWsmBJ8a9Z3xq786mTIj5kOiKYun+ap
        IljLbr3CR8t2Wcu4lMFAUUx1CyewmEU=
X-Google-Smtp-Source: APXvYqx9xZon+o/bW79wbx03uRwh314eTdqElwNEpnJLMdjcHDrL1qCZkldI2UDo81i5d1UPOHrRLw==
X-Received: by 2002:a5d:6447:: with SMTP id d7mr8801561wrw.247.1570715827786;
        Thu, 10 Oct 2019 06:57:07 -0700 (PDT)
Received: from localhost ([194.105.145.90])
        by smtp.gmail.com with ESMTPSA id q15sm9125827wrg.65.2019.10.10.06.57.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Oct 2019 06:57:06 -0700 (PDT)
From:   Igor Opaniuk <igor.opaniuk@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Li Jun <jun.li@nxp.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] usb: phy: add usb mode for usb_phy
Date:   Thu, 10 Oct 2019 16:56:54 +0300
Message-Id: <20191010135656.3264-1-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Jun <jun.li@nxp.com>

USB phy driver may need to know the current working mode of
the controller, and can provide different settings according to
host mode or device mode.

Signed-off-by: Li Jun <jun.li@nxp.com>
Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
---

v2:
- restored original commit author
- fixed build for multi_v7

 include/linux/usb/phy.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
index e4de6bc1f69b..d138703e3688 100644
--- a/include/linux/usb/phy.h
+++ b/include/linux/usb/phy.h
@@ -63,6 +63,13 @@ enum usb_otg_state {
 	OTG_STATE_A_VBUS_ERR,
 };
 
+/* The usb role of phy to be working with */
+enum usb_current_mode {
+	USB_CURRENT_MODE_NONE,
+	USB_CURRENT_MODE_HOST,
+	USB_CURRENT_MODE_DEVICE,
+};
+
 struct usb_phy;
 struct usb_otg;
 
@@ -155,6 +162,13 @@ struct usb_phy {
 	 * manually detect the charger type.
 	 */
 	enum usb_charger_type (*charger_detect)(struct usb_phy *x);
+
+	/*
+	 * Set current working mode of the USB controller
+	 * (device, host)
+	 */
+	int	(*set_mode)(struct usb_phy *x,
+			enum usb_current_mode mode);
 };
 
 /* for board-specific init logic */
@@ -213,6 +227,15 @@ usb_phy_vbus_off(struct usb_phy *x)
 	return x->set_vbus(x, false);
 }
 
+static inline int
+usb_phy_set_mode(struct usb_phy *x, enum usb_current_mode mode)
+{
+	if (!x || !x->set_mode)
+		return 0;
+
+	return x->set_mode(x, mode);
+}
+
 /* for usb host and peripheral controller drivers */
 #if IS_ENABLED(CONFIG_USB_PHY)
 extern struct usb_phy *usb_get_phy(enum usb_phy_type type);
-- 
2.17.1

