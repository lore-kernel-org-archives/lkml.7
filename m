Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8FBC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197F1206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbfETJ0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:26:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:39714 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727319AbfETJ0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:26:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B26F4AD17;
        Mon, 20 May 2019 09:26:49 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] firmware: Free temporary page table after vmapping
Date:   Mon, 20 May 2019 11:26:43 +0200
Message-Id: <20190520092647.8622-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190520092647.8622-1-tiwai@suse.de>
References: <20190520092647.8622-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once after performing vmap() to map the S/G pages, our own page table
becomes superfluous since the pages can be released via vfree()
automatically.  Let's change the buffer release code and discard the
page table array for saving some memory.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/base/firmware_loader/fallback.c | 7 ++++++-
 drivers/base/firmware_loader/main.c     | 6 +++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index f962488546b6..a0a1856aac84 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -222,7 +222,7 @@ static ssize_t firmware_loading_show(struct device *dev,
 /* one pages buffer should be mapped/unmapped only once */
 static int map_fw_priv_pages(struct fw_priv *fw_priv)
 {
-	if (!fw_priv->is_paged_buf)
+	if (!fw_priv->pages)
 		return 0;
 
 	vunmap(fw_priv->data);
@@ -230,6 +230,11 @@ static int map_fw_priv_pages(struct fw_priv *fw_priv)
 			     PAGE_KERNEL_RO);
 	if (!fw_priv->data)
 		return -ENOMEM;
+
+	/* page table is no longer needed after mapping, let's free */
+	vfree(fw_priv->pages);
+	fw_priv->pages = NULL;
+
 	return 0;
 }
 
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 7eaaf5ee5ba6..aed1a7c56713 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -252,13 +252,13 @@ static void __free_fw_priv(struct kref *ref)
 	spin_unlock(&fwc->lock);
 
 #ifdef CONFIG_FW_LOADER_USER_HELPER
-	if (fw_priv->is_paged_buf) {
+	if (fw_priv->pages) {
+		/* free leftover pages */
 		int i;
-		vunmap(fw_priv->data);
 		for (i = 0; i < fw_priv->nr_pages; i++)
 			__free_page(fw_priv->pages[i]);
 		vfree(fw_priv->pages);
-	} else
+	}
 #endif
 	if (!fw_priv->allocated_size)
 		vfree(fw_priv->data);
-- 
2.16.4

