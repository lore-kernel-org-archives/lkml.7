Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62B0C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65A9206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732097AbfETJ0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:26:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:39732 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729642AbfETJ0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:26:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C870CADAF;
        Mon, 20 May 2019 09:26:49 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] firmware: Use kvmalloc for page tables
Date:   Mon, 20 May 2019 11:26:45 +0200
Message-Id: <20190520092647.8622-4-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190520092647.8622-1-tiwai@suse.de>
References: <20190520092647.8622-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a minor optimization to use kvmalloc() variant for allocating
the page table for the SG-buffer.  They aren't so big in general, so
kmalloc() would fit often better.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/base/firmware_loader/fallback.c | 7 ++++---
 drivers/base/firmware_loader/main.c     | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 8970a5315e85..b5cd96fd0e77 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -232,7 +232,7 @@ static int map_fw_priv_pages(struct fw_priv *fw_priv)
 		return -ENOMEM;
 
 	/* page table is no longer needed after mapping, let's free */
-	vfree(fw_priv->pages);
+	kvfree(fw_priv->pages);
 	fw_priv->pages = NULL;
 
 	return 0;
@@ -397,7 +397,8 @@ static int fw_realloc_pages(struct fw_sysfs *fw_sysfs, int min_size)
 					 fw_priv->page_array_size * 2);
 		struct page **new_pages;
 
-		new_pages = vmalloc(array_size(new_array_size, sizeof(void *)));
+		new_pages = kvmalloc_array(new_array_size, sizeof(void *),
+					   GFP_KERNEL);
 		if (!new_pages) {
 			fw_load_abort(fw_sysfs);
 			return -ENOMEM;
@@ -406,7 +407,7 @@ static int fw_realloc_pages(struct fw_sysfs *fw_sysfs, int min_size)
 		       fw_priv->page_array_size * sizeof(void *));
 		memset(&new_pages[fw_priv->page_array_size], 0, sizeof(void *) *
 		       (new_array_size - fw_priv->page_array_size));
-		vfree(fw_priv->pages);
+		kvfree(fw_priv->pages);
 		fw_priv->pages = new_pages;
 		fw_priv->page_array_size = new_array_size;
 	}
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 083fc3e4f2fd..2e74a1b73dae 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -276,7 +276,7 @@ void fw_free_paged_buf(struct fw_priv *fw_priv)
 
 	for (i = 0; i < fw_priv->nr_pages; i++)
 		__free_page(fw_priv->pages[i]);
-	vfree(fw_priv->pages);
+	kvfree(fw_priv->pages);
 	fw_priv->pages = NULL;
 	fw_priv->page_array_size = 0;
 	fw_priv->nr_pages = 0;
-- 
2.16.4

