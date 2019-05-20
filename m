Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E12C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CA221019
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355070;
	bh=MX77u6kdfwvVUV47sbTkHYwPbZuLAvAi0T8q94a6MjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UJeuEl/FBZ118+VzeCmrSUtC94l1JzL/LYJ9VdzPUQuMZ12S7O2LO1cp9qUXm86dT
	 2Mrz1MvvzjZG3XCmHPIyhoTBMsSM560Hkg5zShBsl6eWgG9OAd5FGLfeQmJRzY/nVE
	 jPsVze1HB4o6nrYSYBep8Y5+bZaaKGlvoV0eiBOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388850AbfETMY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:24:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388839AbfETMY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:24:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADA6E20645;
        Mon, 20 May 2019 12:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355066;
        bh=MX77u6kdfwvVUV47sbTkHYwPbZuLAvAi0T8q94a6MjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TZfd1/SD1Jg0Rq+alTlaPGdNt/OFwhBkQBGju/SdfAeIDHt4knzDeAeM0a9uREhWg
         ugkoEcJNQZlEjNwSZ8vvLAkyGvwr6kX/tXniA94uhtq0cKNges1wj1lEuNsZYzRTRa
         cMH/J1T92Xml4XFnT7vxdBtpGFmwBHAOLpy0yOWc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 047/105] crypto: ccree - use correct internal state sizes for export
Date:   Mon, 20 May 2019 14:13:53 +0200
Message-Id: <20190520115250.270977831@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115247.060821231@linuxfoundation.org>
References: <20190520115247.060821231@linuxfoundation.org>
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
@@ -1616,7 +1616,7 @@ static struct cc_hash_template driver_ha
 			.setkey = cc_hash_setkey,
 			.halg = {
 				.digestsize = SHA224_DIGEST_SIZE,
-				.statesize = CC_STATE_SIZE(SHA224_DIGEST_SIZE),
+				.statesize = CC_STATE_SIZE(SHA256_DIGEST_SIZE),
 			},
 		},
 		.hash_mode = DRV_HASH_SHA224,
@@ -1641,7 +1641,7 @@ static struct cc_hash_template driver_ha
 			.setkey = cc_hash_setkey,
 			.halg = {
 				.digestsize = SHA384_DIGEST_SIZE,
-				.statesize = CC_STATE_SIZE(SHA384_DIGEST_SIZE),
+				.statesize = CC_STATE_SIZE(SHA512_DIGEST_SIZE),
 			},
 		},
 		.hash_mode = DRV_HASH_SHA384,


