Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2A8C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C0B20857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H54t1Lwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfCBEj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 23:39:29 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46239 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfCBEj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 23:39:29 -0500
Received: by mail-pl1-f196.google.com with SMTP id c17so9263181plz.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 20:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T80MdXzCnVwzBeJXMQTkL4J5G0aH3MXHjAFEpqlA0WA=;
        b=H54t1LwpYL9KnRhB0RSkACShPDrChkkfBpcCaNyX8vbf/4K1S8jijCEuv5s9YRWUzf
         IQfvZ5krjRlj8Rq2oNvTgneiBXMPVs25FPE3SWCoDewQ5uPMgCa1KdmdjKd1A+b0HuYW
         b84nrR/0hqbAO0WaKor8odL6NOOJbwfUSbrIlgyVF7GZPm5gvHCUc7MysgXpAblBzbD4
         H9dVCrvRfvxO5h+cnvrnW0jhXAYo457TNOL/m/9c3Lk7RSe396f4pj/1VvDRhEPWs3ao
         fcR476QUi6NVL5SAH72apw0w6maFPeOpjHRXh8/6cLrPQWt8a5q2LNaSLlsHov0ToFeK
         APZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T80MdXzCnVwzBeJXMQTkL4J5G0aH3MXHjAFEpqlA0WA=;
        b=Cv2v9d4HAD4FhVOENBrMQkgjy6im9S/Dkj0XtTfgWd546zYE77VF8/BRD0jzlhp4oq
         ZZhsdfxb6pWiNviVzEXfybUIUwLMJCodUX9mJlKt2nBwbWB1YBn9/Odh4IahP0CIn46k
         aeWlA/RSpt/4qu6QhlvfJbNF3N8wLQUAavVwp9Hly84HiyQ3iubC6EkSX2s9rdQvbw20
         AWfGUzcb4RTbuWWWbeZCPVktVFFkPecgaUwiFz/0dnQ3AhqqAxkvqJTSlNi4gqxSP/Ff
         AVT/cMgUcqbHybW7XRfFEATaGQRer845E4WQrcASUO83mf9fMI2PTGph/BDMyKwoWSGi
         syTw==
X-Gm-Message-State: APjAAAU/cgf9FITAGEs/QfyznuUtrDolSzMu9ws2Zz1oeDBj2gqNyM4r
        e4A4YBNbyeWIpIQIOQzxLOE=
X-Google-Smtp-Source: APXvYqxrbuCoMsX8jDfR607E+AkSPdih1iVDlTkR+/4MYXNh/xAM6MP7Wqzc9csPX45GlxJm4H/Zcw==
X-Received: by 2002:a17:902:b709:: with SMTP id d9mr9235818pls.83.1551501568725;
        Fri, 01 Mar 2019 20:39:28 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id a24sm29102508pfo.160.2019.03.01.20.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 20:39:27 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     vbabka@suse.cz, mhocko@suse.com, jrdr.linux@gmail.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, shaoyafang@didiglobal.com,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] mm: compaction: some tracepoints should be defined only when CONFIG_COMPACTION is set
Date:   Sat,  2 Mar 2019 12:38:58 +0800
Message-Id: <1551501538-4092-2-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551501538-4092-1-git-send-email-laoar.shao@gmail.com>
References: <1551501538-4092-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only mm_compaction_isolate_{free, migrate}pages may be used when
CONFIG_COMPACTION is not set.
All others are used only when CONFIG_COMPACTION is set.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/trace/events/compaction.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/compaction.h b/include/trace/events/compaction.h
index 6074eff..3e42078 100644
--- a/include/trace/events/compaction.h
+++ b/include/trace/events/compaction.h
@@ -64,6 +64,7 @@
 	TP_ARGS(start_pfn, end_pfn, nr_scanned, nr_taken)
 );
 
+#ifdef CONFIG_COMPACTION
 TRACE_EVENT(mm_compaction_migratepages,
 
 	TP_PROTO(unsigned long nr_all,
@@ -132,7 +133,6 @@
 		__entry->sync ? "sync" : "async")
 );
 
-#ifdef CONFIG_COMPACTION
 TRACE_EVENT(mm_compaction_end,
 	TP_PROTO(unsigned long zone_start, unsigned long migrate_pfn,
 		unsigned long free_pfn, unsigned long zone_end, bool sync,
@@ -166,7 +166,6 @@
 		__entry->sync ? "sync" : "async",
 		__print_symbolic(__entry->status, COMPACTION_STATUS))
 );
-#endif
 
 TRACE_EVENT(mm_compaction_try_to_compact_pages,
 
@@ -195,7 +194,6 @@
 		__entry->prio)
 );
 
-#ifdef CONFIG_COMPACTION
 DECLARE_EVENT_CLASS(mm_compaction_suitable_template,
 
 	TP_PROTO(struct zone *zone,
@@ -296,7 +294,6 @@
 
 	TP_ARGS(zone, order)
 );
-#endif
 
 TRACE_EVENT(mm_compaction_kcompactd_sleep,
 
@@ -352,6 +349,7 @@
 
 	TP_ARGS(nid, order, classzone_idx)
 );
+#endif
 
 #endif /* _TRACE_COMPACTION_H */
 
-- 
1.8.3.1

