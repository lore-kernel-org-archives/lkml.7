Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A75AC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 10:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7042E20645
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 10:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562667907;
	bh=s6cE65Eljr/iHn5WA9WGd58naGDekFmphC0KLU2gGdU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=aAuojPmp4ehQEJstMJ3DcNNFBsDGd3M51RqoSiSf2eJvZVb+ygItXUhbCxDN/tqmS
	 2xcmBmnTlx85HZDVUyAOC14+SyTRBaTZXZAEWksMSwcMIMAFHYH25PpR/IGjyb8YbJ
	 85np65fD+RBiBvXAYvzosJc/tnQjzpSqRL1cmAjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfGIKZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 06:25:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfGIKZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 06:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SFTO/dK8SIeELbyjmWLxRQjDXjnyydcKlq+hFQch7Xk=; b=kaTYe12YjtXiZyDx7eArbT8N7
        tp56ndNM22Z2sEqW/o4XYuU6REDbGGlDQI5mCtzdOxLjv6DvzQ/CIihog3RU2TnN4SrBGWw9MlMlZ
        9abWY6HKcIcoVSxcrvJlZCFIer9cOy8LCJNoJ+X4rW9PPbafjDudIr+ItpYbHhjrUz0Cwl1oyjzKB
        d3We1Q5OD1sKsaMU2I2ydIWQGKIMHV/X7Uf7Suhs1wPxnY8TKvMMIdg5TMQMX7i0Hh3pNCubP6/8q
        aNZc0XZL2HJp3NuOF015JQOppeJWT2w44lwvGjOw7CvgkSFTxMqEuKGZePyekzkxWFgB83rGxr8Dk
        2T6JX4geg==;
Received: from 177.43.30.58.dynamic.adsl.gvt.net.br ([177.43.30.58] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hknJ3-0005Wy-CQ; Tue, 09 Jul 2019 10:25:05 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hknJ1-0001Ts-5f; Tue, 09 Jul 2019 07:25:03 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] docs: pdf: add all Documentation/*/index.rst to PDF output
Date:   Tue,  9 Jul 2019 07:25:02 -0300
Message-Id: <534357e57c539b421a745536dcf95cef78252b1e.1562667900.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, all index files should be manually added to the
latex_documents array at conf.py.

While this allows fine-tuning some LaTeX specific things, like
the name of the output file and the name of the document, it
is not uncommon to forget adding new documents there.

So, add a logic that will seek for all Documentation/*/index.rst.
If the index is not yet at latex_documents, it includes using
a reasonable default.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/conf.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index a502baecbb85..191bd380c523 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -410,6 +410,21 @@ latex_documents = [
      'The kernel development community', 'manual'),
 ]
 
+# Add all other index files from Documentation/ subdirectories
+for fn in os.listdir('.'):
+    doc = os.path.join(fn, "index")
+    if os.path.exists(doc + ".rst"):
+        has = False
+        for l in latex_documents:
+            if l[0] == doc:
+                has = True
+                break
+        if not has:
+            latex_documents.append((doc, fn + '.tex',
+                                    'Linux %s Documentation' % fn.capitalize(),
+                                    'The kernel development community',
+                                    'manual'))
+
 # The name of an image file (relative to this directory) to place at the top of
 # the title page.
 #latex_logo = None
-- 
2.21.0

