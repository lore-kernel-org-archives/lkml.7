Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1C7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8375D20811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CVBOlK1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfC0FPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:15:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33861 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfC0FPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:15:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so9395488pgq.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 22:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ykf4Vr8+YQBu3HM6TlXuYVSTHQZbeQlUQPTrMnE/By4=;
        b=CVBOlK1q8uHo6tNUBZaTCOsxGeGTOVtpB6BfpXH+/iXWEv+xbGh6pYlYpInM8JB0Fa
         v7o4UcUfADVxYgmwqXSaMBLGA3Uv6oWl7I9lsh7AamiV9b+9RDaA+j9EGWwMzBae5fBa
         sXCJVGTcsikC6RNfuGMPWMWoU9ckjuitzQ+g4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ykf4Vr8+YQBu3HM6TlXuYVSTHQZbeQlUQPTrMnE/By4=;
        b=LDwILICa3AfPwQcxNFIILNhRR1//vfZC1e17QU/EEeA9whnNuzIX3t46JD1Xf+R3Hq
         +M+YKw+6iDMeplI+zUYszrCKfSzdMGKMYMBZOZheiz0cTWPzNn0I61y6VvPzHiYdzLQn
         RHHQuJJN5raWIBC+AifhHG1eN+CXfhB0sIUgyo1JhQmzcZJ7woSybSUGIO0H3JpUgDuO
         4Q4Wd66f1Vp/CONKN8nnmLxQPjMZsE0a8Mkpq1gyrjq5f+GpsJrG7r9e1UwaxyCR5akO
         qM8LKiEePIrLNn13ceeItHaIV3W/auPkNBU8ZU+SFi6RlMsB9BfV5UKJ4P1ay1GThWXD
         uAjg==
X-Gm-Message-State: APjAAAW+mzXw2RJdfnyJAk65Elq4o8FYJWbs0oQCqKcfhE5U85fGtaVb
        5JAtOjTfefLL/oh2EjadOY2HvQ==
X-Google-Smtp-Source: APXvYqyP7GLs2iBEgAEnBvpKsM8ipQ7h2tK6i4K30swdkFxy2VhaZMOaRa6ufIxQWtoPOvyZW615NQ==
X-Received: by 2002:a62:b40b:: with SMTP id h11mr24147278pfn.133.1553663701403;
        Tue, 26 Mar 2019 22:15:01 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id k72sm58622609pfb.122.2019.03.26.22.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 22:15:00 -0700 (PDT)
From:   Peter Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>, Erin Lo <erin.lo@mediatek.com>,
        Rob Herring <robh@kernel.org>,
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
Subject: [PATCH v7 1/7] dt-bindings: Add a binding for Mediatek SCP
Date:   Wed, 27 Mar 2019 13:14:43 +0800
Message-Id: <20190327051450.16222-2-pihsun@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190327051450.16222-1-pihsun@chromium.org>
References: <20190327051450.16222-1-pihsun@chromium.org>
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
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes from v6:
 - No change.

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
2.21.0.392.gf8f6787159e-goog

