Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B93C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DEA2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560534763;
	bh=y3uaJKfnZusBbzIYjjrBA5cDn6wIZRA2h1/E4QkZcv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q5dGbwWUt8Ht1dfWU3og4PfbuhLyX2U8Rva3NregXRNpsc4QmCMqWqbx4avUwMkMl
	 KD2CMIP86DUhNs3Ni3oQEMlBFW4rxtYW2I+FwIp9eaYY1NS28TFi09ZNDE6lcwO/GH
	 SPUL9iPxNn4rxl4VXYBM6KHhcyaFj+wAn4iyzEOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfFNRwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:52:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfFNRwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WNiRsq7voQTs7B1oPyVixDdCGhlnrWKg3Vv2Nss1FD8=; b=kkWV5+DyTvzf1HePB9t3K7/LFg
        WuHQyJZM42+cYmkMZmFIQFEclXJ6fEnb5Xjrk9mZWDRtUxv9RZpYxDzODJLYWc4BlU3PkwBn2ki3J
        tBh/Zmiiu7Y45YewFCjTUjFon2xrhFqTKwVcuUoj5ZzyKL8NSoQt9MeX+zIKKXed7DBd/45FP8RXo
        lHVHEVkQGpwVoJ+zSS5Yi/8uZTgsNNTGmwE0BkzlRqDyfzT+Qfs3c8OmIlvMFoUFFt0aoSQ9vzqYi
        mmS9Tr70xL0DqKYPvW8Umb7MpOqtx6tjFSsvmGBtNTAO9R4bB2SHfJm5vNMy/E/NXuNooOgE74QVM
        5xD6eoIQ==;
Received: from 177.133.85.52.dynamic.adsl.gvt.net.br ([177.133.85.52] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbqNO-0000Pa-KU; Fri, 14 Jun 2019 17:52:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hbqNM-0002PJ-23; Fri, 14 Jun 2019 14:52:32 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 14/16] docs: sphinx/kernel_abi.py: fix UTF-8 support
Date:   Fri, 14 Jun 2019 14:52:28 -0300
Message-Id: <8797b79370b399ffa6c614be966a7b80289153be.1560534648.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1560534648.git.mchehab+samsung@kernel.org>
References: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1560534648.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parser breaks with UTF-8 characters with Sphinx 1.4.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/sphinx/kernel_abi.py | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index 32ce90775d96..0f3e51e67e8d 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -1,4 +1,5 @@
-# -*- coding: utf-8; mode: python -*-
+# coding=utf-8
+#
 u"""
     kernel-abi
     ~~~~~~~~~~
@@ -28,6 +29,7 @@ u"""
 
 """
 
+import codecs
 import sys
 import os
 from os import path
@@ -43,14 +45,6 @@ from docutils.utils.error_reporting import ErrorString
 
 __version__  = '1.0'
 
-# We can't assume that six is installed
-PY3 = sys.version_info[0] == 3
-PY2 = sys.version_info[0] == 2
-if PY3:
-    # pylint: disable=C0103, W0622
-    unicode     = str
-    basestring  = str
-
 def setup(app):
 
     app.add_directive("kernel-abi", KernelCmd)
@@ -115,12 +109,12 @@ class KernelCmd(Directive):
                 cmd
                 , stdout = subprocess.PIPE
                 , stderr = subprocess.PIPE
-                , universal_newlines = True
                 , **kwargs
             )
             out, err = proc.communicate()
-            if err:
-                self.warn(err)
+
+            out, err = codecs.decode(out, 'utf-8'), codecs.decode(err, 'utf-8')
+
             if proc.returncode != 0:
                 raise self.severe(
                     u"command '%s' failed with return code %d"
@@ -129,7 +123,7 @@ class KernelCmd(Directive):
         except OSError as exc:
             raise self.severe(u"problems with '%s' directive: %s."
                               % (self.name, ErrorString(exc)))
-        return unicode(out)
+        return out
 
     def nestedParse(self, lines, fname):
         content = ViewList()
-- 
2.21.0

