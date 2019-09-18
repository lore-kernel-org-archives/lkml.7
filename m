Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562D7C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B5021A49
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568787704;
	bh=ZkLdxNAd1JjyAr7Z/1lwo1NdnKy3RKQR5Pu43SOeOzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dZ2Zev8l69mMhchX3urM7QXc6DaAOv5Ml03x+6eFgSQGLya7R97g1jz8IJRRjNPEt
	 6amMJZgye+E+CoMtgdJy1ik4fz6YNmiBJocbrnLaBz5mQtQ/F1d+DWFXGXq5CPFXBE
	 mtP/jcVCNVRBIIvm8GYxLZBq0IV9Xj3wdpOcohmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfIRGVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:21:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729184AbfIRGVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:21:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D31E921920;
        Wed, 18 Sep 2019 06:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787699;
        bh=ZkLdxNAd1JjyAr7Z/1lwo1NdnKy3RKQR5Pu43SOeOzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SdCakmHuLVh4JFZpWCurvqrUciKO5p2XmxEju3VJQ36nlegAm3PeaguNsPdjftXdy
         Hqn7BmbANzZq3OmpwXItGWy0RZN8vySUn4cMhmpkpW72K0S5kvqVFsm/x8GCBP6Ijs
         afmVWHlq3gVcxudufp6uBAJjTYrWq794qNgtIpFM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 39/45] crypto: talitos - HMAC SNOOP NO AFEU mode requires SW icv checking.
Date:   Wed, 18 Sep 2019 08:19:17 +0200
Message-Id: <20190918061227.567413573@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061222.854132812@linuxfoundation.org>
References: <20190918061222.854132812@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit 4bbfb839259a9c96a0be872e16f7471b7136aee5 upstream.

In that mode, hardware ICV verification is not supported.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: 7405c8d7ff97 ("crypto: talitos - templates for AEAD using HMAC_SNOOP_NO_AFEU")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/talitos.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1475,7 +1475,8 @@ static int aead_decrypt(struct aead_requ
 	if (IS_ERR(edesc))
 		return PTR_ERR(edesc);
 
-	if ((priv->features & TALITOS_FTR_HW_AUTH_CHECK) &&
+	if ((edesc->desc.hdr & DESC_HDR_TYPE_IPSEC_ESP) &&
+	    (priv->features & TALITOS_FTR_HW_AUTH_CHECK) &&
 	    ((!edesc->src_nents && !edesc->dst_nents) ||
 	     priv->features & TALITOS_FTR_SRC_LINK_TBL_LEN_INCLUDES_EXTENT)) {
 


