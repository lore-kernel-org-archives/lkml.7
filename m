Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8136FC31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5271621537
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560477916;
	bh=BQGBjN+KFuGIoYcoPNWMgrK4j/GPvrTViXU5yWIP4FE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pdZHjVcvA9XZGmkRIWjJiny49FXjtn2Y7YlNfKyuDrqGln6xXxw6hIE6ph5SbWtom
	 XUHOJu30vVwznPcCcN7IavOrIQyYYU7mH7m1a+3TrNAwepYqeyluS5lWqgI1HOCRql
	 QwA4Rzg5J7EAqXkjPLdaVYhNnXPIDpnFMC2soS3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfFNCE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 22:04:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52856 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfFNCE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 22:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=B5ljNYAaph2OUjbLpP0bTBC9oAg634tmKbVqfodSoYs=; b=syAx0VeqymrYjIszYsJJDheh8A
        1kZ/SvpWOfBSdAfgmThgVQlrwIEEIcR+kjNXQxRzYgHiRb56miNBXmrVNqphxnD5f21rBss7n9qGZ
        whFTD3E9we76ga98pEbXy2j0Gpc7U5+c62E5nR03XwOePb6vo7HsPCf9HO+HU6UKHCg526/pcZkn7
        VKhTfG/VzYNZMkJQZg9LlHQQBS254pc4A/qUJiW9sPUu0ofRSX1MfzkiML/b39C3gdpo9biYYWX8P
        t/J2zmHIQgm/UauGcLxHuApEN8xbOtMNpo9Ut/ObwBmjddJ9dh4maA9Bimb1QwMceUO9qswDp44bB
        sECpJ/MA==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbbZr-0000EC-In; Fri, 14 Jun 2019 02:04:27 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hbbZn-0002ns-RC; Thu, 13 Jun 2019 23:04:23 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 06/14] scripts/get_abi.pl: parse files with text at beginning
Date:   Thu, 13 Jun 2019 23:04:12 -0300
Message-Id: <e2211d5694243692f5c87d76a1024b510539f567.1560477540.git.mchehab+samsung@kernel.org>
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

It sounds usefult o parse files with has some text at the
beginning. Add support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/get_abi.pl | 59 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index f7c9944a833c..ac0f057fa3ca 100755
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
+                $data{$my_what}->{xrefs} = $xrefs;
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

