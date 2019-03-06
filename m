Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3C0C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6D720684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbfCFTx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 14:53:29 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:36009 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfCFTx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 14:53:28 -0500
X-Originating-IP: 79.86.19.127
Received: from alex.numericable.fr (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 47EB9FF806;
        Wed,  6 Mar 2019 19:53:26 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v3] scripts: checkpatch: Check multiple blank lines when deleting code
Date:   Wed,  6 Mar 2019 14:53:24 -0500
Message-Id: <20190306195324.11634-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By matching only current line starting with '+', we miss the case
when deleting code makes consecutive blank lines appear: this patch
then makes it possible to detect this case by also matching current
line starting with ' ', which is an already existing blank line.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---

Changes in v3 as suggested by Joe Perches:
	- Do not try to fix this case
	- Make this test separate from the insertion one so that warning
	  is more explicit

Changes in v2:
	- Fix the --fix option

 scripts/checkpatch.pl | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b737ca9d7204..c0728cff292f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3296,7 +3296,7 @@ sub process {
 			}
 		}
 
-# check for multiple consecutive blank lines
+# check for multiple consecutive blank lines caused by blank line insertion
 		if ($prevline =~ /^[\+ ]\s*$/ &&
 		    $line =~ /^\+\s*$/ &&
 		    $last_blank_line != ($linenr - 1)) {
@@ -3309,6 +3309,16 @@ sub process {
 			$last_blank_line = $linenr;
 		}
 
+# check for multiple consecutive blank lines caused by code deletion
+		if ($prevline =~ /^[\+ ]\s*$/ &&
+		    $line =~ /^ \s*$/ &&
+		    $last_blank_line != ($linenr - 1)) {
+			CHK("LINE_SPACING",
+			    "Avoid deleting lines that create consecutive blank lines\n" . $hereprev);
+
+			$last_blank_line = $linenr;
+		}
+
 # check for missing blank lines after declarations
 		if ($sline =~ /^\+\s+\S/ &&			#Not at char 1
 			# actual declarations
-- 
2.20.1

