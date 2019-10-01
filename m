Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBBFC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7D6218DE
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388763AbfJANrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:47:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:51123 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbfJANrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:47:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 06:47:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="197857666"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2019 06:47:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 343B71F6; Tue,  1 Oct 2019 16:47:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <john.stultz@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 4/4] usb: host: xhci-tegra: Switch to use %ptT
Date:   Tue,  1 Oct 2019 16:47:17 +0300
Message-Id: <20191001134717.81282-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001134717.81282-1-andriy.shevchenko@linux.intel.com>
References: <20191001134717.81282-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use %ptT instead of open coded variant to print content of
time64_t type in human readable format.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-tegra.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 2ff7c911fbd0..c1bf2ad1474d 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -802,7 +802,6 @@ static int tegra_xusb_load_firmware(struct tegra_xusb *tegra)
 	const struct firmware *fw;
 	unsigned long timeout;
 	time64_t timestamp;
-	struct tm time;
 	u64 address;
 	u32 value;
 	int err;
@@ -907,11 +906,8 @@ static int tegra_xusb_load_firmware(struct tegra_xusb *tegra)
 	}
 
 	timestamp = le32_to_cpu(header->fwimg_created_time);
-	time64_to_tm(timestamp, 0, &time);
 
-	dev_info(dev, "Firmware timestamp: %ld-%02d-%02d %02d:%02d:%02d UTC\n",
-		 time.tm_year + 1900, time.tm_mon + 1, time.tm_mday,
-		 time.tm_hour, time.tm_min, time.tm_sec);
+	dev_info(dev, "Firmware timestamp: %ptT UTC\n", &timestamp);
 
 	return 0;
 }
-- 
2.23.0

