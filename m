Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A887C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA402084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802758;
	bh=s6FgJYfNgOiYJdk98S53txAk4fmhvuTEHWOb5pEm2x8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iKZ5i5x03MNCKzFoDGYATti2yH/oWamyyoOah/S0rMBYXliLZMHuWXRaswdaiyuhY
	 OBLnil6obLp6UhM1wEIDRimPOD8xhjta+K14FbtCgJIyjmy5iSZyokk3p3r1NH2b0z
	 AP2AJ5SdruCz0U+APPFnd9nJQTeVXvqhkAIJ8Wew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbfHNRMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:12:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730332AbfHNRMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:12:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 858812084D;
        Wed, 14 Aug 2019 17:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802754;
        bh=s6FgJYfNgOiYJdk98S53txAk4fmhvuTEHWOb5pEm2x8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gbxcTkGT24C47ZAy/LOarh2ZNh6ukCccbfq6ECchURVxYtA82YwP2BMAwSXbW2lbC
         o6lCvyx7c2wS2fHe0+3+sO3rCvdPKi8ishRnEElLNheQrJCt62qwN1MnvXhCNnSWKW
         guNx8rZVYl8OKlH+sCJWwnRTDKpCWyNoFIEHiecw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gary R Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 03/69] crypto: ccp - Ignore tag length when decrypting GCM ciphertext
Date:   Wed, 14 Aug 2019 19:01:01 +0200
Message-Id: <20190814165745.372646143@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165744.822314328@linuxfoundation.org>
References: <20190814165744.822314328@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gary R Hook <gary.hook@amd.com>

commit e2664ecbb2f26225ac6646876f2899558ffb2604 upstream.

AES GCM input buffers for decryption contain AAD+CTEXT+TAG. Only
decrypt the ciphertext, and use the tag for comparison.

Fixes: 36cf515b9bbe2 ("crypto: ccp - Enable support for AES GCM on v5 CCPs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Gary R Hook <gary.hook@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccp/ccp-ops.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/crypto/ccp/ccp-ops.c
+++ b/drivers/crypto/ccp/ccp-ops.c
@@ -752,8 +752,7 @@ static int ccp_run_aes_gcm_cmd(struct cc
 		while (src.sg_wa.bytes_left) {
 			ccp_prepare_data(&src, &dst, &op, AES_BLOCK_SIZE, true);
 			if (!src.sg_wa.bytes_left) {
-				unsigned int nbytes = aes->src_len
-						      % AES_BLOCK_SIZE;
+				unsigned int nbytes = ilen % AES_BLOCK_SIZE;
 
 				if (nbytes) {
 					op.eom = 1;


