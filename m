Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C9FCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E32F21D7D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="sUE9SHEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfKDOh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:37:27 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39982 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728287AbfKDOh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:37:26 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4ERGoq004129;
        Mon, 4 Nov 2019 15:37:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=+pqW3tmknQkUaVLMwtyyZmv86PtC0OIFE0YGfYD6OSY=;
 b=sUE9SHEQzHgrRVmmtmeCgVACIzEsKwviy+pGX1tYxHdIdTWtA505OzSqxbqm+NE2FVJy
 w32klntmh+IhTYqBlYbkYdj5Oy1DhTzuuyeMv0Zp6a5kNML+8nfufVrpm/s0ZqD0e2Fz
 okqEJBjBMCMwGFnlNvQgzRemdTTleLRGSfR9G3G1kmQId15m/yixlpDFFxTLYwdfXiSg
 1TV93vMCj34PFqkAOmPxuIjhfYa6UMUZCVRH3SlZXhzoNiW070Bh6Wp6VK0pU5WzWbA8
 Nv9ybJvhu9rGEva5qQRE9Afk4ftpKC7vKiH/X8LQnn4syX4DgW7WwWEfZQEMa5aWM2/g ig== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2w11jn25wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 15:37:15 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DB43F10002A;
        Mon,  4 Nov 2019 15:37:14 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C433E220FCD;
        Mon,  4 Nov 2019 15:37:14 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 4 Nov 2019 15:37:14
 +0100
From:   Alexandre Torgue <alexandre.torgue@st.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] phy: core: Add consumer device link support
Date:   Mon, 4 Nov 2019 15:37:13 +0100
Message-ID: <20191104143713.11137-1-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-04_08:2019-11-04,2019-11-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to enforce suspend/resume ordering, this commit creates link
between phy consumers and phy devices. This link avoids to suspend phy
before phy consumers.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

---

Hi,

To manage device_link in phy-core I had to "balance" get and put APIs a bit
more. Fot this reason, you'll find updates in Renesas usbhs rcar and rza drivers
as phy API changes.

Regards
Alex

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index b04f4fe85ac2..8dfb4868c8c3 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -29,7 +29,7 @@ static void devm_phy_release(struct device *dev, void *res)
 {
 	struct phy *phy = *(struct phy **)res;
 
-	phy_put(phy);
+	phy_put(dev, phy);
 }
 
 static void devm_phy_provider_release(struct device *dev, void *res)
@@ -566,12 +566,12 @@ struct phy *of_phy_get(struct device_node *np, const char *con_id)
 EXPORT_SYMBOL_GPL(of_phy_get);
 
 /**
- * phy_put() - release the PHY
- * @phy: the phy returned by phy_get()
+ * of_phy_put() - release the PHY
+ * @phy: the phy returned by of_phy_get()
  *
- * Releases a refcount the caller received from phy_get().
+ * Releases a refcount the caller received from of_phy_get().
  */
-void phy_put(struct phy *phy)
+void of_phy_put(struct phy *phy)
 {
 	if (!phy || IS_ERR(phy))
 		return;
@@ -584,6 +584,20 @@ void phy_put(struct phy *phy)
 	module_put(phy->ops->owner);
 	put_device(&phy->dev);
 }
+EXPORT_SYMBOL_GPL(of_phy_put);
+
+/**
+ * phy_put() - release the PHY
+ * @dev: device that wants to release this phy
+ * @phy: the phy returned by phy_get()
+ *
+ * Releases a refcount the caller received from phy_get().
+ */
+void phy_put(struct device *dev, struct phy *phy)
+{
+	device_link_remove(dev, &phy->dev);
+	of_phy_put(phy);
+}
 EXPORT_SYMBOL_GPL(phy_put);
 
 /**
@@ -651,6 +665,7 @@ struct phy *phy_get(struct device *dev, const char *string)
 {
 	int index = 0;
 	struct phy *phy;
+	struct device_link *link;
 
 	if (string == NULL) {
 		dev_WARN(dev, "missing string\n");
@@ -672,6 +687,13 @@ struct phy *phy_get(struct device *dev, const char *string)
 
 	get_device(&phy->dev);
 
+	link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
+	if (!link) {
+		dev_err(dev, "failed to create device link to %s\n",
+			dev_name(phy->dev.parent));
+		return ERR_PTR(-EINVAL);
+	}
+
 	return phy;
 }
 EXPORT_SYMBOL_GPL(phy_get);
@@ -765,6 +787,7 @@ struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
 			    const char *con_id)
 {
 	struct phy **ptr, *phy;
+	struct device_link *link;
 
 	ptr = devres_alloc(devm_phy_release, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)
@@ -778,6 +801,13 @@ struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
 		devres_free(ptr);
 	}
 
+	link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
+	if (!link) {
+		dev_err(dev, "failed to create device link to %s\n",
+			dev_name(phy->dev.parent));
+		return ERR_PTR(-EINVAL);
+	}
+
 	return phy;
 }
 EXPORT_SYMBOL_GPL(devm_of_phy_get);
@@ -798,6 +828,7 @@ struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
 				     int index)
 {
 	struct phy **ptr, *phy;
+	struct device_link *link;
 
 	ptr = devres_alloc(devm_phy_release, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)
@@ -819,6 +850,13 @@ struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
 	*ptr = phy;
 	devres_add(dev, ptr);
 
+	link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
+	if (!link) {
+		dev_err(dev, "failed to create device link to %s\n",
+			dev_name(phy->dev.parent));
+		return ERR_PTR(-EINVAL);
+	}
+
 	return phy;
 }
 EXPORT_SYMBOL_GPL(devm_of_phy_get_by_index);
diff --git a/drivers/usb/renesas_usbhs/rcar2.c b/drivers/usb/renesas_usbhs/rcar2.c
index 440d213e1749..791908f8cf73 100644
--- a/drivers/usb/renesas_usbhs/rcar2.c
+++ b/drivers/usb/renesas_usbhs/rcar2.c
@@ -34,7 +34,7 @@ static int usbhs_rcar2_hardware_exit(struct platform_device *pdev)
 	struct usbhs_priv *priv = usbhs_pdev_to_priv(pdev);
 
 	if (priv->phy) {
-		phy_put(priv->phy);
+		phy_put(&pdev->dev, priv->phy);
 		priv->phy = NULL;
 	}
 
diff --git a/drivers/usb/renesas_usbhs/rza2.c b/drivers/usb/renesas_usbhs/rza2.c
index 021749594389..3eed3334a17f 100644
--- a/drivers/usb/renesas_usbhs/rza2.c
+++ b/drivers/usb/renesas_usbhs/rza2.c
@@ -29,7 +29,7 @@ static int usbhs_rza2_hardware_exit(struct platform_device *pdev)
 {
 	struct usbhs_priv *priv = usbhs_pdev_to_priv(pdev);
 
-	phy_put(priv->phy);
+	phy_put(&pdev->dev, priv->phy);
 	priv->phy = NULL;
 
 	return 0;
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 56d3a100006a..19eddd64c8f6 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -234,7 +234,8 @@ struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
 			    const char *con_id);
 struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
 				     int index);
-void phy_put(struct phy *phy);
+void of_phy_put(struct phy *phy);
+void phy_put(struct device *dev, struct phy *phy);
 void devm_phy_put(struct device *dev, struct phy *phy);
 struct phy *of_phy_get(struct device_node *np, const char *con_id);
 struct phy *of_phy_simple_xlate(struct device *dev,
@@ -419,7 +420,11 @@ static inline struct phy *devm_of_phy_get_by_index(struct device *dev,
 	return ERR_PTR(-ENOSYS);
 }
 
-static inline void phy_put(struct phy *phy)
+static inline void of_phy_put(struct phy *phy)
+{
+}
+
+static inline void phy_put(struct device *dev, struct phy *phy)
 {
 }
 
-- 
2.17.1

