Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB56C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B52D21721
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfH3HwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:52:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:24311 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbfH3HwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:52:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 00:52:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,446,1559545200"; 
   d="scan'208";a="197983254"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 30 Aug 2019 00:51:58 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v3 1/2] software node: Initialize the return value in software_node_to_swnode()
Date:   Fri, 30 Aug 2019 10:51:55 +0300
Message-Id: <20190830075156.76873-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190830075156.76873-1-heikki.krogerus@linux.intel.com>
References: <20190830075156.76873-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The software node is searched from a list that may be empty
when the function is called. This makes sure that the
function returns NULL even if the list is empty.

Fixes: 80488a6b1d3c ("software node: Add support for static node descriptors")
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/swnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 024d3f54a8d6..82dd69d72a64 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -51,7 +51,7 @@ EXPORT_SYMBOL_GPL(is_software_node);
 static struct swnode *
 software_node_to_swnode(const struct software_node *node)
 {
-	struct swnode *swnode;
+	struct swnode *swnode = NULL;
 	struct kobject *k;
 
 	if (!node)
-- 
2.23.0.rc1

