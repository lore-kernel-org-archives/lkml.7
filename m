Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068D8C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13CB21721
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558363701;
	bh=ieHWmSfzVGoogWT2ToTE8TVzg9uy2cKqdUIdWbPe6v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iBo2z/oCx6OEtaThqlUJymWCUmFp7HG+HDOoBWmEUdtDObimsbhtxwG5juEvYolqO
	 Wo9khLkTiDb/glLOX4NFsewHIxX/LZe7g5jObOzPMsjfpNevmSIrWzlAzQvFeiQRgV
	 g9eBThifqlUyxMzQncTipdQFpbXyVtnhMTYob0P4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbfETOsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:48:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388519AbfETOsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=M5AYSXE7Y2LngfbsJ/DojP/iVd7EdymmZUqfay+8Wow=; b=TdU1BN1Gcd022p3TFE2CDrG8c+
        l0Y1gZm2e+rk85dleVznTM8XTUlj1Mobek1VkEvS3KnIIATx1mXLy4xsbZmqfvS3mxxdCzOswvXjm
        U6URgJS+kyi9687r2RUq01vs3KVljynLfkUsMM2AuqyXKyZXxTuT5gs8Szx2znfbs1TrxqLjTPXba
        1OOUeverfVJbZwmSM4bxj7oc95G7jZQbmF20DKqYwlsnb4etDZoLtU6O9IQNVADCAvvswALN/x4Wq
        53j+1u5Qi745w9wGME/aEsraVx2L7V8vODwnicm53fdfUPDIdVi7F4Gk8hp9p/geYDiijwJoX9iBE
        EgbyJ74g==;
Received: from 179.176.119.151.dynamic.adsl.gvt.net.br ([179.176.119.151] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSjaH-0000aP-Gv; Mon, 20 May 2019 14:48:13 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hSjZo-00010e-V0; Mon, 20 May 2019 11:47:44 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 01/10] scripts/documentation-file-ref-check: better handle translations
Date:   Mon, 20 May 2019 11:47:30 -0300
Message-Id: <e2f07cda112179828d52a8aeb06eebcf6576360e.1558362030.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558362030.git.mchehab+samsung@kernel.org>
References: <cover.1558362030.git.mchehab+samsung@kernel.org>
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

