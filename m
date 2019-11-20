Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166B4C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C102251F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VgQ+63HH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbfKTN04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:26:56 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:55218 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbfKTN0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:26:55 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191120132653epoutp034fdc9a9e74c0318306e39e7af69e65b4~Y4d3s04Nm1460214602epoutp031
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 13:26:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191120132653epoutp034fdc9a9e74c0318306e39e7af69e65b4~Y4d3s04Nm1460214602epoutp031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574256413;
        bh=2YYXgjCg4OpFQwaAFuEh8nJn991F2oDFmVnHATA+nac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VgQ+63HH2IHiDROrgPvDUv4JKJaNKoBa86BmPkIvG3LXZQm+8huEjFZKTNbYU2i2g
         RhNNaEruV5YiryyR4Kuec8osLbzMKI13q7LzKrUViHGHW4if4581owO964J3AJEUfS
         cUln/ZDIpRPJLOh0soI+eQoAKHnZzk6lqghKBKtU=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20191120132651epcas5p3c6b19e9d1604491c0d66ecea5ebf6e03~Y4d2mbMQz0361803618epcas5p3z;
        Wed, 20 Nov 2019 13:26:51 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.72.04078.B1F35DD5; Wed, 20 Nov 2019 22:26:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20191120132650epcas5p11fc132ba7084db7b7ad1b6c22b357770~Y4d1YCrMm0920909209epcas5p1u;
        Wed, 20 Nov 2019 13:26:50 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191120132650epsmtrp2b19643f5eac0ec4644253e8d9eaa2393~Y4d1XZfmK1949619496epsmtrp20;
        Wed, 20 Nov 2019 13:26:50 +0000 (GMT)
X-AuditID: b6c32a49-5edff70000000fee-0e-5dd53f1b909f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.AC.03814.A1F35DD5; Wed, 20 Nov 2019 22:26:50 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191120132648epsmtip28cdd8c7c16f6d215fce3d3b66b3e7e3d~Y4dzz3-qq2641726417epsmtip2M;
        Wed, 20 Nov 2019 13:26:48 +0000 (GMT)
From:   Anvesh Salveru <anvesh.s@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        pankaj.dubey@samsung.com, lorenzo.pieralisi@arm.com,
        andrew.murray@arm.com, bhelgaas@google.com, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Anvesh Salveru <anvesh.s@samsung.com>
Subject: [PATCH v3 1/2] phy: core: add phy_property_present method
Date:   Wed, 20 Nov 2019 18:56:10 +0530
Message-Id: <1574256371-617-2-git-send-email-anvesh.s@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574256371-617-1-git-send-email-anvesh.s@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSXUhTYRjHeXe2s+NycZojnzSlBpbT1JSEI5T2hZygC2+LpA55cNKmsjnL
        itD83FKzHDOX6fyYyTC0pU6nK5umFWpGLvVi4oVZiBmlBGFpzTPp7vf/P//ng5eXwCRFgiAi
        IzOHVWcyShku4vcMyQ9GBSe5Uw/rG2Kpwk27gBp3NAqoltsKyuEpE1Jta7VCavJTOU59cNTh
        1PL6FyFlmX7Po5q614RUsXNYeHwH3V7fjug+k0dIm21a2mbV4XRllxXRXS9WET06Y+fRq7bQ
        FOK86Ggaq8zIZdUxiZdEis05N8oehmvm+sh8dEeqR34EkEeg1WAR6JGIkJD9CIzOGh4nfiDQ
        mWv4nPiJYH6hibfdMvC0A+MKTgRNNVU+UcSDr/mGrRRORsKvV06hl6XkPnhWsbi1BCM3ELjX
        6pEeEUQAeRL6C+Re5JNhUDwf6Y2L/7m26gIhtywUZid0mJf9yFNQby/EvWOAHMPhXbkO50Kn
        YaP7m++6AFga7fI1B8HqitOXyYIKj8Xn3wSDpwxxnASDU3V87w0YKYcOR4zXxsidULG+wPPa
        QIqhrETCoQxKam9wjQDNDbMYxzTMLhb6Hs6IYKy/UVCFQkz/h5oRsqI9bLZGlc5q4rNjM9mr
        0RpGpdFmpkdfzlLZ0NbfiDjTi0wTZ12IJJDMX6wId6dKBEyuJk/lQkBgMql4YHoqVSJOY/Ku
        s+qsi2qtktW4UDDBlwWK7wvcFyRkOpPDXmHZbFa9XeURfkH5KKyqpdek6Emwr5zTHSDvOpRt
        GUa+TpQ6JR9JNnR2aIfDmdZd/pa5/djrQ9LntkfjY2j4XvtS88c894PmPo8WRZR2DU3GyRzx
        Cw+Z3dXWx8rS3zNq17GRDWPc26G9t558Vk1Xrg8uLUsC30S9NJevdv4xhiQndCc2jdm+4ykn
        ZHyNgomNwNQa5i9c12FgFwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsWy7bCSvK6U/dVYg7Y50hbN/7ezWpzdtZDV
        YklThsWuux3sFiu+zGS3uPC0h83i8q45bBZvfr9gt1h6/SKTxaKtX9gtWvceYXfg9lgzbw2j
        x85Zd9k9Fmwq9di0qpPNo2/LKkaPLfs/M3ocv7GdyePzJrkAjigum5TUnMyy1CJ9uwSujP/3
        rjIWHJGoWDBPu4GxW6SLkZNDQsBEYs/G9cxdjFwcQgK7GSVOLDvFBJGQkPiy9ysbhC0ssfLf
        c3aIoiYmif9rzzKDJNgEtCV+Ht3LDmKLCChIbO59xgpSxCzQxSSx9vQWoAQHh7CAk8TuRk0Q
        k0VAVaL1gTZIOS9QdNPkRnaI+XISN891go3kFHCWmLe9mQ2kXAioZs1r6wmMfAsYGVYxSqYW
        FOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgSHrJbWDsYTJ+IPMQpwMCrx8GZoXI0VYk0sK67M
        PcQowcGsJMK75/qVWCHelMTKqtSi/Pii0pzU4kOM0hwsSuK88vnHIoUE0hNLUrNTUwtSi2Cy
        TBycUg2MrvNETc1b37rdfhDNVD8vJ4Kr40xZiq7AwrB9BxZtXdG4wdlieU38UQ8bptMNsX1H
        OpeqPTnUfL/VJp+712dBqUb2/gsmvem/Jzn+WGg7e8nrQuHT/86qbLV/Mi+hqOjRweysohm7
        zycavts72Tqc59CD5IIvn+++KV4jap+1WvP299sSKaG+SizFGYmGWsxFxYkAp6RtwVUCAAA=
X-CMS-MailID: 20191120132650epcas5p11fc132ba7084db7b7ad1b6c22b357770
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191120132650epcas5p11fc132ba7084db7b7ad1b6c22b357770
References: <1574256371-617-1-git-send-email-anvesh.s@samsung.com>
        <CGME20191120132650epcas5p11fc132ba7084db7b7ad1b6c22b357770@epcas5p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some platforms, we need information of phy properties in
the controller drivers. This patch adds a new phy_property_present()
method which can be used to check if some property exists in PHY
or not.

In case of DesignWare PCIe controller, we need to write into controller
register to specify about ZRX-DC compliance property of the PHY, which
reduces the power consumption during lower power states.

Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 drivers/phy/phy-core.c  | 26 ++++++++++++++++++++++++++
 include/linux/phy/phy.h |  8 ++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index b04f4fe..0a62eca 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -420,6 +420,32 @@ int phy_calibrate(struct phy *phy)
 EXPORT_SYMBOL_GPL(phy_calibrate);
 
 /**
+ * phy_property_present() - checks if the property is present in PHY
+ * @phy: the phy returned by phy_get()
+ * @property: name of the property to check
+ *
+ * Used to check if the given property is present in PHY. PHY drivers
+ * can implement this callback function to expose PHY properties to
+ * controller drivers.
+ *
+ * Returns: true if property exists, false otherwise
+ */
+bool phy_property_present(struct phy *phy, const char *property)
+{
+	bool ret;
+
+	if (!phy || !phy->ops->property_present)
+		return false;
+
+	mutex_lock(&phy->mutex);
+	ret = phy->ops->property_present(phy, property);
+	mutex_unlock(&phy->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_property_present);
+
+/**
  * phy_configure() - Changes the phy parameters
  * @phy: the phy returned by phy_get()
  * @opts: New configuration to apply
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 15032f14..3dd8f3c 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -61,6 +61,7 @@ union phy_configure_opts {
  * @reset: resetting the phy
  * @calibrate: calibrate the phy
  * @release: ops to be performed while the consumer relinquishes the PHY
+ * @property_present: check if some property is present in PHY
  * @owner: the module owner containing the ops
  */
 struct phy_ops {
@@ -103,6 +104,7 @@ struct phy_ops {
 	int	(*reset)(struct phy *phy);
 	int	(*calibrate)(struct phy *phy);
 	void	(*release)(struct phy *phy);
+	bool	(*property_present)(struct phy *phy, const char *property);
 	struct module *owner;
 };
 
@@ -217,6 +219,7 @@ static inline enum phy_mode phy_get_mode(struct phy *phy)
 }
 int phy_reset(struct phy *phy);
 int phy_calibrate(struct phy *phy);
+bool phy_property_present(struct phy *phy, const char *property);
 static inline int phy_get_bus_width(struct phy *phy)
 {
 	return phy->attrs.bus_width;
@@ -354,6 +357,11 @@ static inline int phy_calibrate(struct phy *phy)
 	return -ENOSYS;
 }
 
+static inline bool phy_property_present(struct phy *phy, const char *property)
+{
+	return false;
+}
+
 static inline int phy_configure(struct phy *phy,
 				union phy_configure_opts *opts)
 {
-- 
2.7.4

