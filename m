Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01B7C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05E920674
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfK0Itd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 03:49:33 -0500
Received: from foss.arm.com ([217.140.110.172]:44570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbfK0It2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 03:49:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FC6031B;
        Wed, 27 Nov 2019 00:49:28 -0800 (PST)
Received: from e110176-lin.kfn.arm.com (unknown [10.50.4.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4DCF3F52E;
        Wed, 27 Nov 2019 00:49:26 -0800 (PST)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>, stable@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] crypto: ccree: fix backlog memory leak
Date:   Wed, 27 Nov 2019 10:49:08 +0200
Message-Id: <20191127084909.14472-5-gilad@benyossef.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191127084909.14472-1-gilad@benyossef.com>
References: <20191127084909.14472-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix brown paper bag bug of not releasing backlog list item buffer
when backlog was consumed causing a memory leak when backlog is
used.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: stable@vger.kernel.org # v4.19+
---
 drivers/crypto/ccree/cc_request_mgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/ccree/cc_request_mgr.c b/drivers/crypto/ccree/cc_request_mgr.c
index 3ed3164820eb..a5606dc04b06 100644
--- a/drivers/crypto/ccree/cc_request_mgr.c
+++ b/drivers/crypto/ccree/cc_request_mgr.c
@@ -404,6 +404,7 @@ static void cc_proc_backlog(struct cc_drvdata *drvdata)
 		spin_lock(&mgr->bl_lock);
 		list_del(&bli->list);
 		--mgr->bl_len;
+		kfree(bli);
 	}
 
 	spin_unlock(&mgr->bl_lock);
-- 
2.23.0

