Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2775FC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C07214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="cH68ixxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfLKV5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 16:57:37 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:41540 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfLKV5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 16:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vyPYuKP4nBZWwRtmxSe5elUv8cYRbdETpDEHXZisMr8=; b=cH68ixxC4aHnX4hnIZCm+faQ/e
        CCufRSSS0KY68o8eLy0HnYIeoSqSOdExYCI/wYAm1Um6dOAT/3WAp2BXG+LutniBpSqLiiUU0WqOT
        Y+mnchjpaIaVBMd4YmkERWK6AbOcpUaMbc1v2TaZzIZgdLpYy83ojZsL14JBj/uRZzYs=;
Received: from p200300ccff0c6f001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0c:6f00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1if9zC-0002HF-Vg; Wed, 11 Dec 2019 22:57:35 +0100
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1if9zC-00052q-JM; Wed, 11 Dec 2019 22:57:34 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] mfd: rn5t618: cleanup i2c_device_id
Date:   Wed, 11 Dec 2019 22:57:31 +0100
Message-Id: <20191211215731.19350-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That list was just empty, so it can be removed if .probe_new
instead of .probe is used

Suggested-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/mfd/rn5t618.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index 18d56a732b20..70d52b46ee8a 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -150,8 +150,7 @@ static const struct of_device_id rn5t618_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rn5t618_of_match);
 
-static int rn5t618_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
+static int rn5t618_i2c_probe(struct i2c_client *i2c)
 {
 	const struct of_device_id *of_id;
 	struct rn5t618 *priv;
@@ -251,11 +250,6 @@ static int __maybe_unused rn5t618_i2c_resume(struct device *dev)
 	return 0;
 }
 
-static const struct i2c_device_id rn5t618_i2c_id[] = {
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, rn5t618_i2c_id);
-
 static SIMPLE_DEV_PM_OPS(rn5t618_i2c_dev_pm_ops,
 			rn5t618_i2c_suspend,
 			rn5t618_i2c_resume);
@@ -266,9 +260,8 @@ static struct i2c_driver rn5t618_i2c_driver = {
 		.of_match_table = of_match_ptr(rn5t618_of_match),
 		.pm = &rn5t618_i2c_dev_pm_ops,
 	},
-	.probe = rn5t618_i2c_probe,
+	.probe_new = rn5t618_i2c_probe,
 	.remove = rn5t618_i2c_remove,
-	.id_table = rn5t618_i2c_id,
 };
 
 module_i2c_driver(rn5t618_i2c_driver);
-- 
2.20.1

