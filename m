Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45582C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED2D214AE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380485;
	bh=ZDkfIO33o/McqlV4/dQSVvDdcBktevj8xnFF6u9XYqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0oeQrR+8XSEVWF0xGXTwm4+dYez3DM8Ah+AVDqYsqDQP/+5Q2VjlORWXuoRETAZ+9
	 MgA3p9GpgIu7R29Ydne0FuLMrIWPe4PdZ7wR5wO3M+xL6hi3U/tC5EpDJtlN7RCBZD
	 v5wlAazqa0FtD1sSuLV0vtK7F9w+HWLCnO5tXBnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388441AbfIMNOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:14:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388983AbfIMNOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:14:40 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDFDD214AE;
        Fri, 13 Sep 2019 13:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380480;
        bh=ZDkfIO33o/McqlV4/dQSVvDdcBktevj8xnFF6u9XYqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L3zYDLmfhW14Km3B1H9kc723aqW4qTggDB5uYn89uefha0d5nbVu6+gdUOOIWxeFA
         A78q/wGPokhPZg+mCIvhYa9noF30O1jE8zCHRwbC7SyEZq56oKFKF6wISe6OtpcL0v
         e3ImgZ+GHrZKgVVT9nB6H3zFbx8H/z6UVMNocBQs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gilad Ben-Yossef <gilad@benyossef.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>, stable@kernel.org
Subject: [PATCH 4.19 079/190] crypto: ccree - fix resume race condition on init
Date:   Fri, 13 Sep 2019 14:05:34 +0100
Message-Id: <20190913130605.818055957@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1358c13a48c43f5e4de0c1835291837a27b9720c ]

We were enabling autosuspend, which is using data set by the
hash module, prior to the hash module being inited, casuing
a crash on resume as part of the startup sequence if the race
was lost.

This was never a real problem because the PM infra was using low
res timers so we were always winning the race, until commit 8234f6734c5d
("PM-runtime: Switch autosuspend over to using hrtimers") changed that :-)

Fix this by seperating the PM setup and enablement and doing the
latter only at the end of the init sequence.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: stable@kernel.org # v4.20
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/ccree/cc_driver.c |  7 ++++---
 drivers/crypto/ccree/cc_pm.c     | 13 ++++++-------
 drivers/crypto/ccree/cc_pm.h     |  3 +++
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/ccree/cc_driver.c b/drivers/crypto/ccree/cc_driver.c
index 1ff229c2aeab1..186a2536fb8b9 100644
--- a/drivers/crypto/ccree/cc_driver.c
+++ b/drivers/crypto/ccree/cc_driver.c
@@ -364,7 +364,7 @@ static int init_cc_resources(struct platform_device *plat_dev)
 	rc = cc_ivgen_init(new_drvdata);
 	if (rc) {
 		dev_err(dev, "cc_ivgen_init failed\n");
-		goto post_power_mgr_err;
+		goto post_buf_mgr_err;
 	}
 
 	/* Allocate crypto algs */
@@ -387,6 +387,9 @@ static int init_cc_resources(struct platform_device *plat_dev)
 		goto post_hash_err;
 	}
 
+	/* All set, we can allow autosuspend */
+	cc_pm_go(new_drvdata);
+
 	/* If we got here and FIPS mode is enabled
 	 * it means all FIPS test passed, so let TEE
 	 * know we're good.
@@ -401,8 +404,6 @@ post_cipher_err:
 	cc_cipher_free(new_drvdata);
 post_ivgen_err:
 	cc_ivgen_fini(new_drvdata);
-post_power_mgr_err:
-	cc_pm_fini(new_drvdata);
 post_buf_mgr_err:
 	 cc_buffer_mgr_fini(new_drvdata);
 post_req_mgr_err:
diff --git a/drivers/crypto/ccree/cc_pm.c b/drivers/crypto/ccree/cc_pm.c
index 79fc0a37ba6e4..638082dff183a 100644
--- a/drivers/crypto/ccree/cc_pm.c
+++ b/drivers/crypto/ccree/cc_pm.c
@@ -103,20 +103,19 @@ int cc_pm_put_suspend(struct device *dev)
 
 int cc_pm_init(struct cc_drvdata *drvdata)
 {
-	int rc = 0;
 	struct device *dev = drvdata_to_dev(drvdata);
 
 	/* must be before the enabling to avoid resdundent suspending */
 	pm_runtime_set_autosuspend_delay(dev, CC_SUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(dev);
 	/* activate the PM module */
-	rc = pm_runtime_set_active(dev);
-	if (rc)
-		return rc;
-	/* enable the PM module*/
-	pm_runtime_enable(dev);
+	return pm_runtime_set_active(dev);
+}
 
-	return rc;
+/* enable the PM module*/
+void cc_pm_go(struct cc_drvdata *drvdata)
+{
+	pm_runtime_enable(drvdata_to_dev(drvdata));
 }
 
 void cc_pm_fini(struct cc_drvdata *drvdata)
diff --git a/drivers/crypto/ccree/cc_pm.h b/drivers/crypto/ccree/cc_pm.h
index 020a5403c58ba..f626243570209 100644
--- a/drivers/crypto/ccree/cc_pm.h
+++ b/drivers/crypto/ccree/cc_pm.h
@@ -16,6 +16,7 @@
 extern const struct dev_pm_ops ccree_pm;
 
 int cc_pm_init(struct cc_drvdata *drvdata);
+void cc_pm_go(struct cc_drvdata *drvdata);
 void cc_pm_fini(struct cc_drvdata *drvdata);
 int cc_pm_suspend(struct device *dev);
 int cc_pm_resume(struct device *dev);
@@ -29,6 +30,8 @@ static inline int cc_pm_init(struct cc_drvdata *drvdata)
 	return 0;
 }
 
+static void cc_pm_go(struct cc_drvdata *drvdata) {}
+
 static inline void cc_pm_fini(struct cc_drvdata *drvdata) {}
 
 static inline int cc_pm_suspend(struct device *dev)
-- 
2.20.1



