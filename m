Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F481C10F06
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 01:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E46B2085A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 01:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfCOBB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 21:01:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:38888 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbfCOBB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 21:01:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 18:01:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,480,1544515200"; 
   d="scan'208";a="127093664"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.244.182])
  by orsmga006.jf.intel.com with ESMTP; 14 Mar 2019 18:01:26 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
        net-next@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
        joe@perches.com
Subject: [PATCH] checkpatch: fix camel case seeding when run with --root
Date:   Thu, 14 Mar 2019 18:01:23 -0700
Message-Id: <20190315010123.4334-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.18.0.219.gaf81d287a9da
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch.pl avoids warning about camel case of some definitions by
seeding a file that tracks all of the currently committed camel case
definitions.

To build this seed file, checkpatch.pl decides between using git or the
--root parameter.

This works as long as you don't run checkpatch.pl from within
a different git tree that is not the Linux kernel.

In this case, the check for ".git" will return true, and checkpatch will
attempt to seed a camel case file using the current directory. This
works fine if --root is not provided, but can result in an incorrect
camel case seed file resulting in false positive warnings.

Fix this by checking for $root/.git instead, so that we use the --root
parameter properly when seeding the camel case list.

Additionally, when generating the list of files to be checked, prefix
the $root path so that the correct file will be found.

These changes allow checkpatch.pl to honor the --root parameter even if
being run from within another git repository.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

I sent this a long time ago, https://patchwork.ozlabs.org/patch/663831/ but
it was never noticed or reviewed.

I thought I'd dredge it back up and write a better description of the
problem and the fix.

 scripts/checkpatch.pl | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d0001fd1112d..358add495e18 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -903,8 +903,8 @@ sub seed_camelcase_includes {
 
 	$camelcase_seeded = 1;
 
-	if (-e ".git") {
-		my $git_last_include_commit = `git log --no-merges --pretty=format:"%h%n" -1 -- include`;
+	if (-e "$root/.git") {
+		my $git_last_include_commit = `cd $root && git log --no-merges --pretty=format:"%h%n" -1 -- include`;
 		chomp $git_last_include_commit;
 		$camelcase_cache = ".checkpatch-camelcase.git.$git_last_include_commit";
 	} else {
@@ -931,9 +931,10 @@ sub seed_camelcase_includes {
 		return;
 	}
 
-	if (-e ".git") {
-		$files = `git ls-files "include/*.h"`;
+	if (-e "$root/.git") {
+		$files = `cd $root && git ls-files "include/*.h"`;
 		@include_files = split('\n', $files);
+		@include_files = map("$root/$_", @include_files);
 	}
 
 	foreach my $file (@include_files) {
-- 
2.18.0.219.gaf81d287a9da

