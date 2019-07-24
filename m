Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492B6C76190
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCCB229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3Nes+Y9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbfGXCYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 22:24:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33216 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbfGXCYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 22:24:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so21291483plo.0;
        Tue, 23 Jul 2019 19:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZnbumCREj6sZK3wsFFVAfbJwjr1IchFH+4M4kBo6km8=;
        b=g3Nes+Y9kIKm0x4z3mRtQqmfZa4BMECs4BxTq6WGlCxFGhlbYPtwIP+Uq1iQBA6y9H
         Jvvap5cSjhxQI+xsu5KrRaiotz+CEaY4X7cSogiuiHVVn0AGazbVqrZoom+vLiqCqd71
         hPNlWaUDrJkRpe4ITTufGsWZSBr2THIX3ecUVm7FvfGvERvTG6FLS80rNQ4qNKYJg1ir
         fsJ4/Gj5fOz91y8trrvrHuaRMX+q59sKT6yOUykTkfuAJMmQrqfJ7HwLw0rKEUKo8Hb8
         ko/tdMsdF0h5bHPW1Vfr/ATrzx/OKyCE3Kp6VGXnvaldFnwv0y0jP8rqQVWLnqSjGOdf
         EzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZnbumCREj6sZK3wsFFVAfbJwjr1IchFH+4M4kBo6km8=;
        b=HY+axqBOGcR+BLvAHrJ4WHSDkmjRzj6nWucj3SKZUKOs2u6VKN1kJJz3N6oQBWf42P
         HDZZ6xsVmJJ9r28VLwiDBSkd7tmgi1oGfpCkF0+EUfUVhcLZBj03BZQ6RMRafa5FKhxj
         VC1iG0nbR4vprFDUBx/i/e/3FfTnP82Y0Wx2xLEN/Rl4qv4mI+W/z1K+QKyAj+bs81Cz
         WF4BwU/SZjtucb9it/ICL6YJKy05K0pEtIzBV1iPJjJvlXfEvy8lNdxotDXF1GiGi6AM
         OJJXvVuFzx4GwebKXfC5CqlqgjIperdeCafmQo7TUmzuT+oD/aZ6MCbOAxbNM5CNvjaO
         PbsA==
X-Gm-Message-State: APjAAAXyOrYUBQQa4XDVB2Nn9OYSe93GltCv6u5PD0Os45g/CYRJ4hIw
        O4v/6kC6anRTqwHBRqtvSMSJbJNvBd4=
X-Google-Smtp-Source: APXvYqyPIf+xjqNW9Oiwp312pSP+M75l49IWHS96NTEDKDy6wqOdQnNpLhmQiqtfoskbTvOJ2ajxUg==
X-Received: by 2002:a17:902:2865:: with SMTP id e92mr44040013plb.264.1563935058635;
        Tue, 23 Jul 2019 19:24:18 -0700 (PDT)
Received: from guoguo-omen-lan.lan ([107.151.139.128])
        by smtp.gmail.com with ESMTPSA id s185sm63468029pgs.67.2019.07.23.19.24.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 19:24:18 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        linux-mips@vger.kernel.org (open list:MIPS),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM)
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        John Crispin <john@phrozen.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Weijie Gao <hackpascal@gmail.com>, NeilBrown <neil@brown.name>,
        Chuanhong Guo <gch981213@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/6] dt-bindings: clock: add dt binding header for mt7621-pll
Date:   Wed, 24 Jul 2019 10:23:05 +0800
Message-Id: <20190724022310.28010-2-gch981213@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190724022310.28010-1-gch981213@gmail.com>
References: <20190724022310.28010-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds dt binding header for mediatek,mt7621-pll

Signed-off-by: Weijie Gao <hackpascal@gmail.com>
Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Change since v1:
Change commit title prefix.

 include/dt-bindings/clock/mt7621-clk.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 include/dt-bindings/clock/mt7621-clk.h

diff --git a/include/dt-bindings/clock/mt7621-clk.h b/include/dt-bindings/clock/mt7621-clk.h
new file mode 100644
index 000000000000..a29e14ee2efe
--- /dev/null
+++ b/include/dt-bindings/clock/mt7621-clk.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Weijie Gao <hackpascal@gmail.com>
+ */
+
+#ifndef __DT_BINDINGS_MT7621_CLK_H
+#define __DT_BINDINGS_MT7621_CLK_H
+
+#define MT7621_CLK_CPU		0
+#define MT7621_CLK_BUS		1
+
+#define MT7621_CLK_MAX		2
+
+#endif /* __DT_BINDINGS_MT7621_CLK_H */
-- 
2.21.0

