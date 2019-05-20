Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBF2C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032C220815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355012;
	bh=Vc76SIEwx46ODrXQqltdqyN2/mHnKSGbQiibyzx/1hQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WhRbMwIljdlKTF/TgT+QqGr4SPZmGTPYKXqd4dTADPaFcxakPTpsv1yjgfpFv2QRN
	 qg30Fo1r2GIEZc45De2+okrhQaUrDVH7m8Rt5jt1t0j1D2+Cl/jnMHU8ne9V8nj6wg
	 XsWJZfUO1qk6goYRw8XuDquDuq65J0tVi8H2XdDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388617AbfETMXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:23:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388023AbfETMX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:23:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9365B20675;
        Mon, 20 May 2019 12:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355009;
        bh=Vc76SIEwx46ODrXQqltdqyN2/mHnKSGbQiibyzx/1hQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=auzmw+dpH+8DZGb3Sh0ZSb5o1JdWQe9lIB8YznJUcGcMzJYgrBszwKCq0jvKXQxsZ
         3BzY2SQrmY6oXkSIzOEZthXnw2pbcBoVP+bWofMbLfFqVGjFepCzAYYp2vU1bKsw4H
         CSMRSlCe0M7TVvkMKd82rMgWDMa1aA3fqb5oxYZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 045/105] crypto: ccree - fix mem leak on error path
Date:   Mon, 20 May 2019 14:13:51 +0200
Message-Id: <20190520115250.133283526@linuxfoundation.org>
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

commit d574b707c873d6ef1a2a155f8cfcfecd821e9a2e upstream.

Fix a memory leak on the error path of IV generation code.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: stable@vger.kernel.org # v4.19+
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccree/cc_ivgen.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/drivers/crypto/ccree/cc_ivgen.c
+++ b/drivers/crypto/ccree/cc_ivgen.c
@@ -154,9 +154,6 @@ void cc_ivgen_fini(struct cc_drvdata *dr
 	}
 
 	ivgen_ctx->pool = NULL_SRAM_ADDR;
-
-	/* release "this" context */
-	kfree(ivgen_ctx);
 }
 
 /*!
@@ -174,10 +171,12 @@ int cc_ivgen_init(struct cc_drvdata *drv
 	int rc;
 
 	/* Allocate "this" context */
-	ivgen_ctx = kzalloc(sizeof(*ivgen_ctx), GFP_KERNEL);
+	ivgen_ctx = devm_kzalloc(device, sizeof(*ivgen_ctx), GFP_KERNEL);
 	if (!ivgen_ctx)
 		return -ENOMEM;
 
+	drvdata->ivgen_handle = ivgen_ctx;
+
 	/* Allocate pool's header for initial enc. key/IV */
 	ivgen_ctx->pool_meta = dma_alloc_coherent(device, CC_IVPOOL_META_SIZE,
 						  &ivgen_ctx->pool_meta_dma,
@@ -196,8 +195,6 @@ int cc_ivgen_init(struct cc_drvdata *drv
 		goto out;
 	}
 
-	drvdata->ivgen_handle = ivgen_ctx;
-
 	return cc_init_iv_sram(drvdata);
 
 out:


