Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550C5C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CA02146E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="aPR/75ic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504362AbfIXJnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 05:43:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42642 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfIXJnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 05:43:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id z12so995193pgp.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 02:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rIHPogPc/o59rHSt2l9XbYMbKfUpR3e59gO3GQ/onCQ=;
        b=aPR/75icPGm6xIHo1YTPQvp9lqYOOOfvk5TERkZNRmdFPrI+fSmjOMd2fTIJOiQG5d
         rnfBnfzy55NuxKZz8sbMOn46X74IGCOtRxAzjU1Web4A7g7Z96ZuQwZjQPRu60RCyxga
         DQIh8j8l6leABrCiURHZm2sugLqHPhicL7TJbIukzEn+GHRP33R44zwTFQxGvn0qlAJy
         v13b36qwQLk95NmwEa/mGSbOtXtjn019p2QNXQ8i5y/3Pfhu9Mu7H9lVcut76rYvei5/
         HuA3tuy8XFfRDbbnLGVsOrdfqotCoBKriAmc0O+sSz9H0GlVnArOtpnriCGbpWJ/BRs4
         +qgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rIHPogPc/o59rHSt2l9XbYMbKfUpR3e59gO3GQ/onCQ=;
        b=XkhNaolKx+/DsXizCyKXTePQCAEJ4+99XSZv4skOXMQ6dwvm5bcfhlMSqikDITDEP3
         OUfpNm+nZt2QGZ7NzBrScBQ+4qvnpYO5x2zP33fa1NcxXH7YaBBNjOFZwjsQNh3ue30Z
         UZWWl71xBrOU1BZqmgypK9Ik2/nSdYuEXxy+PI+90msJUKPrmr19ST6f3O4W2SzLevFE
         1dku15Q6jeRDMRHJe4xOU5C0wTHS4nYGp1Nif0uRJqaxSZfmKJyezP6/GA9f8llxA6R1
         7lIEdyX3y2Qehbp+2yLSOt/H9Fgh7YeOEdqPyo95IVbvgv7KSVXcmaCHAyRcmBA2/S6s
         b67Q==
X-Gm-Message-State: APjAAAVEn4F4QVDNKC2iVaP02s9FnYwaAuxtRop1+uwWuiQuh6/W6P8z
        o6eu/FAchxgfrsydunDDI541cA==
X-Google-Smtp-Source: APXvYqw573NEC4ww2bP389KiYOxULpT0MuqvZXde9Af08N+ecpZLzb2zyyNU2c6HiCB5ewdNh4PujA==
X-Received: by 2002:a05:6a00:8c:: with SMTP id c12mr2260846pfj.200.1569318231135;
        Tue, 24 Sep 2019 02:43:51 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id g202sm2481746pfb.155.2019.09.24.02.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 02:43:50 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] nvme: Add quirk for Kingston NVME SSD running FW E8FK11.T
Date:   Tue, 24 Sep 2019 17:42:41 +0800
Message-Id: <20190924094240.5975-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kingston NVME SSD with firmware version E8FK11.T has no interrupt after
resume with actions related to suspend to idle. This patch applied
NVME_QUIRK_SIMPLE_SUSPEND quirk to fix this issue.

Fixes: d916b1be94b6 ("nvme-pci: use host managed power state for suspend")
Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=204887
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 drivers/nvme/host/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1ede1763a5ee..84fe3c4059a2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2298,6 +2298,16 @@ static const struct nvme_core_quirk_entry core_quirks[] = {
 		.vid = 0x14a4,
 		.fr = "22301111",
 		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
+	},
+	{
+		/*
+		 * This Kingston E8FK11.T firmware version has no interrupt
+		 * after resume with actions related to suspend to idle
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=204887
+		 */
+		.vid = 0x2646,
+		.fr = "E8FK11.T",
+		.quirks = NVME_QUIRK_SIMPLE_SUSPEND,
 	}
 };
 
-- 
2.20.1

