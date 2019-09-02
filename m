Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77028C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55303217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbfIBN5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:57:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:52292 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731082AbfIBN5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:57:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 06:57:35 -0700
X-IronPort-AV: E=Sophos;i="5.64,459,1559545200"; 
   d="scan'208";a="184503321"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 06:57:32 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id E112521057;
        Mon,  2 Sep 2019 16:57:25 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1i4mpo-00067d-RY; Mon, 02 Sep 2019 16:57:32 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v5 09/11] lib/vsprintf: OF nodes are first and foremost, struct device_nodes
Date:   Mon,  2 Sep 2019 16:57:30 +0300
Message-Id: <20190902135732.23455-10-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902135732.23455-1-sakari.ailus@linux.intel.com>
References: <20190902135732.23455-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out static kobject_string() function that simply calls
device_node_string(), and thus remove references to kobjects (as these are
struct device_node).

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/vsprintf.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index a04a2167101ef..4ad9332d54ba6 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1905,6 +1905,9 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 	struct printf_spec str_spec = spec;
 	str_spec.field_width = -1;
 
+	if (fmt[0] != 'F')
+		return error_string(buf, end, "(%pO?)", spec);
+
 	if (!IS_ENABLED(CONFIG_OF))
 		return error_string(buf, end, "(%pOF?)", spec);
 
@@ -1978,17 +1981,6 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 	return widen_string(buf, buf - buf_start, end, spec);
 }
 
-static char *kobject_string(char *buf, char *end, void *ptr,
-			    struct printf_spec spec, const char *fmt)
-{
-	switch (fmt[1]) {
-	case 'F':
-		return device_node_string(buf, end, ptr, spec, fmt + 1);
-	}
-
-	return error_string(buf, end, "(%pO?)", spec);
-}
-
 /*
  * Show a '%p' thing.  A kernel extension is that the '%p' is followed
  * by an extra set of alphanumeric characters that are extended format
@@ -2167,7 +2159,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	case 'G':
 		return flags_string(buf, end, ptr, spec, fmt);
 	case 'O':
-		return kobject_string(buf, end, ptr, spec, fmt);
+		return device_node_string(buf, end, ptr, spec, fmt + 1);
 	case 'x':
 		return pointer_string(buf, end, ptr, spec);
 	}
-- 
2.20.1

