Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F67C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DDB2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfC1MhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:37:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:34153 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727330AbfC1Mgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:36:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 05:36:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="138136892"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 28 Mar 2019 05:36:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2BC02161E; Thu, 28 Mar 2019 14:36:35 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Mario.Limonciello@dell.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        netdev@vger.kernel.org
Subject: [PATCH v3 28/36] thunderbolt: Run tb_xdp_handle_request() in system workqueue
Date:   Thu, 28 Mar 2019 15:36:25 +0300
Message-Id: <20190328123633.42882-29-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We run all XDomain requests during discovery in tb->wq and since it only
runs one work at the time it means that sending back reply to the other
domain may be delayed too much depending whether there is an active
XDomain discovery request running.

To make sure we can send reply to the other domain as soon as possible
run tb_xdp_handle_request() in system workqueue instead. Since the
device can be hot-removed in the middle we need to make sure the domain
structure is still around when the function is run so increase reference
count before we schedule the reply work.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/tb.h      | 7 +++++++
 drivers/thunderbolt/xdomain.c | 6 ++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index dd7808f9de39..19bdeeaf1d18 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -462,6 +462,13 @@ int tb_domain_approve_xdomain_paths(struct tb *tb, struct tb_xdomain *xd);
 int tb_domain_disconnect_xdomain_paths(struct tb *tb, struct tb_xdomain *xd);
 int tb_domain_disconnect_all_paths(struct tb *tb);
 
+static inline struct tb *tb_domain_get(struct tb *tb)
+{
+	if (tb)
+		get_device(&tb->dev);
+	return tb;
+}
+
 static inline void tb_domain_put(struct tb *tb)
 {
 	put_device(&tb->dev);
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index 7bae92bc486f..44d3b2e486cd 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -524,6 +524,8 @@ static void tb_xdp_handle_request(struct work_struct *work)
 out:
 	kfree(xw->pkg);
 	kfree(xw);
+
+	tb_domain_put(tb);
 }
 
 static bool
@@ -542,9 +544,9 @@ tb_xdp_schedule_request(struct tb *tb, const struct tb_xdp_header *hdr,
 		kfree(xw);
 		return false;
 	}
-	xw->tb = tb;
+	xw->tb = tb_domain_get(tb);
 
-	queue_work(tb->wq, &xw->work);
+	schedule_work(&xw->work);
 	return true;
 }
 
-- 
2.20.1

