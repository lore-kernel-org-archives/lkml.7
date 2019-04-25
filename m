Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FC2C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2AB0215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HwKxCamA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbfDYTs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:48:58 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:44723 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfDYTs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:48:58 -0400
Received: by mail-ot1-f73.google.com with SMTP id w3so518354otg.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KQMVZFBYV3l7bj2x5noGMtlzW2OP8eFi+jkangDmvwU=;
        b=HwKxCamAoHOE6nUFmXQ8v/yFGaMkGY4T09T8MB7vAvXMSDsBD6K89hPOV94dn38H7R
         qnMHn1xN9rryCO0LGRp3pJCqxh/d4tp8xRAjZWI5T9z1oV+5G3NW/RXDlL6/v2bJAWik
         s/2yq1WF7xOaipb0jRRQKBJCihnxbwQyvSAHmn5B4qyIVM5+E7vlZ1R3AA3SgUYxd2tx
         WkcvZ2wJjoUZXterXYUKr8kk6tAKycr6LnkvNkJ+1f7tBXNY84B5AYvBiYyvpwZSZtjv
         vkw4Rg2roGNov0FgmD/HW8F+dk1llV3+Bs9yBnP4n5DOMNAmc3ZH+eBpw0EQrZmMAb79
         PX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KQMVZFBYV3l7bj2x5noGMtlzW2OP8eFi+jkangDmvwU=;
        b=aS4MvbHSw8U1/14X+ML6+od1AO+xr63UHr14KrIrvAnKj/aC7cAPiJzOPv6ZdrsEZA
         ivZuwRxto02aDl+JuYRVoCFE7ay/HxjMKlXS20xGoj/lyO5yNw32XtWuEMfVfP3e4qOt
         xs6cEKtcNZWSB6RVnydH9/hiimAd50a75EMRw75bEaHkfg3U8DswkVabQheZjDipjVQn
         fMbxYhYZHuLT4nNWd3V9884EO50LZT3b82y4MKoitftGx5EskUKeYeuxdsPzgo45jUay
         yFEWhTeJDAY60ypEjWFvi+LzbPhO/CBLNUKeBU84jRkOfYT6lit4cYIrf6UJHKFFg0qd
         slVw==
X-Gm-Message-State: APjAAAWfacfg5ws47uL7oZlPCuwlBGAFQhNis3+JVhR8dDzsocT5Ds8g
        Y32z+lUTdpJyYaK+RPV5Q2om5jhWz+hO
X-Google-Smtp-Source: APXvYqxkecb+/acwzzKQ9MUPwhZ5gBo/wMvGEdXfYC8QdGg/6XfZ0F4qH1j+ozU73r5nAUIGPGvn1+J6kWdd
X-Received: by 2002:a9d:6ad1:: with SMTP id m17mr10625475otq.108.1556221737304;
 Thu, 25 Apr 2019 12:48:57 -0700 (PDT)
Date:   Thu, 25 Apr 2019 12:48:53 -0700
Message-Id: <20190425194853.140617-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH 1/2] ARM: dts: aspeed: Add aspeed-p2a-ctrl node
From:   Patrick Venture <venture@google.com>
To:     venture@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        joel@jms.id.au, andrew@aj.id.au
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        arm@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for the aspeed-p2a-ctrl module.  This node, when enabled will
disable the PCI-to-AHB bridge and then allow control of this bridge via
ioctls, and access via mmap.

Signed-off-by: Patrick Venture <venture@google.com>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 4 ++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 9549f867aa1ef..0b7bc6072aed0 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -165,6 +165,10 @@
 					compatible = "aspeed,g4-pinctrl";
 				};
 
+				p2a: p2a-control {
+					compatible = "aspeed,ast2400-p2a-ctrl";
+					status = "disabled";
+				};
 			};
 
 			rng: hwrng@1e6e2078 {
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 3e4ed081505cc..5f01befcca1e2 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -212,6 +212,11 @@
 					aspeed,external-nodes = <&gfx &lhc>;
 
 				};
+
+				p2a: p2a-control {
+					compatible = "aspeed,ast2500-p2a-ctrl";
+					status = "disabled";
+				};
 			};
 
 			rng: hwrng@1e6e2078 {
-- 
2.21.0.593.g511ec345e18-goog

