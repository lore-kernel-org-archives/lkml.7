Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CE2C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1C12184B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzICmywM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391429AbfEXRYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:24:35 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44308 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391273AbfEXRYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:24:32 -0400
Received: by mail-lj1-f194.google.com with SMTP id e13so9299704ljl.11;
        Fri, 24 May 2019 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jX9jSPoknvc5J7MjiliCqU6YnL7woTcrtYt9debrJo8=;
        b=HzICmywML7dNNYf526T4yXnbvvYwN9GHBu9iyq4xa9l7vdkyP0RJv2Eq81fKpVLHol
         27LuMeQFKAh5hkr6xvKTrhHkCRuLs5cfPaF+gMacOKAsuGO3v0vI/HzXOoP1sH5maPAh
         ny46aNSVMbrunTV5h83GBKs2K7yum/bp9Kd+PxiItKGsMuty8mawjRUST/CfjznIWf9x
         NUN0MIM7m4SNB+wxD5jT49n9jf9Yl1wmH8AUwkrDnp8rC110WmmUyzxdZd1Q+Fhi636+
         AqZYxE3LfjxjnVqmrYF2/Bpo0WVHbHFbjfmtn0fLZxHOHMvVt7qfqB8jcC9zlkrw1YFM
         N77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jX9jSPoknvc5J7MjiliCqU6YnL7woTcrtYt9debrJo8=;
        b=KjJCXdXtbZd6YxYxLF+To7JUqSwUhfWh3ai+PnMHwQRK4DecgS6hObuJWTKJqXWUnr
         QHX3LrSzw8OUvQbpL4I4N9PVlW4Dy5gA+3HzBZJLocuYk3gsfpBQmpMlkC7cOvuJnPdd
         gDm5A56lSMRdoyCVtL45dyTvJc/RBtCaGxRBdreUmA2g5sxy9kKsysn/6yluVoXR4JVP
         l1OosUGPds7+KllsjKR/aEtIz8dnwhRuP+iIpln6iOCxhTfWmTDTw+HvP/nAgVYomVA0
         wDLJ9ysB7uyUGMlZmgKKJLSiSjWcGfJwA11C2E3H5Go41q0bWjgqek8+jzuYfLsB1tgg
         9LRQ==
X-Gm-Message-State: APjAAAXqPn+RNUR2ogeYxJ3cpXgsiHXqRsJk50QAFfvG7n+7A2XfjS+l
        1FGIEzDP7SUq6azO34n5Nsg=
X-Google-Smtp-Source: APXvYqxia7CZHs66fTPXo33YqXyuk4zXwUYBd32/y6nx3/106ieo0PzVMzR4eWC0y0rPU81iaN9s1A==
X-Received: by 2002:a2e:548:: with SMTP id 69mr17090696ljf.176.1558718669710;
        Fri, 24 May 2019 10:24:29 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id d13sm196957lfm.27.2019.05.24.10.24.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 10:24:28 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/8] ARM: dts: tegra30: Add External Memory Controller node
Date:   Fri, 24 May 2019 20:23:53 +0300
Message-Id: <20190524172353.29087-9-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524172353.29087-1-digetx@gmail.com>
References: <20190524172353.29087-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add External Memory Controller node to the device-tree.

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
2.21.0

