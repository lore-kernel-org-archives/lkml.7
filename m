Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E554C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 22:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64302089C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 22:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbfGSWbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 18:31:37 -0400
Received: from smtprelay0030.hostedemail.com ([216.40.44.30]:39670 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727344AbfGSWbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 18:31:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id CD874181D12E4;
        Fri, 19 Jul 2019 22:31:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: balls64_4803536cd1a0e
X-Filterd-Recvd-Size: 1905
Received: from joe-laptop.perches.com (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Fri, 19 Jul 2019 22:31:34 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] checkpatch: Don't interpret stack dumps as commit IDs
Date:   Fri, 19 Jul 2019 15:31:32 -0700
Message-Id: <f7dc9727795db3802809a24162abe0b67e14123b.1563575364.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add more types of lines that appear to be stack dumps that also include
hex lines that might otherwise be interpreted as commit IDs.

Link: http://lkml.kernel.org/r/ff00208289224f0ca4eaf4ff7c9c6e087dad0a63.camel@perches.com

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

This replaces the unsigned patch with an incomplete commit description
in -next.

 scripts/checkpatch.pl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 93a7edfe0f05..3c0ee0dde850 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2725,8 +2725,10 @@ sub process {
 		    ($line =~ /^\s*(?:WARNING:|BUG:)/ ||
 		     $line =~ /^\s*\[\s*\d+\.\d{6,6}\s*\]/ ||
 					# timestamp
-		     $line =~ /^\s*\[\<[0-9a-fA-F]{8,}\>\]/)) {
-					# stack dump address
+		     $line =~ /^\s*\[\<[0-9a-fA-F]{8,}\>\]/) ||
+		     $line =~ /^(?:\s+\w+:\s+[0-9a-fA-F]+){3,3}/ ||
+		     $line =~ /^\s*\#\d+\s*\[[0-9a-fA-F]+\]\s*\w+ at [0-9a-fA-F]+/) {
+					# stack dump address styles
 			$commit_log_possible_stack_dump = 1;
 		}
 
-- 
2.15.0

