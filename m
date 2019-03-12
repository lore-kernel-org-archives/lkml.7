Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C303C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0527B2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfCLNSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:18:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:31775 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbfCLNSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:18:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 06:18:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,471,1544515200"; 
   d="scan'208";a="306524135"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 12 Mar 2019 06:18:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0DDC82E0; Tue, 12 Mar 2019 15:18:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/4] auxdisplay: charlcd: Introduce charlcd_free() helper
Date:   Tue, 12 Mar 2019 15:18:28 +0200
Message-Id: <20190312131830.4253-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312131830.4253-1-andriy.shevchenko@linux.intel.com>
References: <20190312131830.4253-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The charlcd_free() is a counterpart to charlcd_alloc()
and should be called symmetrically on tear down.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/charlcd.c | 6 ++++++
 include/misc/charlcd.h       | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 60e0b772673f..882be08ddad5 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -818,6 +818,12 @@ struct charlcd *charlcd_alloc(unsigned int drvdata_size)
 }
 EXPORT_SYMBOL_GPL(charlcd_alloc);
 
+void charlcd_free(struct charlcd *lcd)
+{
+	kfree(lcd);
+}
+EXPORT_SYMBOL_GPL(charlcd_free);
+
 static int panel_notify_sys(struct notifier_block *this, unsigned long code,
 			    void *unused)
 {
diff --git a/include/misc/charlcd.h b/include/misc/charlcd.h
index 23f61850f363..1832402324ce 100644
--- a/include/misc/charlcd.h
+++ b/include/misc/charlcd.h
@@ -35,6 +35,7 @@ struct charlcd_ops {
 };
 
 struct charlcd *charlcd_alloc(unsigned int drvdata_size);
+void charlcd_free(struct charlcd *lcd);
 
 int charlcd_register(struct charlcd *lcd);
 int charlcd_unregister(struct charlcd *lcd);
-- 
2.20.1

