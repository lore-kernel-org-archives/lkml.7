Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AABC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CF620650
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfJJUaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:30:23 -0400
Received: from mga17.intel.com ([192.55.52.151]:30892 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbfJJU36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:29:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 13:29:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,281,1566889200"; 
   d="scan'208";a="277902019"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga001.jf.intel.com with ESMTP; 10 Oct 2019 13:29:51 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@intel.com
Cc:     prarit@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RESEND][PATCH 01/10] tools/power/x86/intel-speed-select: Remove warning for unused result
Date:   Thu, 10 Oct 2019 13:29:36 -0700
Message-Id: <20191010202945.73616-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191010202945.73616-1-srinivas.pandruvada@linux.intel.com>
References: <20191010202945.73616-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warning for:
isst-config.c: In function ‘set_cpu_online_offline’:
isst-config.c:221:3: warning: ignoring return value of ‘write’,
declared with attribute warn_unused_result [-Wunused-result]
   write(fd, "1\n", 2);

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 tools/power/x86/intel-speed-select/isst-config.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 2a9890c8395a..21fcfe621d3a 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -169,7 +169,7 @@ int get_topo_max_cpus(void)
 static void set_cpu_online_offline(int cpu, int state)
 {
 	char buffer[128];
-	int fd;
+	int fd, ret;
 
 	snprintf(buffer, sizeof(buffer),
 		 "/sys/devices/system/cpu/cpu%d/online", cpu);
@@ -179,9 +179,12 @@ static void set_cpu_online_offline(int cpu, int state)
 		err(-1, "%s open failed", buffer);
 
 	if (state)
-		write(fd, "1\n", 2);
+		ret = write(fd, "1\n", 2);
 	else
-		write(fd, "0\n", 2);
+		ret = write(fd, "0\n", 2);
+
+	if (ret == -1)
+		perror("Online/Offline: Operation failed\n");
 
 	close(fd);
 }
-- 
2.17.2

