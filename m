Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BAFC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137CD2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="cfAQLDXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfDLNo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:44:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35500 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbfDLNot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:44:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id w1so12036847wrp.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 06:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i+5maHFIx27CE8rGKrmmIRAieWP01QawvbHD18Ck7dU=;
        b=cfAQLDXoSP/DwxbnlLal9FlQVJLk3ZjfNWNSuqMNjHctlch/U2D5EmoZMnSl8n7IRi
         As19DB07whzvmejADMf/9W/tOcxtf4Tifk33BH7QRHxe5X3o8WauBezrMvs93G2jCBoq
         xFcZCiRegqlieIEqOLaOxzz3YE1ADpZbSJSOEWA09EQRkRIhJzDS9Lu77OrIVKOTj9Q5
         Ly1wh5U6qnt4SU0WGSLFE6iWtMbf9sLhPPSn2uz6WoV3c/S5u6zTFjHIG3G4P1SaN1xL
         mw6s5FUMBr6MlLmsbmZS/FEkZVZBxmO/8TzAjfxYDdyWYW6xdKZPCD7olRJdQcMqJp4n
         QBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i+5maHFIx27CE8rGKrmmIRAieWP01QawvbHD18Ck7dU=;
        b=mYkdbteZ64iE26B0qSHo/enTfIPxo/tta6ngkD+Jd0A3hRZh7EbyluNFxY8LjqM/Pi
         1ctVIcB9SiRAjiRjZmj5LGVG5WgWz7TeRm5au6hb4UtGcMblcH91TmOXCkmVElLhcMLj
         27u+1rliC41aER1NzVfSlcLVIn+9S4i3baAemOY5EihDD/Shp5jjAre7E2gkOVWhO93n
         Xmz+qrrNEiCJQelpxKlFdbjfJibQ824F5ANp9pM46XrHtR+jD0qaaGhVBxFnDbPPPu7H
         2zvUghDzFytbkbXS/cAFwAdy6kM5YhKIUW7wYNAvkTNvkJ95vlaBtTCUauN4kuiueCBI
         fgeA==
X-Gm-Message-State: APjAAAUKNv2KQgdL2ZCnLb43RdUGuSU+xVdux4AchR3yAlx0OkC88S/7
        G4YMFCc5/KgKl0DxETVNBOc0ug==
X-Google-Smtp-Source: APXvYqzLyrVjr2vfTfr0KKko5NxKfwfF/C/+6ZBFl2LDq9nOStP0uTLpw/4zHRlj+gPBs4X8vI5WIg==
X-Received: by 2002:adf:b6a4:: with SMTP id j36mr34985465wre.55.1555076687792;
        Fri, 12 Apr 2019 06:44:47 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-35-248.w90-86.abo.wanadoo.fr. [90.86.90.248])
        by smtp.gmail.com with ESMTPSA id s18sm9964672wmc.41.2019.04.12.06.44.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 06:44:47 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 5/5] ARM: davinci_all_defconfig: Enable CPUFREQ_DT
Date:   Fri, 12 Apr 2019 15:44:37 +0200
Message-Id: <20190412134437.14864-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412134437.14864-1-brgl@bgdev.pl>
References: <20190412134437.14864-1-brgl@bgdev.pl>
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

