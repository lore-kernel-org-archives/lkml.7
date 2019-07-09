Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4BDC73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38E12080C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVwNMuiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfGISWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:22:08 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44470 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfGISWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:22:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so7424046plr.11;
        Tue, 09 Jul 2019 11:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ak4mzSvdCfIFRyuGPxe/qi9F59UZumKoJWlYz5x99d4=;
        b=bVwNMuizuvDgv2KPg7ltY+o20vUNid+RnTHfmiKZZUzNowuOpFARNPxvE8bNHXayHY
         pUv8u2BllrEXCroFgW5CoVNdW6JTSkpe5kVT/gwkRIJO6AERV6GL/PkBPVLYxe+TBkRq
         lsy2gWFnhr7DBvz/wipzWRwTDaZK3h5J0lFGxk04aORXv0kPqJvH8B+Mb7YpqhgF//pD
         0CcrRRapAI6CW31SBtaXEO1ZPDxrKuQvsioJhd4H9tRk4IG5lPeC98/VyRXbV9KBATHC
         WsIf3dGLhXEt7Pj4NEVy6pmLnmr9r7xkJfeYnguBH5nA/L9DGAMjztKPBxUSRIpjFKnW
         V+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ak4mzSvdCfIFRyuGPxe/qi9F59UZumKoJWlYz5x99d4=;
        b=O8OIfKLA7mYD3E1+AtTA87i1iGRaYve3umzE/X42iJkMn6o+2sS3IjQ6zwi5ZC4Iap
         B9BSrj+flBjzxhsfi1oUtZtOAoE3ifYNYdtlX4r64W3xA9xuAqJtwg6CnvMc8MxhuQx8
         pbvYG2NQBkpu7PIXP6/FETvtxcFxfLs+1Ue07PfkNwjv/XPmpz5h1mzYmdwSmp304Dfd
         27RFtLIMpjDWm9TYBPHj0r31Z+FF6zGJ+UmLxgzV+7UqIwG8tiaipJPfM2jqoZkqMCVu
         GZJkBzNl7exrO5et7JkyEuq25e8akmN00xABUGpIFCIPZOpp9T74pXwJKYHRcneF7Iy0
         nIzg==
X-Gm-Message-State: APjAAAVcQarvJssQ2BhvP8UtH8ypmoKMXAqSqYhAimffplfQmuv/eMOg
        CvrRrf5bFbuo8IjF+JXpFUzNSUTUNedClA==
X-Google-Smtp-Source: APXvYqwFwa+aooo4ZK2UYKcp8xR3hrxBNFAO5s5Q79PSnO0tyhUxtWOG8e7TC/CKqZP+Y5yP4JlozQ==
X-Received: by 2002:a17:902:b702:: with SMTP id d2mr33420940pls.259.1562696526193;
        Tue, 09 Jul 2019 11:22:06 -0700 (PDT)
Received: from localhost.localdomain ([2001:19f0:7001:2668:5400:1ff:fe62:2bbd])
        by smtp.gmail.com with ESMTPSA id m69sm21008639pga.11.2019.07.09.11.21.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 11:22:05 -0700 (PDT)
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
Subject: [PATCH 1/5] MIPS: ralink: add dt binding header for mt7621-pll
Date:   Wed, 10 Jul 2019 02:20:14 +0800
Message-Id: <20190709182018.23193-2-gch981213@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190709182018.23193-1-gch981213@gmail.com>
References: <20190709182018.23193-1-gch981213@gmail.com>
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

