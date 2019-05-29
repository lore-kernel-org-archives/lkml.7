Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC75C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C8124302
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559171384;
	bh=ieHWmSfzVGoogWT2ToTE8TVzg9uy2cKqdUIdWbPe6v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n/GKqTBPnTPaG3H+FF678qEqcTCBz0ogB2n3gXUS5kF9o1bNElZCe/d63b+nnS8LF
	 475oeAayLGDrFPVINLjbwty+7nukyLnCwbntuuASrlzsaD6Zogl+b7AzyVhVaRia3n
	 NTXI++gcw9sXvGApTVuzNZcAMlTIXzSZxIfMlhW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfE2XJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 19:09:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47600 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbfE2XJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=M5AYSXE7Y2LngfbsJ/DojP/iVd7EdymmZUqfay+8Wow=; b=StuhuTjhMvOAiFhs0ch3NTd6a8
        BLQGgL1+v4o0HI5fPhs2RB4p2QfnHl1k4QGhBmCxFH32mla5jWly+9Xw+Dqrh6J/Lk5yKr+d8MJ/v
        ZYYXNBG0nx2RHI7lnKJmgUMEYGAhJ2L5zbkn8NlT1vi6j4UTchxCg0lHbejRCbIxmByvzsrjBsfTY
        bp+ByvZIVquF3ynm8kuAw8YkaRZdA5iZWuhry0WkTzV9nSUmbsy9PbuwzVMA/+z6DW2i3wxQ0Kquu
        blWsap7mGUzTx3d5Q4I4haqkKFDWmCFJ97wD1EFZ7ef2gOkkicqhgdjvufljS7bbStkiM4RSlVyQA
        IrfU28bQ==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW7hQ-0000lD-Go; Wed, 29 May 2019 23:09:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hW7hN-0007TZ-Kz; Wed, 29 May 2019 20:09:33 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 05/10] scripts/documentation-file-ref-check: better handle translations
Date:   Wed, 29 May 2019 20:09:27 -0300
Message-Id: <0f7e9a81fccac06225a2a8277957c99d7678d9e6.1559170790.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559170790.git.mchehab+samsung@kernel.org>
References: <cover.1559170790.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only seek for translation renames inside the translation
directory.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/documentation-file-ref-check | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/scripts/documentation-file-ref-check b/scripts/documentation-file-ref-check
index 63e9542656f1..6b622b88f4cf 100755
--- a/scripts/documentation-file-ref-check
+++ b/scripts/documentation-file-ref-check
@@ -141,6 +141,10 @@ print "Auto-fixing broken references. Please double-check the results\n";
 foreach my $ref (keys %broken_ref) {
 	my $new =$ref;
 
+	my $basedir = ".";
+	# On translations, only seek inside the translations directory
+	$basedir  = $1 if ($ref =~ m,(Documentation/translations/[^/]+),);
+
 	# get just the basename
 	$new =~ s,.*/,,;
 
@@ -161,18 +165,18 @@ foreach my $ref (keys %broken_ref) {
 	# usual reason for breakage: file renamed to .rst
 	if (!$f) {
 		$new =~ s/\.txt$/.rst/;
-		$f=qx(find . -iname $new) if ($new);
+		$f=qx(find $basedir -iname $new) if ($new);
 	}
 
 	# usual reason for breakage: use dash or underline
 	if (!$f) {
 		$new =~ s/[-_]/[-_]/g;
-		$f=qx(find . -iname $new) if ($new);
+		$f=qx(find $basedir -iname $new) if ($new);
 	}
 
 	# Wild guess: seek for the same name on another place
 	if (!$f) {
-		$f = qx(find . -iname $new) if ($new);
+		$f = qx(find $basedir -iname $new) if ($new);
 	}
 
 	my @find = split /\s+/, $f;
-- 
2.21.0

