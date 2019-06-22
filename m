Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C1CC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACDD20679
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561222789;
	bh=pxvytKFestq2TcDz4jnN42GQeOz4ldzQ6V/m5HuFo2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C61LhbTNwbkozQOTLXWQAi3GgevoCxQl6HCuY0vy7kB+6CQ3lMJ9F86MMW8V6cmkD
	 sYmuZHhbvaYhn431kyw+ho3BNds5ocUC1icg7JXgpsMOI7BvT3fXzztOm62Xj4jict
	 i09xuWlzowyYsKLcep+VwcyVroszNjf8yI3kpubg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfFVQ7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 12:59:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42806 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfFVQ67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 12:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LPewfwcxR+4Yksi9PvbYmBTtfzvnLhTfEY4M7qiXJJw=; b=n1HdsECKGW/EqJ504qit88qkeN
        9OclllUIQap0OeizoFdMZnUWMLMP+jUpzC/ryS19B5fcnCP0AaPh7DN37mIlcGxaWUUOa9D8ZpjDP
        lx5IV9zAC6BeGv0REraNpc2/zfA+WY5/sTuBD1MbKsA+V6QyRI3HO3WDBjsQYoau5FVO5yZGM43FM
        vR+N2JBmVgxV9FEl1sWwuxK8DurDWwfTFSGaBOefAGkfJoXeqAINApFiGwR1qkNnulhceN10nIHDQ
        qg+EHLvA3EozwoUTS9jksIxHcmONmRTQeHsgGBr9EzePd8qrFQZLZ6O42MF7ap5YTaAv6drvHwYLP
        ikt583Bw==;
Received: from [179.95.45.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hejLu-00054k-Fm; Sat, 22 Jun 2019 16:58:58 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hejLr-0000v9-Qf; Sat, 22 Jun 2019 13:58:55 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        gregkh@linuxfoundation.org, Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] scripts/get_abi.pl: change script to allow parsing in ReST mode
Date:   Sat, 22 Jun 2019 13:58:42 -0300
Message-Id: <13487012631a4543dc1aca13f17722699c9edcce.1561221403.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561221403.git.mchehab+samsung@kernel.org>
References: <cover.1561221403.git.mchehab+samsung@kernel.org>
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
index c738cb795514..107672cdacb3 100755
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
@@ -137,14 +143,15 @@ sub parse_abi {
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
@@ -160,11 +167,15 @@ sub parse_abi {
 
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
@@ -274,23 +285,27 @@ sub output_rest {
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
@@ -382,7 +397,7 @@ abi_book.pl - parse the Linux ABI files and produce a ReST book.
 
 =head1 SYNOPSIS
 
-B<abi_book.pl> [--debug] [--man] [--help] [--dir=<dir>] <COMAND> [<ARGUMENT>]
+B<abi_book.pl> [--debug] [--man] [--help] --[(no-)rst-source] [--dir=<dir>] <COMAND> [<ARGUMENT>]
 
 Where <COMMAND> can be:
 
@@ -405,6 +420,13 @@ B<validate>              - validate the ABI contents
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

