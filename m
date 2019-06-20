Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62404C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201972084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561051518;
	bh=AgOwejEoyxJ807Ul08F/0O+tGdcreoGcOh3qhzmOI78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sfzNT4yZjuDJPEPx9CN1w1Q6N7tEvcJLBHDYu6p5VLWkmd/KAMlV/7/0p3B49Q/2S
	 usH+WuzUZ8maZqAJ4Qu7oYcb/VGfsu5fNnInfgNLwrSI446FJfZqcUBT5TGhiTlA0J
	 Yf4OyK1KosJ7byN7Z4mEFP0ORVBmQ89zS3YL7JRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732375AbfFTRYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:24:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52576 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732159AbfFTRXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YlkVRaJYoloPTJHSMGpuuWEZdOaSNGKkqHxmAd4fl1s=; b=JqJ22RS8x5aZfiVIMPJPFgIKSU
        7YBDFpuBz9BXmuTMmXXEhbf7AVT/UZebH67y/OfS9w2jIXmfI7GeC6ydTo7avEJKX/1VXCG4uasp/
        F+RQWsjayIUZnGvdj9Cuj9io4wZtZwmWVpAKwBwpcJBQLJ6upZ1K8Si857ZVplovrLWF9VqC+QpbZ
        4gkDBkKBgOud8npAhzsxp7eYATkT51iAIu2RuFR+pKL0UdWy0GDgU4ZNueh3z3gGv9F3Bna6YpMr+
        bBbWd1BIguLNt+3z332fKuxAy8Yekpcjv1YXTP05UPSkdv4VDvUUnCXybDTh9ZtP083Jabaxsoka7
        pcY0UDlQ==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1he0mM-0008Rv-9h; Thu, 20 Jun 2019 17:23:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1he0mK-0000E7-32; Thu, 20 Jun 2019 14:23:16 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 22/22] scripts/get_abi.pl: change script to allow parsing in ReST mode
Date:   Thu, 20 Jun 2019 14:23:14 -0300
Message-Id: <c4d540b2df8f17bbcd9284c25910a23b081c9cf9.1561050806.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561050806.git.mchehab+samsung@kernel.org>
References: <cover.1561050806.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, several ABI files won't parse as ReST, as they
contain severe violations to the spec, with makes the script
to crash.

So, the code has a sanity logic with escapes bad code and
cleans tags that can cause Sphinx to crash.

Add support for disabling this mode.

Right now, as enabling rst-mode causes crash, it is disabled
by default.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/get_abi.pl | 74 ++++++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 26 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 7bc619b6890c..e2cd2234af34 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -12,8 +12,14 @@ my $man;
 my $debug;
 my $prefix="Documentation/ABI";
 
+#
+# If true, assumes that the description is formatted with ReST
+#
+my $description_is_rst = 0;
+
 GetOptions(
 	"debug|d+" => \$debug,
+	"rst-source!" => \$description_is_rst,
 	"dir=s" => \$prefix,
 	'help|?' => \$help,
 	man => \$man
@@ -145,14 +151,15 @@ sub parse_abi {
 					next;
 				}
 				if ($tag eq "description") {
-					next if ($content =~ m/^\s*$/);
-					if ($content =~ m/^(\s*)(.*)/) {
-						my $new_content = $2;
-						$space = $new_tag . $sep . $1;
-						while ($space =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {}
-						$space =~ s/./ /g;
-						$data{$what}->{$tag} .= "$new_content\n";
+					# Preserve initial spaces for the first line
+					$content = ' ' x length($new_tag) . $sep . $content;
+					$content =~ s,^(\s*):,$1 ,;
+					if ($content =~ m/^(\s*)(.*)$/) {
+						$space = $1;
+						$content = $2;
 					}
+					while ($space =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {}
+					$data{$what}->{$tag} .= $content;
 				} else {
 					$data{$what}->{$tag} = $content;
 				}
@@ -168,11 +175,15 @@ sub parse_abi {
 
 		if ($tag eq "description") {
 			if (!$data{$what}->{description}) {
-				next if (m/^\s*\n/);
+				s/^($space)//;
 				if (m/^(\s*)(.*)/) {
-					$space = $1;
-					while ($space =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {}
-					$data{$what}->{$tag} .= "$2\n";
+					my $sp = $1;
+					while ($sp =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {}
+					my $content = "$sp$2";
+
+					$content =~ s/^($space)//;
+
+					$data{$what}->{$tag} .= "$content";
 				}
 			} else {
 				my $content = $_;
@@ -282,23 +293,27 @@ sub output_rest {
 		print "Defined on file :ref:`$file <$fileref>`\n\n" if ($type ne "File");
 
 		my $desc = $data{$what}->{description};
-		$desc =~ s/^\s+//;
-
-		# Remove title markups from the description, as they won't work
-		$desc =~ s/\n[\-\*\=\^\~]+\n/\n/g;
 
 		if (!($desc =~ /^\s*$/)) {
-			if ($desc =~ m/\:\n/ || $desc =~ m/\n[\t ]+/  || $desc =~ m/[\x00-\x08\x0b-\x1f\x7b-\xff]/) {
-				# put everything inside a code block
-				$desc =~ s/\n/\n /g;
-
-				print "::\n\n";
-				print " $desc\n\n";
-			} else {
-				# Escape any special chars from description
-				$desc =~s/([\x00-\x08\x0b-\x1f\x21-\x2a\x2d\x2f\x3c-\x40\x5c\x5e-\x60\x7b-\xff])/\\$1/g;
-
+			if ($description_is_rst) {
 				print "$desc\n\n";
+			} else {
+				$desc =~ s/^\s+//;
+
+				# Remove title markups from the description, as they won't work
+				$desc =~ s/\n[\-\*\=\^\~]+\n/\n\n/g;
+
+				if ($desc =~ m/\:\n/ || $desc =~ m/\n[\t ]+/  || $desc =~ m/[\x00-\x08\x0b-\x1f\x7b-\xff]/) {
+					# put everything inside a code block
+					$desc =~ s/\n/\n /g;
+
+					print "::\n\n";
+					print " $desc\n\n";
+				} else {
+					# Escape any special chars from description
+					$desc =~s/([\x00-\x08\x0b-\x1f\x21-\x2a\x2d\x2f\x3c-\x40\x5c\x5e-\x60\x7b-\xff])/\\$1/g;
+					print "$desc\n\n";
+				}
 			}
 		} else {
 			print "DESCRIPTION MISSING for $what\n\n" if (!$data{$what}->{is_file});
@@ -390,7 +405,7 @@ abi_book.pl - parse the Linux ABI files and produce a ReST book.
 
 =head1 SYNOPSIS
 
-B<abi_book.pl> [--debug] [--man] [--help] [--dir=<dir>] <COMAND> [<ARGUMENT>]
+B<abi_book.pl> [--debug] [--man] [--help] --[(no-)rst-source] [--dir=<dir>] <COMAND> [<ARGUMENT>]
 
 Where <COMMAND> can be:
 
@@ -413,6 +428,13 @@ B<validate>              - validate the ABI contents
 Changes the location of the ABI search. By default, it uses
 the Documentation/ABI directory.
 
+=item B<--rst-source> and B<--no-rst-source>
+
+The input file may be using ReST syntax or not. Those two options allow
+selecting between a rst-compliant source ABI (--rst-source), or a
+plain text that may be violating ReST spec, so it requres some escaping
+logic (--no-rst-source).
+
 =item B<--debug>
 
 Put the script in verbose mode, useful for debugging. Can be called multiple
-- 
2.21.0

