Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD4CC48BE1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EC72084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561051461;
	bh=P01JkKh2EwDIKOkKeZ63M1fuJyDYnZHPDcjEI+Lqenc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=czjpL03afVR4Re6j14jRU/Mv/hbCx/5fK16LY5RsE4Iey4NXuZ9yU0AwilXnL/Ti9
	 31oxf9QqGEuclXLYuibRKqWXQEgNA5AekgkF5FPQ9QG8y9+OO6T4UUOGA1b6FJJheX
	 B7O79JjlmKXD3smTa+MSxQhElFQ6V+4dX983Vs1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732398AbfFTRYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:24:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52604 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732175AbfFTRXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wEP/uGZbmvWdMQQ7lu7aU2Sw4lu0L8oVUgCmRRiaIis=; b=hYGfsqnERhERW74kuTKpp9dGDQ
        idsqIvnqbQ2HPeOGcNBZLOjPftaE8Gwcdl438lmZWxfJpxkt8iYRtBngBVbmBlqjUSjsWp/dQhJtd
        ee9PUG4S7g1GnHolIVGWRRQdcisjteczrPJfGLxNqgp8SnFqO0ZbBlNpqn7OnEZF//0zKWfRc7Vhc
        nrdiz+VUllggL7n965C/tvo65s171yFy31OWozOPy4YgmvRUujCF6tMzmkMnlTCj+vJynIEo1AQzm
        6NoNQsv+AuOhidkNC0KUnR2GXbS5MWgh8odBAmJ2LtClaurYDOqV4KMxTfqnbV36dD9Ig5VN3hBXz
        NG41ur8w==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1he0mM-0008S1-A8; Thu, 20 Jun 2019 17:23:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1he0mJ-0000Cw-LS; Thu, 20 Jun 2019 14:23:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 05/22] scripts/get_abi.pl: avoid use literal blocks when not needed
Date:   Thu, 20 Jun 2019 14:22:57 -0300
Message-Id: <5964e0e4e93dc6582a8a1662116c015f07247a36.1561050806.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561050806.git.mchehab+samsung@kernel.org>
References: <cover.1561050806.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usage of literal blocks make the document very complex,
causing the browser to take a long time to load.

On most ABI descriptions, they're a plain text, and don't
require a literal block.

So, add a logic there with identifies when a literal block
is needed.

As, on literal blocks, we need to respect the original
document space, the most complex part of this patch is
to preserve the original spacing where needed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/get_abi.pl | 104 +++++++++++++++++++++++++++++++++------------
 1 file changed, 78 insertions(+), 26 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index ef9b6e108973..0ede9593c639 100755
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
+			if ($desc =~ m/\:\n/ || $desc =~ m/\n[\t ]+/  || $desc =~ m/[\x00-\x08\x0b-\x1f\x7b-\xff]/) {
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

