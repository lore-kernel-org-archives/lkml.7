Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D37CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D8920578
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCPl+46h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbfKDSTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:19:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35342 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729496AbfKDSTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:19:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id 8so10116591wmo.0;
        Mon, 04 Nov 2019 10:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=crl/sUJTIYngi8fCHSniOxSSni3lgNa7iQh3Jutt6vc=;
        b=rCPl+46hCB8Mnj8qi6TYtxjg6Ezu+S1u9FI7m3WICddeN51CJeVMntsykKw9XxBwcp
         9IUdFhOkA2la4PN3vJv9GrNi7JET4iS5y265fGNnb8SHwd0GlRiqnexA6tLXX5JGwKeV
         /K1ASK6k89Obg7/lasOFryB+BWSwTgROvyS1s0aO1nPzd9LHq7NGxdLpw/ygTa/62Tpe
         9tpZ8uXwtmBQ3KKnVIDG8vANv9F6XwRO12Pw4JgIyQ/XNpy4PrPUhrQxIegc71nrMGkV
         Y3YkNNOnbDpPRDz+4OEJg0deyP0bWWL+W2iYgURBBYgFggTWefElTHO8G6qX6xdpDRzf
         +NaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=crl/sUJTIYngi8fCHSniOxSSni3lgNa7iQh3Jutt6vc=;
        b=jCri6EdDleWfsHSfFZwtHAz091bQWTx6Dp+lwz6pDuP510GUEGWUkM6B5rbMFBHLxC
         Xz7rTJAq3+MMuyLW/QMmJKPfNsviukcGYz8zXwvEhj5wnhHAu6w9Nsq/TR6Cvx64ifj+
         owhSG2iwnIrQw0VqscJ2JaFtJQDMLit+fTcYfhRzQe5JEHJ4142TMoZk01QSVyEkewH5
         SJnzOB4cwoT+RyURwHhrJYODRJCcUAZmy2VFaC5guBR3B7efciKFZl0anEnvAEXGhNHx
         hRTyRUyVpai3E7oDBOysKcouD3rf2qOi1qKwpBLC3G3qmZkLsTQYGaJVh/Ikuuk+FVPl
         TF1Q==
X-Gm-Message-State: APjAAAWi79Om+QJWZ1r57/tu6HWygJzqqiYCrRQfyyx/8eW6LN3ZTTu3
        iv+dpfJtmr97g/Z8ipXzZww=
X-Google-Smtp-Source: APXvYqyi85IXeYNlKiRU9CfS3VUsHIeGRvcoN3KGVKyN/8gCemDLZxmG2aberbhL23uSfab6ZAZFnA==
X-Received: by 2002:a1c:6a14:: with SMTP id f20mr375073wmc.110.1572891559775;
        Mon, 04 Nov 2019 10:19:19 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w8sm23127580wrr.44.2019.11.04.10.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 10:19:18 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] reset: brcmstb: Remove resource checks
Date:   Mon,  4 Nov 2019 10:15:02 -0800
Message-Id: <20191104181502.15679-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104181502.15679-1-f.fainelli@gmail.com>
References: <20191104181502.15679-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of IS_ALIGNED() is incorrect, the typical resource we pass looks
like this: start: 0x8404318, size: 0x30. When using IS_ALIGNED() we will
get the following 0x8404318 & (0x18 - 1) = 0x10 which is definitively
not equal to 0, same goes with the size. These two checks would make the
driver fail probing.

Remove the resource checks, since there should be no constraint on the
base addresse or size.

Fixes: 77750bc089e4 ("reset: Add Broadcom STB SW_INIT reset controller driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/reset/reset-brcmstb.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/reset/reset-brcmstb.c b/drivers/reset/reset-brcmstb.c
index a608f445dad6..f213264c8567 100644
--- a/drivers/reset/reset-brcmstb.c
+++ b/drivers/reset/reset-brcmstb.c
@@ -91,12 +91,6 @@ static int brcmstb_reset_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!IS_ALIGNED(res->start, SW_INIT_BANK_SIZE) ||
-	    !IS_ALIGNED(resource_size(res), SW_INIT_BANK_SIZE)) {
-		dev_err(kdev, "incorrect register range\n");
-		return -EINVAL;
-	}
-
 	priv->base = devm_ioremap_resource(kdev, res);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
-- 
2.17.1

