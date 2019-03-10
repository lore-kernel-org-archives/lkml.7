Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD38C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 07:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B942E207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 07:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="aKLFTBO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbfCJHxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 03:53:16 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:38474 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfCJHxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 03:53:15 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 052FAB74
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 07:53:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GKMeaEhy_dQw for <linux-kernel@vger.kernel.org>;
        Sun, 10 Mar 2019 01:53:13 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id D04BEC00
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 01:53:13 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id k24so1667821ioa.18
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 23:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=9+d/3RmFm/YVmk9EkJcnxokw+bFW2JJa2RfH9W+dLLE=;
        b=aKLFTBO4gWYR0dausejhX7bng9Ji/nX0TYpFIIYCqTIYKmg/QaS+gfZ4UGWmiwWYLo
         ge6LPg9VUHXGVwi4seailr0HdObbqkE33apSvf0/xWY1ISHNpLn0Cgwq8OFCWg13SrgV
         B9DJohvpV5AgrkSZuyi9xnx9VXRrE+5l+fPNSarkrMJk+JU23/pNPsxCacdydQ7tyQbq
         nCP4KblC7m1cyOYT/21QHVNzAnEXgcynXBVSLxhiVHD/0OqCZQsiSCdg5zeGiQYsLM9e
         +xwluASQ1S73GDWu4bNGC42/MCE36gm9abIYLCjoi4qOGEHfZvUD24xAAmzu3v7dpgJF
         r/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9+d/3RmFm/YVmk9EkJcnxokw+bFW2JJa2RfH9W+dLLE=;
        b=GS5l/Ip8n7C/cu7wpK0+vMQU+n4EC6Y7cMXJWC6X5YP58EUtGRN/fZg+7YSoddWZWA
         WTuSzRPu1lMESB1d/829WjWyPWgIOBDUQww1EgM5pB+gcD8qFS9ik2cxpIjBa9W+XIWO
         f/FHe7W1rZoa9t+j5RiWMgKTcOHOPCgt6nY2mBVxKbWk8uthZ0u8QnFzXf3l6JAO+x1Q
         XyKyOPhmdt1K7f4CI9m/G28a8NhVj2+1rZI/gRKjhsdaWxoLbFgZw2/dlUbb6UF4eyBS
         x3ipPdBI5Qqqd/TGl4AEg4T4f9LL5Ht4X/+zfHDFAonklCoGTpfwd67oANlXeQj1u6a3
         juMw==
X-Gm-Message-State: APjAAAW+l1TAZ7E8Q6qTT2er3c7L/5j+Ef9+w+wwr+E/s8/1dR85ueKg
        wum2WkQr8cYm5A/Cm5sVXpZhm5YHYeQstocPnBlFmRKj+s05UDIYuUJnzaRiXluQJGJbkAMy+oo
        drcniFRPfzN5qhqb1U03kNMvYR+5Q
X-Received: by 2002:a24:4750:: with SMTP id t77mr14531102itb.107.1552204393346;
        Sat, 09 Mar 2019 23:53:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqyQzBKgdesRsdidCOBa2kREKB2qC+J19OjHF9fb8Xe/yCMTp6Eq3DduCVMQhzWcI8heEdM7sg==
X-Received: by 2002:a24:4750:: with SMTP id t77mr14531094itb.107.1552204393065;
        Sat, 09 Mar 2019 23:53:13 -0800 (PST)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id s10sm123342ioc.54.2019.03.09.23.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 23:53:12 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc_spi: add a status check for spi_sync_locked
Date:   Sun, 10 Mar 2019 01:53:05 -0600
Message-Id: <20190310075306.2193-1-kjlu@umn.edu>
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
index 1b1498805972..32fea585262b 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -819,6 +819,10 @@ mmc_spi_readblock(struct mmc_spi_host *host, struct spi_transfer *t,
 	}
 
 	status = spi_sync_locked(spi, &host->m);
+	if (status < 0) {
+		dev_dbg(&spi->dev, "read error %02x (%d)\n", status, status);
+		return status;
+	}
 
 	if (host->dma_dev) {
 		dma_sync_single_for_cpu(host->dma_dev,
-- 
2.17.1

