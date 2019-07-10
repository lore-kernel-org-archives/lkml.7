Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE33C73C6E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DB52083D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfGJFEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 01:04:36 -0400
Received: from smtprelay0016.hostedemail.com ([216.40.44.16]:43557 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbfGJFEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 01:04:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 7644B18225E0E;
        Wed, 10 Jul 2019 05:04:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: point79_abbc6ba6bd53
X-Filterd-Recvd-Size: 1939
Received: from joe-laptop.perches.com (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jul 2019 05:04:33 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] checkpatch: Add GENMASK tests
Date:   Tue,  9 Jul 2019 22:04:14 -0700
Message-Id: <c5cf9dd30360a395b50514f8fece2231e0180ce1.1562734889.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1562734889.git.joe@perches.com>
References: <cover.1562734889.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro is easy to misuse as it's odd argument order.

If specified with simple decimal values, make sure the arguments are
ordered high then low.

Also check if any argument is > 32 where instead of GENMASK,
GENMASK_ULL should be used.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 6cb99ec62000..d37bbe33524b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6368,6 +6368,21 @@ sub process {
 			     "switch default: should use break\n" . $herectx);
 		}
 
+# check for misuses of GENMASK
+		if ($line =~ /\b(GENMASK(?:_ULL)?)\s*\(\s*(\d+)\s*,\s*(\d+)\s*\)/) {
+			my $type = $1;
+			my $high = $2;
+			my $low = $3;
+			if ($high < $low) {
+				ERROR("GENMASK",
+				      "$type argument order is high then low\n" . $herecurr);
+			}
+			if ($type eq "GENMASK" && ($high >= 32 || $low >= 32)) {
+				ERROR("GENMASK",
+				      "$type with arguments >= 32 should use GENMASK_ULL\n" . $herecurr);
+			}
+		}
+
 # check for gcc specific __FUNCTION__
 		if ($line =~ /\b__FUNCTION__\b/) {
 			if (WARN("USE_FUNC",
-- 
2.15.0

