Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FA0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43D02133F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfCRTP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:15:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:37070 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbfCRTPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:15:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 12:15:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,494,1544515200"; 
   d="scan'208";a="156107029"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga001.fm.intel.com with ESMTP; 18 Mar 2019 12:15:04 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 05/10] HID: intel-ish-hid: Store ishtp_cl_device instance in device
Date:   Mon, 18 Mar 2019 12:14:23 -0700
Message-Id: <20190318191428.6527-6-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190318191428.6527-1-srinivas.pandruvada@linux.intel.com>
References: <20190318191428.6527-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store ishtp_cl_device pointer in device struct private data. In this
way we can get ishtp_cl_device * from device struct pointer.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index 95a97534fcda..2ca65864192f 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -466,6 +466,7 @@ static struct ishtp_cl_device *ishtp_bus_add_device(struct ishtp_device *dev,
 	}
 
 	ishtp_device_ready = true;
+	dev_set_drvdata(&device->dev, device);
 
 	return device;
 }
-- 
2.17.2

