Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD540C41514
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7789722BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itn+ATRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfGYSor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:44:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34495 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfGYSoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:44:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so23763496plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 11:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NhwngYDbvri5ejmcM0XgYmhjUBSSl/buGnAbDPDI9EI=;
        b=itn+ATRxnc66FvQMYJryteL+cOXPgFskNlezDWkecZsggx+jExRT3w/o6Zozs9r4lG
         7p+nYoCch1hfycj2Nee5j56Dal/g7Fchu2Bo2iHKtJuZT1VJX80T3oUPlIJFK8zFzP3l
         fLnG1YQh79ExZFmGg3Vdh4sIhJXUvwotn0Rdca8RSEGgBD61h9ckWIZGcKP63fnc4DeU
         NtdzrRSRiFo6iIaf5S09Z1w1VIWf47s6ZRjqMN/SQet0AgUstkkV0e/If8ZBqHwuVvZw
         n7UJO9EjWtc94vpUjFu23209ncO9R4sRtMWsUI649YSjzndG72fY/mV2qUIliSKCqnrP
         qPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NhwngYDbvri5ejmcM0XgYmhjUBSSl/buGnAbDPDI9EI=;
        b=Bxp4PF7MwYKVLH4gOrHPICVAzLtZL/tqqDbSYLfXbF3+7+Ebqe6nV4TGFxbeooqg0v
         ca9hwOdXFVdSYJUZN53aklU3jq8tKp/wu9g8tGL2MBFZ1ELX7TihvLgIrq2vI0sQnIpu
         pOL1EjnZUe8OvfH+Xlb9iJxgM2udR0TKkpEtxWX1TXUuTaoVFN82CC1eHYpO5vQkJ2ar
         gj07nMB768lfBUaXlYuJEIOV/vsJ8FTvnV9zIXeJwkUkb5huee9tExEeWsXioGoHzRsR
         JayM8L7TN0pfiNVZDhJa05a30SZb1DWumT/sIC8Y84dpOyS07480RyTD09XLIsfB8RZk
         pR0g==
X-Gm-Message-State: APjAAAVo0/bt7H1uEMS0fWO6QSbTRt8ie8nw277eMfgZyGD/LOskspUx
        kGkf6XaJ7jGO3p9ZuIZjl2M=
X-Google-Smtp-Source: APXvYqxd1avMi033AmybLadPo/1ryj1iZmvCPadNNWuTSgJQuR4oMLhBqyYbEtyoNYRC9tLu3admKA==
X-Received: by 2002:a17:902:28e9:: with SMTP id f96mr88604969plb.114.1564080285671;
        Thu, 25 Jul 2019 11:44:45 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:624:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id w3sm43818257pgl.31.2019.07.25.11.44.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 11:44:45 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@suse.com, vbabka@suse.cz,
        cai@lca.pw, aryabinin@virtuozzo.com, osalvador@suse.de,
        rostedt@goodmis.org, mingo@redhat.com,
        pavel.tatashin@microsoft.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH 09/10] mm/compaction: use unsigned int for "kcompactd_max_order" in struct pglist_data
Date:   Fri, 26 Jul 2019 02:42:52 +0800
Message-Id: <20190725184253.21160-10-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725184253.21160-1-lpf.vector@gmail.com>
References: <20190725184253.21160-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because "kcompactd_max_order" will never be negative, so just
make it unsigned int.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
---
 include/linux/compaction.h | 6 ++++--
 include/linux/mmzone.h     | 2 +-
 mm/compaction.c            | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index a8049d582265..1b296de6efef 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -175,7 +175,8 @@ bool compaction_zonelist_suitable(struct alloc_context *ac,
 
 extern int kcompactd_run(int nid);
 extern void kcompactd_stop(int nid);
-extern void wakeup_kcompactd(pg_data_t *pgdat, int order, int classzone_idx);
+extern void wakeup_kcompactd(pg_data_t *pgdat, unsigned int order,
+				int classzone_idx);
 
 #else
 static inline void reset_isolation_suitable(pg_data_t *pgdat)
@@ -220,7 +221,8 @@ static inline void kcompactd_stop(int nid)
 {
 }
 
-static inline void wakeup_kcompactd(pg_data_t *pgdat, int order, int classzone_idx)
+static inline void wakeup_kcompactd(pg_data_t *pgdat, unsigned int order,
+					int classzone_idx)
 {
 }
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0947e7cb4214..60bebdf47661 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -723,7 +723,7 @@ typedef struct pglist_data {
 	int kswapd_failures;		/* Number of 'reclaimed == 0' runs */
 
 #ifdef CONFIG_COMPACTION
-	int kcompactd_max_order;
+	unsigned int kcompactd_max_order;
 	enum zone_type kcompactd_classzone_idx;
 	wait_queue_head_t kcompactd_wait;
 	struct task_struct *kcompactd;
diff --git a/mm/compaction.c b/mm/compaction.c
index aad638ad2cc6..909ead244cff 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2607,7 +2607,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 		pgdat->kcompactd_classzone_idx = pgdat->nr_zones - 1;
 }
 
-void wakeup_kcompactd(pg_data_t *pgdat, int order, int classzone_idx)
+void wakeup_kcompactd(pg_data_t *pgdat, unsigned int order, int classzone_idx)
 {
 	if (!order)
 		return;
-- 
2.21.0

