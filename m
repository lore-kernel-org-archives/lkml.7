Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D049C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 18:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350C320661
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 18:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfLCSUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 13:20:16 -0500
Received: from mga12.intel.com ([192.55.52.136]:47264 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbfLCSUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 13:20:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 10:20:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,274,1571727600"; 
   d="scan'208";a="235976270"
Received: from txandevlnx324.an.intel.com ([10.123.117.46])
  by fmsmga004.fm.intel.com with ESMTP; 03 Dec 2019 10:20:15 -0800
From:   Ben Shelton <benjamin.h.shelton@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ben Shelton <benjamin.h.shelton@intel.com>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2] checkpatch: Don't warn about returning EPOLL* defines
Date:   Tue,  3 Dec 2019 12:19:48 -0600
Message-Id: <1575397188-40817-1-git-send-email-benjamin.h.shelton@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EPOLL* defines are bit definitions, not errno values, so they should
be returned as-is, not as negative values.

Signed-off-by: Ben Shelton <benjamin.h.shelton@intel.com>
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 592911a..67ca588 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4869,7 +4869,8 @@ sub process {
 # Return of what appears to be an errno should normally be negative
 		if ($sline =~ /\breturn(?:\s*\(+\s*|\s+)(E[A-Z]+)(?:\s*\)+\s*|\s*)[;:,]/) {
 			my $name = $1;
-			if ($name ne 'EOF' && $name ne 'ERROR') {
+			if ($name ne 'EOF' && $name ne 'ERROR' &&
+			    $name !~ /EPOLL/) {
 				WARN("USE_NEGATIVE_ERRNO",
 				     "return of an errno should typically be negative (ie: return -$1)\n" . $herecurr);
 			}
-- 
2.6.4

