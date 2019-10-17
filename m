Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA09ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889252064A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502467AbfJQMhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:37:14 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:51893 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729184AbfJQMhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:37:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01451;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TfJXjjY_1571315822;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TfJXjjY_1571315822)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Oct 2019 20:37:11 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     xlpang@linux.alibaba.com, zhiche.yy@alibaba-inc.com,
        Wen Yang <wenyang@linux.alibaba.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: add checks for fixes tags
Date:   Thu, 17 Oct 2019 20:37:01 +0800
Message-Id: <20191017123701.45562-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SHA1 should be at least 12 digits long, as suggested
by Stephen:
Https://lkml.org/lkml/2019/9/10/626
Https://lkml.org/lkml/2019/7/10/304

And the fixes tag should also be capitalized (Fixes:),
as suggested by David:
Https://lkml.org/lkml/2019/10/1/1067

Add checks to the above issues.

Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Andy Whitcroft <apw@canonical.com> (maintainer:CHECKPATCH)
Cc: Joe Perches <joe@perches.com> (maintainer:CHECKPATCH)
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org (open list)
---
 scripts/checkpatch.pl | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a85d719df1f4..daefd0c546ff 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2925,7 +2925,7 @@ sub process {
 		}
 
 # check for invalid commit id
-		if ($in_commit_log && $line =~ /(^fixes:|\bcommit)\s+([0-9a-f]{6,40})\b/i) {
+		if ($in_commit_log && $line =~ /(\bcommit)\s+([0-9a-f]{6,40})\b/i) {
 			my $id;
 			my $description;
 			($id, $description) = git_commit_info($2, undef, undef);
@@ -2935,6 +2935,25 @@ sub process {
 			}
 		}
 
+# check for invalid fixes tag
+		if ($in_commit_log && $line =~ /(^fixes:)\s+([0-9a-f]{6,40})\b/i) {
+			my $id;
+			my $description;
+			($id, $description) = git_commit_info($2, undef, undef);
+			if (!defined($id)) {
+				WARN("UNKNOWN_COMMIT_ID",
+				     "Unknown commit id '$2', maybe rebased or not pulled?\n" . $herecurr);
+			}
+			if ($1 ne "Fixes:") {
+				WARN("FIXES_TAG_STYLE",
+				     "The fixes tag should be capitalized (Fixes:).\n" . $hereprev);
+			}
+			if (length($2) < 12) {
+				WARN("FIXES_TAG_STYLE",
+				     "SHA1 should be at least 12 digits long.\n" . $hereprev);
+			}
+		}
+
 # ignore non-hunk lines and lines being removed
 		next if (!$hunk_line || $line =~ /^-/);
 
-- 
2.23.0

