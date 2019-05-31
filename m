Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0F5C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 20:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82EA826ED1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 20:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="tCjkZ8iy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfEaUQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 16:16:22 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46218 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbfEaUQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 16:16:22 -0400
Received: by mail-qk1-f195.google.com with SMTP id a132so7093165qkb.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 13:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=r1ZINiqMC0wxlld9QMTJmz5jWV4jlbebAasegE3Ledc=;
        b=tCjkZ8iytNNlII4EhkPmrM+JWWmfhjRRm/cYg2PDXqGZe2bQr8lQ5AEqWds671Sq41
         /Z7dEJHPjarRv7wcDPjxybrFlpZxgsRkWVUrhealG2hZolvmWH7u/AyiZSgupmtq1pbk
         dBnve1MTt+rsCQQAjP5UTERnPqXgT1fLduR/qkwfbwEsFN3ti1dh0kmdO0GHDVV4aXEs
         N03LovIZ0/2Ewk86i75/1bnMI+Mu1PyAVy62tKxZDFLbLxk7UzFvJi42apXFyJ0jaE8Z
         Oyj6uZqxrdGCA01rRzhooRnA4BtGtm187DhH0VnmBSedMl1Y5UEs+JE+Lqs4mXaeiMEt
         z47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r1ZINiqMC0wxlld9QMTJmz5jWV4jlbebAasegE3Ledc=;
        b=YG5QJqndHqI/cujZWN/damsk+VQDXJXJ7cEiDE4Jkghe+i5eAYdZxZ7PLDk1Albc1X
         cY4QBRTpXHz0LAZFbqAPqer79GSn2wj4fMBJk7jXjoz/T23oqErksaZkfbQp0QFJ92yt
         sLrtUBqxWp1qESvKLpWzxiupTiHLDJS/5FrRfcCmPGrwvWZ6X52p6TbZlE0MtC3++Tyy
         GB/n2jGfq/zBXVuLCpy3BQuRXVd84xEMbu4GjGkJm4hrgVt8hkws2Qr0RS0f2esuzubR
         zRoGcUof4wduQPiJXh2W7nRml5Vnaho26DUSaLSQg3g/ev3eMKnEKxMh01UUNfX3GcUW
         z5Qw==
X-Gm-Message-State: APjAAAUbxazmbC7oA2YW89FlSSrq/csjqOy2ispXmprp6c9AvpTgvMNg
        VV8UTv45NN+fgIjMGz5yAgzH1A==
X-Google-Smtp-Source: APXvYqyoBBIeLIKPc7eNaHX572ejYUeQ95Q9RZYT/nFVi4qNHT150g2pb0ZRKfhpbfnCvP5ZclDTXA==
X-Received: by 2002:a37:8105:: with SMTP id c5mr9932705qkd.192.1559333781173;
        Fri, 31 May 2019 13:16:21 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z20sm4842639qtz.34.2019.05.31.13.16.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 13:16:20 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     jroedel@suse.de
Cc:     jamessewart@arista.com, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] intel-iommu: fix a variable set but not used
Date:   Fri, 31 May 2019 16:16:02 -0400
Message-Id: <1559333762-2436-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit "iommu/vt-d: Delegate the dma domain to upper layer" left an
unused variable,

drivers/iommu/intel-iommu.c: In function 'disable_dmar_iommu':
drivers/iommu/intel-iommu.c:1652:23: warning: variable 'domain' set but
not used [-Wunused-but-set-variable]

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/intel-iommu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b431cc6f6ba4..073c547f247a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1649,16 +1649,12 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 
 	spin_lock_irqsave(&device_domain_lock, flags);
 	list_for_each_entry_safe(info, tmp, &device_domain_list, global) {
-		struct dmar_domain *domain;
-
 		if (info->iommu != iommu)
 			continue;
 
 		if (!info->dev || !info->domain)
 			continue;
 
-		domain = info->domain;
-
 		__dmar_remove_one_dev_info(info);
 	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
-- 
1.8.3.1

