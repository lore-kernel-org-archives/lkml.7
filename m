Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFD0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B521218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="CfbMLoyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfCUOKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:10:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46730 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728429AbfCUOKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:10:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id o1so6741538wrs.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 07:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DJCTKeU3jLYf3XASl//CRihnyc7HBAaFWnezC3bBpFc=;
        b=CfbMLoyy8+9JSS43PNZatcMaZtF0yQSGD+7TN2FQPD0IRTVQheXnraFpbCGl25PT++
         70qecKSeGjoXqbeQVc98LGXismdsyat0n0jmMLY5zzTjlnK0hjF8VxOcU8h72T38lroZ
         1fj61ktZHYrWB45+yLRAbjrATXECF+NiUfll+3PiOUqJU8rYYcNncx59KE/fyr3ph0GX
         HEZ9YYW4181cW369MBrmQ7Gne7DjeeiQFdDW61laxXGLe22aONDFcQJKRP4kAdTEAoya
         +3au7KwliS+RDFZYdyb3uQy1PiEv2sE2hRsBDTE/GdLc1mIy5QLRnyD4vxdQ2WqZXwgu
         LdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DJCTKeU3jLYf3XASl//CRihnyc7HBAaFWnezC3bBpFc=;
        b=eDPdbQkIiDNiTAFCBlG2u/sUwjlgN+IAv96aELFXcbV72UdHYJO5UOWLEfDw1ptW7C
         51ZPXr63h63mWvvG/bOQGGSSV7HuMsBb1goxjrfcyElUsf3d0PxdC1/IgnK3EH+npGZf
         3JBEr5cVXYBIOOx+WXAwrqUcYYtr1xGESNahFHXSejY+cFUK7iGPacGI9IaqYuh5oO4V
         LTVVH71TdUaRJquwvbcdXR6bczIrBKtQz9NA+jYILUHD47u6f93jHsMLHShoaDmz23nC
         N/9a6JkjgkSSAJHeZZV+DArC8jDjGzXUV1VwrAzQylpgaWCqiMomfM1wz3Sn5fOaOSGp
         3wrA==
X-Gm-Message-State: APjAAAVHqY95Rl4xpqhIdvq9ut+VZ2ZDWJ+inRKAyw609l66M7O1U/sr
        cqc4Gm0BSCs0Piak+kLkV5aqxg==
X-Google-Smtp-Source: APXvYqzZldfMrIir7Hte9XAKescw+wR50ntN05EloX09sQAIpX4BTfbPo27xT+qKEl/HOXRsehzgEw==
X-Received: by 2002:a5d:6988:: with SMTP id g8mr2857844wru.117.1553177420332;
        Thu, 21 Mar 2019 07:10:20 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-20-74.w90-86.abo.wanadoo.fr. [90.86.223.74])
        by smtp.gmail.com with ESMTPSA id z14sm7513921wrv.78.2019.03.21.07.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 07:10:19 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4/4] ARM: davinci_all_defconfig: Enable CPUFREQ_DT
Date:   Thu, 21 Mar 2019 15:10:10 +0100
Message-Id: <20190321141010.19612-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321141010.19612-1-brgl@bgdev.pl>
References: <20190321141010.19612-1-brgl@bgdev.pl>
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
2.20.1

