Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D92AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37FD20828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBWiep0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfLJUcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:32:11 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41891 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfLJUcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:32:05 -0500
Received: by mail-pg1-f196.google.com with SMTP id x8so9433873pgk.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 12:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YFx2eeL+mMfvTTf1lfSUrY023GFsFEPvhm+wP8s61nE=;
        b=SBWiep0YvtZPWNzdZjLGonPbi9n/uBVRyUymQTVSTLhY9kWFbpUUomQ2NP+HJpHC6Y
         wn4KC5VcDJwJtEzcVIHxzfaTaz5BuaEiap31NcVRZ2Q6ELoAdUwy+XFshLt5l6/bkjHU
         zFmIfX4GM+CVFaavy5frhpYe8RYvztIsU1v+U2C4XrKmEtcHlzN4FcoYwSZTSo3J5qXU
         gdLgGKY7AMQams6+9gyArIEcDwvX7l31ejau5nY9vokwSY5QblStrk7OsKRSWVTVEypD
         RMTg2Bupob+7C/0kxZ6PN1pPd1/a9EW+TKfzMm6QwDr+nGt2vSADC5vGP7B94+AgwYhz
         80DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YFx2eeL+mMfvTTf1lfSUrY023GFsFEPvhm+wP8s61nE=;
        b=Zq9vMaMnt0r1Mb0pZZf5arDjSh2bU21qyh58/Ot5UuEgujhraTgOlH5d3TGsvLhaIi
         DC0OQeRB/7PtdQ/xDfqQS1Sbzsd8kM1LYSNMIHBI0n7JI71DOt0NMeaByc49OsnPkE/5
         LwkCPSmp1oK8MsJJMjzTqdJK3L0bBo7jqiINoc36LkAV3q8HPbw49no2GPdFXyd8nYUK
         d/+upvkKAf+kYGZfR38/1uEDlRDp3b9B05QJmsig/zOmxoJ28vSn7KB1BGu69QhcT4P+
         CV0dmiz7rln8QAwofXibhD5KLJHTGGL36FTUwuxD77e7w3YXz9sckpExOeWC2QdFeD2V
         ogFw==
X-Gm-Message-State: APjAAAVVykk0D4PTTfjglRse0FknqAlabmE5ECCBx7jrGNZyYFd5KEbL
        JzZ4Lr9d+qg8B3UyrYL+5AA=
X-Google-Smtp-Source: APXvYqz0RhGoHF4qhZt0cmp90qwcWKRuRuKFQWCZVCoKkL/hxwYPB5yhwE3N4YwcmAmyN923ReuvJw==
X-Received: by 2002:a62:ed0b:: with SMTP id u11mr36347939pfh.46.1576009924303;
        Tue, 10 Dec 2019 12:32:04 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id l14sm2360727pgt.42.2019.12.10.12.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Dec 2019 12:32:03 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        srinivas.kandagatla@linaro.org, vz@mleia.com, khilman@baylibre.com,
        mripard@kernel.org, wens@csie.org,
        andriy.shevchenko@linux.intel.com, mchehab+samsung@kernel.org,
        mans@mansr.com, treding@nvidia.com, suzuki.poulose@arm.com,
        bgolaszewski@baylibre.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 4/5] nvmem: bcm-ocotp: convert to devm_platform_ioremap_resource
Date:   Tue, 10 Dec 2019 20:31:49 +0000
Message-Id: <20191210203149.7115-5-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210203149.7115-1-tiny.windzz@gmail.com>
References: <20191210203149.7115-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/nvmem/bcm-ocotp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvmem/bcm-ocotp.c b/drivers/nvmem/bcm-ocotp.c
index a8097511582a..87b7198a7676 100644
--- a/drivers/nvmem/bcm-ocotp.c
+++ b/drivers/nvmem/bcm-ocotp.c
@@ -254,7 +254,6 @@ MODULE_DEVICE_TABLE(acpi, bcm_otpc_acpi_ids);
 static int bcm_otpc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	struct otpc_priv *priv;
 	struct nvmem_device *nvmem;
 	int err;
@@ -269,8 +268,7 @@ static int bcm_otpc_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	/* Get OTP base address register. */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(dev, res);
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base)) {
 		dev_err(dev, "unable to map I/O memory\n");
 		return PTR_ERR(priv->base);
-- 
2.17.1

