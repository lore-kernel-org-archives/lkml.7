Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E48C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CD12053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfICPhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:37:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729720AbfICPhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:37:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E1F0796EF;
        Tue,  3 Sep 2019 15:37:43 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 909AD19C78;
        Tue,  3 Sep 2019 15:37:42 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Arcari <darcari@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] tools/power/x86/intel-speed-select: Simplify output for turbo-freq and base-freq
Date:   Tue,  3 Sep 2019 11:37:30 -0400
Message-Id: <20190903153734.11904-5-prarit@redhat.com>
In-Reply-To: <20190903153734.11904-1-prarit@redhat.com>
References: <20190903153734.11904-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 03 Sep 2019 15:37:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current output of 'intel-speed-select -c 53 perf-profile info -l 0'
shows

        speed-select-turbo-freq-support:1
        speed-select-base-freq-support:1
        speed-select-base-freq-enabled:0
        speed-select-turbo-freq-enabled:0

Simplify the output to single lines displaying status of disabled,
enabled, and unsupported.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: David Arcari <darcari@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 .../x86/intel-speed-select/isst-display.c     | 30 ++++++++++---------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index 0d9a53a5da2d..3ae693efceaa 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -297,23 +297,25 @@ void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
 		format_and_print(outf, base_level + 4, header, value);
 
 		snprintf(header, sizeof(header),
-			 "speed-select-turbo-freq-support");
-		snprintf(value, sizeof(value), "%d", ctdp_level->fact_support);
+			 "speed-select-turbo-freq");
+		if (ctdp_level->fact_support) {
+			if (ctdp_level->fact_enabled)
+				snprintf(value, sizeof(value), "enabled");
+			else
+				snprintf(value, sizeof(value), "disabled");
+		} else
+			snprintf(value, sizeof(value), "unsupported");
 		format_and_print(outf, base_level + 4, header, value);
 
 		snprintf(header, sizeof(header),
-			 "speed-select-base-freq-support");
-		snprintf(value, sizeof(value), "%d", ctdp_level->pbf_support);
-		format_and_print(outf, base_level + 4, header, value);
-
-		snprintf(header, sizeof(header),
-			 "speed-select-base-freq-enabled");
-		snprintf(value, sizeof(value), "%d", ctdp_level->pbf_enabled);
-		format_and_print(outf, base_level + 4, header, value);
-
-		snprintf(header, sizeof(header),
-			 "speed-select-turbo-freq-enabled");
-		snprintf(value, sizeof(value), "%d", ctdp_level->fact_enabled);
+			 "speed-select-base-freq");
+		if (ctdp_level->pbf_support) {
+			if (ctdp_level->pbf_enabled)
+				snprintf(value, sizeof(value), "enabled");
+			else
+				snprintf(value, sizeof(value), "disabled");
+		} else
+			snprintf(value, sizeof(value), "unsupported");
 		format_and_print(outf, base_level + 4, header, value);
 
 		snprintf(header, sizeof(header), "thermal-design-power(W)");
-- 
2.21.0

