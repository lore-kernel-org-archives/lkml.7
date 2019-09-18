Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0BAC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CD420665
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4AGJTsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731299AbfIROjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 10:39:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36002 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730211AbfIROjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 10:39:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id f19so54933plr.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 07:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=quDi5FFcEHmlmH1e9u/MVGG/WChEumxXk9EifB9fhCs=;
        b=X4AGJTsD51BzXMVwK60Kca2mkVAorXHjtmOlaZmPsf02Km0NHNPnq13zWfat/YHbtE
         MV426iBdoaftcc9CNARoo9dNrKrwcZL4wBWxBcv93uDY1tG18vQdFyTr5wQz5d6/1lq5
         3lQz/3U76yl0m6th7oYYIAGey6OJIu9/koqpHyYGIMnlIFoRXuty8rR1WIYFh0yF+GVB
         AhYxq+YLPDtaaYDt0eYStxC/EKX79V2fKip58qT/VjKFMF7VmJYvOuJXaJWGMI1C854P
         PfMMGrru9f7WlqiI2p3n2RWtbExtuQYTlaSnLnzYyKxhGMvtyzsu/7caN3OpTAvEUyUF
         oYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=quDi5FFcEHmlmH1e9u/MVGG/WChEumxXk9EifB9fhCs=;
        b=KsX0u+GUT738Q9KpAY/lhfBY6cd46W7tqCdozQxoJga1dWMTLlnUaKjUei5KDBQZIE
         fbSyph7VNpeCeRlMv58wAoRr2mYbx4pk57vUulKKYcQ911/vZ1RIujcu/kv7DlytMmUm
         pb+ZtUykMH0UBCMEBxvLgUrBTCs77M+7OTQRtUJvzc3P3iw0SpCji5Qw5gP9y3NRdOg+
         bvHCt+k38b0joDdimpPLBuP8iFsYG2swbAdQWwkeeT6rgrLRbco+2X2g7O/X94JNPzl3
         NzPSaX2wsI8CesM8Xisu+NpQ3/oFMyx8HV9vDyQ/DiyVhZfPkrWEBfUIt5VlHBx7dzJd
         47CA==
X-Gm-Message-State: APjAAAUmmeLk4kB4tfGwn12DQ+lXczWYPLyYo2vQiGXhFFDKy+audvlM
        6LnHWJBSgmjMPrZBakWSuXw=
X-Google-Smtp-Source: APXvYqzMwzc7yuyYjnb76QPE6ltH+wKNbQpk+wmIggNsOZEqgDsGe2eSrc7MLGYNJSazFP7gPANnIg==
X-Received: by 2002:a17:902:7c13:: with SMTP id x19mr4662626pll.322.1568817556152;
        Wed, 18 Sep 2019 07:39:16 -0700 (PDT)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id l11sm5272197pgq.58.2019.09.18.07.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 07:39:15 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        jolsa@redhat.com, namhyung@kernel.org, akpm@linux-foundation.org
Cc:     tonyj@suse.com, florian.schmidt@nutanix.com,
        daniel.m.jordan@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 2/2] tracing, vmscan: add comments for perf script page-reclaim
Date:   Wed, 18 Sep 2019 10:38:42 -0400
Message-Id: <1568817522-8754-3-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568817522-8754-1-git-send-email-laoar.shao@gmail.com>
References: <1568817522-8754-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there's no easy way to make perf scripts in sync with
tracepoints. One possible way is to run perf's tests regularly, another way
is once we changes the definitions of tracepoints we must keep in mind that
the perf scripts which are using these tracepoints must be changed as well.
So I add this comment for the new introduced page-reclaim script as a
reminder.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/trace/events/vmscan.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index a5ab297..f0447ad 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -1,4 +1,17 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Bellow tracepoints are used by perf script page-reclaim:
+ *	mm_vmscan_direct_reclaim_begin
+ *	mm_vmscan_direct_reclaim_end
+ *	mm_vmscan_kswapd_wake
+ *	mm_vmscan_kswapd_sleep
+ *	mm_vmscan_wakeup_kswapd
+ *	mm_vmscan_lru_shrink_inactive
+ *	mm_vmscan_writepage
+ * We must keep the definitions of these tracepoints in sync with the perf
+ * script page-reclaim.
+ */
+
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM vmscan
 
-- 
1.8.3.1

