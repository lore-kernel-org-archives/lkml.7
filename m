Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD5CC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6C721841
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560534809;
	bh=PABrE2lAAOtOUZq2hw1sU/csf5Quf9MdiGXF3pudcpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gLD2Lo5JpT+673wd2wJs86N16af/3JDyWElau4+Wf1/fAB/G2gxwYQZKpmKBWJuOg
	 E+Mg4D0VavA4TG6JVqNk2kE5A/QMqMuKqKsJELGfp/0j0MzDXUMkvIkl0gN6WnV6Zh
	 iu6aDYjOPpttoBY+SKfbLl66CbkAbNTtNBLQ692U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfFNRwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:52:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38644 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfFNRwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e/+2h49PQTLebtYTQ2y+poBPVIU3vbzyE9O3TGMGRrw=; b=s06sJE7Dj9sJR//8FWhjDgsjij
        Qs6zD8uc6GtcoNlCemAa3kvFvVFpyTEJ6rFhCJC1UwhXxkIucnNc2kKoLP2GelG2o6hhzyHbeL+Zy
        fkpk6y5GfB6yYJEWl7CIV8xRpoo70L6wzT6yKCTZu1P+oiiVVKUPT/baF8p5sWvIujiC4j1P0/duQ
        VblKPtJg03FZ1nG93w7OfFHF7HsL+e2rvazWzDO6yULz8ZKXdddu/jBpGrCnMZQRysNborC13iMII
        aULXyJWbGF4S+hXqWgO66k+bGE9pHqZWvZSD+pQzpcKYIvlMjZnfFtFiMVGodsBQjO0WF3NU8A1lr
        KEMDLt1w==;
Received: from 177.133.85.52.dynamic.adsl.gvt.net.br ([177.133.85.52] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbqNO-0000PV-KL; Fri, 14 Jun 2019 17:52:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hbqNL-0002Oe-PU; Fri, 14 Jun 2019 14:52:31 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 04/16] scripts/get_abi.pl: parse files with text at beginning
Date:   Fri, 14 Jun 2019 14:52:18 -0300
Message-Id: <46c30cf8ed898e85a0ee59781687e58efd6264d1.1560534648.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1560534648.git.mchehab+samsung@kernel.org>
References: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1560534648.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It sounds usefult o parse files with has some text at the
beginning. Add support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/get_abi.pl | 59 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index f7c9944a833c..ef9b6e108973 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -55,7 +55,10 @@ sub parse_abi {
 	my $what;
 	my $new_what;
 	my $tag;
+	my $label;
 	my $ln;
+	my $has_file;
+	my $xrefs;
 
 	print STDERR "Opening $file\n" if ($debug > 1);
 	open IN, $file;
@@ -67,7 +70,7 @@ sub parse_abi {
 
 			if (!($new_tag =~ m/(what|date|kernelversion|contact|description|users)/)) {
 				if ($tag eq "description") {
-					$data{$what}->{$tag} .= "\n$content";;
+					$data{$what}->{$tag} .= "\n$content";
 					$data{$what}->{$tag} =~ s/\n+$//;
 					next;
 				} else {
@@ -83,6 +86,25 @@ sub parse_abi {
 					$new_what = 1;
 				}
 				$tag = $new_tag;
+
+				if ($has_file) {
+					$label = "abi_" . $content . " ";
+					$label =~ tr/A-Z/a-z/;
+
+					# Convert special chars to "_"
+					$label =~s/[\x00-\x2f]+/_/g;
+					$label =~s/[\x3a-\x40]+/_/g;
+					$label =~s/[\x7b-\xff]+/_/g;
+					$label =~ s,_+,_,g;
+					$label =~ s,_$,,;
+
+					$data{$what}->{label} .= $label;
+
+					# Escape special chars from content
+					$content =~s/([\x00-\x1f\x21-\x2f\x3a-\x40\x7b-\xff])/\\$1/g;
+
+					$xrefs .= "- :ref:`$content <$label>`\n\n";
+				}
 				next;
 			}
 
@@ -104,8 +126,18 @@ sub parse_abi {
 			next;
 		}
 
-		# Silently ignore any headers before the database
-		next if (!$tag);
+		# Store any contents before the database
+		if (!$tag) {
+			next if (/^\n/);
+
+			my $my_what = "File $name";
+			$data{$my_what}->{what} = "File $name";
+			$data{$my_what}->{type} = "File";
+			$data{$my_what}->{file} = $name;
+			$data{$my_what}->{description} .= $_;
+			$has_file = 1;
+			next;
+		}
 
 		if (m/^\s*(.*)/) {
 			$data{$what}->{$tag} .= "\n$1";
@@ -117,6 +149,11 @@ sub parse_abi {
 		parse_error($file, $ln, "Unexpected line:", $_);
 	}
 	close IN;
+
+	if ($has_file) {
+		my $my_what = "File $name";
+		$data{$my_what}->{xrefs} = $xrefs;
+	}
 }
 
 # Outputs the output on ReST format
@@ -128,8 +165,17 @@ sub output_rest {
 		my $w = $what;
 		$w =~ s/([\(\)\_\-\*\=\^\~\\])/\\$1/g;
 
+		if ($data{$what}->{label}) {
+			my @labels = split(/\s/, $data{$what}->{label});
+			foreach my $label (@labels) {
+				printf ".. _%s:\n\n", $label;
+			}
+		}
+
 		print "$w\n\n";
-		print "- defined on file $file (type: $type)\n\n::\n\n";
+
+		print "- defined on file $file (type: $type)\n\n" if ($type ne "File");
+		print "::\n\n";
 
 		my $desc = $data{$what}->{description};
 		$desc =~ s/^\s+//;
@@ -144,8 +190,11 @@ sub output_rest {
 		if (!($desc =~ /^\s*$/)) {
 			print " $desc\n\n";
 		} else {
-			print " DESCRIPTION MISSING\n\n";
+			print " DESCRIPTION MISSING for $what\n\n";
 		}
+
+		printf "Has the following ABI:\n\n%s", $data{$what}->{xrefs} if ($data{$what}->{xrefs});
+
 	}
 }
 
-- 
2.21.0

