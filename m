Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB43C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A5E20693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jnDSm1kT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732216AbfG3PU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:20:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41825 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbfG3PU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:20:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id d24so62465298ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 08:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Bm8TrbVGw472rHZ96Q2MRXayJlnL67ZSjInVLj2+c0=;
        b=jnDSm1kThBj9/KTO+yzj/l4jRVeijOOMciJDemA7qx5oWy2BpzWea2X6F5jthNRmCw
         hfSr2Qo5grf2ao4WI/Rv/6+JTx8Lp2t8YQx1HHN4CC4S9uuRVtlR2o7K9LcnXvuZEkSw
         ec1Ra6Ri4dsy/dQyYDxBu/SQQy1IvuJ5YSJ3iiW0rRp2izDyYu/4SYd/rAXB1yQcv7ct
         KV1w1w6hnwy/LLNozmJxpZK29XuUCZbPtjkCgyfhrcrZfvjz4pREBM71j9UO/xGx0rzO
         dZBHBS0BHiPTLjCzdPBdV3ZJfizcSx3il5IcKCZLDwkvQXjY19CQe0JDNTqtdDwr3wUo
         wkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Bm8TrbVGw472rHZ96Q2MRXayJlnL67ZSjInVLj2+c0=;
        b=tEd3VRVgqExeE5us7hcMBz95ScQtSPxma9fED6NBbYB/O2Y+h+HyjU94xqZr6Th5vg
         Ww4JRgASXHB+Bl3VGupKtQsnw+qwXQ3GgEiS9eOONGZqxV7Oo+rQ3TuwKOPpup+7TaJc
         KeUymzpxYA4fQZZsm6IDknUYvYCCoxzTg4pGMQn2Qc/lNd67pShUAF/xiv3KZob2o2J3
         djHngNNMHL934tmPTfn2pSDuiJh23mj4Hn6hLHumeMISdVOnw0NhNmoC8BRzXWnuFesB
         H8VURwCTWQ59pspd1C/NM6+n9lav4iovtaApzNcdQFpm03fO46ldUhP9qWCRPTaCnXmb
         9w3A==
X-Gm-Message-State: APjAAAWeoMmRRSUgiqqHx0q8EKkwjjG0g1CWVeT+Jid7PmYeHY2zn/fY
        esTj0n7i11A3n8s47xQRzrlmhA==
X-Google-Smtp-Source: APXvYqw8cNQwIuVo3MyhmOP8pwoiYmj+MEq273fNs7PYTrH2vLKbLF+Kndi+zZObbX2ZtiI8cgVutg==
X-Received: by 2002:a2e:65ca:: with SMTP id e71mr1547102ljf.61.1564500024139;
        Tue, 30 Jul 2019 08:20:24 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id q17sm11266522lfn.71.2019.07.30.08.20.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 08:20:23 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     will@kernel.org, joro@8bytes.org
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] iommu: arm-smmu-v3: Mark expected switch fall-through
Date:   Tue, 30 Jul 2019 17:20:11 +0200
Message-Id: <20190730152012.2615-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that -Wimplicit-fallthrough is passed to GCC by default, the
following warning shows up:

../drivers/iommu/arm-smmu-v3.c: In function ‘arm_smmu_write_strtab_ent’:
../drivers/iommu/arm-smmu-v3.c:1189:7: warning: this statement may fall
 through [-Wimplicit-fallthrough=]
    if (disable_bypass)
       ^
../drivers/iommu/arm-smmu-v3.c:1191:3: note: here
   default:
   ^~~~~~~

Rework so that the compiler doesn't warn about fall-through. Make it
clearer by calling 'BUG_ON()' when disable_bypass is set, and always
'break;'

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index a9a9fabd3968..c5c93e48b4db 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1186,8 +1186,8 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 			ste_live = true;
 			break;
 		case STRTAB_STE_0_CFG_ABORT:
-			if (disable_bypass)
-				break;
+			BUG_ON(!disable_bypass);
+			break;
 		default:
 			BUG(); /* STE corruption */
 		}
-- 
2.20.1

