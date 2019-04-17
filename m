Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90916C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B8D20821
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Hos/v3pk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732695AbfDQP1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:27:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43459 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732668AbfDQP1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:27:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id k17so27825563wrx.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 08:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i+5maHFIx27CE8rGKrmmIRAieWP01QawvbHD18Ck7dU=;
        b=Hos/v3pkfxOkzSlUiKdPtsjRYzPUb2Kg+PDpz7S3CBB0LRPNwalmW8V6DfsAIRKvId
         +Qb5MtKukFdyabcShmDpFdL9BdFoT51a//QCRuZa152LUavo8R6z12znG14onnf8iN1y
         R8iXD84NadrHT3cZYMygsH0ijsG22loeFZm3xw++hf/eSJKAjlIg9oyy7kSt2gZOR00y
         mU/upW6zdoVHH7QcEdFEql1uEb+8j3CTacOJ5AoF2iWZjm0uD44t58wKIaXAwdSolzqt
         T2CobV+RfA8Mz2+4Z5XEVHg28/QVgPDNxC/dh3IirwtSW8sF/sTgCLD8tzClo16vV/Jz
         QqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i+5maHFIx27CE8rGKrmmIRAieWP01QawvbHD18Ck7dU=;
        b=WD5u6ZSED/xa2jnb2xea2hwW+eaOIwUiRC88LYSeyzaeZ1JVwcxYiHLaD268D5kU+3
         f4AqcPpufRvZQZ9GechrkTzKPEmI2Tc6kti7SzKu5IJj0pDYSAudjNDlAnq+C5Draxkh
         CFElrND3iLRmtUoEalutIA2zbpjqNv/O5M39gFZ11DCfdmagsdPIJ2r79JxLHIs/WzAu
         sucnO5p4E+vumKbs1dm2yBcoF6+bkl2ltiWN7v1kYG2dZK0qNl4hwn19apq14dpc8xwD
         ElMj11qr03zHHAhOt+FlxluPRu0QX80sJygj9Tw+Ds15NguYsFPWIhnpslnPO03Oqzyo
         LAtw==
X-Gm-Message-State: APjAAAU6Unnb2DOqfxM2pAIFWHH8qPIiGQ88T74Ln0p908fcl7ymbuoh
        JEYHUGqTr8tMyZjlFmpQZuV/tQ==
X-Google-Smtp-Source: APXvYqyA+vtKd9GI39xGaxBtaOomdl3VNhlu0UfEd5pei0KZYH4z9efoZ91waLgm3i4mLXdSpInurA==
X-Received: by 2002:adf:cf05:: with SMTP id o5mr56262777wrj.8.1555514833448;
        Wed, 17 Apr 2019 08:27:13 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-15-216.w90-86.abo.wanadoo.fr. [90.86.218.216])
        by smtp.gmail.com with ESMTPSA id v16sm75478817wru.76.2019.04.17.08.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 08:27:12 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 5/5] ARM: davinci_all_defconfig: Enable CPUFREQ_DT
Date:   Wed, 17 Apr 2019 17:27:01 +0200
Message-Id: <20190417152701.23391-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417152701.23391-1-brgl@bgdev.pl>
References: <20190417152701.23391-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lechner <david@lechnology.com>

This sets CONFIG_CPUFREQ_DT=m in davinci_all_defconfig. This is used for
frequency scaling on device tree boards.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/configs/davinci_all_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 207962a656a2..c3502236132e 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -45,6 +45,7 @@ CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_PERFORMANCE=m
 CONFIG_CPU_FREQ_GOV_POWERSAVE=m
 CONFIG_CPU_FREQ_GOV_ONDEMAND=m
+CONFIG_CPUFREQ_DT=m
 CONFIG_CPU_IDLE=y
 CONFIG_NET=y
 CONFIG_PACKET=y
-- 
2.21.0

