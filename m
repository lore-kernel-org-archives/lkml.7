Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1B4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6499521738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368107;
	bh=z9pa16jbPNuW6QtaKlDtNIIttUCIaFhSPtukLi5/rOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Tvm/tu3gpVIsa7mTnJArbHrOS4xPMsrdWmOzlFPnduxJ4C66rMqLrPf5q9OutqmD
	 5qx3zXyEXQ15IEGUhNcJYcR7xvKCC9O/hVEH+2uU9POwB/T/1Umrf67DIvw7rhtzBX
	 MSKvSs2iNeM/ZtISRvtR0cMXS2aTXKal6vwEPDQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbfDDIzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730168AbfDDIzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:55:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB5BE21738;
        Thu,  4 Apr 2019 08:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368102;
        bh=z9pa16jbPNuW6QtaKlDtNIIttUCIaFhSPtukLi5/rOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z8pDFEzBFJU28iPN2+9uWDzmIbIfH6NYh1Bzw9/8CDm9t0r+DrME8D4veXVCWkouG
         Vq52EnS88kTNnxT1f0mHdbUWPej5phdDRO4OrPSO/Rxq4DP+qC8I/Lk/4k4UxfVcHU
         c8fiiCCxN2snlebdnjUPelLtodbuxN8f2bKDRG14=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 038/121] crypto: crypto4xx - add missing of_node_put after of_device_is_available
Date:   Thu,  4 Apr 2019 10:47:06 +0200
Message-Id: <20190404084547.389039984@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8c2b43d2d85b48a97d2f8279278a4aac5b45f925 ]

Add an of_node_put when a tested device node is not available.

The semantic patch that fixes this problem is as follows
(http://coccinelle.lip6.fr):

// <smpl>
@@
identifier f;
local idexpression e;
expression x;
@@

e = f(...);
... when != of_node_put(e)
    when != x = e
    when != e = x
    when any
if (<+...of_device_is_available(e)...+>) {
  ... when != of_node_put(e)
(
  return e;
|
+ of_node_put(e);
  return ...;
)
}
// </smpl>

Fixes: 5343e674f32fb ("crypto4xx: integrate ppc4xx-rng into crypto4xx")
Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/amcc/crypto4xx_trng.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/amcc/crypto4xx_trng.c b/drivers/crypto/amcc/crypto4xx_trng.c
index 677ca17fd223..368c5599515e 100644
--- a/drivers/crypto/amcc/crypto4xx_trng.c
+++ b/drivers/crypto/amcc/crypto4xx_trng.c
@@ -80,8 +80,10 @@ void ppc4xx_trng_probe(struct crypto4xx_core_device *core_dev)
 
 	/* Find the TRNG device node and map it */
 	trng = of_find_matching_node(NULL, ppc4xx_trng_match);
-	if (!trng || !of_device_is_available(trng))
+	if (!trng || !of_device_is_available(trng)) {
+		of_node_put(trng);
 		return;
+	}
 
 	dev->trng_base = of_iomap(trng, 0);
 	of_node_put(trng);
-- 
2.19.1



