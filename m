Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DC5C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4591B2430B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559171378;
	bh=voLiJJ+YBWkuXuOa/EV1wytC0XoJkY6LDaACMMBxoag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IB+DE1yTnGSEdrqb1hZfltIiHXVclFgwcp+09FEQWARFvujqzzcj5WMnYjV3n2Vi3
	 OLrTWwi6P2blWd1cg8arKo3XdLMXUi4OsX7xEv7th5rqZi9+whRkVgED/n/pDlDwBH
	 thkuQyWVti94QMaypGD2YtvTyzH/VXY1l4JxmjmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfE2XJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 19:09:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47586 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfE2XJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Pzy7R7NMtIp0soxdacOvAtehGecGOy+zjqDf/NYYYuQ=; b=ox5BvDxZ/jy4+sN4uLv8yqRD44
        XESlSqsqcaZEBuY3CmAeXrFTq7oW+fwCkUQdNtbYKmx/y3rv7ROk/C6P/0D8sKTLp6+qElFtOS/j1
        x8+xS12gxsGFcWXNWtmHr4nOomFrnXUS4LVv3Nv0w/cY/2Gx7JPe0sUmXnS9+KhpslITowcGW2l22
        gC3R3/j5njBxKCZeBnPSYIz0uQAYS4aKUp34Yosr1udeR7gsFr5MoN0NPwlp1ZFyLKtzcLwZX1Vyf
        ylb2X4m8uCwpZpurJDSAnh5++ME70oF5oG/EzVmWV6mMR1/5aPtu1kNGXqgh3s6ehf9JXfxZzE9sa
        2GqMI9Rw==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW7hQ-0000lB-Fv; Wed, 29 May 2019 23:09:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hW7hN-0007Tl-NR; Wed, 29 May 2019 20:09:33 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 08/10] scripts/documentation-file-ref-check: teach about .txt -> .yaml renames
Date:   Wed, 29 May 2019 20:09:30 -0300
Message-Id: <a301b6e922407c12279d7ca51b70156673e66ddc.1559170790.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559170790.git.mchehab+samsung@kernel.org>
References: <cover.1559170790.git.mchehab+samsung@kernel.org>
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

