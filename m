Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFF4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FBF2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="RVCPr9MF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfCKFxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 01:53:43 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:38408 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfCKFxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 01:53:43 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 290E2976
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 05:53:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0gD9nJDdXn8F for <linux-kernel@vger.kernel.org>;
        Mon, 11 Mar 2019 00:53:42 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id EDEEF7AD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 00:53:41 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id x87so10077309ita.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 22:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jhZX/CshQpUKOEYtck7KT65H6yPuUObxY0xLJgwH7KA=;
        b=RVCPr9MF7bx/Mqg8zLOIQYoePEPusNDj5xvSbIvQ0tiosE9cANwlTzpKd8ZQo9YoUj
         ZgbqWUm/t2t3abXMpD0RYIytKsTkdDSTWzqolJLvlo7R3T7XG/OvwilT0gSpTwfztbIM
         Q8BVj51YffyHGJjS5+Rd/1BfmEjTkMiMXujhQDM5h91NskCqSlrPIW6pj0DJxx63fwbl
         kNRIuXnu8aNIgqb8kUZta2ZsK0EYKDblXYyX/GPJu9vWY/crOWqJE7j4yL69a0aVPLXi
         kYBfAgv3wPoBcftGz+AswabjT6PHI+Ky2uqEqP8xUZhOLfwwt15w2vU/G0DnCASKFwgZ
         20dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jhZX/CshQpUKOEYtck7KT65H6yPuUObxY0xLJgwH7KA=;
        b=HpwpMerRqK3Iym7fDqklh1ICruDMiaRtfXVpIwM3T9eZMvR3ErEo+DoAVRA0dFjG5M
         SnkHifZEaj+fJqPp0qXlpHZwH4K2EYmqmFrpiqmd4bHT9WWc/mS1tmJLj3bxk9/3ruHE
         HFhpSxCei/VVsQsBLWpPJACaLvmSgBzDch7NUskvIV8th5lPQVyro8kfzoOR5QTktRf8
         EbYYNcozPLDcXIXFqnffsUczWa+QgYIGqs9vSK9nxjoQfBT4O8+L2vwYIbz0DowUTakq
         ltlqhwyDlUgamAGks4g5v7//qizLgY/ODtiaX7VPxHmfbVkM0SHBdE3srpqQJgwjDnP0
         ysew==
X-Gm-Message-State: APjAAAXMrm0v4tb8utRGOp82vx9rgiBjPNZHwKSE9R2IdsGk2lcHUoOs
        6o1MEAJox//mLc86OK7q8+vAmTM/h8Bz6iYGrfv8zRFhtVgRmaC1VTxE2Ue2/monOmJDpvMqJr5
        pZZnbOiMMVHBKz6jSQT9FeweQjHz5
X-Received: by 2002:a24:f6c6:: with SMTP id u189mr14298054ith.6.1552283621188;
        Sun, 10 Mar 2019 22:53:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx5fRQlVHDDIfFvExXZYe3326nvt4u8G/RUVUDLDrj9GhHr4Su6OvBZOfdt1tVKzffRZ/jCaA==
X-Received: by 2002:a24:f6c6:: with SMTP id u189mr14298044ith.6.1552283620964;
        Sun, 10 Mar 2019 22:53:40 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id c25sm1937701ioa.75.2019.03.10.22.53.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 22:53:40 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc_spi: add a status check for spi_sync_locked
Date:   Mon, 11 Mar 2019 00:53:33 -0500
Message-Id: <20190311055334.13670-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case spi_sync_locked fails, the fix reports the error and
returns the error code upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/mmc/host/mmc_spi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 1b1498805972..a3533935e282 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -819,6 +819,10 @@ mmc_spi_readblock(struct mmc_spi_host *host, struct spi_transfer *t,
 	}
 
 	status = spi_sync_locked(spi, &host->m);
+	if (status < 0) {
+		dev_dbg(&spi->dev, "read error %d\n", status);
+		return status;
+	}
 
 	if (host->dma_dev) {
 		dma_sync_single_for_cpu(host->dma_dev,
-- 
2.17.1

