Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A39C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164D12084E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561222777;
	bh=Fh5C7dWUW51j2MQrotTWIH6S7+EqkaLENb2ayqMMaso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IC/9MqrOGsW8NU5IY2f2edGfjvKeh2UvjObLYVUAtRaAg4v1n/0PFuXYDl8MLzr8F
	 H/Apo6pcwxNcaCXvdT53jKFNrgECnNzBitSlZh+Ouin0urliQNUuUOYGCELIKWsiWq
	 sZkgFsjx1mBXn5zR9OPtxFysvRFCg/1oHntdByD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfFVQ7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 12:59:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfFVQ67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 12:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QVmMfFbyrBUXO4UWpk3NqsWGbMgl5YlRIWt5G2YrmUU=; b=BD8dVQEmdtenNCv0Bd6za1gP/0
        GldlaOcpCRtaJ7/AjD+l27JA706wEqfKFZ/jeFv36QyBb7OPaKxeKQJh9DcZEFcKSwRak26twcuru
        iXo8dvhZt+PRjglE9m23NrtJMisAzDbrIV+ZbeO0I+0Aczoipnu7POIpAARwlvExSoZjOpeHVeAlE
        XQClNlijq+gGwdj7w3cvGZaWtQ/yDMhnSPJ3Q7u3fq65BlxPHsQj3aQcfy9d1ev8yFotrMyK5mq/g
        YH7vsvSzQ6i26xuirviGsnHxSSKjo9AbgCokUYRkth5pREhbGlcR2ugQtCnE8xKWVFr2jjHEWbukS
        aZF47caQ==;
Received: from [179.95.45.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hejLu-00054l-Eq; Sat, 22 Jun 2019 16:58:58 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hejLr-0000vL-TE; Sat, 22 Jun 2019 13:58:55 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        gregkh@linuxfoundation.org, Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] docs: kernellog.py: add support for info()
Date:   Sat, 22 Jun 2019 13:58:45 -0300
Message-Id: <256cb655e6f2a0737722c67d36070c99a2f53140.1561221403.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561221403.git.mchehab+samsung@kernel.org>
References: <cover.1561221403.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An extension may want to just inform about something. So, add
support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/sphinx/kernellog.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/sphinx/kernellog.py b/Documentation/sphinx/kernellog.py
index af924f51a7dc..8ac7d274f542 100644
--- a/Documentation/sphinx/kernellog.py
+++ b/Documentation/sphinx/kernellog.py
@@ -25,4 +25,8 @@ def verbose(app, message):
     else:
         app.verbose(message)
 
-
+def info(app, message):
+    if UseLogging:
+        logger.info(message)
+    else:
+        app.info(message)
-- 
2.21.0

