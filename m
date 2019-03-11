Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808F2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49633206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SwzRnbAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfCKGfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:35:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36780 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfCKGfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:35:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id n22so2990271pfa.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 23:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ssNQT9HiuVSvo4AmSqcCe40slJgH7PCwZwIQFMP2sww=;
        b=SwzRnbAjCUxkK+Z2mOzgRqIhTH5zHhEEy3yqvZE6FCwIiSNWRzhGKDzDcvA0j+1veQ
         AX6jPRdCvz5RjjVJ4i6uXoGrz8TVCmeE3r3jZP6qS30m1Yti7QvPgzNUnUrDE5tUEPev
         Fk0ukM//OLs69UhXx6eRcBzUuel+QJSnfflic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ssNQT9HiuVSvo4AmSqcCe40slJgH7PCwZwIQFMP2sww=;
        b=PC2tS/7jepVWqIrsNsbD1k0DoK7tlgevEVkxa30Qs8khWxVqEom8/o0fOa60liYRK+
         AIInFd+5Uxaga/0m1HdH2I9NF10890LM1CJ34+mz+PaEid5ggSbBiP/Ws9oBGmLB+sHy
         NmcAWz4sPQFMcLd4RTnY4n6asiUDY2B+BsJ/vX3+SYNrgWk2FBZzqWwt3wAIm4PDtaw3
         6wTG9qmWViEIdtO3jUAB2x869I3RHWmU3qVhbm265HFiu2AY5uo70N9zew5gO96MsiHj
         Y7pCOVE7Rk/X5U0E995Jmxg9FWzjkwMXyRVOZOGpWyhOKGfnn4eHfuYy1Gkl5hlcyOU7
         M6Sg==
X-Gm-Message-State: APjAAAVepOvAl4wsqTfQqJ9q/CfIL1qrC7Na86icpCu0glZQ0iCXka8c
        wPZ8CDOnC08NqzwPDlWD3Y662Q==
X-Google-Smtp-Source: APXvYqwh7jw9WacyKmgDAfbO7xEF+urqCv/9vDCXPpCdXhptE4Ym0XyWp9gEJWoppKoqnLbHBSqhnQ==
X-Received: by 2002:a17:902:8218:: with SMTP id x24mr7991172pln.219.1552286113466;
        Sun, 10 Mar 2019 23:35:13 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id p5sm6573040pfn.154.2019.03.10.23.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 23:35:12 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>, Erin Lo <erin.lo@mediatek.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-remoteproc@vger.kernel.org (open list:REMOTE PROCESSOR
        (REMOTEPROC) SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 1/7] dt-bindings: Add a binding for Mediatek SCP
Date:   Mon, 11 Mar 2019 14:34:52 +0800
Message-Id: <20190311063458.137473-2-pihsun@chromium.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
In-Reply-To: <20190311063458.137473-1-pihsun@chromium.org>
References: <20190311063458.137473-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Erin Lo <erin.lo@mediatek.com>

Add a DT binding documentation of SCP for the
MT8183 SoC from Mediatek.

Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
Changes from v5:
 - Remove dependency on CONFIG_RPMSG_MTK_SCP.

Changes from v4:
 - Add detail of more properties.
 - Document the usage of mtk,rpmsg-name in subnode from the new design.

Changes from v3:
 - No change.

Changes from v2:
 - No change. I realized that for this patch series, there's no need to
   add anything under the mt8183-scp node (neither the mt8183-rpmsg or
   the cros-ec-rpmsg) for them to work, since mt8183-rpmsg is added
   directly as a rproc_subdev by code, and cros-ec-rpmsg is dynamically
   created by SCP name service.

Changes from v1:
 - No change.
---
 .../bindings/remoteproc/mtk,scp.txt           | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,scp.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
new file mode 100644
index 000000000000..3ba668bab14b
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.txt
@@ -0,0 +1,36 @@
+Mediatek SCP Bindings
+----------------------------------------
+
+This binding provides support for ARM Cortex M4 Co-processor found on some
+Mediatek SoCs.
+
+Required properties:
+- compatible		Should be "mediatek,mt8183-scp"
+- reg			Should contain the address ranges for the two memory
+			regions, SRAM and CFG.
+- reg-names		Contains the corresponding names for the two memory
+			regions. These should be named "sram" & "cfg".
+- clocks		Clock for co-processor (See: ../clock/clock-bindings.txt)
+- clock-names		Contains the corresponding name for the clock. This
+			should be named "main".
+
+Subnodes
+--------
+
+Subnodes of the SCP represent rpmsg devices. The names of the devices are not
+important. The properties of these nodes are defined by the individual bindings
+for the rpmsg devices - but must contain the following property:
+
+- mtk,rpmsg-name	Contains the name for the rpmsg device. Used to match
+			the subnode to rpmsg device announced by SCP.
+
+Example:
+
+	scp: scp@10500000 {
+		compatible = "mediatek,mt8183-scp";
+		reg = <0 0x10500000 0 0x80000>,
+		      <0 0x105c0000 0 0x5000>;
+		reg-names = "sram", "cfg";
+		clocks = <&infracfg CLK_INFRA_SCPSYS>;
+		clock-names = "main";
+	};
-- 
2.21.0.360.g471c308f928-goog

