Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A05C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4426B2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KL/bUo4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfCUNYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:24:51 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39251 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbfCUNYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:24:51 -0400
Received: by mail-lf1-f65.google.com with SMTP id m13so4579197lfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 06:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vVJB78a97q468PtC/UfYEkUnsmC+RQqZfVfZT6REWsU=;
        b=KL/bUo4xyk2D2vqLcNy0Qi3m0chmqoLjW/f8R6A4idG0H8fyP9/X9xEcgKTucYUSqc
         Hmtky9I+CYOSBt4i7jhIWGW5mJxNP/6Vo8rhPVI0roYmRA/Al14q1GVimBGVvRGpoefF
         TV1t4jf57aeEUZCDdge3YAJCsDL8GWNUlnSqwWV8JyHvDPq3xuNQhn4Af8bpaBYl9Gii
         TzROjeMjEFt3q17zivjmkylAzNvHaBJbbYbGSnebrV0OiiEcePwqjeDsT76yvDAwJzcW
         Vl+zkEz58iIXNxBqb6NC8fsOX83cwGffS3ct/eEv0Qp9a9+7YGmsPrHVsd4mnI0XN+0V
         B7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vVJB78a97q468PtC/UfYEkUnsmC+RQqZfVfZT6REWsU=;
        b=IffJiXAeYk2pa5rXp6VJd9I9+cDOTvbaKj5xhi/Qhl7AmIXuhV6Sqq1phUhsG+pkDb
         PWC8meEwGJWwOdCLt1IAyROmUh+43JA+1mawIK8B/SsoeOlskKLtaliAAQRLliVmv1i2
         n3MZSygFTkhGXK99914s81xDdfiJqSZ6PpaMbxJQJ0o7JtM8Uve6llXAuUqp9zEXSkiv
         W6mbPeVbh9lWFlzqnEsRTH9wryFwBMTWy82WYgRcAI/N1+3rO3ZEbs/phyA4hXPKyaiy
         Kp6v2I4KtMvAI+EsQ6PRzwFhyS8X/U471n6T5k7KMmNk5VpijC/3+v1OExA1luwbnguo
         PpVQ==
X-Gm-Message-State: APjAAAWWc8NobEabAUlXxbC1LMMMJVMYyknR3bbS37xXpT4q19t6yHHz
        AizTCKUCzSXbDVeN9GJensrofA==
X-Google-Smtp-Source: APXvYqyS4b49xep5ZC0x78z3Fd3D+FdD97/9DKappeKEBXES1DZvXshK11WirrdczCsE/DsH+YXjeA==
X-Received: by 2002:a19:a40b:: with SMTP id q11mr2041154lfc.33.1553174689175;
        Thu, 21 Mar 2019 06:24:49 -0700 (PDT)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id m18sm851796ljb.35.2019.03.21.06.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 06:24:48 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        matthias.bgg@gmail.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] drivers: ufs: Add missing MODULE_* information
Date:   Thu, 21 Mar 2019 14:24:44 +0100
Message-Id: <20190321132444.28659-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building the ufs-mediatek module the following warning shows up:

WARNING: modpost: missing MODULE_LICENSE() in
  drivers/scsi/ufs/ufs-mediatek.o

Rework to add MODULE_LICENSE,MODULE_AUTHOR and MODULE_DESCRIPTION.

Fixes: ddd90623ce26 ("scsi: ufs-mediatek: Add UFS support for Mediatek SoC chips")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/scsi/ufs/ufs-mediatek.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/ufs/ufs-mediatek.c b/drivers/scsi/ufs/ufs-mediatek.c
index c3b78fc83d3f..5e3bda42ac3b 100644
--- a/drivers/scsi/ufs/ufs-mediatek.c
+++ b/drivers/scsi/ufs/ufs-mediatek.c
@@ -364,4 +364,9 @@ static struct platform_driver ufs_mtk_pltform = {
 	},
 };
 
+MODULE_AUTHOR("Stanley Chu <stanley.chu@mediatek.com>");
+MODULE_AUTHOR("Peter Wang <peter.wang@mediatek.com>");
+MODULE_DESCRIPTION("MediaTek UFS Host Driver");
+MODULE_LICENSE("GPL v2");
+
 module_platform_driver(ufs_mtk_pltform);
-- 
2.20.1

