Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53FBC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EEB2178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="crGU2R9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731998AbfKFP4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 10:56:01 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38029 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfKFP4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 10:56:01 -0500
Received: by mail-lj1-f194.google.com with SMTP id v8so11055258ljh.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 07:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Qpl59SkxVGxYRO1y4hy9vYURdogoOxolBZEq335zpV0=;
        b=crGU2R9aBYvgI4zzKv7bUfa+SWTkLwQp6yyPjoaL6tkbjuYf5Ky2/o4a7yo/q/UUzV
         MBKRcJbbSQRyYxLd6Pg0NoIVnxAi+FiKD00neMcezQYG2t5xy+BRy6DxX9ERkkQw4xjn
         HhcBt4EHaXif2TNLuNf5HP2YPobFp3mCibv/P6flxs4eex0tKWF7MIInNsyjx+AjG1Zs
         gV5B1AXA5+r95uMX6mSO+4fdyWnRzLsbRk/5WKmIOPTyXX0Q3aL29fzpyEmX0R7ePaQZ
         DwM7Tor8rWKV6+1QRPGX08LlbvGpfXU+vkYl2kR87IQwFOkMoDpxSmOjN0z9WAOJDAZ/
         Hdxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Qpl59SkxVGxYRO1y4hy9vYURdogoOxolBZEq335zpV0=;
        b=CDfSGhrr4hax8b3yzzvlop3SI1fPhx0bSowzQXGwYKpJDrRxctkuYazELjd7znUwRW
         b3BvAYrk7Pl97dow229v5F2xWKq+k02mvQtzeqbh1mkerkRQfyi7A3WtQKtGmcPOAh2W
         +wCcqCGNbuayFp89g/LbQfzEL9jDXbAf1gmOBuzpAmG0KYIo7wqAz6vc89+ujaZQOx6q
         CIlHbkDp3ECWZZ4q36nS+fuRBHyeIpK16mBcBvgFVUz6LKmlaiYlQ/vzUSctywZGYfwU
         UBr3cXyIbKiEIh0EPCthNPFxKh6TzPKiXo1aZ1THdqz5JxEHqG8xOphgewk2Bfl+r+Wc
         uWaQ==
X-Gm-Message-State: APjAAAVdCizYv9ufGxbgtls7lBpr5ZIr8ffF8tNpOfHjHbjae0QknBCY
        09dAfkxXooOS2u5xxl3UKOxP4NBZ2RQ=
X-Google-Smtp-Source: APXvYqyIDCj1EArqUS/KfCY+Ed7DLtEfID0IusRmXwjbGvjfcC5kpcSMGPxpQznGRhH1feDUSsZBdQ==
X-Received: by 2002:a2e:88c1:: with SMTP id a1mr2591237ljk.204.1573055758918;
        Wed, 06 Nov 2019 07:55:58 -0800 (PST)
Received: from jax.urgonet (h-48-83.A175.priv.bahnhof.se. [94.254.48.83])
        by smtp.gmail.com with ESMTPSA id k187sm4704895lfd.54.2019.11.06.07.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 07:55:58 -0800 (PST)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tee-dev@lists.linaro.org
Cc:     Victor Chong <victor.chong@linaro.org>,
        Jerome Forissier <jerome@forissier.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH] tee: optee: fix device enumeration error handling
Date:   Wed,  6 Nov 2019 16:55:38 +0100
Message-Id: <20191106155538.5618-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to this patch in optee_probe() when optee_enumerate_devices() was
called the struct optee was fully initialized. If
optee_enumerate_devices() returns an error optee_probe() is supposed to
clean up and free the struct optee completely, but will at this late
stage need to call optee_remove() instead. This isn't done and thus
freeing the struct optee prematurely.

With this patch the call to optee_enumerate_devices() is done after
optee_probe() has returned successfully and in case
optee_enumerate_devices() fails everything is cleaned up with a call to
optee_remove().

Fixes: c3fa24af9244 ("tee: optee: add TEE bus device enumeration support")
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/core.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 1854a3db7345..b830e0a87fba 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -643,11 +643,6 @@ static struct optee *optee_probe(struct device_node *np)
 	if (optee->sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
 		pr_info("dynamic shared memory is enabled\n");
 
-	rc = optee_enumerate_devices();
-	if (rc)
-		goto err;
-
-	pr_info("initialized driver\n");
 	return optee;
 err:
 	if (optee) {
@@ -702,9 +697,10 @@ static struct optee *optee_svc;
 
 static int __init optee_driver_init(void)
 {
-	struct device_node *fw_np;
-	struct device_node *np;
-	struct optee *optee;
+	struct device_node *fw_np = NULL;
+	struct device_node *np = NULL;
+	struct optee *optee = NULL;
+	int rc = 0;
 
 	/* Node is supposed to be below /firmware */
 	fw_np = of_find_node_by_name(NULL, "firmware");
@@ -723,6 +719,14 @@ static int __init optee_driver_init(void)
 	if (IS_ERR(optee))
 		return PTR_ERR(optee);
 
+	rc = optee_enumerate_devices();
+	if (rc) {
+		optee_remove(optee);
+		return rc;
+	}
+
+	pr_info("initialized driver\n");
+
 	optee_svc = optee;
 
 	return 0;
-- 
2.17.1

