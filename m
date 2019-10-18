Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4CCCA9EC8
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 01:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B441220820
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 01:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406816AbfJRBI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 21:08:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:46857 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392283AbfJRBIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 21:08:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 18:08:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,309,1566889200"; 
   d="scan'208";a="202553412"
Received: from intel10-debian.sh.intel.com ([10.239.53.1])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Oct 2019 18:08:54 -0700
From:   Zhengjun Xing <zhengjun.xing@linux.intel.com>
To:     rostedt@goodmis.org, mingo@redhat.com, tom.zanussi@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, zhengjun.xing@linux.intel.com
Subject: [PATCH v2] tracing: fix "gfp_t" format for synthetic events
Date:   Fri, 18 Oct 2019 09:20:34 +0800
Message-Id: <20191018012034.6404-1-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the format of synthetic events, the "gfp_t" is shown as "signed:1",
but in fact the "gfp_t" is "unsigned", should be shown as "signed:0".

The issue can be reproduced by the following commands:

echo 'memlatency u64 lat; unsigned int order; gfp_t gfp_flags; int migratetype' > /sys/kernel/debug/tracing/synthetic_events
cat  /sys/kernel/debug/tracing/events/synthetic/memlatency/format

name: memlatency
ID: 2233
format:
        field:unsigned short common_type;       offset:0;       size:2; signed:0;
        field:unsigned char common_flags;       offset:2;       size:1; signed:0;
        field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
        field:int common_pid;   offset:4;       size:4; signed:1;

        field:u64 lat;  offset:8;       size:8; signed:0;
        field:unsigned int order;       offset:16;      size:4; signed:0;
        field:gfp_t gfp_flags;  offset:24;      size:4; signed:1;
        field:int migratetype;  offset:32;      size:4; signed:1;

print fmt: "lat=%llu, order=%u, gfp_flags=%x, migratetype=%d", REC->lat, REC->order, REC->gfp_flags, REC->migratetype

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 57648c5aa679..7482a1466ebf 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -679,6 +679,8 @@ static bool synth_field_signed(char *type)
 {
 	if (str_has_prefix(type, "u"))
 		return false;
+	if (strcmp(type, "gfp_t") == 0)
+		return false;
 
 	return true;
 }
-- 
2.17.1

