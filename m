Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFF7C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED90B208E3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cBf5XbKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfFDR3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 13:29:05 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46840 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfFDR3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:29:04 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so6870373pls.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 10:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mFo+Cml7JxiPey2gwmiRmH8tPb+Deo/oS3silL2yxZc=;
        b=cBf5XbKESWpXtgyIzi/8h+k25RwP+X0uA6/LU0BccXujypKyhJkbIKEYGQd9tcfPNs
         W4vSpAt8axOiZd5j3jvEjzXC79+UULFH5sAYlOVAyzP3Y2GzclNlGnuY1LdnmSKSXRgT
         3oHdfwDdRi7oMHldyCnZX6D/9a15qwBJmqK9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mFo+Cml7JxiPey2gwmiRmH8tPb+Deo/oS3silL2yxZc=;
        b=Xe98NwmP6Qa3LVnmEkPKN5hlECWSVhI0PL+E0BFGHII4GWYAXyFVwjDzknIO2WvOnn
         c2ajHsaN55X7uvq4y2V1flmh73cWSO09++M92EsFUkVm9+0S8Y5nSZ7cdfnOl55DyqZc
         mq88sz11qg+VBBgHkoYX5ZrKwJuqnFCfqhj67T+omwpM5CyFUmLNijHG91GZLvNmCWMb
         ntjSC8COFwdFfDLK8YatJzn0jez6oFCV5/SZAxH3T4vnysmkQpsIiUnPWbaxp+Bsdepp
         OH2F/ncAhZRagpM5ltK7ifFEssNO5moyLjaRJMCfsoibKPpkqKBz10unwP3k4pq5OxF+
         BtQA==
X-Gm-Message-State: APjAAAVZxFA6B6e/EYYQ/xcYam8gdM+gBXsy6pbG/XaN1tWJ/WD0aFdf
        ZKx9VJDd1NKncXh0MjBx8rGAVA==
X-Google-Smtp-Source: APXvYqzPO4ICaqAPtnx7zJzFCLLGLjyR8STtZCGEnKZqvBb6BI3ZWdE7H0kogepUqmM0OHWQkgdnQw==
X-Received: by 2002:a17:902:9a06:: with SMTP id v6mr21601217plp.71.1559669344327;
        Tue, 04 Jun 2019 10:29:04 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id b128sm13591829pfa.165.2019.06.04.10.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 10:29:03 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ganapathi Bhat <gbhat@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] mwifiex: drop 'set_consistent_dma_mask' log message
Date:   Tue,  4 Jun 2019 10:28:58 -0700
Message-Id: <20190604172858.107084-1-briannorris@chromium.org>
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

