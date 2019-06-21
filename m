Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F39BC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64934208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfFUQUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 12:20:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:13108 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbfFUQUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 12:20:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2019 09:20:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,401,1557212400"; 
   d="scan'208";a="312029849"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 21 Jun 2019 09:20:11 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 2/4] intel_th: msu: Remove set but not used variable 'last'
Date:   Fri, 21 Jun 2019 19:19:28 +0300
Message-Id: <20190621161930.60785-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621161930.60785-1-alexander.shishkin@linux.intel.com>
References: <20190621161930.60785-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Commit aad14ad3cf3a ("intel_th: msu: Add current window tracking") added
the following gcc warning:

> drivers/hwtracing/intel_th/msu.c: In function msc_win_switch:
> drivers/hwtracing/intel_th/msu.c:1389:21: warning: variable last set but
> not used [-Wunused-but-set-variable]

Fix it by removing the variable.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Fixes: aad14ad3cf3a ("intel_th: msu: Add current window tracking")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/msu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 8c568b5c8920..6bfce03c6489 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -1400,10 +1400,9 @@ static int intel_th_msc_init(struct msc *msc)
 
 static void msc_win_switch(struct msc *msc)
 {
-	struct msc_window *last, *first;
+	struct msc_window *first;
 
 	first = list_first_entry(&msc->win_list, struct msc_window, entry);
-	last = list_last_entry(&msc->win_list, struct msc_window, entry);
 
 	if (msc_is_last_win(msc->cur_win))
 		msc->cur_win = first;
-- 
2.20.1

