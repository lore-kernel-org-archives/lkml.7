Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB386C4CECE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00FE218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568788022;
	bh=Nt/kPG6oe+0JPPcyadZkQEyzrD/qvGFGAb41Yao9ZbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kBPnVQI657tRIj4/CTFtkdHjnav3x3b/rXIJ8NjsTnBWg73NBCGqNqamPr3spLU3Q
	 meIiNLbas9v9eGNqwpux3SWFSCpIFTAwog3JbEJm2ccrxNht4W7PPn91w2Ul/dblFX
	 jY1ETphFQ2+L6dRoZuWhzyq5mBqh5y23jdcWUqd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbfIRG1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:27:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729091AbfIRG05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:26:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96249218AF;
        Wed, 18 Sep 2019 06:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568788017;
        bh=Nt/kPG6oe+0JPPcyadZkQEyzrD/qvGFGAb41Yao9ZbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RMmAP0F5pTDKHaB7n3q0kcztp5gaUE4WxvkXoZLGDx5vLOCD8F6W7Eqp7OMmtzrTZ
         c/xNRgeXdda7rQXR9A6u4OvnP0H6Fg1lUMaOxX58ZSRNSEWwl2o/5aga2LFL2TaVMG
         LmxBcMGBcHPCG9mTP8w0EjFGi6xtIc0Gpv3r/xek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.2 68/85] crypto: talitos - HMAC SNOOP NO AFEU mode requires SW icv checking.
Date:   Wed, 18 Sep 2019 08:19:26 +0200
Message-Id: <20190918061237.567054088@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061234.107708857@linuxfoundation.org>
References: <20190918061234.107708857@linuxfoundation.org>
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
@@ -1515,7 +1515,8 @@ static int aead_decrypt(struct aead_requ
 	if (IS_ERR(edesc))
 		return PTR_ERR(edesc);
 
-	if ((priv->features & TALITOS_FTR_HW_AUTH_CHECK) &&
+	if ((edesc->desc.hdr & DESC_HDR_TYPE_IPSEC_ESP) &&
+	    (priv->features & TALITOS_FTR_HW_AUTH_CHECK) &&
 	    ((!edesc->src_nents && !edesc->dst_nents) ||
 	     priv->features & TALITOS_FTR_SRC_LINK_TBL_LEN_INCLUDES_EXTENT)) {
 


