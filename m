Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8465AC31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507A321721
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560477931;
	bh=etvSjn/FSb0WSGgAt9jv5+vX781tH5wU0bZQ3OQW4y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xE1jkDA9Nns+lLH1HMrTlMIZcYl5ROakuTq250a0aL+dyxlDV8HfEXDxuAkIc6IoM
	 UcHime1YdgH90j+LtgLjBbfl67KDTx6qLncclo+mEnw8g2eZolfdYGVBmYt6etuqkz
	 a4lRAWTQ5GNLsqGXsdfmQAgXJf7QmbqvFN+9BQ0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfFNCF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 22:05:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52860 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfFNCE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 22:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5IX0zYlL8/oA+sc7E+MTsWO5O1lu6ceK5gRHr9c7H2s=; b=Qy9zUAbLE/fNWlgA7b71QVmnh4
        YOlaJ45E4wIMaCbCCrTaznV7sCaoOVUGs5Wm3ppnniVFK6vg8v/gobT3l7zp6pMRuSBFDfDUMy6Sy
        LcCl5edAAgIgdW4fvsV22O/1xbm3rc6t+J0uJZj+pa3Uez+eFOYlCLWwzvl84zQzQJC3NMhZqsQ6W
        35XaepdSuNFjBQLnjeUvyelyoeN52p4lUdUDeOUumsAbUeUZzgBvXM+Qd6nxBE0V8O8mCgR4K06Ku
        M6+IZCwspH7oZ3vUcLVqriwAIm+VUmOdOGNykYoLctPBDqagdLYgsvmY79OCBC5BBhSEoAK2nyVJP
        xrC9ulug==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbbZr-0000EA-E1; Fri, 14 Jun 2019 02:04:27 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hbbZn-0002o8-Ui; Thu, 13 Jun 2019 23:04:23 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 10/14] scripts/get_abi.pl: represent what in tables
Date:   Thu, 13 Jun 2019 23:04:16 -0300
Message-Id: <a10fc22582447572eb84c62666b65fb5129b634b.1560477540.git.mchehab+samsung@kernel.org>
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

Several entries at the ABI have multiple What: with the same
description.

Instead of showing those symbols as sections, let's show them
as tables. That makes easier to read on the final output,
and avoid too much recursion at Sphinx parsing.

We need to put file references at the end, as we don't want
non-file tables to be mangled with other entries.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/get_abi.pl | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index c202292af1a2..a2861fcec745 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -193,16 +193,19 @@ sub parse_abi {
 #
 # Outputs the book on ReST format
 #
+
 sub output_rest {
-	foreach my $what (sort keys %data) {
+	foreach my $what (sort {
+				($data{$a}->{type} eq "File") cmp ($data{$b}->{type} eq "File") ||
+				$a cmp $b
+			       } keys %data) {
 		my $type = $data{$what}->{type};
 		my $file = $data{$what}->{file};
+		my $filepath = $data{$what}->{filepath};
 
 		my $w = $what;
 		$w =~ s/([\(\)\_\-\*\=\^\~\\])/\\$1/g;
 
-		my $bar = $w;
-		$bar =~ s/./-/g;
 
 		foreach my $p (@{$data{$what}->{label}}) {
 			my ($content, $label) = @{$p};
@@ -222,9 +225,37 @@ sub output_rest {
 			last;
 		}
 
-		print "$w\n$bar\n\n";
 
-		print "- defined on file $file (type: $type)\n\n" if ($type ne "File");
+		$filepath =~ s,.*/(.*/.*),\1,;;
+		$filepath =~ s,[/\-],_,g;;
+		my $fileref = "abi_file_".$filepath;
+
+		if ($type eq "File") {
+			my $bar = $w;
+			$bar =~ s/./-/g;
+
+			print ".. _$fileref:\n\n";
+			print "$w\n$bar\n\n";
+		} else {
+			my @names = split /\s*,\s*/,$w;
+
+			my $len = 0;
+
+			foreach my $name (@names) {
+				$len = length($name) if (length($name) > $len);
+			}
+
+			print "What:\n\n";
+
+			print "+-" . "-" x $len . "-+\n";
+			foreach my $name (@names) {
+				printf "| %s", $name . " " x ($len - length($name)) . " |\n";
+				print "+-" . "-" x $len . "-+\n";
+			}
+			print "\n";
+		}
+
+		print "Defined on file :ref:`$file <$fileref>`\n\n" if ($type ne "File");
 
 		my $desc = $data{$what}->{description};
 		$desc =~ s/^\s+//;
-- 
2.21.0

