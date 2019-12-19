Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5224C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 22:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADF524679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 22:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i7YNRON1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfLSWTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:19:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38740 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfLSWTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 17:19:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so7559027wrh.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 14:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=nhWrXjSnpH2QceyFXbqxKw6inPm9TBJwp6NEX3eK/pk=;
        b=i7YNRON1eodJqUDGgzXOLcxj/XOD0Fm3HQMs184nXWzFyqZmze5CODV+Z1u01qW/sE
         Dg2qV0PKf/QHa/MWfYwD8F1IZM8pXMeji1F7fFTVPrGr29AtZQA0gtVyZ9pWNMchVwWZ
         MzsNyZSHZ3+Zu5W5mNRhcvx1aBiq2qdcMpkEKtKPkIPAlXSp8lATixMTLA4XnRCRGO7S
         5viSYN9wefIHUcuvzev+IvnlAZUyINSZgJNzJ67ZclB4aq4surzlN9wc1r6Rfv2v/EOC
         wOmCmSVEHPb5GZnzr6qeenntLKqpThVus6cglY+oO8ux5fNIp7U4cMNk+d8wZc34uEE3
         swZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nhWrXjSnpH2QceyFXbqxKw6inPm9TBJwp6NEX3eK/pk=;
        b=OTkZlgdv7XGHe6vWoSog2Q2X4/1w2pIWlxsZqH83WZzWN+wAukxuIemsGATGT+YG5B
         8yS+8Y4e7uj6tjZIeKPfu+Mg/sWcI6w6ZNqytsH4baKrUPvOMxTgjdY5KORoTgbCbNTL
         W6spKqWFzFLSoS4vGvtj76nr7C5aTiyiVDZi0qMmYG1xtijrXaUD0YusYZEtdgrud6PJ
         BhXaLu3CaQLuA+H7q5OSxbCAfRHmX3h74Ct8gFVfzZHLksdF5gG9WD09xDccrKRIaMcp
         DIKvdGXWxJ33ggvKCl2dUoxnmfcfnl016OIgBU56aBbl4LzynsRr3rC9JMdG6sSTd4TZ
         BNJg==
X-Gm-Message-State: APjAAAVzI53iBWXDCeURmnE2yuZZkd5nTIQDBwMS4K3V7f/jOh/HA0jj
        f9/Qu2tnTVRxb0Z+Md4h9SEcpw==
X-Google-Smtp-Source: APXvYqxAb0pty85TOlb1yjs5LSkPrQ8phzG73IvcNBYbXZvy01PcgA7P+YBIhkxagWYrDWMbZWg9Sg==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr12005486wrq.196.1576793987998;
        Thu, 19 Dec 2019 14:19:47 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:58d:4e9b:2833:86c3])
        by smtp.gmail.com with ESMTPSA id n189sm8161765wme.33.2019.12.19.14.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 14:19:47 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] DT: bindings: Add cooling cells for idle states
Date:   Thu, 19 Dec 2019 23:19:27 +0100
Message-Id: <20191219221932.15930-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT documentation to add an idle state as a cooling device. The CPU
is actually the cooling device but the definition is already used by
frequency capping. As we need to make cpufreq capping and idle
injection to co-exist together on the system in order to mitigate at
different trip points, the CPU can not be used as the cooling device
for idle injection. The idle state can be seen as an hardware feature
and therefore as a component for the passive mitigation.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/arm/idle-states.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Documentation/devicetree/bindings/arm/idle-states.txt
index 771f5d20ae18..702a19b6b0b2 100644
--- a/Documentation/devicetree/bindings/arm/idle-states.txt
+++ b/Documentation/devicetree/bindings/arm/idle-states.txt
@@ -346,6 +346,17 @@ follows:
 	idle-states node. Please refer to the entry-method bindings
 	documentation for properties definitions.
 
+	When the idle state is used as a cooling device, the #cooling-cells
+	must be added in order to allow registering it.
+
+	- #cooling-cells:
+		Usage: Optional
+		Type: unsigned
+		Size: one cell
+		Definition: A cooling device specific information. At least
+			    must be two. Refer to the thermal DT bindings for
+			    more details.
+
 ===========================================
 4 - Examples
 ===========================================
-- 
2.17.1

