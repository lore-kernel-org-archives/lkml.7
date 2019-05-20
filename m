Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07F3C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56CB216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558363682;
	bh=voLiJJ+YBWkuXuOa/EV1wytC0XoJkY6LDaACMMBxoag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S7XO077aLLbY7C/qLotS9N3knOU7YNF/hZArG/ontMQJC8eckLFfvLehWnU3L6luG
	 DByJC5rOycPWeH/qcqtmOle9Sx0iSi9FA8JUYK9eKBEPtw4a+XwA87zOLaz0WEp8Gf
	 644TC8BoF9+omKJcYfD0XvcxdHtmh2/ZGEjAnASc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392022AbfETOsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:48:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34508 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731837AbfETOsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Pzy7R7NMtIp0soxdacOvAtehGecGOy+zjqDf/NYYYuQ=; b=opGgamrus8/MlNcjK7Utg0Jb2d
        v5+OiZpAbqArtyZuw3nL37J17iwVLYbHlwPSk1rdMi8+P9KvECgzceshxYCwnuf1ywAInuP4VeaXM
        cd+/0eihRLYwuutLWVxPvCMjOUY6Nls5Pf2hYnrcP1+2ztECoxsURhXC5GBfrYQtHQGHeal320tGM
        qF7AL9qAznzKtt5NhTYIuQCTVGEni36xWwZd6PEy/f1rIkUWLCooi+RQuPBonL2SivqcgoEipw0O/
        cftVM4DHbilj/R42KXMqF6NVKuCpdabb9OmXst2nbUvZ+zF+Fwz8Qe2tLoBvpEIihqHU1YT0UMjHF
        EHbI3qrA==;
Received: from [179.176.119.151] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSja3-0000E5-Ou; Mon, 20 May 2019 14:47:59 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hSjZq-00010r-O7; Mon, 20 May 2019 11:47:46 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 04/10] scripts/documentation-file-ref-check: teach about .txt -> .yaml renames
Date:   Mon, 20 May 2019 11:47:33 -0300
Message-Id: <e48361790f6c8cbf00f3e6c25bd07381b7be537d.1558362030.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558362030.git.mchehab+samsung@kernel.org>
References: <cover.1558362030.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At DT, files are being renamed to jason. Teach the script how to
handle such renames when used in fix mode.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/documentation-file-ref-check | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/scripts/documentation-file-ref-check b/scripts/documentation-file-ref-check
index 5d775ca7469b..ff16db269079 100755
--- a/scripts/documentation-file-ref-check
+++ b/scripts/documentation-file-ref-check
@@ -165,13 +165,22 @@ foreach my $ref (keys %broken_ref) {
 
 	# usual reason for breakage: DT file moved around
 	if ($ref =~ /devicetree/) {
-		my $search = $new;
-		$search =~ s,^.*/,,;
-		$f = qx(find Documentation/devicetree/ -iname "*$search*") if ($search);
+		# usual reason for breakage: DT file renamed to .yaml
 		if (!$f) {
-			# Manufacturer name may have changed
-			$search =~ s/^.*,//;
+			my $new_ref = $ref;
+			$new_ref =~ s/\.txt$/.yaml/;
+			$f=$new_ref if (-f $new_ref);
+		}
+
+		if (!$f) {
+			my $search = $new;
+			$search =~ s,^.*/,,;
 			$f = qx(find Documentation/devicetree/ -iname "*$search*") if ($search);
+			if (!$f) {
+				# Manufacturer name may have changed
+				$search =~ s/^.*,//;
+				$f = qx(find Documentation/devicetree/ -iname "*$search*") if ($search);
+			}
 		}
 	}
 
-- 
2.21.0

