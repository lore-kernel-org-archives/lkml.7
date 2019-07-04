Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD947C5B578
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896152187F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfGDCpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 22:45:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:25429 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbfGDCpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 22:45:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 19:45:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,449,1557212400"; 
   d="scan'208";a="191241507"
Received: from intel10-debian.sh.intel.com ([10.239.53.1])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jul 2019 19:45:21 -0700
From:   Zhengjun Xing <zhengjun.xing@linux.intel.com>
To:     rostedt@goodmis.org, mingo@redhat.com, tom.zanussi@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, zhengjun.xing@linux.intel.com
Subject: [PATCH] trace:add "gfp_t" support in synthetic_events
Date:   Thu,  4 Jul 2019 10:55:06 +0800
Message-Id: <20190704025506.30199-1-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "gfp_t" support in synthetic_events, then the "gfp_t" type
parameter in some functions can be traced.

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index ca6b0dff60c5..0d3ab01b7cb5 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -752,6 +752,8 @@ static int synth_field_size(char *type)
 		size = sizeof(unsigned long);
 	else if (strcmp(type, "pid_t") == 0)
 		size = sizeof(pid_t);
+	else if (strcmp(type, "gfp_t") == 0)
+		size = sizeof(gfp_t);
 	else if (synth_field_is_string(type))
 		size = synth_field_string_size(type);
 
@@ -792,6 +794,8 @@ static const char *synth_field_fmt(char *type)
 		fmt = "%lu";
 	else if (strcmp(type, "pid_t") == 0)
 		fmt = "%d";
+	else if (strcmp(type, "gfp_t") == 0)
+		fmt = "%u";
 	else if (synth_field_is_string(type))
 		fmt = "%s";
 
-- 
2.14.1

