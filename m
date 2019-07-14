Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE04CC73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C962063F
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563117050;
	bh=KwsR6WrcpAX49OsNj6CikyRByK25K2YnOJDXnDZ+R7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iO8mgG9GBX+YLS3Wc/USrdyzY4B3bgN1jiXzRxxg7rfxfg2u6vXJxNRpaxD8ilSPq
	 C1zPUF4Fhmd3bOqPMTrb1Eo/bGmozdrhYHMR8PDLNFfAtqMXS7tXXQdzhE3UgJjZn1
	 O+AyCIWiJsuLkKpavEo9O+O7OE+3vMeBkT3yAtmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbfGNPKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 11:10:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45528 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfGNPKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 11:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WaTHXnanHUyA+63XriQfQq8umJVikepy1D3atlAnVJY=; b=rADDdUC8TE1XXDn1kAFniDjW1z
        zQteU5ILYgbHdgJIUobdskOYjEJb3miRoZYzr+9mZBGWTy4SAlQ7/D55io1F9FIvRsBUGs5pTZ1JA
        Y3ElNCrDpymkZy/qdsDkfWEpWcy1bmvXFvEdq41MwcVP8NuH7AH6zYf4YQtBIjye7xAc2KYlo9AC1
        5+H6CU6l2T8ESb26fE3OrFyJQu9YBH3rUdkFfeS32JEPy2zpuNOcjb/lz4kgvOXLniEXQZKDAM/fw
        l7uwHGHW88mdsSFRhj9ziUEzK2KO0r6KMLfJdOHVlqlfaXYsaiY0N1OOpER5TFafsCnnksCvnxrSK
        nv+9t0wA==;
Received: from 201.86.163.160.dynamic.adsl.gvt.net.br ([201.86.163.160] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hmg8o-0004f7-Df; Sun, 14 Jul 2019 15:10:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hmg8l-0007TO-3s; Sun, 14 Jul 2019 12:10:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 7/8] docs: load_config.py: avoid needing a conf.py just due to LaTeX docs
Date:   Sun, 14 Jul 2019 12:10:12 -0300
Message-Id: <8076229480bdec3e86489d43b10a5afcfd88a75e.1563115732.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1563115732.git.mchehab+samsung@kernel.org>
References: <cover.1563115732.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, for every directory that we need to have LaTeX output,
a conf.py file is required.

That causes an extra overhead and it is actually a hack, as
the latex_documents line there are usually a copy of the ones
that are there already at the main conf.py.

So, instead, re-use the global latex_documents var, just
adjusting the path to be relative ones.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/sphinx/load_config.py | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/sphinx/load_config.py b/Documentation/sphinx/load_config.py
index 301a21aa4f63..75f527ff4c95 100644
--- a/Documentation/sphinx/load_config.py
+++ b/Documentation/sphinx/load_config.py
@@ -21,6 +21,29 @@ def loadConfig(namespace):
         and os.path.normpath(namespace["__file__"]) != os.path.normpath(config_file) ):
         config_file = os.path.abspath(config_file)
 
+        # Let's avoid one conf.py file just due to latex_documents
+        start = config_file.find('Documentation/')
+	if start >= 0:
+	    start = config_file.find('/', start + 1)
+
+        end = config_file.rfind('/')
+        if start >= 0 and end > 0:
+            dir = config_file[start + 1:end]
+
+            print("source directory: %s" % dir)
+            new_latex_docs = []
+            latex_documents = namespace['latex_documents']
+
+            for l in latex_documents:
+                if l[0].find(dir) == 0:
+                    has = True
+                    fn = l[0][len(dir) + 1:]
+                    new_latex_docs.append((fn, l[1], l[2], l[3], l[4]))
+                    break
+
+            namespace['latex_documents'] = new_latex_docs
+
+        # If there is an extra conf.py file, load it
         if os.path.isfile(config_file):
             sys.stdout.write("load additional sphinx-config: %s\n" % config_file)
             config = namespace.copy()
@@ -28,5 +51,3 @@ def loadConfig(namespace):
             execfile_(config_file, config)
             del config['__file__']
             namespace.update(config)
-        else:
-            sys.stderr.write("WARNING: additional sphinx-config not found: %s\n" % config_file)
-- 
2.21.0

