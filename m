Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD77DC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8712020673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEWHPIM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfFXCCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 22:02:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36795 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfFXCCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:02:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so10943540ljj.3;
        Sun, 23 Jun 2019 19:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OpRgBHIbpOuAIRmC5hAbsG+gtGfST0EqR1Mz8i1XFZM=;
        b=UEWHPIM+R5z0E3Vplag65jH9IWmRu9wJa1nac4dklpzcPXmjG2fcEVQAAwTskqlKYy
         b8HncNdkOjk/MrtZmo+fb51cMIKolRAWYBlBJ07PFWFE4TqjErGBCImCjbv7W+hjc+qL
         utZHi6XMY00Xmd4CGOwEBzOMP2mBVRNFfYQLcBSlkb5f7R8VQspzeub2Ux0NQfgRRc1L
         4i/aJwtlv5ByK9HFttuMmj6md7UKZJKvVB4QVUZ2CcV/TFfCWx5smKPwRTIEPa7vF7w1
         1M1jukjBUwKS7VGH159PX22M2FMaStEUUk6B0VfyxGCT/aHN0QHQ75yjdZXkbB+LmN2O
         0NXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OpRgBHIbpOuAIRmC5hAbsG+gtGfST0EqR1Mz8i1XFZM=;
        b=F6LP05d3d8TXxLwqR6nScJ2K8h7cO8zU4bfp5FXHMMcAC/AXLIGbdwo1qOQ26JnWX7
         HQGCq39SNR8/yFfDFKkfiPu4bP6wpzqQHEzqTx//JD8+QoCzpfLF6JiH/6QzSMRnrTTI
         TuuoLpxMo4+yOJ4JrP4W1iji3lFUGwtlfP+h2iHzNI/lsSGzImDFixbwZHfNUqDu4rjD
         YsLraJmiIW/bwEZ+e05naOhKG5ii+4KuzrcfDZSyiPi1hchyaSnuQEfBO5QXQWCVBLZV
         BfEHHNrVbrweSXktbS6lf/jGUpAp2KDrRzwNdruN85d5j/OXQl915RQYFkiKTV6PhQ9Z
         Z7BQ==
X-Gm-Message-State: APjAAAUnQ8Ki79/gCjJjy+Nb8fFTiwW9D56n5KmiEKrkAl7ZdBw4Y8n5
        UJrnMo8olvFrOy9pBZX4AnGkg41p
X-Google-Smtp-Source: APXvYqwOIUx48Ioz//gnowWELX2etqP+2SsH3RYNkIRjAlKOq3WdHRPiGHQeDullIbpvvxD5qqopEA==
X-Received: by 2002:a2e:92c6:: with SMTP id k6mr4167363ljh.148.1561336327043;
        Sun, 23 Jun 2019 17:32:07 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id y5sm1495146ljj.5.2019.06.23.17.32.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 17:32:06 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/10] ARM: dts: tegra30: Add External Memory Controller node
Date:   Mon, 24 Jun 2019 03:31:32 +0300
Message-Id: <20190624003132.29473-11-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624003132.29473-1-digetx@gmail.com>
References: <20190624003132.29473-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add External Memory Controller node to the device-tree.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index e074258d4518..92c4aeafab29 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -732,6 +732,17 @@
 		#reset-cells = <1>;
 	};
 
+	memory-controller@7000f400 {
+		compatible = "nvidia,tegra30-emc";
+		reg = <0x7000f400 0x400>;
+		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA30_CLK_EMC>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		nvidia,memory-controller = <&mc>;
+	};
+
 	fuse@7000f800 {
 		compatible = "nvidia,tegra30-efuse";
 		reg = <0x7000f800 0x400>;
-- 
2.22.0

