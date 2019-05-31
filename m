Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3810C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52C626A52
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfEaOPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 10:15:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:8345 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfEaOPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 10:15:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 May 2019 07:15:52 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 31 May 2019 07:15:50 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 01/16] software node: Allow node creation without properties
Date:   Fri, 31 May 2019 17:15:32 +0300
Message-Id: <20190531141547.22728-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531141547.22728-1-heikki.krogerus@linux.intel.com>
References: <20190531141547.22728-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Software nodes are not forced to have device properties.
Adding check to property_entries_dup() to make it possible
to create software nodes that don't have any properties.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/base/swnode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 7fc5a18e02ad..30077454eb68 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -383,6 +383,9 @@ property_entries_dup(const struct property_entry *properties)
 	int i, n = 0;
 	int ret;
 
+	if (!properties)
+		return NULL;
+
 	while (properties[n].name)
 		n++;
 
-- 
2.20.1

