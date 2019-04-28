Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8CCC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 12:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2C42075D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 12:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfD1Mxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 08:53:41 -0400
Received: from smtp-out.xnet.cz ([178.217.244.18]:45324 "EHLO smtp-out.xnet.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfD1Mxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 08:53:41 -0400
Received: from meh.true.cz (meh.true.cz [108.61.167.218])
        (Authenticated sender: petr@true.cz)
        by smtp-out.xnet.cz (Postfix) with ESMTPSA id D154E4533;
        Sun, 28 Apr 2019 14:53:38 +0200 (CEST)
Received: by meh.true.cz (OpenSMTPD) with ESMTP id eb05989d;
        Sun, 28 Apr 2019 14:53:37 +0200 (CEST)
From:   =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Alban Bedel <albeu@free.fr>,
        =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>
Subject: [PATCH v2 1/4] of_net: Add NVMEM support to of_get_mac_address
Date:   Sun, 28 Apr 2019 14:53:19 +0200
Message-Id: <1556456002-13430-2-git-send-email-ynezz@true.cz>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556456002-13430-1-git-send-email-ynezz@true.cz>
References: <1556456002-13430-1-git-send-email-ynezz@true.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many embedded devices have information such as MAC addresses stored
inside NVMEMs like EEPROMs and so on. Currently there are only two
drivers in the tree which benefit from NVMEM bindings.

Adding support for NVMEM into every other driver would mean adding a lot
of repetitive code. This patch allows us to configure MAC addresses in
various devices like ethernet and wireless adapters directly from
of_get_mac_address, which is already used by almost every driver in the
tree.

Predecessor of this patch which used directly MTD layer has originated
in OpenWrt some time ago and supports already about 497 use cases in 357
device tree files.

Cc: Alban Bedel <albeu@free.fr>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Petr Štetiar <ynezz@true.cz>
---

 Changes since v1:

  * moved handling of nvmem after mac-address and local-mac-address properties

 drivers/of/of_net.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/of/of_net.c b/drivers/of/of_net.c
index d820f3e..8ce4f47 100644
--- a/drivers/of/of_net.c
+++ b/drivers/of/of_net.c
@@ -8,6 +8,7 @@
 #include <linux/etherdevice.h>
 #include <linux/kernel.h>
 #include <linux/of_net.h>
+#include <linux/of_platform.h>
 #include <linux/phy.h>
 #include <linux/export.h>
 
@@ -47,12 +48,45 @@ static const void *of_get_mac_addr(struct device_node *np, const char *name)
 	return NULL;
 }
 
+static const void *of_get_mac_addr_nvmem(struct device_node *np)
+{
+	int r;
+	u8 mac[ETH_ALEN];
+	struct property *pp;
+	struct platform_device *pdev = of_find_device_by_node(np);
+
+	if (!pdev)
+		return NULL;
+
+	r = nvmem_get_mac_address(&pdev->dev, &mac);
+	if (r < 0)
+		return NULL;
+
+	pp = kzalloc(sizeof(*pp), GFP_KERNEL);
+	if (!pp)
+		return NULL;
+
+	pp->name = "nvmem-mac-address";
+	pp->length = ETH_ALEN;
+	pp->value = kmemdup(mac, ETH_ALEN, GFP_KERNEL);
+	if (!pp->value || of_add_property(np, pp))
+		goto free;
+
+	return pp->value;
+free:
+	kfree(pp->value);
+	kfree(pp);
+
+	return NULL;
+}
+
 /**
  * Search the device tree for the best MAC address to use.  'mac-address' is
  * checked first, because that is supposed to contain to "most recent" MAC
  * address. If that isn't set, then 'local-mac-address' is checked next,
- * because that is the default address.  If that isn't set, then the obsolete
- * 'address' is checked, just in case we're using an old device tree.
+ * because that is the default address.  If that isn't set, try to get MAC
+ * address from nvmem cell named 'mac-address'. If that isn't set, then the
+ * obsolete 'address' is checked, just in case we're using an old device tree.
  *
  * Note that the 'address' property is supposed to contain a virtual address of
  * the register set, but some DTS files have redefined that property to be the
@@ -77,6 +111,10 @@ const void *of_get_mac_address(struct device_node *np)
 	if (addr)
 		return addr;
 
+	addr = of_get_mac_addr_nvmem(np);
+	if (addr)
+		return addr;
+
 	return of_get_mac_addr(np, "address");
 }
 EXPORT_SYMBOL(of_get_mac_address);
-- 
1.9.1

