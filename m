Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1B6C28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 22:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D654E20862
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 22:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfFDWvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 18:51:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:52979 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbfFDWvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 18:51:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 15:51:12 -0700
X-ExtLoop1: 1
Received: from otc-lr-04.jf.intel.com ([10.54.39.141])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jun 2019 15:51:12 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 4/5] perf header: Rename "sibling cores" to "sibling sockets"
Date:   Tue,  4 Jun 2019 15:50:43 -0700
Message-Id: <1559688644-106558-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559688644-106558-1-git-send-email-kan.liang@linux.intel.com>
References: <1559688644-106558-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The "sibling cores" actually shows the sibling CPUs of a socket.
The name "sibling cores" is very misleading.

Rename "sibling cores" to "sibling sockets"

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V2.

 tools/perf/Documentation/perf.data-file-format.txt | 2 +-
 tools/perf/util/header.c                           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 0165e92..de78183 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -168,7 +168,7 @@ struct {
 };
 
 Example:
-	sibling cores   : 0-8
+	sibling sockets : 0-8
 	sibling dies	: 0-3
 	sibling dies	: 4-7
 	sibling threads : 0-1
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 6497625..06ddb66 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1460,7 +1460,7 @@ static void print_cpu_topology(struct feat_fd *ff, FILE *fp)
 	str = ph->env.sibling_cores;
 
 	for (i = 0; i < nr; i++) {
-		fprintf(fp, "# sibling cores   : %s\n", str);
+		fprintf(fp, "# sibling sockets : %s\n", str);
 		str += strlen(str) + 1;
 	}
 
-- 
2.7.4

