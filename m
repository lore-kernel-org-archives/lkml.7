Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA04C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 16:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2483A20869
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 16:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="q+F51iBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfDTQgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 12:36:40 -0400
Received: from sender4-pp-o95.zoho.com ([136.143.188.95]:25575 "EHLO
        sender4-pp-o95.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDTQgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 12:36:40 -0400
X-Greylist: delayed 960 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Apr 2019 12:36:40 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1555777291; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=HTTiHkVrcGhltWl5YAo3q2rbVhPtA+0GwwyrLHmS4VKvbq5ttxag2hORUZDVMu770xfDR+RGrZXHdg0Pp3ImGJK9NR031Ly+iwEnivHTazfRPo12DLzKx1vW4cuq4pAenOi/KH7Ew9C19GVtfVTGKT8Dgt1ggDz48wqnkzR1W5c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1555777291; h=Cc:Date:From:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=TcNyGdTYH8VgNNRiNbi3oWrA2PtCg8NXMlUiWnytha0=; 
        b=PEmN+q9K4LM7Q/XG7Rkm/sP29MWTua0jE++uz5Eww5MmcfQQcpDiyMQhKTnnzEQdCLY8MNvNe3PtWwkqdh88f+C0xr32XAFvUhwMmAUGrNa/G/9zRxzAdBotf7scSMT9rSpqd8XC77dzoAFPj64tsvGFmB1a+h9AGnl7YB7sAGM=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=WP02vy0FtGpNKokpfMAsYa6Ujnvi41sehSzVQf/d1S6m3ddvyp0xgyyWwnCGaKPeyBWShjr1czte
    XbUObcvp0lc+gMvPgpbBqiP9OJSKxq+htM7iG1mE8Kx44pE2ecXl  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1555777291;
        s=default; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=1759;
        bh=TcNyGdTYH8VgNNRiNbi3oWrA2PtCg8NXMlUiWnytha0=;
        b=q+F51iBMBHlKziRuq/HKKUsY6n1sYwPc97acF2fIHRa/f5haNObTpazWlAyguWwv
        YxOiUvYh4q7zD4rCUm2ky+TFHEU+mPQOedsF7cc9AvnYlRCudj9o30WMQOm0fz6U+Oe
        NVKr5lPr293WaEOuwWtlrh/GoE7NknR+cRq1Wot0=
Received: from YEHS1XR3054QMS.lenovo.com (123.118.182.142 [123.118.182.142]) by mx.zohomail.com
        with SMTPS id 1555777290062966.0734097869595; Sat, 20 Apr 2019 09:21:30 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     mpatocka@redhat.com, snitzer@redhat.com, agk@redhat.com
Cc:     prarit@redhat.com, chengnt@lenovo.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH] dm-writecache: avoid unnecessary lookups in writecache_find_entry
Date:   Sun, 21 Apr 2019 00:21:02 +0800
Message-Id: <20190420162102.6460-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

Only when entry has been found, that would only be necessary to check the
lowest or highest seq-count.

Add local variable "found" in writecache_find_entry, if no entry has been
found, it is meaningless that having a useless rb_prev or rb_next.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/md/dm-writecache.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index ddf1732..047ae09 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -537,14 +537,18 @@ static struct wc_entry *writecache_find_entry(struct dm_writecache *wc,
 {
 	struct wc_entry *e;
 	struct rb_node *node = wc->tree.rb_node;
+	bool found = false;
 
 	if (unlikely(!node))
 		return NULL;
 
 	while (1) {
 		e = container_of(node, struct wc_entry, rb_node);
-		if (read_original_sector(wc, e) == block)
+		if (read_original_sector(wc, e) == block) {
+			found = true;
 			break;
+		}
+
 		node = (read_original_sector(wc, e) >= block ?
 			e->rb_node.rb_left : e->rb_node.rb_right);
 		if (unlikely(!node)) {
@@ -564,7 +568,8 @@ static struct wc_entry *writecache_find_entry(struct dm_writecache *wc,
 		}
 	}
 
-	while (1) {
+	/* only need to check lowest or highest seq-count when entry has been found */
+	while (found) {
 		struct wc_entry *e2;
 		if (flags & WFE_LOWEST_SEQ)
 			node = rb_prev(&e->rb_node);
@@ -577,6 +582,9 @@ static struct wc_entry *writecache_find_entry(struct dm_writecache *wc,
 			return e;
 		e = e2;
 	}
+
+	/* no entry has been found, return the following entry */
+	return e;
 }
 
 static void writecache_insert_entry(struct dm_writecache *wc, struct wc_entry *ins)
-- 
1.8.3.1


