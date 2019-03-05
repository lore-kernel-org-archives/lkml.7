Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935BEC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673DD2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfCESCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:02:44 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:42381 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfCESCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:02:44 -0500
Received: from alex.numericable.fr (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 3D34510000E;
        Tue,  5 Mar 2019 18:02:41 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH] scripts: checkpatch: Check block comments start with /* empty line outside net
Date:   Tue,  5 Mar 2019 13:02:38 -0500
Message-Id: <20190305180238.32630-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch ensures that apart from net code, block comments start with an
empty /* line.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 scripts/checkpatch.pl | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7dc12c137009..bcaf5d317976 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3230,12 +3230,21 @@ sub process {
 
 # Block comment styles
 # Networking with an initial /*
-		if ($realfile =~ m@^(drivers/net/|net/)@ &&
-		    $prevrawline =~ /^\+[ \t]*\/\*[ \t]*$/ &&
-		    $rawline =~ /^\+[ \t]*\*/ &&
-		    $realline > 2) {
-			WARN("NETWORKING_BLOCK_COMMENT_STYLE",
-			     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
+		if ($realfile =~ m@^(drivers/net/|net/)@) {
+			if ($prevrawline =~ /^\+[ \t]*\/\*[ \t]*$/ &&
+			    $rawline =~ /^\+[ \t]*\*/ &&
+			    $realline > 2) {
+				WARN("NETWORKING_BLOCK_COMMENT_STYLE",
+				     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
+			}
+		} else {
+# 'Normal' with an initial empty /*
+			if ($prevrawline =~ /^\+[ \t]*\/\*[ \t]*\S/ &&
+			    $rawline =~ /^\+[ \t]*\*/ &&
+			    $realline > 2) {
+				WARN("BLOCK_COMMENT_STYLE",
+				     "block comments use an empty /* line, don't use /* Comment...\n" . $hereprev);
+			}
 		}
 
 # Block comments use * on subsequent lines
-- 
2.20.1

