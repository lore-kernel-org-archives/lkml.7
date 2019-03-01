Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569AEC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0312087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733116AbfCAIKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 03:10:07 -0500
Received: from mga07.intel.com ([134.134.136.100]:36844 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbfCAIKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 03:10:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2019 00:10:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,426,1544515200"; 
   d="scan'208";a="128172075"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2019 00:10:00 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH] intel_th: gth: Fix an off-by-one in output unassigning
Date:   Fri,  1 Mar 2019 10:09:55 +0200
Message-Id: <20190301080955.1256-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9ed3f22223c3 ("intel_th: Don't reference unassigned outputs")
fixes a NULL dereference for all masters except the last one ("256+"),
which keeps the stale pointer after the output driver had been unassigned.

Fix the off-by-one.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: 9ed3f22223c3 ("intel_th: Don't reference unassigned outputs")
---
 drivers/hwtracing/intel_th/gth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/gth.c b/drivers/hwtracing/intel_th/gth.c
index cc287cf6eb29..edc52d75e6bd 100644
--- a/drivers/hwtracing/intel_th/gth.c
+++ b/drivers/hwtracing/intel_th/gth.c
@@ -616,7 +616,7 @@ static void intel_th_gth_unassign(struct intel_th_device *thdev,
 	othdev->output.port = -1;
 	othdev->output.active = false;
 	gth->output[port].output = NULL;
-	for (master = 0; master < TH_CONFIGURABLE_MASTERS; master++)
+	for (master = 0; master <= TH_CONFIGURABLE_MASTERS; master++)
 		if (gth->master[master] == port)
 			gth->master[master] = -1;
 	spin_unlock(&gth->gth_lock);
-- 
2.20.1

