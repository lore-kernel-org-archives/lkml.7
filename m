Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B582CCA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B545222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGDqicuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410237AbfJRNNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:13:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46309 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbfJRNNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:13:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id e15so3349443pgu.13;
        Fri, 18 Oct 2019 06:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hULzerLYG/gcRIJMPWxpg7FxjyhoxEiB2hYB8bieHL8=;
        b=fGDqicuc+QPDMddr7IShi196Ot2soVvfxejuv4rrVhvzoHa3CwXmQkD9XtnyRmqavi
         OuRrKjXc14dWuv/D4tn1EJZj2uJHqC4AoyYZJIi55Rh+9Tkedr0qJbAZXxF6nTl3DYe6
         N8/Is6ep9/0jxJrXYxbJyC+p2tajR51viaJAa4ej2yYBC/1OjShpTEyC0/3OG/+HxVHN
         tehT4bwNs8FBrl4T8ZUQI2epb5rgyM4b/nhR1NQPnvbJhUmMUtyNBSpn0bNWBFCBCln/
         RH33LMePj+DRGNbexZCyCjHR8PWsPGQu1kwSV/pAdicex7/seIMCnWF8KcA9C5fdbYod
         Sj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hULzerLYG/gcRIJMPWxpg7FxjyhoxEiB2hYB8bieHL8=;
        b=MHuCkApHBo1CnJQDim/nr7fdfsM7qMBZxDU+RAKZUthw23vTXG50F3h78zqjX2z4Te
         0ys/6JML2WshgwWi0m65Z6HqhrTzEXN7qaToqDV6BRXkoKKmD4utOfY19E6sldSqOU15
         QUiyh1F+Oe+nrwhLaTQ7Tp6Jse6zu0U7BdWFq2vVO8uZyq26iLTSWaZFm7ad5iUxfaWu
         Z90Ff52cKmKiB1ivrisQT+1k+GoXjrtq3MjEBipilNwBPhLP0Jp0oSqtre8LcbX3/x8T
         vziyXpbS9i7USIBPD73t21kTMDihWHFam1/TlXkY4MXFrZHBNZfCkYeh82x2CVwPjWUR
         0d1A==
X-Gm-Message-State: APjAAAUYZM+xdpAYRZK4K2NxCwjeZKJ8EsVZtt/uaA4+LZzphrSVkpEt
        3EJz3J+ZeJpArpRNi11SMsk=
X-Google-Smtp-Source: APXvYqxJQreCnPuShoe0YBOWfKU6B6vaxEAoSMVug4Mfi8Rjc3+0lpKksGSi9yh28irqzpgFjNkhog==
X-Received: by 2002:a63:1c03:: with SMTP id c3mr9866955pgc.198.1571404428261;
        Fri, 18 Oct 2019 06:13:48 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id ce16sm6307205pjb.29.2019.10.18.06.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 06:13:47 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] mmc: renesas_sdhi: add checks for pinctrl_lookup_state
Date:   Fri, 18 Oct 2019 21:13:38 +0800
Message-Id: <20191018131338.11713-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

renesas_sdhi_probe misses checks for pinctrl_lookup_state and may miss
failures.
Add checks for them to fix the problem.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index d4ada5cca2d1..dc5ad6632df3 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -694,8 +694,13 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (!IS_ERR(priv->pinctrl)) {
 		priv->pins_default = pinctrl_lookup_state(priv->pinctrl,
 						PINCTRL_STATE_DEFAULT);
+		if (IS_ERR(priv->pins_default))
+			return PTR_ERR(priv->pins_default);
+
 		priv->pins_uhs = pinctrl_lookup_state(priv->pinctrl,
 						"state_uhs");
+		if (IS_ERR(priv->pins_uhs))
+			return PTR_ERR(priv->pins_uhs);
 	}
 
 	host = tmio_mmc_host_alloc(pdev, mmc_data);
-- 
2.20.1

