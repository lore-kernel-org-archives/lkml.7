Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87D4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93D22083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tRcKxyEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbfCVNbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:31:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37758 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728328AbfCVNbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:31:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so2199432wmf.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 06:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VX3opZVcmkM+En0hefdq8W/vBGhiheYA82Y7qB1etT8=;
        b=tRcKxyEPgC7Yid5dHv4z/8D5OkvK/tWuasq0SLL7LtYel1NfOlvgDkSFno301pz2ZM
         5QjmO0cLoXdCp6FKKPQsYmSjUS8dH6kGFs9zL0x6NoGOwiqfQQhl0Ym3Tt1F7vyN1hQY
         CGolNXd/jWk18hZg+KweqZL5O642Ui2BE7BQCWrd5qt81Rg3zQYgb332jIsbuxGn0qaC
         efL39/TtOWA9nrwG4f09XUB+SMR+bDxT3tQ0/AD+Fwvtb/HXJ6RNMgIL0pJNYwvJpl19
         Gw01ZC0kML5W23sPeOnhF0D1tdl5ZogBhMX3J21pYDE7xwifRXRghs9/DxaxHUmxvzpA
         6YSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VX3opZVcmkM+En0hefdq8W/vBGhiheYA82Y7qB1etT8=;
        b=QDMcp93dN2kDnHr++3DdgWiSt/UMb4XlUJ/Sxmm9BTcusk5IRqTH2usXyq60QgF/XG
         S57cwrQtlDdskRKBlbwwmDwSR0n3KslAshDJN2S1eC06HhDyHHuV+TxtX49O0sv6l7QB
         p3WkScNQ0D9srEefSqPbvA8y33kedhKyDPsofHRb67eHNK60Ab60pDQldZJDN5ZgrqKv
         i00dUUhsdelnHkYLhKShrjnvJygPkq3CrNKMFRl+lDk2jJybJ1BWAC7HfYCggaQ3sclz
         4JDEL6A2v9OeJVF8/9hxtZx0CbiG84g2kxV5kIOOlAH+V8km7z2rzwDr6SuvPw+FCoPu
         AYmw==
X-Gm-Message-State: APjAAAUGmyqiBaU1TQWeo+JsLt34VSh6YroMGAINU2Sa5cgTjl8taASe
        +Hc5sKZnxI/ELcPWnOW7ugsW5A==
X-Google-Smtp-Source: APXvYqwkMum/YJ7a4mIiYv3wZuCKXSQ84Yc+NCU2xW7a3sF5mVC3G90c/BGgg6VCDrNrOnjL878rVw==
X-Received: by 2002:a1c:66c2:: with SMTP id a185mr3055085wmc.139.1553261470538;
        Fri, 22 Mar 2019 06:31:10 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o15sm4684345wrj.59.2019.03.22.06.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 06:31:09 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 1/4] ARM: davinci: fix cpufreq registration on da850-evm
Date:   Fri, 22 Mar 2019 14:31:02 +0100
Message-Id: <20190322133105.5945-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322133105.5945-1-brgl@bgdev.pl>
References: <20190322133105.5945-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The system_rev variable is never set on davinci and is always 0, so
we're using the default max operating point of 300MHz. The cvdd supply
comes from the tps6507 pmic and the voltage can go all the way to 1.3V
so the maximum supported rate should be 456MHz.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 1fdc9283a8c5..58b2a485b527 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1155,17 +1155,7 @@ static struct edma_rsv_info *da850_edma_rsv[2] = {
 #ifdef CONFIG_CPU_FREQ
 static __init int da850_evm_init_cpufreq(void)
 {
-	switch (system_rev & 0xF) {
-	case 3:
-		da850_max_speed = 456000;
-		break;
-	case 2:
-		da850_max_speed = 408000;
-		break;
-	case 1:
-		da850_max_speed = 372000;
-		break;
-	}
+	da850_max_speed = 456000;
 
 	return da850_register_cpufreq("pll0_sysclk3");
 }
-- 
2.20.1

