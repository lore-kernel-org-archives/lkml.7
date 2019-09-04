Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0955FC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03FB207E0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPGrtlHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfIDE6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 00:58:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41693 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfIDE6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 00:58:03 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so9013243pls.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 21:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yt52QxN/vO0A7NTS6kceW8E28EXkOyPFe1Yaki9MZSs=;
        b=YPGrtlHrwYcEs5ATgzZ2d2zHJ1ZGj4cLPhbWIavyegC13Kivz7vQajPA6wyN6XkLeq
         uoPkVRH2+DIPlg8WdDVRpEczbVM5fvOtACdo5XKpe39hrSSqFbf4sIzPtWXskSBUdrwW
         kjjrEVjw9L0wLTDsnvoyr1QJ8kVSTN5ZkgTpsCuF6MNsD88ujMTihNOSfOHenQ+m1+dU
         81rQtaDjlPU5DX4geLkO5y1HwbfmR+gOuHy+rcqKOsG9U6ekQayIXQ8zIDJmSbkzKKUA
         2hF9grE99GjhGLmUKsGy5fHIChBEe6ADn2SJ/Zs90mMFbHOnnJnpK04Urqalo4uPIyAD
         O3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yt52QxN/vO0A7NTS6kceW8E28EXkOyPFe1Yaki9MZSs=;
        b=fM0s7e7qF9NTNi5JcpjI3pnb6qTbyRB+28mPCmpWIlZ3j6h/3CJM9ywjHdLNbsO2kL
         MUTMaKDnLG/Zllf42sA6Bxsiiq7V9Y5ZJ6cqlaj62W9BOhGWeZiovUoscEdd/oEVaumm
         fA0orCqrJA0yZieE3al5JyRq4cwhwgUEak4xCABzXM3/CEzX6qVtbxdv+fnnTcerhlve
         NZsE4lv3btkRiNvFgzwrICJqLQNXym+SYlHy/S1XeOf++ofV+HZZwYj1JvkgJbjv1P4r
         9MZ44KLDnsq6sEnZ854k+2qibGJe/D4H0vKtTU3WJHfHqoVJZ6LchIlaOdAboNpmF6OT
         +9Hw==
X-Gm-Message-State: APjAAAW9pjrx2tqOdXD0IAeti7qu5GEXTXCj8SxSPnR9t9gxypQ5xSKk
        DJXu5iEQLfDXnDpAKGo44yhi/siUytA=
X-Google-Smtp-Source: APXvYqy3Dl7YArRgQrGvWlYLq9H9ij92I0h5BCYw6ZCkNrMWpmtZJd2NRFzdOZibKVno6T8GW/9Ehg==
X-Received: by 2002:a17:902:9349:: with SMTP id g9mr38258119plp.262.1567573082347;
        Tue, 03 Sep 2019 21:58:02 -0700 (PDT)
Received: from Marcuss-MacBook-Pro.local.net (c-24-7-60-112.hsd1.ca.comcast.net. [24.7.60.112])
        by smtp.gmail.com with ESMTPSA id c23sm17071503pgj.62.2019.09.03.21.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Sep 2019 21:58:01 -0700 (PDT)
From:   Marcus Eagan <marcuseagan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     marcussorealheis <marcuseagan@gmail.com>
Subject: [PATCH] remove the acheive sp error
Date:   Tue,  3 Sep 2019 21:57:58 -0700
Message-Id: <20190904045758.24383-1-marcuseagan@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: marcussorealheis <marcuseagan@gmail.com>

---
 drivers/clk/rockchip/clk-cpu.c                  | 2 +-
 drivers/clk/samsung/clk-cpu.c                   | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 2 +-
 fs/xfs/xfs_inode.c                              | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk-cpu.c b/drivers/clk/rockchip/clk-cpu.c
index 0dc478a19451..e5b69f281b0f 100644
--- a/drivers/clk/rockchip/clk-cpu.c
+++ b/drivers/clk/rockchip/clk-cpu.c
@@ -19,7 +19,7 @@
  * clock and the corresponding rate changes of the auxillary clocks of the CPU
  * domain. The platform clock driver provides a clock register configuration
  * for each configurable rate which is then used to program the clock hardware
- * registers to acheive a fast co-oridinated rate change for all the CPU domain
+ * registers to achieve a fast co-oridinated rate change for all the CPU domain
  * clocks.
  *
  * On a rate change request for the CPU clock, the rate change is propagated
diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
index efc4fa61fbaf..d2c0193a3930 100644
--- a/drivers/clk/samsung/clk-cpu.c
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -19,7 +19,7 @@
  * clock and the corresponding rate changes of the auxillary clocks of the CPU
  * domain. The platform clock driver provides a clock register configuration
  * for each configurable rate which is then used to program the clock hardware
- * registers to acheive a fast co-oridinated rate change for all the CPU domain
+ * registers to achieve a fast co-oridinated rate change for all the CPU domain
  * clocks.
  *
  * On a rate change request for the CPU clock, the rate change is propagated
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 310afa708831..e9c7d5e0fd93 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -185,7 +185,7 @@ void hns3_set_vector_coalesce_rl(struct hns3_enet_tqp_vector *tqp_vector,
 
 	/* this defines the configuration for RL (Interrupt Rate Limiter).
 	 * Rl defines rate of interrupts i.e. number of interrupts-per-second
-	 * GL and RL(Rate Limiter) are 2 ways to acheive interrupt coalescing
+	 * GL and RL(Rate Limiter) are 2 ways to achieve interrupt coalescing
 	 */
 
 	if (rl_reg > 0 && !tqp_vector->tx_group.coal.gl_adapt_enable &&
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 6467d5e1df2d..ab7d60174651 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2574,7 +2574,7 @@ xfs_ifree_cluster(
 		 * only using to mark the buffer as stale in the log, and to
 		 * attach stale cached inodes on it. That means it will never be
 		 * dispatched for IO. If it is, we want to know about it, and we
-		 * want it to fail. We can acheive this by adding a write
+		 * want it to fail. We can achieve this by adding a write
 		 * verifier to the buffer.
 		 */
 		bp->b_ops = &xfs_inode_buf_ops;
-- 
2.22.0

