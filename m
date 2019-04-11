Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A616C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681EC2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 23:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfMN7cJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfDKXDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 19:03:35 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39097 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfDKXDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 19:03:31 -0400
Received: by mail-lf1-f67.google.com with SMTP id z9so5959608lfh.6;
        Thu, 11 Apr 2019 16:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fm0zR05pFfCB61HXo/Y1EppostOOVPX/1as4YANTCFU=;
        b=GfMN7cJhgWqXJ2wODqqhGP28q1+EXRMte+JgQwj1+cEDB2Prk4xuhK5SrPjxy6h9L8
         pBT9VbrHLKFUH3CtQaoT5UCaf6zG+ymFWJkxsuxZLAeaNTknm1btDTNIiojeRTJz7EpW
         IIPw84em5uGGrleXlQ1SvwTPhvGYXPEq3YHsyII/+hVEcViE3fiHV6fjnbdsV/q7gAYH
         Pe9a3jnySewBr9K/O52msipjN68U4b/2WtS1r6LAGqLCTusOfw0107+lrgmarbmm/GIY
         xUx7+NrOsMRqXIz353v2MaHcU6L+26NpemmGQy54J+nvyhS62QTt+NKBRKo2phMRCgtg
         b6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fm0zR05pFfCB61HXo/Y1EppostOOVPX/1as4YANTCFU=;
        b=VXnXdZ04gV4EoR/kw5HS4ZGUETW73nYYcQcRtXkYciKMN0/BCwwBe75un4+0Z7tOOB
         9qNIjqJEoIbAlyoj5Iy9/rZ82jUNLXqafxS8X/tujyThFt68fHWqEUOuKIiHMmw5Hyu8
         BkiQHrnbNPXOkCAVjQKTUNhnmZxvaYj/27qt4NdX/9uwl/cYbby/n7s8fj19IObRuPUh
         LQc13mM6t4uxq9h41hSvNB/M+n3QDlhJy9JRpTWuPYe/hrKLkcMwVAfYxIFqv0Jj0DFX
         59ojxGm6GEModbVeCHAR/wwg0aNF5JLpl45I5Q2K3y4q5zk+DlQ8cxIrcaeyV2Y9i/ou
         Sfvw==
X-Gm-Message-State: APjAAAVqQaeSqHp+VYatIja4SSLeqGkh6WEy5+n9FTpUnKyg/9ULh2un
        6waBFwA7HVuDfcovUaDukjg=
X-Google-Smtp-Source: APXvYqw3CC1e247+pyhLEurYeU4FqvvzOuykfkA9Q887CIEc5bFaA37RaDsjG6jI8HxsvlVIJfEWZw==
X-Received: by 2002:a19:7702:: with SMTP id s2mr9346217lfc.102.1555023808748;
        Thu, 11 Apr 2019 16:03:28 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id u19sm7764486lfg.74.2019.04.11.16.03.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 16:03:28 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] ARM: dts: tegra30: Add External Memory Controller node
Date:   Fri, 12 Apr 2019 02:02:21 +0300
Message-Id: <20190411230221.31362-4-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411230221.31362-1-digetx@gmail.com>
References: <20190411230221.31362-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Add External Memory Controller node to the device-tree.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30.dtsi     | 11 +++++++++++
 drivers/memory/tegra/tegra30-emc.c |  3 ++-
 2 files changed, 13 insertions(+), 1 deletion(-)

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
diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index 38ebdb076ccd..defdb38bde54 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -980,7 +980,8 @@ static long emc_round_rate(unsigned long rate,
 	}
 
 	if (!timing) {
-		dev_err(emc->dev, "no timing for rate %lu\n", rate);
+		dev_err(emc->dev, "no timing for rate %lu min %lu max %lu\n",
+			rate, min_rate, max_rate);
 		return -EINVAL;
 	}
 
-- 
2.21.0

