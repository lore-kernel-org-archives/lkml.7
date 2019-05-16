Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040ABC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 07:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C2C2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 07:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k49M8IvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfEPH2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 03:28:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37390 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfEPH2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 03:28:02 -0400
Received: by mail-pl1-f194.google.com with SMTP id p15so1178965pll.4;
        Thu, 16 May 2019 00:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XGByJB50qhjOEW1MHuUufGyQ+1XNyLAS4RXXQtspXjY=;
        b=k49M8IvVTT17Qi7G3qbTV82EJr5KBMjNovfVRYiNhVskivzffuKIdnYSspF0YwakAO
         K2doCcizrxg6kmFm4kcNm0qjMbI1mdPGymttMv/Y86L0U6Bljgjn5KUkw43xSj7M5tOW
         jlitQQQ6r7NmZUbowmAKp9IC2Zdfp9MJ3W65xK6nDHjOXh3gfPp5ZJgn03U8njHUFW+x
         YIl5l9W5qaduplsJg30z6HoUZR3FVTyBBOz1x6m8kg0DYzLg6AQPvfkMnTZqk3Hxm4L0
         TuxVYoTUGSh1mGuInMQZTxmovfQShZXnv31DIaPkFRbJzjaNTMxiOJKExsJDvijjo4jM
         nryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XGByJB50qhjOEW1MHuUufGyQ+1XNyLAS4RXXQtspXjY=;
        b=bQrp/WW/KbhPvrSQrTtL5Is1wO0Ih+ipFRTKx73E/WUjk7ty0xnioT8iG+Eh2mbp9a
         JlR7dG/dbj9nUa8Q5jjhnFe0DzJuWHkIl5VKvXF2yuk6omApoa4nmNC2MzBIr1SzVf3N
         FEj3DhIYNTvJyz/MiDtyvXd6REJsoLMsvlmaIYsv7VOWiPOss2VZtOby0lZybbHMVt9x
         xeIM7ZNz9YV+XlR9HFh2tXqtMexRo6Xpo3VWzKKwzdsy+FThChaf6mr5uNoATtCc3DqB
         XOPKpA5PFHs8zS8H3PaL9mgOEXHaF2CL+/PBBCNf5bojruJZdSm0Dd6dhawkDxILlbt9
         qQOg==
X-Gm-Message-State: APjAAAW4+MXDg4vUOqLUTGulHLMwh8hjVjnPJpxQfQ0HFJBiszaC9BEP
        GWlHtSQLdHb2ajTFN3Vtva3PXxtDwXI=
X-Google-Smtp-Source: APXvYqyEpyV0Gam6SpbSKLLk8Ct8g546tevJNXeRBvS//cl1+2pV9XcXmytOEY5JLMkIPbo42tG4Yw==
X-Received: by 2002:a17:902:7783:: with SMTP id o3mr11955428pll.21.1557991681457;
        Thu, 16 May 2019 00:28:01 -0700 (PDT)
Received: from localhost.localdomain ([107.151.139.128])
        by smtp.gmail.com with ESMTPSA id f5sm5099124pfn.161.2019.05.16.00.27.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 00:28:00 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Weijie Gao <hackpascal@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: ralink: add mt7621-clk.h for device tree binding
Date:   Thu, 16 May 2019 15:25:51 +0800
Message-Id: <20190516072731.21957-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds dt binding header for mediatek,mt7621-pll which
was added in:
commit e6046b5e69a0 ("MIPS: ralink: fix cpu clock of mt7621 and add dt clk devices")

Signed-off-by: Weijie Gao <hackpascal@gmail.com>
Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---

checkpatch.pl shows a warning that the line referencing old commit
is over 75 chars but if I shink it down anyhow it gave me an error
saying I should use a proper style for commits. So I chose to ignore
the warning and fix the error.

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

