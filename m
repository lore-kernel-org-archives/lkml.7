Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A162CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791CE2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfCLOok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:44:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:54009 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbfCLOog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:44:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 07:44:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,471,1544515200"; 
   d="scan'208";a="281971336"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 12 Mar 2019 07:44:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 66C322E0; Tue, 12 Mar 2019 16:44:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 3/5] auxdisplay: charlcd: Introduce charlcd_free() helper
Date:   Tue, 12 Mar 2019 16:44:30 +0200
Message-Id: <20190312144432.7668-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312144432.7668-1-andriy.shevchenko@linux.intel.com>
References: <20190312144432.7668-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The charlcd_free() is a counterpart to charlcd_alloc()
and should be called symmetrically on tear down.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/charlcd.c | 6 ++++++
 include/misc/charlcd.h       | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 407acd22efa8..a351a9400054 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -818,6 +818,12 @@ struct charlcd *charlcd_alloc(unsigned int drvdata_size)
 }
 EXPORT_SYMBOL_GPL(charlcd_alloc);
 
+void charlcd_free(struct charlcd *lcd)
+{
+	kfree(charlcd_to_priv(lcd));
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

