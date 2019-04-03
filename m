Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740EAC10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42AC52147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E1PpikXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfDCBS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 21:18:59 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44942 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfDCBS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 21:18:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id g12so7145829pll.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 18:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CZ2aCugsmc8waDJuDEPimClTRC9P2krhZEU6lVq0VZs=;
        b=E1PpikXxHNMNjnGc38TSD0hpJcMItN1CtSdVANbrhgXH1OD+ksvXNFNkl73oKt6IA7
         /Hxl4EMqOk0w3Z22X9oHxUv8CTHCWwSE8gG6I40Fgx0mXlqNE4tRazSAjaU7BrxFUBag
         +ReE+vTi4llDkze6WkrA1ha3DhjLUehEHJlP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CZ2aCugsmc8waDJuDEPimClTRC9P2krhZEU6lVq0VZs=;
        b=AjTgUauTLDqgqvgX9CXI99ZYoU4jbnoh92q72lEb6TRxdDziyRhhV3m/YgfjjM0O5h
         L3TDAdckgpjmRTI3k+wEpq3tSo6rJ6bCxeRzt88z/IhQ0qESjIPNn+WOvcImK6K+Y1JG
         kWVs4XsMKZbwXbFYt9c49g1lRe8dBmopLfDdKccdqmHFLfz6FxLHhvZHbXukHDljNwYo
         xsj/Jx35W/5sG8BV32yxYW0d7C06cP7GYdINVYhCrNDYSO80FsKvPWmd47wz2uyQTS5M
         ezSiyxl+YUQfuPQEH2FOJb62dDWHfGK/iW+GpHDndDjEGf9k19rjmui8mXlwEUDElKfB
         Cyig==
X-Gm-Message-State: APjAAAWFlV1fe2axz7TigfOhsMdJs4m+wBPvwmSNnuKd+Vbh4Cfwc4uG
        si/FZHJ+Nqwd4aWS1AR1Cx3tpQ==
X-Google-Smtp-Source: APXvYqxYCSpyhtVwlrgQESOuG4wMefqUWVN9VSgsuupHVfqXbtK0YHpmCTl6JW+nwzeFdPvX98glpg==
X-Received: by 2002:a17:902:b717:: with SMTP id d23mr54927144pls.260.1554254337761;
        Tue, 02 Apr 2019 18:18:57 -0700 (PDT)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 4sm19589046pfn.159.2019.04.02.18.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 18:18:57 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Michael Cheng <ccheng@broadcom.com>
Subject: [PATCH v6 3/9] i2c: iproc: Add support for more master error status
Date:   Tue,  2 Apr 2019 18:18:24 -0700
Message-Id: <20190403011830.3254-4-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403011830.3254-1-ray.jui@broadcom.com>
References: <20190403011830.3254-1-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Cheng <ccheng@broadcom.com>

Add support for more master error status including FIFO underrun and RX
FIFO full

Signed-off-by: Michael Cheng <ccheng@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 915c1b5aafd8..d64876cfa11c 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -73,6 +73,8 @@
 #define M_CMD_STATUS_NACK_ADDR       0x2
 #define M_CMD_STATUS_NACK_DATA       0x3
 #define M_CMD_STATUS_TIMEOUT         0x4
+#define M_CMD_STATUS_FIFO_UNDERRUN   0x5
+#define M_CMD_STATUS_RX_FIFO_FULL    0x6
 #define M_CMD_PROTOCOL_SHIFT         9
 #define M_CMD_PROTOCOL_MASK          0xf
 #define M_CMD_PROTOCOL_BLK_WR        0x7
@@ -536,6 +538,14 @@ static int bcm_iproc_i2c_check_status(struct bcm_iproc_i2c_dev *iproc_i2c,
 		dev_dbg(iproc_i2c->device, "bus timeout\n");
 		return -ETIMEDOUT;
 
+	case M_CMD_STATUS_FIFO_UNDERRUN:
+		dev_dbg(iproc_i2c->device, "FIFO under-run\n");
+		return -ENXIO;
+
+	case M_CMD_STATUS_RX_FIFO_FULL:
+		dev_dbg(iproc_i2c->device, "RX FIFO full\n");
+		return -ETIMEDOUT;
+
 	default:
 		dev_dbg(iproc_i2c->device, "unknown error code=%d\n", val);
 
-- 
2.17.1

