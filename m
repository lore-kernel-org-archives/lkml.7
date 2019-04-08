Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723A1C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39675208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="qmTAywpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfDHH7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:59:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41646 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfDHH7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:59:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so15097835wrq.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 00:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i+5maHFIx27CE8rGKrmmIRAieWP01QawvbHD18Ck7dU=;
        b=qmTAywpNoXFUsi9pVWZhA5s9hqBcL7ScvGthx3IfJRmYMgbfxpkKr64Zj4s7i6gfLj
         vdvTSCwsLMJupChuhDV8hgKM/RdLStILwgG/vE4ApPZ4h0AxyzzCIrCUk7CxCGgjJFrp
         nMLq+glHQj/j26Y/8jAbrSOYGDb+JSugztweakyo110tAgNgfNkmaFyR6qhujuDA+99y
         coWAmhOPe/t0Hat7XC6xYAPh0GqKXrjSx0KJTIBn1aNhI68wpkAWWaXnspTZIjmq1OTt
         tN4W1kmeARnj9NC8H/StK2n/gVFH7BHjZ59Vfmj7vA7vRzYHJY54iJ5MLoVq6wQ/fnaL
         I6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i+5maHFIx27CE8rGKrmmIRAieWP01QawvbHD18Ck7dU=;
        b=WQKO2udiB4P2AmadgNa+epKZiWIMeLPWujTDG/SaqnnScqtqYnhS9A8sFQVn5fRT8+
         h5O7kyxVm0+ae1ROzFL8h+90yWsXQ+2ZHFuT0UMZD+t2Fhk2qVpgg7TVwSofYyWZQtZl
         fLJU6lAo0uH3sTBpFdDJ65P8hzveSLWR2KWVcQFxEwB/es45zumzqDPSLbiOBMUokL3q
         3L/hYikI/U7LedS+hlNWYWR2i69qdRFUYN9aJ+kThJEWJwBsZoBiD5DBrOiVAMHAYb+w
         CMy85jhnrRUl57/6GEpJF5kTuOnoEfHo+LJ+EK8VhJL7mVK6/ILsOiEgiseR9a3WYgBn
         pyWg==
X-Gm-Message-State: APjAAAU27KFCMIOTy92siYEjMBQZG1xIuYd3X90ttfvR5H+SAwnTlLRR
        ho+TVmMfKr+NOb9FRXFdqq1CM2QgYZs=
X-Google-Smtp-Source: APXvYqy5I/WPTY1nUrMfK2mebQw+wNXRauUYZ+QA2nE3saG9AMp1cBnx1rhw0KMVj2kGvy1N87qBXw==
X-Received: by 2002:a5d:5190:: with SMTP id k16mr17950326wrv.10.1554710376253;
        Mon, 08 Apr 2019 00:59:36 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-12-194.w90-86.abo.wanadoo.fr. [90.86.215.194])
        by smtp.gmail.com with ESMTPSA id o17sm31658711wrw.73.2019.04.08.00.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 00:59:35 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 3/3] ARM: davinci_all_defconfig: Enable CPUFREQ_DT
Date:   Mon,  8 Apr 2019 09:59:24 +0200
Message-Id: <20190408075924.2284-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190408075924.2284-1-brgl@bgdev.pl>
References: <20190408075924.2284-1-brgl@bgdev.pl>
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

