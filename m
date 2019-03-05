Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C3AC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0086E20675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfCEHM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 02:12:56 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:50927 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfCEHM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 02:12:56 -0500
X-Originating-IP: 79.86.19.127
Received: from alex.numericable.fr (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 63E5620002;
        Tue,  5 Mar 2019 07:12:53 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v2] scripts: checkpatch: Check multiple blank lines when deleting code
Date:   Tue,  5 Mar 2019 02:12:51 -0500
Message-Id: <20190305071251.28427-1-alex@ghiti.fr>
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

Changes in v2:
	- Fix the --fix option

 scripts/checkpatch.pl | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b737ca9d7204..7dc12c137009 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2081,10 +2081,15 @@ sub fix_inserted_deleted_lines {
 		}
 
 		while (defined($inserted) && ${$inserted}{'LINENR'} == $old_linenr) {
+			my $len = 1;
 			push(@lines, ${$inserted}{'LINE'});
+			# Do not increment the length when inserting a deletion line.
+			if (${$inserted}{'LINE'} =~ /^\-/) {
+				$len = 0;
+			}
 			$inserted = @{$insertedRef}[$next_insert++];
 			$new_linenr++;
-			fixup_current_range(\$lines[$range_last_linenr], $delta_offset++, 1);
+			fixup_current_range(\$lines[$range_last_linenr], $delta_offset++, $len);
 		}
 
 		if ($save_line) {
@@ -3298,12 +3303,18 @@ sub process {
 
 # check for multiple consecutive blank lines
 		if ($prevline =~ /^[\+ ]\s*$/ &&
-		    $line =~ /^\+\s*$/ &&
+		    $line =~ /^[\+ ]\s*$/ &&
 		    $last_blank_line != ($linenr - 1)) {
 			if (CHK("LINE_SPACING",
 				"Please don't use multiple blank lines\n" . $hereprev) &&
 			    $fix) {
 				fix_delete_line($fixlinenr, $rawline);
+				if ($line =~ /^ \s*$/) {
+					# If the line is not an inserted blank line, the multiple
+					# consecutive blank lines are caused by deletion: fix this
+					# by replacing the blank line with a deletion line.
+					fix_insert_line($fixlinenr, "\-");
+				}
 			}
 
 			$last_blank_line = $linenr;
-- 
2.20.1

