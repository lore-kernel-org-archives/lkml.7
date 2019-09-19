Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8ADCC4CED0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8518020640
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568932104;
	bh=ZkLdxNAd1JjyAr7Z/1lwo1NdnKy3RKQR5Pu43SOeOzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e3PJxh5vaqQlbwvBQa91jSiEFUu1ze537z0BcOH35qp+2Obd5Z2CWleiFZPT7Pso3
	 4FwMWizik+A3oqBsMGMN35gCiNQINuPybXZ65VPPA6kAQEosCBPk21rv8Ekg3Gb3/k
	 O+a1Np/z8AZVTue5mmMwfKJBB56li6SAr1d5fehw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392791AbfISWTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:19:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389568AbfISWTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:19:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CCAF20678;
        Thu, 19 Sep 2019 22:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931564;
        bh=ZkLdxNAd1JjyAr7Z/1lwo1NdnKy3RKQR5Pu43SOeOzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2bXLxADlL5unoqOb0C3mVrwM/1sKxz/FnFU8/P9MmvO32XNnaBJZak3tntGwBaeRT
         boaxPn8VqTMXg5iRU8N6qORLSCCH7WBV1QMIEVgGL2hecfiQa6kDR/v9l7ijMHB1j5
         Od01ajioyDDX8n78Z/NOwevOIWRs2rrAaVnDeRWI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.9 31/74] crypto: talitos - HMAC SNOOP NO AFEU mode requires SW icv checking.
Date:   Fri, 20 Sep 2019 00:03:44 +0200
Message-Id: <20190919214808.108690266@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214800.519074117@linuxfoundation.org>
References: <20190919214800.519074117@linuxfoundation.org>
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
 


