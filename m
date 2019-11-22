Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01AEC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B207B20721
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420473;
	bh=9tlsXAq1wvbQ7vXhH0WzC2FHYWWLkSRWNraPNNPO6MY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ybUUJ86kawWLRbe7gelqKyngZbxp0hW2F4yfCw7nh2/GU4cfWhTpxD4qrFj/nxeKi
	 1SDrwWcBNdrXCa9d8RdTutenRYiVVsJ+9vwEuNA92p6pjodD9/fqHTlEE5E0K/3/j6
	 8b+0fyqNMe/onvQaXnzUxd6tny6WRIhLBUVwsMGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbfKVLBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:01:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:53888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730109AbfKVLBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:01:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C704520706;
        Fri, 22 Nov 2019 11:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420469;
        bh=9tlsXAq1wvbQ7vXhH0WzC2FHYWWLkSRWNraPNNPO6MY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ODEThaCoj5Sw/zS9EFFOkLzTW58dJ3d8VKomapIxgd2hay6Kk4TBp+dVTyDXXykke
         7gS9GXm6IvUKywu+jQlK1RL2OR9XqEc/nen2v7xGYJaHOv6Xa5FSqQ9v6sXfb0E1Fn
         mLVLZu7ZHoZOOdN38e6oSQvv853626l+0tb7dImA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 115/220] qtnfmac: inform wireless core about supported extended capabilities
Date:   Fri, 22 Nov 2019 11:28:00 +0100
Message-Id: <20191122100921.014116895@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>

[ Upstream commit ab1c64a1d349cc7f1090a60ce85a53298e3d371d ]

Driver retrieves information about supported extended capabilities
from wireless card. However this information is not propagated
further to Linux wireless core. Fix this by setting extended
capabilities fields of wiphy structure.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/quantenna/qtnfmac/cfg80211.c    |  9 +++++++++
 .../net/wireless/quantenna/qtnfmac/commands.c    |  3 +--
 drivers/net/wireless/quantenna/qtnfmac/core.c    | 16 ++++++++++++++--
 drivers/net/wireless/quantenna/qtnfmac/core.h    |  1 +
 4 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
index 1519d986b74a4..05b93f301ca08 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -1126,6 +1126,15 @@ int qtnf_wiphy_register(struct qtnf_hw_info *hw_info, struct qtnf_wmac *mac)
 		wiphy->regulatory_flags |= REGULATORY_WIPHY_SELF_MANAGED;
 	}
 
+	if (mac->macinfo.extended_capabilities_len) {
+		wiphy->extended_capabilities =
+			mac->macinfo.extended_capabilities;
+		wiphy->extended_capabilities_mask =
+			mac->macinfo.extended_capabilities_mask;
+		wiphy->extended_capabilities_len =
+			mac->macinfo.extended_capabilities_len;
+	}
+
 	strlcpy(wiphy->fw_version, hw_info->fw_version,
 		sizeof(wiphy->fw_version));
 	wiphy->hw_version = hw_info->hw_version;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/net/wireless/quantenna/qtnfmac/commands.c
index 7fe22bb53bfc4..734844b34c266 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -1356,8 +1356,7 @@ static int qtnf_parse_variable_mac_info(struct qtnf_wmac *mac,
 		ext_capa_mask = NULL;
 	}
 
-	kfree(mac->macinfo.extended_capabilities);
-	kfree(mac->macinfo.extended_capabilities_mask);
+	qtnf_mac_ext_caps_free(mac);
 	mac->macinfo.extended_capabilities = ext_capa;
 	mac->macinfo.extended_capabilities_mask = ext_capa_mask;
 	mac->macinfo.extended_capabilities_len = ext_capa_len;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wireless/quantenna/qtnfmac/core.c
index 19abbc4e23e06..08928d5e252d7 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -304,6 +304,19 @@ void qtnf_mac_iface_comb_free(struct qtnf_wmac *mac)
 	}
 }
 
+void qtnf_mac_ext_caps_free(struct qtnf_wmac *mac)
+{
+	if (mac->macinfo.extended_capabilities_len) {
+		kfree(mac->macinfo.extended_capabilities);
+		mac->macinfo.extended_capabilities = NULL;
+
+		kfree(mac->macinfo.extended_capabilities_mask);
+		mac->macinfo.extended_capabilities_mask = NULL;
+
+		mac->macinfo.extended_capabilities_len = 0;
+	}
+}
+
 static void qtnf_vif_reset_handler(struct work_struct *work)
 {
 	struct qtnf_vif *vif = container_of(work, struct qtnf_vif, reset_work);
@@ -493,8 +506,7 @@ static void qtnf_core_mac_detach(struct qtnf_bus *bus, unsigned int macid)
 	}
 
 	qtnf_mac_iface_comb_free(mac);
-	kfree(mac->macinfo.extended_capabilities);
-	kfree(mac->macinfo.extended_capabilities_mask);
+	qtnf_mac_ext_caps_free(mac);
 	kfree(mac->macinfo.wowlan);
 	wiphy_free(wiphy);
 	bus->mac[macid] = NULL;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.h b/drivers/net/wireless/quantenna/qtnfmac/core.h
index a1e338a1f055a..ecb5c41c8ed76 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.h
@@ -151,6 +151,7 @@ struct qtnf_hw_info {
 struct qtnf_vif *qtnf_mac_get_free_vif(struct qtnf_wmac *mac);
 struct qtnf_vif *qtnf_mac_get_base_vif(struct qtnf_wmac *mac);
 void qtnf_mac_iface_comb_free(struct qtnf_wmac *mac);
+void qtnf_mac_ext_caps_free(struct qtnf_wmac *mac);
 struct wiphy *qtnf_wiphy_allocate(struct qtnf_bus *bus);
 int qtnf_core_net_attach(struct qtnf_wmac *mac, struct qtnf_vif *priv,
 			 const char *name, unsigned char name_assign_type);
-- 
2.20.1



