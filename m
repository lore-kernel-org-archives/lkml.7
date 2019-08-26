Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73CDC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C61B22CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwcggUp0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbfHZJ6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 05:58:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51777 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730175AbfHZJ6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:58:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id k1so14872656wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 02:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AoSobNwrgWG+0xMdeEJoRWL4tyvVfhtrdTcQZJSWFp4=;
        b=rwcggUp0ra5ExtdNoVbiDmiy4Dt53pQpNoPs0MtFGQAo7WakRCplYCMXCOdOCcoqti
         E1673MoIg6Zlm9soxPvMIqmcUItrb0Jj8sPrxbTB7t4Jz4Pf+lFMBVDl02HT9QLWw23J
         xkEt90T+dHcOh38l5gI9UK45g1rw1utnq692Jzkl0vC9b0Mds9GAia+b3v9l1VKAf/6y
         eh9b0ez79hQRecvrw6tABiLy+uq2wcT5Rj75DGTwZcY0JwdNHdD5icxErkJQEO549fUg
         2RgRxtjEydyGTv3AIb5GNYEtCFvJkQDrkoVce7t5d+6rIaNVD6qWEHtbSXghauDokrGV
         JhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AoSobNwrgWG+0xMdeEJoRWL4tyvVfhtrdTcQZJSWFp4=;
        b=efmuoNw053PJOjShfQld7SsuosxouyDXWH85PCQIHcS6bcrRAace4LLgw9r8CgB6u8
         Dr8O/SS966k091K9p0Xpvo2GtrXg3mSPEkYU3OnLuEK54UtCmrdCTUS7xJ01taFvds0I
         9ZVNLV+IPEhlBUKXbHwrvZrkGeIAMjKTyxtPnb15174mwyBVOi7+55y/ByaDT125LIXj
         HW3LQuoHjwzXD9PflJpR4+gl2/Dc9b5seYQDXtSeNFRgh3CVUgt+qzamKUUOY/42aozN
         7iZNTOn++2xpAj6nttW+rvUmzEjNFpNlozoL5Rfzp0vuTa20Ubi3qGmpeLxY0mJ15PBY
         ZZnw==
X-Gm-Message-State: APjAAAX9EPNtXsKcAnYHAZ9grEChJh3RcjRxdbyqS28+ccZbQpFcUEEN
        0ZxEeByWUkzEpb+NSY5KmfE=
X-Google-Smtp-Source: APXvYqxLWn0nOJw3QcFNjUzjt1itpQYJTgzTtNmSaUiVW/YJLEPS+u/ZdiCopiCpmSdQESeQNyCDbQ==
X-Received: by 2002:a05:600c:114e:: with SMTP id z14mr19782960wmz.161.1566813521900;
        Mon, 26 Aug 2019 02:58:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a58:8166:7500:a940:180f:b044:ac12])
        by smtp.gmail.com with ESMTPSA id 24sm11025551wmf.10.2019.08.26.02.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 02:58:41 -0700 (PDT)
From:   Ilie Halip <ilie.halip@gmail.com>
To:     clang-built-linux@googlegroups.com
Cc:     Ilie Halip <ilie.halip@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bus: imx-weim: remove __init from 2 functions
Date:   Mon, 26 Aug 2019 12:58:28 +0300
Message-Id: <20190826095828.8948-1-ilie.halip@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous commit removed __init from weim_probe(), but this attribute is
still present for other functions called from it. Thus, these warnings
are triggered:
    WARNING: Section mismatch in reference from the function weim_probe() to the function .init.text:imx_weim_gpr_setup()
    WARNING: Section mismatch in reference from the function weim_probe() to the function .init.text:weim_timing_setup()

Remove the __init attribute from these functions as well, since they
don't seem to be used anywhere else.

Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: clang-built-linux@googlegroups.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/bus/imx-weim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 79af0c27f5a3..d82e8c00523d 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -76,7 +76,7 @@ static const struct of_device_id weim_id_table[] = {
 };
 MODULE_DEVICE_TABLE(of, weim_id_table);
 
-static int __init imx_weim_gpr_setup(struct platform_device *pdev)
+static int imx_weim_gpr_setup(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct property *prop;
@@ -126,7 +126,7 @@ static int __init imx_weim_gpr_setup(struct platform_device *pdev)
 }
 
 /* Parse and set the timing for this device. */
-static int __init weim_timing_setup(struct device *dev,
+static int weim_timing_setup(struct device *dev,
 				    struct device_node *np, void __iomem *base,
 				    const struct imx_weim_devtype *devtype,
 				    struct cs_timing_state *ts)
-- 
2.17.1

