Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC896C5B578
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926F3218A6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opj8ooNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfGDCgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 22:36:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38207 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfGDCgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 22:36:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id 9so2250085ple.5;
        Wed, 03 Jul 2019 19:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FPcSnC0MqTt1hmmPlgG7uvaVQM22D9/waxX/5QffJoM=;
        b=opj8ooNe96BKb0W6VPSag5leRRN3U5ElQllkv2/FvuZM2uwe0sa7aOOKOaWLzTfIu2
         zE0Uc5N/d8lQlAzRaDFphxg+8Xj9MINuiJCN96JyJy9iZdDO7IEEcnR6psEJn7PO7Hxx
         JfhjFPP91yPFqQl/kDi/zlaA+zaacs0QXXvGjT6rysfOb7j8gJ2IFaW/Crb8icGiFL1P
         NkUDrbvitcckondPqBNh8C6z87nOEEPs85aPPY+lYIXOhYM8aIzX3n1oEz8K8OuAi9pD
         5DgGzM58V3oFbNZxd6nfFj0EeZZeIfQWaWzf39TVOohgvk3FEjwusOWf6Mpq/yCuBfJY
         N5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FPcSnC0MqTt1hmmPlgG7uvaVQM22D9/waxX/5QffJoM=;
        b=aOQAlgWBwelyssevmT/ijJkg451/V1pQT4ff4vj5ki30HqJwAOggKRsSsYqF5N3TtK
         i4mfldo6kYvBamZcY9VgqM/1lJAU8B4wGu2zwv809M7F5nZIFs2HRSFQjIe80MK83kS+
         ME9CnpDtO1WLTQI2SoQURAFuSJEXNslrT4CQD5tJBfyD8NzV6CIKMZGrNSVJgjkF0laa
         3MH6XdE90Qi8ynK/3rbVLMwBrTjK0iZ2Imrbo5tMwXGk9j57RSLm9qTj+dk78ha0pQlw
         NJ++GecSxtcFIeif28zhrirSDdciaVE+RH7iqMIM8Def2s9GKvFUxcEZCNr7XHT9jzm2
         LYpg==
X-Gm-Message-State: APjAAAVVu2bbSkdNyZ2NrIMsZ0Fkh9mkpXAyQPx7x5FwrjZXj3Xp4paB
        EQ0xFBl0mFLHt0W1gCcWqQY=
X-Google-Smtp-Source: APXvYqw4+qZFH9XYR0LH05CrIhgL/jDTNm8xKvLaq7wDgBvJICsBj+jOc+b0+Jlmi8SV2LsA1lyySw==
X-Received: by 2002:a17:902:f81:: with SMTP id 1mr45614833plz.191.1562207806464;
        Wed, 03 Jul 2019 19:36:46 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id h1sm3216145pgv.93.2019.07.03.19.36.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 19:36:46 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [Patch v2 09/10] net/ethernet: using dev_get_drvdata directly
Date:   Thu,  4 Jul 2019 10:36:40 +0800
Message-Id: <20190704023640.4827-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several drivers cast a struct device pointer to a struct
platform_device pointer only to then call platform_get_drvdata().
To improve readability, these constructs can be simplified
by using dev_get_drvdata() directly.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Make the commit message more clearly.

 drivers/net/ethernet/calxeda/xgmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/calxeda/xgmac.c b/drivers/net/ethernet/calxeda/xgmac.c
index 11d4e91ea754..99f49d059414 100644
--- a/drivers/net/ethernet/calxeda/xgmac.c
+++ b/drivers/net/ethernet/calxeda/xgmac.c
@@ -1855,7 +1855,7 @@ static void xgmac_pmt(void __iomem *ioaddr, unsigned long mode)
 
 static int xgmac_suspend(struct device *dev)
 {
-	struct net_device *ndev = platform_get_drvdata(to_platform_device(dev));
+	struct net_device *ndev = dev_get_drvdata(dev);
 	struct xgmac_priv *priv = netdev_priv(ndev);
 	u32 value;
 
@@ -1881,7 +1881,7 @@ static int xgmac_suspend(struct device *dev)
 
 static int xgmac_resume(struct device *dev)
 {
-	struct net_device *ndev = platform_get_drvdata(to_platform_device(dev));
+	struct net_device *ndev = dev_get_drvdata(dev);
 	struct xgmac_priv *priv = netdev_priv(ndev);
 	void __iomem *ioaddr = priv->base;
 
-- 
2.11.0

