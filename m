Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE49C31E49
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32FCC21537
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560477901;
	bh=5SmoJ4MdOa+v+8SthUyHE0hAkwh/AaJkZ9dBhVRLYYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=czM6MHsFxcRUumBoQ2yRqD6d4WfCy+pntRN32kKnA3JbfiUEi+ijjc+H0D5bqB1sR
	 3HIaIknFNXCYL7NIdCB7kfHRybZ1WZEXj8Qr/kCjkO32WvjcvTJWxhHj8QA4Gqtj8Y
	 XL4amdw9xTI+jPki2u/YDv0mcx86+ENaO61mDS3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfFNCEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 22:04:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52882 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfFNCE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 22:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fel+2k85pk3uIfzPn9NdzPj+rKgNtw5jyrOcDtA6cpw=; b=BVBXyAhWxLuh8FssyWJXKTdz8E
        VbwRnL5ETDfANg1Q2xdkjdu7iEg6b6SAXsxRmnfKB1xSCWdQi1dQ0ScC/4dPaNCNxhkWxIw0n27Zd
        WDQdBcYPmWsYQS2gYsd6pSnbjYZFayq+KE8xcizkhsr++1weY9V5a4RcXODPIX4F51wIHr+nAkD1b
        DvlfE99lAPy/SmFaxxFdfvRNeqjgsIntqcxLo8lS5O+UBnpfCfNthzQgNQw3dJY0xcXBL2YL5Yl6h
        07ftVDMQhmJv7Iw4UGqmxkLDh4ZVeXD5oXPkxKbHVzA3IWCaczl+k8jZjXhmB6Hr0pPNFBaFhipPQ
        DuBmDBBg==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbbZr-0000ED-In; Fri, 14 Jun 2019 02:04:27 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hbbZn-0002o0-Sq; Thu, 13 Jun 2019 23:04:23 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 08/14] scripts/get_abi.pl: split label naming from xref logic
Date:   Thu, 13 Jun 2019 23:04:14 -0300
Message-Id: <32c2aed345b10d488f630a339b9a6ea3e23ae727.1560477540.git.mchehab+samsung@kernel.org>
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

Instead of using a ReST compilant label while parsing,
move the label to ReST output. That makes the parsing logic
more generic, allowing it to provide other types of output.

As a side effect, now all files used to generate the output
will be output. We can later add command line arguments to
filter.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/get_abi.pl | 94 ++++++++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 41 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index ba8a7466f896..d437e148b1c0 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -49,17 +49,23 @@ sub parse_abi {
 	my $name = $file;
 	$name =~ s,.*/,,;
 
+	my $nametag = "File $name";
+	$data{$nametag}->{what} = "File $name";
+	$data{$nametag}->{type} = "File";
+	$data{$nametag}->{file} = $name;
+	$data{$nametag}->{is_file} = 1;
+
 	my $type = $file;
 	$type =~ s,.*/(.*)/.*,$1,;
 
 	my $what;
 	my $new_what;
 	my $tag;
-	my $label;
 	my $ln;
-	my $has_file;
 	my $xrefs;
 	my $space;
+	my @labels;
+	my $label;
 
 	print STDERR "Opening $file\n" if ($debug > 1);
 	open IN, $file;
@@ -88,28 +94,13 @@ sub parse_abi {
 					parse_error($file, $ln, "What '$what' doesn't have a description", "") if ($what && !$data{$what}->{description});
 
 					$what = $content;
+					$label = $content;
 					$new_what = 1;
 				}
+				push @labels, [($content, $label)];
 				$tag = $new_tag;
 
-				if ($has_file) {
-					$label = "abi_" . $content . " ";
-					$label =~ tr/A-Z/a-z/;
-
-					# Convert special chars to "_"
-					$label =~s/[\x00-\x2f]+/_/g;
-					$label =~s/[\x3a-\x40]+/_/g;
-					$label =~s/[\x7b-\xff]+/_/g;
-					$label =~ s,_+,_,g;
-					$label =~ s,_$,,;
-
-					$data{$what}->{label} .= $label;
-
-					# Escape special chars from content
-					$content =~s/([\x00-\x1f\x21-\x2f\x3a-\x40\x7b-\xff])/\\$1/g;
-
-					$xrefs .= "- :ref:`$content <$label>`\n\n";
-				}
+				push @{$data{$nametag}->{xrefs}}, [($content, $label)] if ($data{$nametag}->{what});
 				next;
 			}
 
@@ -117,6 +108,9 @@ sub parse_abi {
 				$tag = $new_tag;
 
 				if ($new_what) {
+					@{$data{$what}->{label}} = @labels if ($data{$nametag}->{what});
+					@labels = ();
+					$label = "";
 					$new_what = 0;
 
 					$data{$what}->{type} = $type;
@@ -145,15 +139,8 @@ sub parse_abi {
 		}
 
 		# Store any contents before tags at the database
-		if (!$tag) {
-			next if (/^\n/);
-
-			my $my_what = "File $name";
-			$data{$my_what}->{what} = "File $name";
-			$data{$my_what}->{type} = "File";
-			$data{$my_what}->{file} = $name;
-			$data{$my_what}->{description} .= $_;
-			$has_file = 1;
+		if (!$tag && $data{$nametag}->{what}) {
+			$data{$nametag}->{description} .= $_;
 			next;
 		}
 
@@ -192,12 +179,8 @@ sub parse_abi {
 		# Everything else is error
 		parse_error($file, $ln, "Unexpected line:", $_);
 	}
+	$data{$nametag}->{description} =~ s/^\n+//;
 	close IN;
-
-	if ($has_file) {
-		my $my_what = "File $name";
-                $data{$my_what}->{xrefs} = $xrefs;
-	}
 }
 
 # Outputs the output on ReST format
@@ -212,11 +195,22 @@ sub output_rest {
 		my $bar = $w;
 		$bar =~ s/./-/g;
 
-		if ($data{$what}->{label}) {
-			my @labels = split(/\s/, $data{$what}->{label});
-			foreach my $label (@labels) {
-				printf ".. _%s:\n\n", $label;
-			}
+		foreach my $p (@{$data{$what}->{label}}) {
+			my ($content, $label) = @{$p};
+			$label = "abi_" . $label . " ";
+			$label =~ tr/A-Z/a-z/;
+
+			# Convert special chars to "_"
+			$label =~s/([\x00-\x2f\x3a-\x40\x5b-\x60\x7b-\xff])/_/g;
+			$label =~ s,_+,_,g;
+			$label =~ s,_$,,;
+
+			$data{$what}->{label} .= $label;
+
+			printf ".. _%s:\n\n", $label;
+
+			# only one label is enough
+			last;
 		}
 
 		print "$w\n$bar\n\n";
@@ -243,10 +237,28 @@ sub output_rest {
 				print "$desc\n\n";
 			}
 		} else {
-			print "DESCRIPTION MISSING for $what\n\n";
+			print "DESCRIPTION MISSING for $what\n\n" if (!$data{$what}->{is_file});
 		}
 
-		printf "Has the following ABI:\n\n%s", $data{$what}->{xrefs} if ($data{$what}->{xrefs});
+		if ($data{$what}->{xrefs}) {
+			printf "Has the following ABI:\n\n";
+
+			foreach my $p(@{$data{$what}->{xrefs}}) {
+				my ($content, $label) = @{$p};
+				$label = "abi_" . $label . " ";
+				$label =~ tr/A-Z/a-z/;
+
+				# Convert special chars to "_"
+				$label =~s/([\x00-\x2f\x3a-\x40\x5b-\x60\x7b-\xff])/_/g;
+				$label =~ s,_+,_,g;
+				$label =~ s,_$,,;
+
+				# Escape special chars from content
+				$content =~s/([\x00-\x1f\x21-\x2f\x3a-\x40\x7b-\xff])/\\$1/g;
+
+				print "- :ref:`$content <$label>`\n\n";
+			}
+		}
 	}
 }
 
-- 
2.21.0

