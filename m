Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66702C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B652070C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389123AbfIEMD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:03:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389092AbfIEMD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:03:26 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 84445335D9;
        Thu,  5 Sep 2019 12:03:26 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBFCF1001947;
        Thu,  5 Sep 2019 12:03:25 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     andriy.shevchenko@intel.com, Prarit Bhargava <prarit@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Arcari <darcari@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/9] tools/power/x86/intel-speed-select: Output success/failed for command output
Date:   Thu,  5 Sep 2019 08:03:10 -0400
Message-Id: <20190905120311.15286-9-prarit@redhat.com>
In-Reply-To: <20190905120311.15286-1-prarit@redhat.com>
References: <20190905120311.15286-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 05 Sep 2019 12:03:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Command output has confusing data, returning "0" on success.  For example

|# ./intel-speed-select -c 14 turbo-freq enable
Intel(R) Speed Select Technology
Executing on CPU model:106[0x6a]
 package-1
   die-0
     cpu-14
       turbo-freq
         enable:0

To avoid confusion change the command output to 'success' or 'failed'.

v2: Remove help output line.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: David Arcari <darcari@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 tools/power/x86/intel-speed-select/isst-config.c  | 1 -
 tools/power/x86/intel-speed-select/isst-display.c | 5 ++++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index f81a28c6b586..78f0cebda1da 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1514,7 +1514,6 @@ static void usage(void)
 	printf("\tResult display uses a common format for each command:\n");
 	printf("\tResults are formatted in text/JSON with\n");
 	printf("\t\tPackage, Die, CPU, and command specific results.\n");
-	printf("\t\t\tFor Set commands, status is 0 for success and rest for failures\n");
 	exit(1);
 }
 
diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index 890a01bfee4b..8500cf2997a6 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -519,7 +519,10 @@ void isst_display_result(int cpu, FILE *outf, char *feature, char *cmd,
 	snprintf(header, sizeof(header), "%s", feature);
 	format_and_print(outf, 4, header, NULL);
 	snprintf(header, sizeof(header), "%s", cmd);
-	snprintf(value, sizeof(value), "%d", result);
+	if (!result)
+		snprintf(value, sizeof(value), "success");
+	else
+		snprintf(value, sizeof(value), "failed(error %d)", result);
 	format_and_print(outf, 5, header, value);
 
 	format_and_print(outf, 1, NULL, NULL);
-- 
2.21.0

