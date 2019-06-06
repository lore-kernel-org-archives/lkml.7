Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DBBC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277CC20866
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gXh1GMRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfFFI4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:56:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41875 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbfFFI4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:56:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so1510693wrm.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 01:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X+dt00Qh8x0HQaYvs/wFWC/RRT+JLiip8W2CMV4OPCA=;
        b=gXh1GMRmsnTxYGhdwMzsN+VckI0EwWyFyk/k8lZJwDGqYqCc/QdUxBcCFiFQtQG89d
         Iqi4iRI+wC0JolDM4R8asAE6EdkkjHKMClfGjFYDbwxh0mWHlzVXgLky8LUHobhHBSjC
         TN/s3md2O0GtY5IAZoHAlE6ESBWXDPzOIFoEqeR2ycOnAjFTYQvUiAvAp9TXSffdPRSt
         bHieKspeavGywum0/FZse0LQo0s1ySK5Odi4gU/yh8SDwrnrBbxv/QEFngaz39/JMiPR
         wwZHXv6760J1eKBDpokpAmDL3687pDBl6n2+Phc0X2YVtlVtCsmScUuZnoOHGSjkTIWH
         iFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X+dt00Qh8x0HQaYvs/wFWC/RRT+JLiip8W2CMV4OPCA=;
        b=Lh/iMMJizwo+UlEq2t4NnxLRc1T0ghGcqTe0lho3mW0lljau7A6+2/YNEvrAv+rtsj
         Z+AjA+N7fbLAwodNPsxEYAJwlJ7kciuvjaZz6uexVW+jjQNrspJMta56WTx8xxUWIO31
         WKWJTbkmJp7BrjUKuFLsqoShuhz7iXu6XY5qqc2VP0bqSnCQnpMrC/+3Jxg1eOHQuRmn
         jVTPZSicnukF2QV/WNAg/Xj0an8V0H06DZqocZR293qvMAIvf6kog5OXGW/dZ5xpf7tY
         /iDH33szP75HundTdVYmEnQk7DW8uXp6hyY+3mMD9EXb+1Zk5rrw3d1HjM8u8nR/tgkT
         GI/Q==
X-Gm-Message-State: APjAAAVEk4smhZAavjUtv1Zx08dF9ZKC15wRlYmd0OT5AvqaLB7V33B+
        AM24uFJAY5q4gHxJEfgsk9zr7Q==
X-Google-Smtp-Source: APXvYqznMLUPjiqEwsRMhUzmodM6ZGK0zxBM/gAmVw54lgAUFVUUw+k8MUlJX7e708oiIu6Ysp8FKA==
X-Received: by 2002:a05:6000:181:: with SMTP id p1mr5549009wrx.247.1559811411480;
        Thu, 06 Jun 2019 01:56:51 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f24sm1087334wmb.16.2019.06.06.01.56.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Jun 2019 01:56:50 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     arm@kernel.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, olof@lixom.net,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/2] arm64: defconfig: enable Lima driver
Date:   Thu,  6 Jun 2019 10:56:44 +0200
Message-Id: <20190606085645.31642-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bunch of arm64 boards can now use the Lima driver, let's enable it
in defconfig, it will be useful to have it enabled for KernelCI
boot and runtime testing.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d588ceb9aa3c..7e9d684332be 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -505,6 +505,7 @@ CONFIG_DRM_HISI_HIBMC=m
 CONFIG_DRM_HISI_KIRIN=m
 CONFIG_DRM_MESON=m
 CONFIG_DRM_PL111=m
+CONFIG_DRM_LIMA=m
 CONFIG_DRM_PANFROST=m
 CONFIG_FB=y
 CONFIG_FB_MODE_HELPERS=y
-- 
2.21.0

