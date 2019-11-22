Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1429EC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B0320658
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574452329;
	bh=jDfD+CL5wDqvqEFQmPaEED4yz67Luv316LwnHkstN0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d7u/bBjeimYbQj+m+4xxFxtWS0mxW+rjQ4NLLC3GKPLiqcBmEc/mJS3C1E6Xs+7E3
	 ku6BfZJ0e8vXJWbWSweowyDMYT7M9SgcQKlE8pgSvK1Q+in+IHiB1SPHQfZEUAtrwv
	 pLX3Wux9/0EbN0R5dVPwnLWV/fxe2/kx6XKk94do=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfKVTwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:52:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:50260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbfKVTt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 14:49:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C31120726;
        Fri, 22 Nov 2019 19:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574452196;
        bh=jDfD+CL5wDqvqEFQmPaEED4yz67Luv316LwnHkstN0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a6Uc6QRTA+6NB0Tw05cj9ECyErRGTjUMtUXO70Pnc6CFSNPEt132ZcQzZGoKB70l/
         JgP3H0UYaYs5WZ+2XgEHyA4hdHJAGpj50aRhbKKIetDDCUwc3/Nh0HZiJLfJtE3b/O
         kQl4N+ae32B4CdU7QCTaoVQImTS6IBzOKoOs4jIs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Yang <wenyang@linux.alibaba.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 20/21] i2c: core: fix use after free in of_i2c_notify
Date:   Fri, 22 Nov 2019 14:49:30 -0500
Message-Id: <20191122194931.24732-20-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122194931.24732-1-sashal@kernel.org>
References: <20191122194931.24732-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wenyang@linux.alibaba.com>

[ Upstream commit a4c2fec16f5e6a5fee4865e6e0e91e2bc2d10f37 ]

We can't use "adap->dev" after it has been freed.

Fixes: 5bf4fa7daea6 ("i2c: break out OF support into separate file")
Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index 8d474bb1dc157..17d727e0b8424 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -238,14 +238,14 @@ static int of_i2c_notify(struct notifier_block *nb, unsigned long action,
 		}
 
 		client = of_i2c_register_device(adap, rd->dn);
-		put_device(&adap->dev);
-
 		if (IS_ERR(client)) {
 			dev_err(&adap->dev, "failed to create client for '%pOF'\n",
 				 rd->dn);
+			put_device(&adap->dev);
 			of_node_clear_flag(rd->dn, OF_POPULATED);
 			return notifier_from_errno(PTR_ERR(client));
 		}
+		put_device(&adap->dev);
 		break;
 	case OF_RECONFIG_CHANGE_REMOVE:
 		/* already depopulated? */
-- 
2.20.1

