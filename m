Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A1EC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2647A2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qAbxj/zI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfKRLlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:41:06 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45081 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfKRLlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:41:05 -0500
Received: by mail-pl1-f195.google.com with SMTP id w7so9647288plz.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uMmNWssOJlXbtofRR2kOKtfa7UxH0Ox6Pxi8KF9bxWY=;
        b=qAbxj/zIvkWlxT5u0mKDsMBil9jocSm3LCCd8FO0IcGNqyTmQ1XWHFGVAaLkzH3/cO
         j+FzzcK8AbDUDyIdFjZouNA8sWKs3Sy5LqPjEdWPU+UtmT/ZSztXmVbwIZiRfUYH1WU3
         4snZJ4bTdVT4Ac/TsILCF90eQXpAqYVOFgh4nxvTTPlqRgSnPVA/0qksjrq4dgFXg3aM
         51uGbkS4k+WiHODUJhHsN8sQYw02vqQff13CcWfadwaFpmVTEL3jhaEg9T+nRXWpfWpZ
         NiX4bT8JOdQYb7x9w9R73Ga/QgQftA6h2/prthwToVdET5WhBBam1nbJeRpiMu6T+EAC
         g1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uMmNWssOJlXbtofRR2kOKtfa7UxH0Ox6Pxi8KF9bxWY=;
        b=Dnl7oftMnIKOXtUZD0xcr+XWZmbJBsqzEHgMDNBIMHaiLR4HV7GrW7KksvRPrFDr7N
         E9KpM6hfY7w3hHo9IPVLEdj+utt2c/YQI7dvJjZkyfftpEjLeGbhK49BAX6Lq6JNO325
         1vtTewIo3fMLHrZKSlabBbltaFs6bkxQKTtEGKsQlSoSzUAk0WB7NQprHvzLN9W2C5wW
         CPm/vMm/jspGLaTF60O17AkHHttulxMVj/tNRyoI7qtlhZm8lDh6FK8PfadONGbC442d
         PfhwktCO9D7eo7m5pkoBsFgrt89zaxHSJ2Y9rI8xhH8JXwWbPbEmLUrNGBz+rftfdmg+
         Bo/g==
X-Gm-Message-State: APjAAAXQKHAknm0HkKsQA9xFCTL1SpCEDPjUQXZHwt+TSlYSb/HhVl+x
        AtihCMvRxT9XVHp8+GAylcY=
X-Google-Smtp-Source: APXvYqxLmHlJWm4W4/DvOEwpANoTCezLffx5/q4/+H0m4YNEERwIbCfFlxtui08nOnOnuXvGkolfzA==
X-Received: by 2002:a17:90a:f013:: with SMTP id bt19mr38840524pjb.16.1574077265326;
        Mon, 18 Nov 2019 03:41:05 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id a21sm19124492pjv.20.2019.11.18.03.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:41:04 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] mfd: tps65010: add missed gpiochip_remove
Date:   Mon, 18 Nov 2019 19:40:56 +0800
Message-Id: <20191118114056.25552-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to call gpiochip_remove to match gpiochip_add_data
in probe.
Add the missed call to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/mfd/tps65010.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/tps65010.c b/drivers/mfd/tps65010.c
index 65fcc58c02da..f73abba7be51 100644
--- a/drivers/mfd/tps65010.c
+++ b/drivers/mfd/tps65010.c
@@ -513,6 +513,7 @@ static int tps65010_remove(struct i2c_client *client)
 			dev_dbg(&client->dev, "board %s %s err %d\n",
 				"teardown", client->name, status);
 	}
+	gpiochip_remove(&tps->chip);
 	if (client->irq > 0)
 		free_irq(client->irq, tps);
 	cancel_delayed_work_sync(&tps->work);
-- 
2.24.0

