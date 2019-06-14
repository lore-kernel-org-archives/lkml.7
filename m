Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC73C31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FCE217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560477873;
	bh=+vgKx1AE3tGNddVJBZYJ5OVj13QyWDtL7SBzjnQ82AI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qZCbdWyxhYWdcK00Qq4FUGvjA60rnhaSbof5DQ3hf0tbrWoQSM39gkilLqnN3fMey
	 q5otrdYY5HUobnSJPeM9YsK0SMiI6J7cogk/DMHyua3yMDh9KjvmBXeNswPrKhF+IG
	 5lhwj40iJC7LoKBm/Mf3IY/S1gcNlLbfcEiO8r5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfFNCEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 22:04:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfFNCE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 22:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cxCNuO2nj6UOWSJ3ZVH67ZvrtAllPRKaWjv6GIZxBS0=; b=jAkNoOYRkwLpHFWntdrHnQm3gx
        T1cfXXSVFOAWY0t3NxU+FLvhQQpvS93FMHND+dkPYcefbgcTjdsnbt92gD9TmybngwxURNIyhGf4h
        QfdYKtFGiZhYp8/9yoaa67DlxL0a0JQsgkLjLNOKdIxcI0TZrvxRoQqx14+ZpVQWp/T361YT+7iVs
        CxbvgsD0Z8q/Te/ZApyaPFms4XhMI4nuUEqjm1isXqhfxULOHFF5fr6zwzy9Pmar7jSW4/N+8pJ0Y
        hFlhFGM6b0oJ5r4uElIr/IkbszdX8UrwDA/L1GJJSliUnsT92fBGSHGOKrNdiY9HYBcECugrfLGl1
        WWdQQ8dQ==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbbZr-0000E8-FW; Fri, 14 Jun 2019 02:04:27 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hbbZn-0002nw-Rz; Thu, 13 Jun 2019 23:04:23 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 07/14] scripts/get_abi.pl: avoid use literal blocks when not needed
Date:   Thu, 13 Jun 2019 23:04:13 -0300
Message-Id: <b5242302c0ba49be016f076e727b3f4889cd32f0.1560477540.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560477540.git.mchehab+samsung@kernel.org>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>

The usage of literal blocks make the document very complex,
causing the browser to take a long time to load.

On most ABI descriptions, they're a plain text, and don't
require a literal block.

So, add a logic there with identifies when a literal block
is needed.

As, on literal blocks, we need to respect the original
document space, the most complex part of this patch is
to preserve the original spacing where needed.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/get_abi.pl | 104 +++++++++++++++++++++++++++++++++------------
 1 file changed, 78 insertions(+), 26 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index ac0f057fa3ca..ba8a7466f896 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -59,29 +59,34 @@ sub parse_abi {
 	my $ln;
 	my $has_file;
 	my $xrefs;
+	my $space;
 
 	print STDERR "Opening $file\n" if ($debug > 1);
 	open IN, $file;
 	while(<IN>) {
 		$ln++;
-		if (m/^(\S+):\s*(.*)/i) {
+		if (m/^(\S+)(:\s*)(.*)/i) {
 			my $new_tag = lc($1);
-			my $content = $2;
+			my $sep = $2;
+			my $content = $3;
 
 			if (!($new_tag =~ m/(what|date|kernelversion|contact|description|users)/)) {
 				if ($tag eq "description") {
-					$data{$what}->{$tag} .= "\n$content";
-					$data{$what}->{$tag} =~ s/\n+$//;
-					next;
+					# New "tag" is actually part of
+					# description. Don't consider it a tag
+					$new_tag = "";
 				} else {
 					parse_error($file, $ln, "tag '$tag' is invalid", $_);
 				}
 			}
 
 			if ($new_tag =~ m/what/) {
+				$space = "";
 				if ($tag =~ m/what/) {
 					$what .= ", " . $content;
 				} else {
+					parse_error($file, $ln, "What '$what' doesn't have a description", "") if ($what && !$data{$what}->{description});
+
 					$what = $content;
 					$new_what = 1;
 				}
@@ -108,25 +113,38 @@ sub parse_abi {
 				next;
 			}
 
-			$tag = $new_tag;
+			if ($new_tag) {
+				$tag = $new_tag;
 
-			if ($new_what) {
-				$new_what = 0;
+				if ($new_what) {
+					$new_what = 0;
 
-				$data{$what}->{type} = $type;
-				$data{$what}->{file} = $name;
-				print STDERR "\twhat: $what\n" if ($debug > 1);
-			}
+					$data{$what}->{type} = $type;
+					$data{$what}->{file} = $name;
+					print STDERR "\twhat: $what\n" if ($debug > 1);
+				}
 
-			if (!$what) {
-				parse_error($file, $ln, "'What:' should come first:", $_);
+				if (!$what) {
+					parse_error($file, $ln, "'What:' should come first:", $_);
+					next;
+				}
+				if ($tag eq "description") {
+					next if ($content =~ m/^\s*$/);
+					if ($content =~ m/^(\s*)(.*)/) {
+						my $new_content = $2;
+						$space = $new_tag . $sep . $1;
+						while ($space =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {}
+						$space =~ s/./ /g;
+						$data{$what}->{$tag} .= "$new_content\n";
+					}
+				} else {
+					$data{$what}->{$tag} = $content;
+				}
 				next;
 			}
-			$data{$what}->{$tag} = $content;
-			next;
 		}
 
-		# Store any contents before the database
+		# Store any contents before tags at the database
 		if (!$tag) {
 			next if (/^\n/);
 
@@ -139,6 +157,32 @@ sub parse_abi {
 			next;
 		}
 
+		if ($tag eq "description") {
+			if (!$data{$what}->{description}) {
+				next if (m/^\s*\n/);
+				if (m/^(\s*)(.*)/) {
+					$space = $1;
+					while ($space =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {}
+					$data{$what}->{$tag} .= "$2\n";
+				}
+			} else {
+				my $content = $_;
+				if (m/^\s*\n/) {
+					$data{$what}->{$tag} .= $content;
+					next;
+				}
+
+				while ($content =~ s/\t+/' ' x (length($&) * 8 - length($`) % 8)/e) {}
+				$space = "" if (!($content =~ s/^($space)//));
+
+				# Compress spaces with tabs
+				$content =~ s<^ {8}> <\t>;
+				$content =~ s<^ {1,7}\t> <\t>;
+				$content =~ s< {1,7}\t> <\t>;
+				$data{$what}->{$tag} .= $content;
+			}
+			next;
+		}
 		if (m/^\s*(.*)/) {
 			$data{$what}->{$tag} .= "\n$1";
 			$data{$what}->{$tag} =~ s/\n+$//;
@@ -165,6 +209,9 @@ sub output_rest {
 		my $w = $what;
 		$w =~ s/([\(\)\_\-\*\=\^\~\\])/\\$1/g;
 
+		my $bar = $w;
+		$bar =~ s/./-/g;
+
 		if ($data{$what}->{label}) {
 			my @labels = split(/\s/, $data{$what}->{label});
 			foreach my $label (@labels) {
@@ -172,10 +219,9 @@ sub output_rest {
 			}
 		}
 
-		print "$w\n\n";
+		print "$w\n$bar\n\n";
 
 		print "- defined on file $file (type: $type)\n\n" if ($type ne "File");
-		print "::\n\n";
 
 		my $desc = $data{$what}->{description};
 		$desc =~ s/^\s+//;
@@ -183,18 +229,24 @@ sub output_rest {
 		# Remove title markups from the description, as they won't work
 		$desc =~ s/\n[\-\*\=\^\~]+\n/\n/g;
 
-		# put everything inside a code block
-		$desc =~ s/\n/\n /g;
-
-
 		if (!($desc =~ /^\s*$/)) {
-			print " $desc\n\n";
+	                if ($desc =~ m/\:\n/ || $desc =~ m/\n[\t ]+/  || $desc =~ m/[\x00-\x08\x0b-\x1f\x7b-\xff]/) {
+				# put everything inside a code block
+				$desc =~ s/\n/\n /g;
+
+				print "::\n\n";
+				print " $desc\n\n";
+			} else {
+				# Escape any special chars from description
+				$desc =~s/([\x00-\x08\x0b-\x1f\x21-\x2a\x2d\x2f\x3c-\x40\x5c\x5e-\x60\x7b-\xff])/\\$1/g;
+
+				print "$desc\n\n";
+			}
 		} else {
-			print " DESCRIPTION MISSING for $what\n\n";
+			print "DESCRIPTION MISSING for $what\n\n";
 		}
 
 		printf "Has the following ABI:\n\n%s", $data{$what}->{xrefs} if ($data{$what}->{xrefs});
-
 	}
 }
 
-- 
2.21.0

