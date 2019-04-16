Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08611C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32C720652
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="csPBFHx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfDPKRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:17:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33753 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfDPKRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:17:39 -0400
Received: by mail-pl1-f195.google.com with SMTP id t16so10120124plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 03:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=58VAXAMKuSUHV7Cj0dPn8pBPEiYtZmA6SG3NC1kOQFg=;
        b=csPBFHx/hbFXpi9bB2gkJ+ju5tt0soW8JoY3MiZhRgn7AqZZ6ZivQnZyeZXwRKJnXe
         +cTghsXW3NrDQBK256CkmC+PjG0aocSVrZyLb4iPyjvq+a5xxuR1LEJ/2yAoQm3EaSVZ
         qdsMXHDpkjZzvxEP6sDUpRCQnApAP9fcoOKmFioccdly1bHFKkwvb1c0AHwJ/N3Sl197
         cY7OEItwn6Qc8jipx6ifaDQZLH6IseAbhGX2gGQWC5pSAoCzWqkqkQIDlJGCxgQ09xQv
         SY/8eRo3GbPviaxMOc6LI593uiueXqjYp7kWtU6ZsD2g6gIbNinuaSYWNyOXN8Wyg7cc
         ZZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=58VAXAMKuSUHV7Cj0dPn8pBPEiYtZmA6SG3NC1kOQFg=;
        b=pbJWG1i+4Gi1Ga9mG8zQSGx1yasumYbNW23TvpQh01aFFYX4zdHZ8bzABnSigXl2lW
         7hJkFCIXBRw2u6xIACPxOm063n5vUf52pqfQlEvXzVnQxiFeT17REFOi7C4QU0pia9AZ
         /RuLJa0TWODt8tn4K3QND/0GEIbubeSdQ9g0jLyx7Byb26bXUP+Lt1+ARIv5ApRExiTD
         o0EXMA8FMdBQht/NmAQyFFLXW2x6dN8SZaaQSlQotEUv0+38/JsmReskgVFRXk72iYWy
         JjFUX9/8Sl3QcBpJDRhj5C5SEokldTtdtXcymM0sKD/LH5hORPlNEwWSPB098ky7GEpa
         ag2A==
X-Gm-Message-State: APjAAAXmULoPwYRQvAp4vItnlsLoIuFYiDl7uw1hcFWDy/GD4c02x4nQ
        koFNRGT5hzl+6DiB2fTEbb1ZMw==
X-Google-Smtp-Source: APXvYqzuDxnv/48trfY462JuVmVw98Tj9NOEdsc1pqstHgpIqqLsjbkwRCXvPpstyPDCGLfvZs68Vg==
X-Received: by 2002:a17:902:70c8:: with SMTP id l8mr82126395plt.177.1555409858412;
        Tue, 16 Apr 2019 03:17:38 -0700 (PDT)
Received: from localhost.localdomain (118-171-129-145.dynamic-ip.hinet.net. [118.171.129.145])
        by smtp.gmail.com with ESMTPSA id h187sm105434588pfc.52.2019.04.16.03.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 03:17:37 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/3] regulator: tps80031: Remove unused *rdev from struct tps80031_regulator
Date:   Tue, 16 Apr 2019 18:17:27 +0800
Message-Id: <20190416101729.26330-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ri-rdev is assigend but not used, so remove it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/tps80031-regulator.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/tps80031-regulator.c b/drivers/regulator/tps80031-regulator.c
index 1001147404c3..d97cd55b6850 100644
--- a/drivers/regulator/tps80031-regulator.c
+++ b/drivers/regulator/tps80031-regulator.c
@@ -85,7 +85,6 @@ struct tps80031_regulator_info {
 
 struct tps80031_regulator {
 	struct device			*dev;
-	struct regulator_dev		*rdev;
 	struct tps80031_regulator_info	*rinfo;
 
 	u8				device_flags;
@@ -736,7 +735,6 @@ static int tps80031_regulator_probe(struct platform_device *pdev)
 					ri->rinfo->desc.name);
 			return PTR_ERR(rdev);
 		}
-		ri->rdev = rdev;
 	}
 
 	platform_set_drvdata(pdev, pmic);
-- 
2.17.1

