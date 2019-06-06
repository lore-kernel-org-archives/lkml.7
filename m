Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DCEC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016C62083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfFFO5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:57:16 -0400
Received: from gateway36.websitewelcome.com ([192.185.193.119]:27197 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728011AbfFFO5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:57:16 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 86B84400C9911
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2019 09:18:11 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id YtpLhxlA84FKpYtpLhHVBS; Thu, 06 Jun 2019 09:57:15 -0500
X-Authority-Reason: nr=8
Received: from [189.250.127.120] (port=43322 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hYtpK-000MlG-DQ; Thu, 06 Jun 2019 09:57:14 -0500
Date:   Thu, 6 Jun 2019 09:57:13 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     qat-linux@intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] crypto: qat - use struct_size() helper
Message-ID: <20190606145713.GA16636@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.127.120
X-Source-L: No
X-Exim-ID: 1hYtpK-000MlG-DQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.127.120]:43322
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct qat_alg_buf_list {
	...
        struct qat_alg_buf bufers[];
} __packed __aligned(64);

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

So, replace the following form:

sizeof(struct qat_alg_buf_list) + ((1 + n) * sizeof(struct qat_alg_buf))

with:

struct_size(bufl, bufers, n + 1)

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/crypto/qat/qat_common/qat_algs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/qat_algs.c b/drivers/crypto/qat/qat_common/qat_algs.c
index 2842b2cdaa90..b50eb55f8f57 100644
--- a/drivers/crypto/qat/qat_common/qat_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_algs.c
@@ -717,8 +717,7 @@ static int qat_alg_sgl_to_bufl(struct qat_crypto_instance *inst,
 	dma_addr_t blp;
 	dma_addr_t bloutp = 0;
 	struct scatterlist *sg;
-	size_t sz_out, sz = sizeof(struct qat_alg_buf_list) +
-			((1 + n) * sizeof(struct qat_alg_buf));
+	size_t sz_out, sz = struct_size(bufl, bufers, n + 1);
 
 	if (unlikely(!n))
 		return -EINVAL;
@@ -755,8 +754,7 @@ static int qat_alg_sgl_to_bufl(struct qat_crypto_instance *inst,
 		struct qat_alg_buf *bufers;
 
 		n = sg_nents(sglout);
-		sz_out = sizeof(struct qat_alg_buf_list) +
-			((1 + n) * sizeof(struct qat_alg_buf));
+		sz_out = struct_size(buflout, bufers, n + 1);
 		sg_nctr = 0;
 		buflout = kzalloc_node(sz_out, GFP_ATOMIC,
 				       dev_to_node(&GET_DEV(inst->accel_dev)));
-- 
2.21.0

