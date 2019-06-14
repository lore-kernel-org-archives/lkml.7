Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C877C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4078D21848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560534780;
	bh=yNYwqeSTSPwIiEd4eYb8uNZq/cfje8/TcJ0O9vDkwOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q1qHUavsJKK45Rvb+4EsAl3I5IVCz/R8QD3jod87CNhaUKcT/gvyJt73r3pjTfx6I
	 hR92GetCYfWPUs6oFM5e4aszTY1OKesqZYKnT6WiZxUjiHA1NoB7R7Y6g/WtTWH+wV
	 zOOdDVzVp9G5W8H0uZTSaKBWVSIWB/uhOj9IMh6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfFNRwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:52:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38622 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfFNRwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3v0sS61wq796LTjrCIGlnUicOjJQzGAsiyF19M1EX2c=; b=u/ESh3f65BSLRXkZ+AXmBNxjNC
        gnrwrngtlWnKOr3vhuLTSXY9/fdw9r+AL/Rav1M8w9/KFYKl52HJA8vdrptJG26xi+f+9PYiWHGQu
        YDj+hpvXJ9lIwYb4dqevFJxcU/dt+uyGZmLfQNHEaIFYlba6LLlmVsnqR99Y3n9PSvz94scfvfG4y
        oigeSHE4XLskhNbhaRES1Yr55THnSNML14iy4zlbHY6MK2OUK2dbsXEoOSTOqYOM+l3aoa5sUtoPB
        +iMhUs+h2lHmCIluqwEkAhQDVR+0mKFQDTxEqUJ/b2iMlupvWjfkuhi7OiC6uUj4aGAIMl0fPzUcl
        h1JLhJAg==;
Received: from 177.133.85.52.dynamic.adsl.gvt.net.br ([177.133.85.52] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbqNO-0000PZ-JI; Fri, 14 Jun 2019 17:52:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hbqNL-0002Ou-TC; Fri, 14 Jun 2019 14:52:31 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 08/16] scripts/get_abi.pl: represent what in tables
Date:   Fri, 14 Jun 2019 14:52:22 -0300
Message-Id: <8a1ae200b2ccdc04811a11cececeaad16c020556.1560534648.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1560534648.git.mchehab+samsung@kernel.org>
References: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1560534648.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several entries at the ABI have multiple What: with the same
description.

Instead of showing those symbols as sections, let's show them
as tables. That makes easier to read on the final output,
and avoid too much recursion at Sphinx parsing.

We need to put file references at the end, as we don't want
non-file tables to be mangled with other entries.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/get_abi.pl | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index ecf6b91df7c4..7d454e359d25 100755
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

