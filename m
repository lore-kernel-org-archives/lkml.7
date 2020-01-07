Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2CBC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8D1206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgAGOgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:36:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54866 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgAGOgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 09:36:09 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iopxh-0006QC-FH; Tue, 07 Jan 2020 14:36:01 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Gary R Hook <gary.hook@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        tee-dev@lists.linaro.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] tee: fix memory allocation failure checks on drv_data and amdtee
Date:   Tue,  7 Jan 2020 14:36:01 +0000
Message-Id: <20200107143601.105321-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the memory allocation failure checks on drv_data and
amdtee are using IS_ERR rather than checking for a null pointer.
Fix these checks to use the conventional null pointer check.

Addresses-Coverity: ("Dereference null return")
Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/tee/amdtee/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
index 9d0cee1c837f..5fda810c79dc 100644
--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -444,11 +444,11 @@ static int __init amdtee_driver_init(void)
 		goto err_fail;
 
 	drv_data = kzalloc(sizeof(*drv_data), GFP_KERNEL);
-	if (IS_ERR(drv_data))
+	if (!drv_data)
 		return -ENOMEM;
 
 	amdtee = kzalloc(sizeof(*amdtee), GFP_KERNEL);
-	if (IS_ERR(amdtee)) {
+	if (!amdtee) {
 		rc = -ENOMEM;
 		goto err_kfree_drv_data;
 	}
-- 
2.24.0

