Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30A0C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 17:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8516520665
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 17:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJl5bfEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfGIR2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 13:28:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46256 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfGIR2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 13:28:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id i8so9772314pgm.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 10:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bzkKqUk15jLQrEfYInm22zoAV7LnCW6U344yV071lSE=;
        b=GJl5bfEy9e9YnFoBVdvkrsSluu4briySpv38RvlBMBknz3J8vxF0HR62lpTbtp9+Z/
         X4jgJxgT5T+QEBjAe+yeZQNs+Igd53Wz6Hdx144cQmhpP0h96WMChKulYZ6NwaXAJCH1
         2N4dvbJNEvcyVn4Omn0Kpie/ylsm+58vb8/0A3XxtOdHuXAUKjJ9TkrDt+6aRW/AgBqg
         HgT4fZOR2ZhwBaS9IclYx4XBz96jua4Yzrvd8Ee0S7VxoFO23M6xGgAfnn+eBU1zmfbW
         6TcZkWMfXMV5WIq4aW1CdNd3483wXMXcq0PWFUaYlgDYcUwCw7+q1F7w/+uqhVICKNRd
         xlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bzkKqUk15jLQrEfYInm22zoAV7LnCW6U344yV071lSE=;
        b=O7lpcDccfvygdltbcQ2wZ9ngWrJ1H2wVv20g7465YYSZAuVsHAMEQA+O4e6g6mOfyw
         cnc5VHGgSPZQcxY3QWcL/q00DJD6Bxm3k5YlHt5AHExHzT/UP5tmafDdkpkEhYKGjmwS
         foqbaN2wBTZdyZyXgLcyUwtB0+C1BpEhPfRZiFvvcihLrT4jAHKATujCacbafAddIHHw
         ofE0oGWjRwTXCSfSCSHb7bTji/OPm8zaK2RCW2ExoXygVTkM1Y9RhKLLkxznG31m+VWk
         BYM5UIc/uHcK6If/ypHg18YAXL6BJ2uHsV0VakKBRGnoWKgrCvg+GIbNN9CEeVIDaYep
         u70A==
X-Gm-Message-State: APjAAAWkXnz1CxXpTZIb88lyjukrybT88YLSwxAUHGzSjf5oIXGS7o22
        GWJTosuTb4iNSOYpW+6lQVo=
X-Google-Smtp-Source: APXvYqzbDrWUOoVaB4ZOiaFytDycmlBjlrY5pweLXs0yXvcAr2UGniO6mqF2mEeEyzv54uIn1C1mKg==
X-Received: by 2002:a17:90a:a489:: with SMTP id z9mr1364690pjp.24.1562693333402;
        Tue, 09 Jul 2019 10:28:53 -0700 (PDT)
Received: from localhost.localdomain ([110.227.64.207])
        by smtp.gmail.com with ESMTPSA id t2sm18788461pgo.61.2019.07.09.10.28.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 10:28:52 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     jassisinghbrar@gmail.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] mailbox: zynqmp-ipi-mailbox: Add of_node_put() before goto
Date:   Tue,  9 Jul 2019 22:58:41 +0530
Message-Id: <20190709172841.13769-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each iteration of for_each_available_child_of_node puts the previous
node, but in the case of a goto from the middle of the loop, there is
no put, thus causing a memory leak. Hence add an of_node_put before the
goto.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 86887c9a349a..bd80d4c10ec2 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -661,6 +661,7 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(dev, "failed to probe subdev.\n");
 			ret = -EINVAL;
+			of_node_put(nc);
 			goto free_mbox_dev;
 		}
 		mbox++;
-- 
2.19.1

