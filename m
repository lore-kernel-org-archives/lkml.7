Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8C8C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EEA62085A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561051522;
	bh=509X9XqZw0ckZakAoADhaZd4JD14ZAUC3DZELbOhiGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pSnufMWbYdqHK2VjaO2FJHS25X5pUVAA7lp8WTtgj6uYTMWf4ob4wqQLI5WjAsqjN
	 N3cO7xrLakj/j5H4d0skAPHg0A7O5kZm5gd6+ym8YUAhWCZcYh86xE1f2d+5/cad2x
	 jJi/r53lFv9879dsPDrzcMBVPJ5CT75/qc68AOog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732261AbfFTRZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:25:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52574 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732155AbfFTRXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FociWLakoZ+8To2zv3/tt7eXrQHxKyGo8THcaHAtO7Q=; b=S8ZNtNr52BE4rZAEFXY58sn9rw
        TNCKgArSvKnw1rvmONqPycw3LSgNbDU+YWO2mcvDBrD7Jp01rnFzx9IIrP0J5dzX9gw6TwqzMJxeu
        Q35+1iiZ6PB5zG0gIgn0HMHcRYrXlvy345A7o6rpZHfsfu0BeVRLTa3/Is/rPQmZ4TrIFLXBviMGn
        iyTLq+c/kWrRcdCQh8v0VIH235kdU93tUkcrjmWoEeCLIwcMerV3NSmWG1bDokT3CyHpAxGJYfPPp
        JAtTvaaM3hM74HyoJMqnTFLgtteU0/JdskA6g0h+Jqw1BlSPwfSI+oXMnagEmzQY1PigqVzdcxSGS
        1gbWNtTg==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1he0mM-0008Ru-AK; Thu, 20 Jun 2019 17:23:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1he0mJ-0000D0-MH; Thu, 20 Jun 2019 14:23:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 06/22] scripts/get_abi.pl: split label naming from xref logic
Date:   Thu, 20 Jun 2019 14:22:58 -0300
Message-Id: <a94701a22320efb500c016620996380cc2d4ae48.1561050806.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561050806.git.mchehab+samsung@kernel.org>
References: <cover.1561050806.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using a ReST compilant label while parsing,
move the label to ReST output. That makes the parsing logic
more generic, allowing it to provide other types of output.

As a side effect, now all files used to generate the output
will be output. We can later add command line arguments to
filter.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/get_abi.pl | 94 ++++++++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 41 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 0ede9593c639..f84d321a72bb 100755
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
-		$data{$my_what}->{xrefs} = $xrefs;
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

