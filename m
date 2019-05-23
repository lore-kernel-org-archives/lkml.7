Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD978C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D0E2175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLDDUfny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbfEWPLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 11:11:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32932 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbfEWPLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 11:11:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id d9so6722323wrx.0;
        Thu, 23 May 2019 08:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9wwz+xfCsHkHpcqUvXeTMqGEu53cQ0RDs4iESG7T3CQ=;
        b=oLDDUfny5GtdyO+VUAmKEqF0H9jggBBicRo3ExIGe7XhbAMOFPWQmKFj8k8jbGzVK3
         +vu/jtK1kcZxpAKsSlNtOXKE25fxw5yoSPHmVUkx3CHQDdllbYQwj4Mq0CMq5C/0/mDr
         86jjGYEWvwLnW4k2LzY4dAbGh2AN26BqQsXRAhPn5qTWog50oKgs4aItEc6cLFiyLRol
         uFuC0uMs1VsVLUFiciLx8JAxuFVE/kFeqAegOGsK9hUV82gwIlhk8+lOy0qiL5F/Msvz
         ohCfn2iEqXyYH1cZA/MjMMCBTjhE4gH3wZHG6FZBQZnh8TBWIpXPxxYBMEymrwOZ2dAN
         j8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9wwz+xfCsHkHpcqUvXeTMqGEu53cQ0RDs4iESG7T3CQ=;
        b=Vq4w/Mc62D15ZJfAoZmbmw9P87P5bifDY+ZbEIC+qo16lkm44FaieDeutiqDl4+iJX
         FhFMMUlx1aWHHiXkFEVtLofqSJ8Cpd1wR8Ls8cm9XadTUWj9K59GOxGf1H4UgktKwFAZ
         JJW7LRiEthBWIO6sGC0EwuKzRIVtioyHe8ZUT1M0NkKC6kUBXeed/1bmlCvlxD+LI5AW
         E3TS26PBPM2+LT8oyCvlAf7Lv0yMg5drL2O/PHneplf3PMYdXZQu+2N4v4Gcx/hWj2LT
         Y4dFpn0EVkYXWmGis8LQsvSF9gjhfehKgCwqIaxE7albBnExQo8tPPYyg6sQ1RADQEhD
         xWgw==
X-Gm-Message-State: APjAAAXwcaV5L4A8+f70fJwAJuXyqqSroJPj5qrsLTN31ACYj1EUPHyX
        ZGx81N7/YX6Q0mx4Lpb9FPE=
X-Google-Smtp-Source: APXvYqwpqFOtLIWfs3xJWCqQCSaru3enfRBsUpAknbkIYOU0UUgbvZX0ZeO7EK5SZbkov/7ukjHJYQ==
X-Received: by 2002:adf:ce8e:: with SMTP id r14mr46914850wrn.289.1558624260438;
        Thu, 23 May 2019 08:11:00 -0700 (PDT)
Received: from localhost.localdomain (18.189-60-37.rdns.acropolistelecom.net. [37.60.189.18])
        by smtp.gmail.com with ESMTPSA id q15sm11436324wrr.19.2019.05.23.08.10.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 08:10:59 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 4/4] arm64: defconfig: enable sunxi watchdog
Date:   Thu, 23 May 2019 17:10:50 +0200
Message-Id: <20190523151050.27302-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523151050.27302-1-peron.clem@gmail.com>
References: <20190523151050.27302-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SUNXI_WATCHDOG option is required to make the
watchdog available on Allwinner H6.

Enable this option as a module.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4d583514258c..fc51dd4decb1 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -420,6 +420,7 @@ CONFIG_UNIPHIER_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_ARM_SP805_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
+CONFIG_SUNXI_WATCHDOG=m
 CONFIG_IMX2_WDT=y
 CONFIG_MESON_GXBB_WATCHDOG=m
 CONFIG_MESON_WATCHDOG=m
-- 
2.20.1

