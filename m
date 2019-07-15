Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE30AC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 08:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC51214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 08:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563177686;
	bh=z/pFGRrc2v/b8ZT1ZmsAjXtOGau0XIHdNGyH1Rbs8E0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QP/J/lOl1gOeR6YhnQrB9qqiwNkXjIRlVB7KHJ9sgtWMFG9PtVavcQJ2DsOIKN1qh
	 BDbSXNKEIzRmJ0Zigr4qieAh8TEAw0GprZDFZXESOpE5+XXIYJH87jUJGh2wRPZZWf
	 8ZdR0YO5J88t5d6XC8+mbh2HA0LIrtonz1/EYZnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbfGOIBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 04:01:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35002 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfGOIBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 04:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cr2TH0iYJZYePVXQlayUtWSyHforlPXZ1/Qdq3ZeKpk=; b=svc9M6QN7+u3C+N6eOPZC4IB2
        aq4dQ5WyLBMh3FW6SPTS6cXA0DGGm0v+nVfBD36mCJ5ikL8c8zu+x7ebEggxTTlPDw+WJpXmFfD65
        yQzBSRpTKD+ZidpNa4zFhrJCZMVXQtci38d1rb+IYhQ2u7UkT6k5tNZ3zwLUT2AVZqAjSeiw2c/sm
        rfs+st2BDAVopdVErU5iCuVSG5+cCH/1YcSFl9DZYLRGFVL9bNbfDAr35w4x8k823ThOpUgZtRSX+
        nVpjbmQW+HiM1IX2g7PpoRM8Pzae/oKFDPmHYdeHNTE/Z+nOJvmZUBqFTzjMxidxX0f3MSJ6iRF9A
        6qREJvBmA==;
Received: from [189.27.46.152] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hmvvI-0008Ju-4t; Mon, 15 Jul 2019 08:01:24 +0000
Date:   Mon, 15 Jul 2019 05:01:20 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 7/8] docs: load_config.py: avoid needing a conf.py just
 due to LaTeX docs
Message-ID: <20190715050120.6eeef30b@coco.lan>
In-Reply-To: <8076229480bdec3e86489d43b10a5afcfd88a75e.1563115732.git.mchehab+samsung@kernel.org>
References: <cover.1563115732.git.mchehab+samsung@kernel.org>
        <8076229480bdec3e86489d43b10a5afcfd88a75e.1563115732.git.mchehab+samsung@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

v2: make SPHINXDIRS="foo" htmldocs now works without needing a per-subdir
    conf.py.

diff --git a/Documentation/sphinx/load_config.py b/Documentation/sphinx/load_config.py
index 301a21aa4f63..e4a04f367b41 100644
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
@@ -29,4 +52,6 @@ def loadConfig(namespace):
             del config['__file__']
             namespace.update(config)
         else:
-            sys.stderr.write("WARNING: additional sphinx-config not found: %s\n" % config_file)
+            config = namespace.copy()
+            config['tags'].add("subproject")
+            namespace.update(config)
