Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1364C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B1E22087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfECIrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:47:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:5527 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbfECIp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:45:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 01:45:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="147811539"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2019 01:45:25 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 04/22] intel_th: Skip subdevices if their MMIO is missing
Date:   Fri,  3 May 2019 11:44:37 +0300
Message-Id: <20190503084455.23436-5-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
References: <20190503084455.23436-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a subdevice requires an MMIO region that wasn't in the resources passed
down from the glue layer, don't instantiate it, but don't error out. This
means that that particular subdevice doesn't exist for this instance of
Intel TH, which is a perfectly normal situation. This applies, for example,
to the "rtit" source device.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index c577b94ee606..8c221e1ed12d 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -607,6 +607,9 @@ intel_th_subdevice_alloc(struct intel_th *th,
 		 */
 		if (!res[r].end && res[r].flags == IORESOURCE_MEM) {
 			bar = res[r].start;
+			err = -ENODEV;
+			if (bar >= th->num_resources)
+				goto fail_put_device;
 			res[r].start = 0;
 			res[r].end = resource_size(&devres[bar]) - 1;
 		}
@@ -749,8 +752,13 @@ static int intel_th_populate(struct intel_th *th)
 
 		thdev = intel_th_subdevice_alloc(th, subdev);
 		/* note: caller should free subdevices from th::thdev[] */
-		if (IS_ERR(thdev))
+		if (IS_ERR(thdev)) {
+			/* ENODEV for individual subdevices is allowed */
+			if (PTR_ERR(thdev) == -ENODEV)
+				continue;
+
 			return PTR_ERR(thdev);
+		}
 
 		th->thdev[th->num_thdevs++] = thdev;
 	}
@@ -813,9 +821,6 @@ intel_th_alloc(struct device *dev, struct intel_th_drvdata *drvdata,
 	struct intel_th *th;
 	int err, r;
 
-	if (ndevres < TH_MMIO_END)
-		return ERR_PTR(-EINVAL);
-
 	th = kzalloc(sizeof(*th), GFP_KERNEL);
 	if (!th)
 		return ERR_PTR(-ENOMEM);
-- 
2.20.1

