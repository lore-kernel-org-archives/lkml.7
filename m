Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B83C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A2E218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pHIlYSro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfCUMum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:50:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35329 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbfCUMum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 08:50:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id t13so5173420lji.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 05:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0bE9X4Elayt/t4zYSHrCEqGfR1WvW2wJpbCu+p5hI5M=;
        b=pHIlYSroVIjOCbs7wcllLiJHVKWjbeNX+h92v1fHayru/7OMlbzOzjPyvprShe44Nd
         JhQAtnhWifyDfz1FO9bgowlQI2Xn86oqaOMEF7aNbFMtIQmsNeJHMBdiXdK4CL+IXe8P
         7Wq5FXOnWAFydr9+/Q22CPqeH4Y4FfkXsjEZnZ8inRrIA69X7L6mKxt0chCJ6A4Hq3qs
         noJDfcA5ZmhKu+IFVMSfAoN6KiO9fFcJojf99XM1j1YiEm5ySEHZtlQTcbaNjwbE/qyp
         WOlrEBPJjjkRoIxrO2PRpt4nGAMXYpT6/ZPJv+uwTH0GgpwaVPxtQIOEt2aVG+dDqs2E
         x2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0bE9X4Elayt/t4zYSHrCEqGfR1WvW2wJpbCu+p5hI5M=;
        b=QQKkSFf7/38YuvRGeriZPi4mkGIrW2eVUfpHiemUIqwsd2fbogK8vxUj+jc4DZde7N
         Qvajwj2qGw8NIep0+w4jknFy9YoBcnMMqTNpffFWqTvuIsORU47HR+wSuhkmydoAa4lt
         plPs6kv27YEbR2Z3yJBh8kLGWeSTHoSCrbooUJoE2UlaAg3b4FE/WkySlkMF4TDxburW
         wSH2oAXDZxyAyxqm8uBiyjdqQNr7o7ZNoeNneo8enRYrUu4tS1MkQjf/Zbr/JHzNptDV
         bdQhuPeCSCVh1Nb08gkGHdcpJKzMpe/oRRqR/AHgdQZxUSPzWxqFbZk+HeiXRIHph84I
         n+eg==
X-Gm-Message-State: APjAAAXm33KFw6MBJMZqffc7KX+i7r/cYQqfiLlFLsSQJ2gypG7ChlSE
        AkaEUqwqj9jzFPX/EfkzZ1hygg==
X-Google-Smtp-Source: APXvYqzcUIhS+EiZpwC3Ri6JGdrv2uU21Tja241yr0fsZg+sT7D5AIiBphh2WM3vt392J/wws+lYBA==
X-Received: by 2002:a2e:680e:: with SMTP id c14mr1944308lja.51.1553172640702;
        Thu, 21 Mar 2019 05:50:40 -0700 (PDT)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id b194sm937898lfg.39.2019.03.21.05.50.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 05:50:39 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        matthias.bgg@gmail.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] drivers: ufs: Add missing MODULE_* information
Date:   Thu, 21 Mar 2019 13:50:34 +0100
Message-Id: <20190321125034.22697-1-anders.roxell@linaro.org>
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
index c3b78fc83d3f..ce4767784937 100644
--- a/drivers/scsi/ufs/ufs-mediatek.c
+++ b/drivers/scsi/ufs/ufs-mediatek.c
@@ -364,4 +364,9 @@ static struct platform_driver ufs_mtk_pltform = {
 	},
 };
 
+MODULE_AUTHOR("Stanley Chu <stanley.chu@mediatek.com>");
+MODULE_AUTHOR("Peter Wang <peter.wang@mediatek.com>");
+MODULE_DESCRIPTION("Mediatek UFS Driver");
+MODULE_LICENSE("GPL v2");
+
 module_platform_driver(ufs_mtk_pltform);
-- 
2.20.1

