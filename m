Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D77AC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556CA2342C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfH3QhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:37:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:65262 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727926AbfH3QhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:37:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 09:37:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="265369630"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by orsmga001.jf.intel.com with ESMTP; 30 Aug 2019 09:37:01 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] checkpatch: Validate Fixes: tag using 'commit' checks
Date:   Fri, 30 Aug 2019 09:36:58 -0700
Message-Id: <20190830163658.17043-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework checkpatch's commit checking to explicitly include the Fixes:
tag so that it catches errors like too short[1] or fat fingered[2] SHA1
references.

Add a new Fixes-only check to verify the fixed commit is a valid object
in the repository.

[1] https://lkml.kernel.org/r/20190830010615.GC27970@linux.intel.com
[2] https://lkml.kernel.org/r/20190825233120.18ac25e4@canb.auug.org.au

Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 scripts/checkpatch.pl | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 93a7edfe0f05..dead0eb41007 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2756,10 +2756,10 @@ sub process {
 		    $line !~ /^\s*(?:Link|Patchwork|http|https|BugLink):/i &&
 		    $line !~ /^This reverts commit [0-9a-f]{7,40}/ &&
 		    ($line =~ /\bcommit\s+[0-9a-f]{5,}\b/i ||
+		     $line =~ /\bfixes:\s*[0-9a-f]{5,}\b/i ||
 		     ($line =~ /(?:\s|^)[0-9a-f]{12,40}(?:[\s"'\(\[]|$)/i &&
-		      $line !~ /[\<\[][0-9a-f]{12,40}[\>\]]/i &&
-		      $line !~ /\bfixes:\s*[0-9a-f]{12,40}/i))) {
-			my $init_char = "c";
+		      $line !~ /[\<\[][0-9a-f]{12,40}[\>\]]/i))) {
+			my $init_tag = "";
 			my $orig_commit = "";
 			my $short = 1;
 			my $long = 0;
@@ -2771,29 +2771,31 @@ sub process {
 			my $orig_desc = "commit description";
 			my $description = "";
 
-			if ($line =~ /\b(c)ommit\s+([0-9a-f]{5,})\b/i) {
-				$init_char = $1;
+			if ($line =~ /\b(commit)\s+([0-9a-f]{5,})\b/i ||
+			    $line =~ /\b(fixes:)\s*([0-9a-f]{5,})\b/i) {
+				$init_tag = $1;
 				$orig_commit = lc($2);
 			} elsif ($line =~ /\b([0-9a-f]{12,40})\b/i) {
+				$init_tag = "commit";
 				$orig_commit = lc($1);
 			}
 
-			$short = 0 if ($line =~ /\bcommit\s+[0-9a-f]{12,40}/i);
-			$long = 1 if ($line =~ /\bcommit\s+[0-9a-f]{41,}/i);
-			$space = 0 if ($line =~ /\bcommit [0-9a-f]/i);
-			$case = 0 if ($line =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
-			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)"\)/i) {
+			$short = 0 if ($line =~ /\b$init_tag\s+[0-9a-f]{12,40}/i);
+			$long = 1 if ($line =~ /\b$init_tag\s+[0-9a-f]{41,}/i);
+			$space = 0 if ($line =~ /\b$init_tag [0-9a-f]/i);
+			$case = 0 if ($line =~ /\b$init_tag\s+[0-9a-f]{5,40}[^A-F]/);
+			if ($line =~ /\b$init_tag\s+[0-9a-f]{5,}\s+\("([^"]+)"\)/i) {
 				$orig_desc = $1;
 				$hasparens = 1;
-			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
+			} elsif ($line =~ /\b$init_tag\s+[0-9a-f]{5,}\s*$/i &&
 				 defined $rawlines[$linenr] &&
 				 $rawlines[$linenr] =~ /^\s*\("([^"]+)"\)/) {
 				$orig_desc = $1;
 				$hasparens = 1;
-			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
+			} elsif ($line =~ /\b$init_tag\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
 				 defined $rawlines[$linenr] &&
 				 $rawlines[$linenr] =~ /^\s*[^"]+"\)/) {
-				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
+				$line =~ /\b$init_tag\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
 				$orig_desc = $1;
 				$rawlines[$linenr] =~ /^\s*([^"]+)"\)/;
 				$orig_desc .= " " . $1;
@@ -2803,10 +2805,15 @@ sub process {
 			($id, $description) = git_commit_info($orig_commit,
 							      $id, $orig_desc);
 
-			if (defined($id) &&
-			   ($short || $long || $space || $case || ($orig_desc ne $description) || !$hasparens)) {
+
+			if (!defined($id)) {
+				if ($init_tag =~ /fixes:/i) {
+					ERROR("GIT_COMMIT_ID",
+					      "Target SHA1 '$orig_commit' does not exist\n" . $herecurr);
+				}
+			} elsif ($short || $long || $space || $case || ($orig_desc ne $description) || !$hasparens) {
 				ERROR("GIT_COMMIT_ID",
-				      "Please use git commit description style 'commit <12+ chars of sha1> (\"<title line>\")' - ie: '${init_char}ommit $id (\"$description\")'\n" . $herecurr);
+				      "Please use git commit description style '$init_tag <12+ chars of sha1> (\"<title line>\")' - ie: '$init_tag $id (\"$description\")'\n" . $herecurr);
 			}
 		}
 
-- 
2.22.0

