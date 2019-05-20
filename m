Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D43DC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D69B20675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbfETJ0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:26:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:39720 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729357AbfETJ0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:26:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B70D7AD2B;
        Mon, 20 May 2019 09:26:49 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] firmware: Unify the paged buffer release helper
Date:   Mon, 20 May 2019 11:26:44 +0200
Message-Id: <20190520092647.8622-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190520092647.8622-1-tiwai@suse.de>
References: <20190520092647.8622-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a common helper to release the paged buffer resources.
This is rather a preparation for the upcoming decompression support.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/base/firmware_loader/fallback.c |  8 +-------
 drivers/base/firmware_loader/firmware.h |  6 ++++++
 drivers/base/firmware_loader/main.c     | 27 ++++++++++++++++++---------
 3 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index a0a1856aac84..8970a5315e85 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -259,7 +259,6 @@ static ssize_t firmware_loading_store(struct device *dev,
 	struct fw_priv *fw_priv;
 	ssize_t written = count;
 	int loading = simple_strtol(buf, NULL, 10);
-	int i;
 
 	mutex_lock(&fw_lock);
 	fw_priv = fw_sysfs->fw_priv;
@@ -270,12 +269,7 @@ static ssize_t firmware_loading_store(struct device *dev,
 	case 1:
 		/* discarding any previous partial load */
 		if (!fw_sysfs_done(fw_priv)) {
-			for (i = 0; i < fw_priv->nr_pages; i++)
-				__free_page(fw_priv->pages[i]);
-			vfree(fw_priv->pages);
-			fw_priv->pages = NULL;
-			fw_priv->page_array_size = 0;
-			fw_priv->nr_pages = 0;
+			fw_free_paged_buf(fw_priv);
 			fw_state_start(fw_priv);
 		}
 		break;
diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index 4c1395f8e7ed..d20d4e7f9e71 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -133,4 +133,10 @@ static inline void fw_state_done(struct fw_priv *fw_priv)
 int assign_fw(struct firmware *fw, struct device *device,
 	      enum fw_opt opt_flags);
 
+#ifdef CONFIG_FW_LOADER_USER_HELPER
+void fw_free_paged_buf(struct fw_priv *fw_priv);
+#else
+static inline void fw_free_paged_buf(struct fw_priv *fw_priv) {}
+#endif
+
 #endif /* __FIRMWARE_LOADER_H */
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index aed1a7c56713..083fc3e4f2fd 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -251,15 +251,7 @@ static void __free_fw_priv(struct kref *ref)
 	list_del(&fw_priv->list);
 	spin_unlock(&fwc->lock);
 
-#ifdef CONFIG_FW_LOADER_USER_HELPER
-	if (fw_priv->pages) {
-		/* free leftover pages */
-		int i;
-		for (i = 0; i < fw_priv->nr_pages; i++)
-			__free_page(fw_priv->pages[i]);
-		vfree(fw_priv->pages);
-	}
-#endif
+	fw_free_paged_buf(fw_priv); /* free leftover pages */
 	if (!fw_priv->allocated_size)
 		vfree(fw_priv->data);
 	kfree_const(fw_priv->fw_name);
@@ -274,6 +266,23 @@ static void free_fw_priv(struct fw_priv *fw_priv)
 		spin_unlock(&fwc->lock);
 }
 
+#ifdef CONFIG_FW_LOADER_USER_HELPER
+void fw_free_paged_buf(struct fw_priv *fw_priv)
+{
+	int i;
+
+	if (!fw_priv->pages)
+		return;
+
+	for (i = 0; i < fw_priv->nr_pages; i++)
+		__free_page(fw_priv->pages[i]);
+	vfree(fw_priv->pages);
+	fw_priv->pages = NULL;
+	fw_priv->page_array_size = 0;
+	fw_priv->nr_pages = 0;
+}
+#endif
+
 /* direct firmware loading support */
 static char fw_path_para[256];
 static const char * const fw_path[] = {
-- 
2.16.4

