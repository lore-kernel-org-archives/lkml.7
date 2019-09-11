Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE36CECDE28
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 06:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F5321A4C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 06:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfIKGQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 02:16:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:26661 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbfIKGQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 02:16:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 23:16:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="185731691"
Received: from pipin.fi.intel.com ([10.237.72.175])
  by fmsmga007.fm.intel.com with ESMTP; 10 Sep 2019 23:16:25 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     Christopher S Hall <christopher.s.hall@intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH v4 2/2] PTP: add support for one-shot output
Date:   Wed, 11 Sep 2019 09:16:22 +0300
Message-Id: <20190911061622.774006-2-felipe.balbi@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190911061622.774006-1-felipe.balbi@linux.intel.com>
References: <20190911061622.774006-1-felipe.balbi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some controllers allow for a one-shot output pulse, in contrast to
periodic output. Now that we have extensible versions of our IOCTLs, we
can finally make use of the 'flags' field to pass a bit telling driver
that if we want one-shot pulse output.

Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
---

Changes since v3:
	- Remove bogus bitwise negation

Changes since v2:
	- Add _PEROUT_ to bit macro

Changes since v1:
	- remove comment from .flags field

 include/uapi/linux/ptp_clock.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
index 9a0af3511b68..f16301015949 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -38,8 +38,8 @@
 /*
  * Bits of the ptp_perout_request.flags field:
  */
-#define PTP_PEROUT_VALID_FLAGS (0)
-
+#define PTP_PEROUT_ONE_SHOT (1<<0)
+#define PTP_PEROUT_VALID_FLAGS	(PTP_PEROUT_ONE_SHOT)
 /*
  * struct ptp_clock_time - represents a time value
  *
@@ -77,7 +77,7 @@ struct ptp_perout_request {
 	struct ptp_clock_time start;  /* Absolute start time. */
 	struct ptp_clock_time period; /* Desired period, zero means disable. */
 	unsigned int index;           /* Which channel to configure. */
-	unsigned int flags;           /* Reserved for future use. */
+	unsigned int flags;
 	unsigned int rsv[4];          /* Reserved for future use. */
 };
 
-- 
2.23.0

