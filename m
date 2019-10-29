Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C69CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C5021882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QEWMcBQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387476AbfJ2Lnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:43:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43138 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732187AbfJ2Lnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:43:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id n1so5814671wra.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 04:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H2CJ5u7SoLyb47H63oMSiNuFZvWZvb1TPdq7zIJAX2Q=;
        b=QEWMcBQuQdPrxlY8iVWmlO5NK7qirG7I/rEGKCjgzqZr+2kStOAgMQOOLpcCXEdCrH
         gLFpZGd1ABHlwBEB8BxPRzO3UHFR2gGn6DcaipPACK1S8OQYampSi+qAhdnlQdJqn32R
         zpFruHwfyjQCCuRnjK4wEOFaXytfLlrK1r7TykgwIFj/YWfDcfXLj1IxJpP3PHUlyKkV
         9rXRbm5rSIBRhj5TMe5a+74bJjFa8wiaqA2+3PToAwLTQGRK/Yu23dj1kHtT5D0ibiZF
         xYHMxoAvL8qPdYVmQ6az6INdUbuPBrZvZQLD/kch8XQPWsqMAPJ2OzKPoy/OOasMvg+r
         QOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H2CJ5u7SoLyb47H63oMSiNuFZvWZvb1TPdq7zIJAX2Q=;
        b=s0fBhh2ULiMX7FNy3S4wXKxQOk3G/po1P39snK77m72+8IVFY6tZfhNa4w+thRf8w7
         FhFZr1F0sa19PquIdvuqDJdt/k3XsIT9BbmHJxOutZDh7iPdVjnCtAaO0Nw+WMkDncbU
         vno1B5OuUfqYYNexVwxS/tb5iwbax91aAwM4TxTncfLFTs/uVNN6DhS4JFJGKGyLHjKp
         8q7EWlmkL/RAtGyL//6E73k6rSfo+sMsScbdmiA7/M5htdtqK2PUGtoC4bYLL1SkjrXQ
         NJe2i/+RV9VT+DN9aYgkFmwfF/BLidDK1XV8fKFSWjQIXMBBkKj+W8cyI+h9Wecp0Xkc
         1ntw==
X-Gm-Message-State: APjAAAUAVBmlj7fPZ4AZptGkZHZK95Rb73BitqfYHPQ+dtFC988KsJiV
        cKInREJcYh9z6LgEt2cJ4ZO7UA==
X-Google-Smtp-Source: APXvYqxXfxvgGbwhHQ7KAWaxfMcQB/qbTX5lVDL9LdHipKZwJ+PU0EN2cUVZBjtPgqLWjIb7dzn2vw==
X-Received: by 2002:a5d:498a:: with SMTP id r10mr20169245wrq.129.1572349413896;
        Tue, 29 Oct 2019 04:43:33 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q25sm26559864wra.3.2019.10.29.04.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 04:43:33 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Baolin Wang <baolin.wang@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 02/10] nvmem: sc27xx: Change to use devm_hwspin_lock_request_specific() to request one hwlock
Date:   Tue, 29 Oct 2019 11:42:32 +0000
Message-Id: <20191029114240.14905-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029114240.14905-1-srinivas.kandagatla@linaro.org>
References: <20191029114240.14905-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baolin Wang <baolin.wang@linaro.org>

Change to use devm_hwspin_lock_request_specific() to help to simplify the
cleanup code for drivers requesting one hwlock. Thus we can remove the
redundant sc27xx_efuse_remove() and platform_set_drvdata().

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sc27xx-efuse.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/nvmem/sc27xx-efuse.c b/drivers/nvmem/sc27xx-efuse.c
index c6ee21018d80..ab5e7e0bc3d8 100644
--- a/drivers/nvmem/sc27xx-efuse.c
+++ b/drivers/nvmem/sc27xx-efuse.c
@@ -211,7 +211,7 @@ static int sc27xx_efuse_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	efuse->hwlock = hwspin_lock_request_specific(ret);
+	efuse->hwlock = devm_hwspin_lock_request_specific(&pdev->dev, ret);
 	if (!efuse->hwlock) {
 		dev_err(&pdev->dev, "failed to request hwspinlock\n");
 		return -ENXIO;
@@ -219,7 +219,6 @@ static int sc27xx_efuse_probe(struct platform_device *pdev)
 
 	mutex_init(&efuse->mutex);
 	efuse->dev = &pdev->dev;
-	platform_set_drvdata(pdev, efuse);
 
 	econfig.stride = 1;
 	econfig.word_size = 1;
@@ -232,21 +231,12 @@ static int sc27xx_efuse_probe(struct platform_device *pdev)
 	nvmem = devm_nvmem_register(&pdev->dev, &econfig);
 	if (IS_ERR(nvmem)) {
 		dev_err(&pdev->dev, "failed to register nvmem config\n");
-		hwspin_lock_free(efuse->hwlock);
 		return PTR_ERR(nvmem);
 	}
 
 	return 0;
 }
 
-static int sc27xx_efuse_remove(struct platform_device *pdev)
-{
-	struct sc27xx_efuse *efuse = platform_get_drvdata(pdev);
-
-	hwspin_lock_free(efuse->hwlock);
-	return 0;
-}
-
 static const struct of_device_id sc27xx_efuse_of_match[] = {
 	{ .compatible = "sprd,sc2731-efuse" },
 	{ }
@@ -254,7 +244,6 @@ static const struct of_device_id sc27xx_efuse_of_match[] = {
 
 static struct platform_driver sc27xx_efuse_driver = {
 	.probe = sc27xx_efuse_probe,
-	.remove = sc27xx_efuse_remove,
 	.driver = {
 		.name = "sc27xx-efuse",
 		.of_match_table = sc27xx_efuse_of_match,
-- 
2.21.0

