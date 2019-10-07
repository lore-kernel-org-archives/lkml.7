Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D5EECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F9521721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dy8coq+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfJGMrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:47:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37452 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfJGMrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:47:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id f22so12199786wmc.2;
        Mon, 07 Oct 2019 05:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AT90Kg/zRUtjsdvlXig6kf61Re1a9yGlOxg7dRhOahY=;
        b=dy8coq+B4djgG7XoW0kM31x7L8/pkrlMXAm4QcJzT3GxJGdjcRPIG8+AJd8nECgQ+m
         pSv6qL03Ct01Prjfha2nrDm+//O/Xxuu2wWq4ThMnWXx1Fcsb/tsCr+qHJJ73ciHlxeL
         miOXgGdtx3D/f0d/2vDBi7g7Z5EwX8EJF13O1BbGy0q5pBYKp3qbnQVc/HQ8tGBhJC79
         y2loQusNna46w9WS6FdAPFLne8ruSPAa7iegJZibz1rftSxs3Dgo0amkY1/6q0krKuCx
         3KO/NMJkdjfk02iNAo82YI38MYqQIPbEBwq9CTrMTCEL3dT+ykzJWXGBfR1lfDu0tFXP
         chIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AT90Kg/zRUtjsdvlXig6kf61Re1a9yGlOxg7dRhOahY=;
        b=EXmJvk/WT0w+b9ZvWGzb4agDLRSMFCi/dUKQxmlbQH/N4KTF8BEH3v702qlpkTeWKa
         hSh0QmvR6aO7hCFT2Ph1z03AsgSyZ09bZwg3VYWcBd3HyyXqGP74UKjv1DNKCcOtuSOW
         /BdrRAVDMNONNq6nI947AkbjSiQz9uyaWqfxTIQLj8lefs74BaaiWovlQ710ULbMVI9X
         I24G/EJ6m36QIzzzeXkL8Fv8XamMG+I2CA3TbIx3yi7KfxbvWuL/XWPKpiPx6IcEYfPl
         OPsKxKUb++czYAOrIWl2q1Fwe1AXrscE+mcYjwLTR4CHR36FgQIVY4sH4/+6GXYf38tI
         dscw==
X-Gm-Message-State: APjAAAW5OCfFceF2nLVxNSTkQemhr+9oa5StTAE4SgCq92dwbaXFqaEa
        z0OKjSKFKIySiVF+SxE90db8Qau2S+U=
X-Google-Smtp-Source: APXvYqx70mWEwFEmfHG43cYeL+pn2QE7GLbM4OthUvaC2hktxXvef6MBklkVuZdXGxUiqauM7QgMTQ==
X-Received: by 2002:a7b:cbc5:: with SMTP id n5mr21592790wmi.31.1570452452161;
        Mon, 07 Oct 2019 05:47:32 -0700 (PDT)
Received: from localhost ([194.105.145.90])
        by smtp.gmail.com with ESMTPSA id w5sm15870495wrs.34.2019.10.07.05.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Oct 2019 05:47:31 -0700 (PDT)
From:   Igor Opaniuk <igor.opaniuk@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Li Jun <jun.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 1/3] usb: phy: add usb mode for usb_phy
Date:   Mon,  7 Oct 2019 15:46:05 +0300
Message-Id: <20191007124607.20618-1-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Opaniuk <igor.opaniuk@toradex.com>

USB phy driver may need to know the current working mode of
the controller, and can provide different settings according to
host mode or device mode.

Signed-off-by: Li Jun <jun.li@nxp.com>
Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
---

 include/linux/usb/phy.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
index e4de6bc1f69b..774941be77d7 100644
--- a/include/linux/usb/phy.h
+++ b/include/linux/usb/phy.h
@@ -63,6 +63,13 @@ enum usb_otg_state {
 	OTG_STATE_A_VBUS_ERR,
 };
 
+/* The usb role of phy to be working with */
+enum usb_current_mode {
+	USB_MODE_NONE,
+	USB_MODE_HOST,
+	USB_MODE_DEVICE,
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

