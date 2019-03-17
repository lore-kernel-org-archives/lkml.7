Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73288C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C59920896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngtZ1jnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfCQUAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 16:00:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42753 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbfCQT7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 15:59:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so10665183wrr.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 12:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tkN3DUc8tIrEElW+ytk2rVTc7MnrQp/XukKo9YSFNsw=;
        b=ngtZ1jnmKLE46xVoLurB6Y+PIjQc+w4ZHvI+poCrfwRO9KeCTRN2Izq2OE96S4fQOW
         vgs7DCpERKuA95OxiWT3NZYijrVY7zEWr2mhpUergydEF4vfAguD9L+V9H+e+/Dy0lLO
         DHw8t5k+RI6ymSFE9vTD9Hy9jBND96tElaBXg0o+zEmcTk60xZag38D2X7Qkvll4CqPZ
         6JeROae6LT4GQsZfOxJuDTEPvPYJJDIAi2fOzkO52ol+aMtSozDGChqngsrXO4EZKCDl
         EPOy0A/CTVpkfbI5c01zSGDgGqyYZHfVrgiKzeUCXqTIxc5RyoTdClaCootUutOEvr3U
         bc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tkN3DUc8tIrEElW+ytk2rVTc7MnrQp/XukKo9YSFNsw=;
        b=a9bP/I2zSCUc0FQ0nElXdjjNhMMLrCChd0GO98/yaq8mmIj1KPRRQBUWvZicwMW4mA
         Lh32XFBe+s4Jjz2SWewY2lsQKMvcezVP1mpAzaeUihk2lkCXNGIWU0mw1pH+ta/G4NLE
         5U7xnlZHywQm2xWMVV0fl2V/yZ7db2hUZ/8nIWqdXPrmxB29Wt+XqRNf83z50VADJPTL
         IfrBV6grKwyDAT8NFo/62xGoRsjjK0iSnngIBIEaSGMtI1sxJjfyaQv+n52RXLM0Z3l8
         VXK8Ttt4vBMWRaML0/YKdPB06gDQV9QVeAIBC60iC4/maaftLAFcLAfLkMYr+gggD1mB
         2fQQ==
X-Gm-Message-State: APjAAAXzRbtnO0g95z1/drOH/8oVWDu5eMzpimwVKzN4TBu2Xc4rl+zd
        leVHvhtKfLq34EjTUNFjPli2wYtr
X-Google-Smtp-Source: APXvYqxmKrdWuV7dqWytpYSDKZqPdLn+br0zedp0N83V7aXp4BuL8XN89nR8aIxV86R30rC62/uNYQ==
X-Received: by 2002:adf:fd01:: with SMTP id e1mr9298649wrr.204.1552852787134;
        Sun, 17 Mar 2019 12:59:47 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id z1sm7039785wrw.28.2019.03.17.12.59.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 12:59:46 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 07/15] habanalabs: ratelimit warnings at start of IOCTLs
Date:   Sun, 17 Mar 2019 21:59:19 +0200
Message-Id: <20190317195927.26238-8-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190317195927.26238-1-oded.gabbay@gmail.com>
References: <20190317195927.26238-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the start of some IOCTLs we check if the device is disabled or in reset.
If it is, we return -EBUSY and print a message to kernel log.

Because these IOCTLs can be called at very high frequency, use ratelimit
to avoid spamming the kernel log. Also use the same type of message -
dev_warn - in all the relevant IOCTLs.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_submission.c | 2 +-
 drivers/misc/habanalabs/habanalabs_ioctl.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index 19c84214a7ea..f908643f871f 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -604,7 +604,7 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 	bool need_soft_reset = false;
 
 	if (hl_device_disabled_or_in_reset(hdev)) {
-		dev_warn(hdev->dev,
+		dev_warn_ratelimited(hdev->dev,
 			"Device is %s. Can't submit new CS\n",
 			atomic_read(&hdev->in_reset) ? "in_reset" : "disabled");
 		rc = -EBUSY;
diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index 2c2739a3c5ec..19b96afc0308 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -106,7 +106,7 @@ static int hl_info_ioctl(struct hl_fpriv *hpriv, void *data)
 	int rc;
 
 	if (hl_device_disabled_or_in_reset(hdev)) {
-		dev_err(hdev->dev,
+		dev_warn_ratelimited(hdev->dev,
 			"Device is disabled or in reset. Can't execute INFO IOCTL\n");
 		return -EBUSY;
 	}
-- 
2.17.1

