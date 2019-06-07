Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96CCC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932A32146F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559933709;
	bh=+qo5mdwkF5goqpUcwVsWYW+H7zAopYn/EYr4Kt7ZlrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cbTbRXEDhG+GHzIdbtwLXkd5gpMKlLWcNx5JZtPjGEzATJvtiWsXD4MYr/fpFSrfz
	 Ub2jgfncsIYwFQQG3SVOb9+gaqArkF6hBhvsaMEH1Yy5TCU8vu8F4nke4vIwxT68fH
	 WYD16Yjn2VeSj2hkw/k2gZd2k/+jPLwU1K2/+fKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732162AbfFGSyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:54:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42262 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbfFGSyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uax00MhLlFpYA5SZzOVY82diwalzYA3SNqGmlnWlanE=; b=OhL+52KyDBrHUieW2mIeoW0YJn
        3JtcLkEizrq9O1igz+VxMEaMffmJkQpN5Lj5FAZzJ14g/KGgwLPNDPFjO8mjw6ZGLSAPpxAkJL2YP
        TTWsASrZeOqC83qtbUA1VzvrJKiHnKJ2u+RjHkWodKTAxQZcetk/eAq2Yq9ViOft9IA2c4vrENqNW
        hBBgzy6F7VMqGwNtTDEmoQeA+I6CzjBjOi0JftPJ5sVrArXthGMIWPCDNcewjz5/vEmS5XXLTMn9N
        12S1smNQMWvnMFqLrd8i1ZMcGL8/iWAmto/v4NdV/uLEZ8/IILCXL7B0W1tNUPWGNI18MoZT7+ZrW
        DaB/++lw==;
Received: from [179.181.119.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZK0d-0005sb-JE; Fri, 07 Jun 2019 18:54:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hZK0b-0007FA-Ge; Fri, 07 Jun 2019 15:54:37 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org
Subject: [PATCH v3 12/20] docs: security: core.rst: Fix several warnings
Date:   Fri,  7 Jun 2019 15:54:28 -0300
Message-Id: <8fb1ec1bbe34b0f5924b75204c26ba7f96f9e663.1559933665.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
References: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multi-line literal markups only work when they're idented at the
same level, with is not the case here:

   Documentation/security/keys/core.rst:1597: WARNING: Inline literal start-string without end-string.
   Documentation/security/keys/core.rst:1597: WARNING: Inline emphasis start-string without end-string.
   Documentation/security/keys/core.rst:1597: WARNING: Inline emphasis start-string without end-string.
   Documentation/security/keys/core.rst:1598: WARNING: Inline emphasis start-string without end-string.
   Documentation/security/keys/core.rst:1598: WARNING: Inline emphasis start-string without end-string.
   Documentation/security/keys/core.rst:1600: WARNING: Inline literal start-string without end-string.
   Documentation/security/keys/core.rst:1600: WARNING: Inline emphasis start-string without end-string.
   Documentation/security/keys/core.rst:1600: WARNING: Inline emphasis start-string without end-string.
   Documentation/security/keys/core.rst:1600: WARNING: Inline emphasis start-string without end-string.
   Documentation/security/keys/core.rst:1600: WARNING: Inline emphasis start-string without end-string.
   Documentation/security/keys/core.rst:1666: WARNING: Inline literal start-string without end-string.
   Documentation/security/keys/core.rst:1666: WARNING: Inline emphasis start-string without end-string.
   Documentation/security/keys/core.rst:1666: WARNING: Inline emphasis start-string without end-string.
   Documentation/security/keys/core.rst:1666: WARNING: Inline emphasis start-string without end-string.

Fix it by using a code-block instead.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/security/keys/core.rst | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index 9521c4207f01..3fd60dcb2dc6 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -1594,10 +1594,12 @@ The structure has a number of fields, some of which are mandatory:
      attempted key link operation. If there is no match, -EINVAL is returned.
 
 
-  *  ``int (*asym_eds_op)(struct kernel_pkey_params *params,
-			  const void *in, void *out);``
-     ``int (*asym_verify_signature)(struct kernel_pkey_params *params,
-				    const void *in, const void *in2);``
+  *  ``asym_eds_op`` and ``asym_verify_signature``::
+
+       int (*asym_eds_op)(struct kernel_pkey_params *params,
+			  const void *in, void *out);
+       int (*asym_verify_signature)(struct kernel_pkey_params *params,
+				    const void *in, const void *in2);
 
      These methods are optional.  If provided the first allows a key to be
      used to encrypt, decrypt or sign a blob of data, and the second allows a
@@ -1662,8 +1664,10 @@ The structure has a number of fields, some of which are mandatory:
      required crypto isn't available.
 
 
-  *  ``int (*asym_query)(const struct kernel_pkey_params *params,
-			 struct kernel_pkey_query *info);``
+  *  ``asym_query``::
+
+       int (*asym_query)(const struct kernel_pkey_params *params,
+			 struct kernel_pkey_query *info);
 
      This method is optional.  If provided it allows information about the
      public or asymmetric key held in the key to be determined.
-- 
2.21.0

