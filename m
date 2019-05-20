Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DCCC04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715EE204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355975;
	bh=N8d2+4SnFNE53BBI5L7qN6qxAsHj6sYtOtlPLCR3Gi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iO9QFZOQ8ym9G4oPllP9OoxZyv3TO2sJa58ZOuSvLvLZDcEAROVrHtHTAJ3S81JOg
	 KIDl4W3XJ2lusbcMm826UYTNFEgYhxrp92V6J5FAzO62iGBK6MtRpLmgcJTZ4GC/Dw
	 2VrhNGgfBzkiw/c9qoieRdc57tzesNrXa10Wkl8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390802AbfETMdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:33:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388747AbfETMdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:33:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EECA216C4;
        Mon, 20 May 2019 12:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355623;
        bh=N8d2+4SnFNE53BBI5L7qN6qxAsHj6sYtOtlPLCR3Gi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XnuQro13hitw8u8mROkRHhXfs78J5KZ+U/Bdk2i926WfhGVSzrQHlX/yvLnymQkgB
         p6seD953YHR7tzxLMoBeVZqUkONz27jVgKg5/HWZivH8prlnbSsLJW062ZAC9TBiPZ
         dGdOKPQqdKaZGS+FsWHRBFJcs7i1Vct+m0QWiOQM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.1 063/128] crypto: ccree - use correct internal state sizes for export
Date:   Mon, 20 May 2019 14:14:10 +0200
Message-Id: <20190520115254.045239986@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115249.449077487@linuxfoundation.org>
References: <20190520115249.449077487@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gilad Ben-Yossef <gilad@benyossef.com>

commit f3df82b468f00cca241d96ee3697c9a5e7fb6bd0 upstream.

We were computing the size of the import buffer based on the digest size
but the 318 and 224 byte variants use 512 and 256 bytes internal state
sizes respectfully, thus causing the import buffer to overrun.

Fix it by using the right sizes.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccree/cc_hash.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/crypto/ccree/cc_hash.c
+++ b/drivers/crypto/ccree/cc_hash.c
@@ -1639,7 +1639,7 @@ static struct cc_hash_template driver_ha
 			.setkey = cc_hash_setkey,
 			.halg = {
 				.digestsize = SHA224_DIGEST_SIZE,
-				.statesize = CC_STATE_SIZE(SHA224_DIGEST_SIZE),
+				.statesize = CC_STATE_SIZE(SHA256_DIGEST_SIZE),
 			},
 		},
 		.hash_mode = DRV_HASH_SHA224,
@@ -1666,7 +1666,7 @@ static struct cc_hash_template driver_ha
 			.setkey = cc_hash_setkey,
 			.halg = {
 				.digestsize = SHA384_DIGEST_SIZE,
-				.statesize = CC_STATE_SIZE(SHA384_DIGEST_SIZE),
+				.statesize = CC_STATE_SIZE(SHA512_DIGEST_SIZE),
 			},
 		},
 		.hash_mode = DRV_HASH_SHA384,


