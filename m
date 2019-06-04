Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6BCC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E4B2473C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559657991;
	bh=+qo5mdwkF5goqpUcwVsWYW+H7zAopYn/EYr4Kt7ZlrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N5urceDbuXmjUbc2vN3w1UhFl90/OIScLndfASsqfiDm8LHGm/n4ZN2TqJxJ82ShT
	 n/1uJOO6W9JZKmVUB6td/6UZ4UTlBmA+D/aoLVEDkxCB79pngTUiA6t0qXiTVm97xZ
	 jW+RGDz3dQQQJu7XhfkhlWMZVM5h7NEeRLRsxZq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfFDOTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:19:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52484 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbfFDOSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uax00MhLlFpYA5SZzOVY82diwalzYA3SNqGmlnWlanE=; b=rWg2aqJgOjMzW/83fP7ArscMmH
        J8fnYCZxolbjo3Cc39M2+rC4GbXGG2l0e/uy7/nc95qm9OC7GC017Xa2VC84CTVi2Boa8R2+rEc0l
        Vg75wTOW07VCcL8fXafq/a2X508hOAQMWC3FOIk0ulDZ0x4Sss6lM0coeO0Er3PibuHYCmjU/HPmZ
        10Ji0hK6+rPvI1zYm6C/k18EKQkVnOJ+H/Ndw4Nd03/fRi7I9z1H9jwB04bhE0TgzI/tnrzAd/R8K
        6EYXIxWHZVCvHovrKyt9a9hhx2sxPvXDSF9Rphgja3mIyza+CdtLUnhIP2g1Yc/c/forOea8dLV8w
        S5KyO17w==;
Received: from [179.182.172.34] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYAGH-0001Rr-V2; Tue, 04 Jun 2019 14:18:01 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hYAGE-0002la-ST; Tue, 04 Jun 2019 11:17:58 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org
Subject: [PATCH v2 15/22] docs: security: core.rst: Fix several warnings
Date:   Tue,  4 Jun 2019 11:17:49 -0300
Message-Id: <21350864823e07cc951e1dc7f0601baa09920ac4.1559656538.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559656538.git.mchehab+samsung@kernel.org>
References: <cover.1559656538.git.mchehab+samsung@kernel.org>
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

