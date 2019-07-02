Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9C6C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321A221841
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUh0QyIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfGBH6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:58:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40086 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfGBH6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:58:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so8730543pla.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fIdmtLJlrrpeUtIRkLh8zkIrXWWZJ4m0bJVTTnkJAG0=;
        b=WUh0QyIqmMKE4tIEmG9dJcKCtZaF99MUu2RR4WGl0Prccvdet07413QO849al2S+Qt
         0CC4O0Ym3k/y39GBYT6w3jxkATdiWnnNgT0hQHo9kBX4S0ew52HLUjDVRzW9gEc53HUH
         I7BhYcTan5X5jMV2RlVZU2P5CLEtXrAFFkkhxWrD1Q+mq93vzF35iJmoj7SFWK53XyaL
         0V3b1gaAtZBbuF48uf33gCFkExaflloZcY99ZmFkVIAQwICaAZfEbGUYfBV4H5EkZ87k
         nDUPjN+q1GFpKjOqSZprIlEn7nLrwLQ68V2vQeVDn8vkVNhTeHe1lwuj+AMpVFFD1UnJ
         ZPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fIdmtLJlrrpeUtIRkLh8zkIrXWWZJ4m0bJVTTnkJAG0=;
        b=AqCcuy8IDLmD5PtawsE6PiS5dlYnVdUlFpyFRxWD9WsspbBu7xenUy4W2eKCtNqi/S
         WzdokPaiocs8ioptnpLuRp7xBycyAk0V8YsuFR3bcb+QAsUoODOKw+6yKx5VEfeenaN0
         7oTNSejpt28BxvgyEQvqFZqOSdYSTk92dSLxWTIKtPwKumoBa4wKdUZ6A6VFQin43WyX
         yH3NsTpgEipm9gI8GJnNmKoaAXTxUO6PtooSyb+yg2jDmH281WuA+Uj22UKefQs1/ef1
         h2DhQLym8qRr7s1PEnrpDA9vM2TYFWkLby7QIIJT8FLUSYLB+Nw6nGmgkXiMFgKim7M1
         q0Hg==
X-Gm-Message-State: APjAAAWHKw1BqsePypjqUIxkTNtjKdr/CCYx/XkX6gqt3rA6w+CdA1Cp
        giD2kNkvDUazfDEdC/aAEFwyRFAtPLY=
X-Google-Smtp-Source: APXvYqxw3yuRLCgR316WWRVqiY4UKzT5jBNlTNZKq/n3jZD9zJ8lFsUstFq0nlZQWREx1Hmc47RgKg==
X-Received: by 2002:a17:902:76c3:: with SMTP id j3mr32772534plt.116.1562054328692;
        Tue, 02 Jul 2019 00:58:48 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id h14sm14066604pfq.22.2019.07.02.00.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 00:58:48 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 15/27] net: use zeroing allocator rather than allocator followed by memset zero
Date:   Tue,  2 Jul 2019 15:58:42 +0800
Message-Id: <20190702075842.24212-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace allocator followed by memset with 0 with zeroing allocator.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Resend

 drivers/net/eql.c                                       | 3 +--
 drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c | 4 +---
 drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c | 4 +---
 drivers/net/ethernet/mellanox/mlx4/en_rx.c              | 3 +--
 4 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/eql.c b/drivers/net/eql.c
index 74263f8efe1a..2f101a6036e6 100644
--- a/drivers/net/eql.c
+++ b/drivers/net/eql.c
@@ -419,14 +419,13 @@ static int eql_enslave(struct net_device *master_dev, slaving_request_t __user *
 	if ((master_dev->flags & IFF_UP) == IFF_UP) {
 		/* slave is not a master & not already a slave: */
 		if (!eql_is_master(slave_dev) && !eql_is_slave(slave_dev)) {
-			slave_t *s = kmalloc(sizeof(*s), GFP_KERNEL);
+			slave_t *s = kzalloc(sizeof(*s), GFP_KERNEL);
 			equalizer_t *eql = netdev_priv(master_dev);
 			int ret;
 
 			if (!s)
 				return -ENOMEM;
 
-			memset(s, 0, sizeof(*s));
 			s->dev = slave_dev;
 			s->priority = srq.priority;
 			s->priority_bps = srq.priority;
diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
index 43d11c38b38a..cf3835da32c8 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
@@ -719,12 +719,10 @@ static int cn23xx_setup_pf_mbox(struct octeon_device *oct)
 	for (i = 0; i < oct->sriov_info.max_vfs; i++) {
 		q_no = i * oct->sriov_info.rings_per_vf;
 
-		mbox = vmalloc(sizeof(*mbox));
+		mbox = vzalloc(sizeof(*mbox));
 		if (!mbox)
 			goto free_mbox;
 
-		memset(mbox, 0, sizeof(struct octeon_mbox));
-
 		spin_lock_init(&mbox->lock);
 
 		mbox->oct_dev = oct;
diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c b/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
index fda49404968c..b3bd2767d3dd 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
@@ -279,12 +279,10 @@ static int cn23xx_setup_vf_mbox(struct octeon_device *oct)
 {
 	struct octeon_mbox *mbox = NULL;
 
-	mbox = vmalloc(sizeof(*mbox));
+	mbox = vzalloc(sizeof(*mbox));
 	if (!mbox)
 		return 1;
 
-	memset(mbox, 0, sizeof(struct octeon_mbox));
-
 	spin_lock_init(&mbox->lock);
 
 	mbox->oct_dev = oct;
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index 6c01314e87b0..f1dff5c47676 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -1062,7 +1062,7 @@ static int mlx4_en_config_rss_qp(struct mlx4_en_priv *priv, int qpn,
 	struct mlx4_qp_context *context;
 	int err = 0;
 
-	context = kmalloc(sizeof(*context), GFP_KERNEL);
+	context = kzalloc(sizeof(*context), GFP_KERNEL);
 	if (!context)
 		return -ENOMEM;
 
@@ -1073,7 +1073,6 @@ static int mlx4_en_config_rss_qp(struct mlx4_en_priv *priv, int qpn,
 	}
 	qp->event = mlx4_en_sqp_event;
 
-	memset(context, 0, sizeof(*context));
 	mlx4_en_fill_qp_context(priv, ring->actual_size, ring->stride, 0, 0,
 				qpn, ring->cqn, -1, context);
 	context->db_rec_addr = cpu_to_be64(ring->wqres.db.dma);
-- 
2.11.0

