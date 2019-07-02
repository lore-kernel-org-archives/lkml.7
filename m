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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAD7C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C82A2183F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqGsXPoy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfGBH50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:57:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41623 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfGBH50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:57:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id q4so5798411pgj.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DxBf1x4KjD3kDdLNieYl31u878MpzlLLLXODZ76c8GA=;
        b=DqGsXPoyBSd9cwfIVLWLCtNrnQmJ+AgC9JZrwQIEeBjtMV3J+fXxwltqy7bABGvxRY
         fN9nwcVr3wGT0uRpgDzlEGJpTuDg+7OeDnsfyC94R+nsvZJuX2PUnFxuJmvr1RKrrKhf
         Fm3KY24nxALs+pg/kz3fuR4RRxKVJSxoShs1qZW+TwJH8a2tzR+w1v0ECmhnDiUTLfUr
         t3udwDuIQLrZpQA/33kXCBLh3rSVflVW1EY8C6VBTSbAJcUFbG2v38FE7vfKaXjzzyji
         5u5Mkbsr/7tBmqvR5Ug34zVTvmnwpnNZAIedbtDRLqbZo3XKCAAHXzKKbFEenu7DO/oK
         /aAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DxBf1x4KjD3kDdLNieYl31u878MpzlLLLXODZ76c8GA=;
        b=R5WyyFLD620cyJ+fwjV/UcmsFlhLFVxOUFkiknQvCakQ/rFfHeF7BjFojn+a2uS+8O
         FkYULLWSXXLCx6h0aFY7fygRO7UtzR8/oiSe0UqlRDBvmcX/SKepOOBp4njuJ7pQv4Wq
         poI2px569P2RsK01WDTBFbUKWVwy/alKm8X+SlX9KqUO/FhrSZRCiECtsyvO0mEiS1Ca
         T7THV4ory5FyrlcloG2ipH9TH7KXZBi6iwevO1Bbghn8dfsQWMM56jvWPzj+r6nqDgBC
         9bNZFs+AL+CpnCeWDQOVDtn1oZARZtwxJobx6B1G+Gpu5pfYWT9sycz/E67nNV1bqMNy
         p/qw==
X-Gm-Message-State: APjAAAVJJ6fKGe6vfGT0gUGoa97Z1X4nFAWX5BRiXEvG6s9KSvmS9Joh
        EpaaVxpGZOZ5U0kvBLhLT/4QRkNB+bA=
X-Google-Smtp-Source: APXvYqzqO73LtgM19udQAIvBUSQkNh2xifo5X3Rt8WZMMuOk+VlHEk0OlfhUO7zw9yU4R32l3pdaNA==
X-Received: by 2002:a65:514c:: with SMTP id g12mr10849844pgq.76.1562054245029;
        Tue, 02 Jul 2019 00:57:25 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id x1sm1458101pjo.4.2019.07.02.00.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 00:57:24 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 05/27] crypto: remove memset after dma_alloc_coherent
Date:   Tue,  2 Jul 2019 15:57:18 +0800
Message-Id: <20190702075718.23741-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 518a2f1925c3
("dma-mapping: zero memory returned from dma_alloc_*"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Use actual commit rather than the merge commit in the commit message

 drivers/crypto/amcc/crypto4xx_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/amcc/crypto4xx_core.c b/drivers/crypto/amcc/crypto4xx_core.c
index 16d911aaa508..5e7f2e233406 100644
--- a/drivers/crypto/amcc/crypto4xx_core.c
+++ b/drivers/crypto/amcc/crypto4xx_core.c
@@ -182,7 +182,6 @@ static u32 crypto4xx_build_pdr(struct crypto4xx_device *dev)
 				  dev->pdr_pa);
 		return -ENOMEM;
 	}
-	memset(dev->pdr, 0, sizeof(struct ce_pd) * PPC4XX_NUM_PD);
 	dev->shadow_sa_pool = dma_alloc_coherent(dev->core_dev->device,
 				   sizeof(union shadow_sa_buf) * PPC4XX_NUM_PD,
 				   &dev->shadow_sa_pool_pa,
-- 
2.11.0

