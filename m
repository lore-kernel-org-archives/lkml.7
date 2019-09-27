Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FA2C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 04:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756EA2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 04:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfI0Eqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 00:46:40 -0400
Received: from smtprelay0182.hostedemail.com ([216.40.44.182]:53042 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbfI0Eqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 00:46:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id C8D02182CED28;
        Fri, 27 Sep 2019 04:46:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: comb94_56d9f54a7e10f
X-Filterd-Recvd-Size: 4689
Received: from XPS-9350 (unknown [113.22.183.150])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Fri, 27 Sep 2019 04:46:36 +0000 (UTC)
Message-ID: <33605b9fc0e0f711236951ae84185a6218acff4f.camel@perches.com>
Subject: [PATCH] get_maintainer: Add signatures from Fixes: <badcommit>
 lines in commit message
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>
Date:   Thu, 26 Sep 2019 21:46:34 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: lines in a commit message generally indicate that a
previous commit was inadequate for whatever reason.

The signers of the previous inadequate commit should also be
cc'd on this new commit so update get_maintainer to find the
old commit and add the original signers.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/get_maintainer.pl | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 5ef59214c555..34085d146fa2 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -26,6 +26,7 @@ my $email = 1;
 my $email_usename = 1;
 my $email_maintainer = 1;
 my $email_reviewer = 1;
+my $email_fixes = 1;
 my $email_list = 1;
 my $email_moderated_list = 1;
 my $email_subscriber_list = 0;
@@ -249,6 +250,7 @@ if (!GetOptions(
 		'r!' => \$email_reviewer,
 		'n!' => \$email_usename,
 		'l!' => \$email_list,
+		'fixes!' => \$email_fixes,
 		'moderated!' => \$email_moderated_list,
 		's!' => \$email_subscriber_list,
 		'multiline!' => \$output_multiline,
@@ -503,6 +505,7 @@ sub read_mailmap {
 ## use the filenames on the command line or find the filenames in the patchfiles
 
 my @files = ();
+my @fixes = ();			# If a patch description includes Fixes: lines
 my @range = ();
 my @keyword_tvi = ();
 my @file_emails = ();
@@ -568,6 +571,8 @@ foreach my $file (@ARGV) {
 		my $filename2 = $2;
 		push(@files, $filename1);
 		push(@files, $filename2);
+	    } elsif (m/^Fixes:\s+([0-9a-fA-F]{6,40})/) {
+		push(@fixes, $1) if ($email_fixes);
 	    } elsif (m/^\+\+\+\s+(\S+)/ or m/^---\s+(\S+)/) {
 		my $filename = $1;
 		$filename =~ s@^[^/]*/@@;
@@ -598,6 +603,7 @@ foreach my $file (@ARGV) {
 }
 
 @file_emails = uniq(@file_emails);
+@fixes = uniq(@fixes);
 
 my %email_hash_name;
 my %email_hash_address;
@@ -612,7 +618,6 @@ my %deduplicate_name_hash = ();
 my %deduplicate_address_hash = ();
 
 my @maintainers = get_maintainers();
-
 if (@maintainers) {
     @maintainers = merge_email(@maintainers);
     output(@maintainers);
@@ -927,6 +932,10 @@ sub get_maintainers {
 	}
     }
 
+    foreach my $fix (@fixes) {
+	vcs_add_commit_signers($fix, "blamed_fixes");
+    }
+
     foreach my $email (@email_to, @list_to) {
 	$email->[0] = deduplicate_email($email->[0]);
     }
@@ -1031,6 +1040,7 @@ MAINTAINER field selection options:
     --roles => show roles (status:subsystem, git-signer, list, etc...)
     --rolestats => show roles and statistics (commits/total_commits, %)
     --file-emails => add email addresses found in -f file (default: 0 (off))
+    --fixes => for patches, add signatures of commits with 'Fixes: <commit>' (default: 1 (on))
   --scm => print SCM tree(s) if any
   --status => print status if any
   --subsystem => print subsystem name if any
@@ -1730,6 +1740,32 @@ sub vcs_is_hg {
     return $vcs_used == 2;
 }
 
+sub vcs_add_commit_signers {
+    return if (!vcs_exists());
+
+    my ($commit, $desc) = @_;
+    my $commit_count = 0;
+    my $commit_authors_ref;
+    my $commit_signers_ref;
+    my $stats_ref;
+    my @commit_authors = ();
+    my @commit_signers = ();
+    my $cmd;
+
+    $cmd = $VCS_cmds{"find_commit_signers_cmd"};
+    $cmd =~ s/(\$\w+)/$1/eeg;	#substitute variables in $cmd
+
+    ($commit_count, $commit_signers_ref, $commit_authors_ref, $stats_ref) = vcs_find_signers($cmd, "");
+    @commit_authors = @{$commit_authors_ref} if defined $commit_authors_ref;
+    @commit_signers = @{$commit_signers_ref} if defined $commit_signers_ref;
+
+    foreach my $signer (@commit_signers) {
+	$signer = deduplicate_email($signer);
+    }
+
+    vcs_assign($desc, 1, @commit_signers);
+}
+
 sub interactive_get_maintainers {
     my ($list_ref) = @_;
     my @list = @$list_ref;


