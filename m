Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14515C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7AA208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N61bh+x1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfFDR3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 13:29:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37109 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfFDR3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:29:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id 20so10758303pgr.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 10:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mFo+Cml7JxiPey2gwmiRmH8tPb+Deo/oS3silL2yxZc=;
        b=N61bh+x1YFfCBev/Zwkc8He+QGNTb342PZxDgzqdfz9pMS/l9YVL+XY0gFYs3oRDyZ
         A6bL52tlZEUDZy84tZ7bum0Q7pjZD5prpeifOqyrLG+IZfhEYwlHCQiGEH6BU3ENg7OG
         VLk+qBj3oUYR83EEE3kuQjE3DYOoxVOAUM6H4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mFo+Cml7JxiPey2gwmiRmH8tPb+Deo/oS3silL2yxZc=;
        b=UTv61itWaeyFbYJfIMtLNWAoB3RTCs/pcddaSrw4cvbqm4Jm6Lz9KHuXuKbGxF4Kyw
         2Y3Q8kbElYAv+BOf/h8Y5m6tWzelaNTyr9y2IyF0xrI6pOahcyykywW5PlUSqIc8LeT5
         KTQ1nMBl5CVXQcZT31am9BePf6iG9/Lx4xmRNryfs+AECu2EHx3e7zw0OMZugxLbenG0
         h1gEYbsw9K8PiCJbBsA76VQuC2fXZ/p0A5QKCV6yfPe1TT9Y/QtLVhBkBxATJb9Ti7l6
         Xo2t8Z/pmA7xaXPo0MjIwrQY796rwkcRrEDRG+4I7hQv6OspYU7i5vLyZCglUlyQcwRL
         ILZQ==
X-Gm-Message-State: APjAAAVCbmmnNYNasCyU2C3WbHida76CR/fVBHkdxnccTZDsrrBDvBaR
        v0qF/oP4CpSt34SodMWo6KT6Ag==
X-Google-Smtp-Source: APXvYqxa24wA9trv1+kh6Te7TMdbEl07eQtif4EI2omG8tMZ2UdPcthS6IFtPY7g6ruYWoJUIQ7Aeg==
X-Received: by 2002:a17:90a:8584:: with SMTP id m4mr38051966pjn.125.1559669353526;
        Tue, 04 Jun 2019 10:29:13 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id k3sm16185351pju.27.2019.06.04.10.29.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 10:29:12 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ganapathi Bhat <gbhat@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] mwifiex: drop 'set_consistent_dma_mask' log message
Date:   Tue,  4 Jun 2019 10:29:10 -0700
Message-Id: <20190604172910.107199-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This message is pointless.

While we're at it, include the error code in the error message, which is
not pointless.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/marvell/mwifiex/pcie.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index 3fe81b2a929a..82f58bf0fc43 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -2924,10 +2924,9 @@ static int mwifiex_init_pcie(struct mwifiex_adapter *adapter)
 
 	pci_set_master(pdev);
 
-	pr_notice("try set_consistent_dma_mask(32)\n");
 	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
 	if (ret) {
-		pr_err("set_dma_mask(32) failed\n");
+		pr_err("set_dma_mask(32) failed: %d\n", ret);
 		goto err_set_dma_mask;
 	}
 
-- 
2.22.0.rc1.311.g5d7573a151-goog

