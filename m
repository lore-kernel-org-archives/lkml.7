Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC2FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C15120820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AUoSLdpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfDDAie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:38:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42194 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDDAie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:38:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id r15so414887pfn.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 17:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OQbWDfJcGsTny0umzfGxUknauZKQ9hwvFbMePNwP87E=;
        b=AUoSLdpGw3sMGjAwH/SKIxx5vgxP601M6t9ZW+vIvlDjbR/06N4fPsT6sfyU4Uu23A
         ieXdyBB4KjlyRMqchFhONOoZsZSCkzT0BbyCyVgId1iZtMLUvWk98Z09vU1OFIMyo109
         4MJAvmC5ekIpLmCxS2WQiz/rYI/d9iHaS7k9gBjPx5j+F3xCNOYiDrHfqOdk8h4YpO7B
         ZCSVCkPG9Ixel7s1pmmrmZ8pTyLR527Sd+lMRpNwoLLue4HKFYl77oISetRDyod/rEmN
         hYnSPvqUPxkO/jjXDwomZvmCRBqHp1+C9iaCVGag3zz1cJovax9lOJO+2VHkGoduYluT
         lN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OQbWDfJcGsTny0umzfGxUknauZKQ9hwvFbMePNwP87E=;
        b=IZ56qhumqSj6H/gZsiOWdRiYEsmwHFMHq4QlOKhjjoGFFOMXkFiNKrexjSapx3Px7U
         gGdLokJ0K80f9QbYEntqG6hX3KGYmSoP2U9tOkCNZIzE4I+f/gM5CNJ2tv7QxEeN3us4
         enESu+TkRqW/2XccO0p3IU3Yp98hA7M8Wk6T1e3YLykgEbw8ycuotutRWHwZ5IhMCkTW
         GqNDmv4tBhedwFJBcycf1BdO4HKb1Gz/3hfqEuBhaQgpgCQzMjnHPgzmPgCijkirSOlL
         3FxB6m846IYq0F/RTJmBb9Kgg2QXvmSHTLcPQsjSDXvWVTsMhwAjx8mwvehPUWtL7U4v
         8k4A==
X-Gm-Message-State: APjAAAUI2/bGCpQXt0L+LfV8aDcezn2s5XKIblaIf1SBvOhIYjv3w+Ue
        6CgTIrBV3ZMGQ9Wa9yk5FueRuw==
X-Google-Smtp-Source: APXvYqwuJoKd6QAAOUETvnqcXFZ2NLuD8m2VPdVyJHkPP7c0AchADYsDx/Eec+gG019ba6w6kHCCMQ==
X-Received: by 2002:aa7:814e:: with SMTP id d14mr2587628pfn.101.1554338312957;
        Wed, 03 Apr 2019 17:38:32 -0700 (PDT)
Received: from viisi.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id q11sm27470321pgs.94.2019.04.03.17.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 17:38:32 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     mark.rutland@arm.com, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, wesley@sifive.com,
        paul.walmsley@sifive.com, palmer@sifive.com
Subject: [PATCH] dt-bindings: clock: sifive: add FU540-C000 PRCI clock constants
Date:   Wed,  3 Apr 2019 17:38:20 -0700
Message-Id: <20190404003820.10679-1-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add preprocessor macros for the important PRCI output clocks
that are needed by both the FU540 PRCI driver and DT data.
Details are available in the FU540 manual in Chapter 7 of

    https://static.dev.sifive.com/FU540-C000-v1.0.pdf

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Wesley Terpstra <wesley@sifive.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
---
Rob, Mark: this patch is a prerequisite for both the FU540 DT data
and for the FU540 PRCI clock driver patch series.  To prevent one
of those patch series from depending on the other, I'd like to ask
Palmer to merge this patch in one of his -rc pull requests.  Could
I get an ack from one or both of you for this purpose?  Thanks.

include/dt-bindings/clock/sifive-fu540-prci.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 include/dt-bindings/clock/sifive-fu540-prci.h

diff --git a/include/dt-bindings/clock/sifive-fu540-prci.h b/include/dt-bindings/clock/sifive-fu540-prci.h
new file mode 100644
index 000000000000..6a0b70a37d78
--- /dev/null
+++ b/include/dt-bindings/clock/sifive-fu540-prci.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018-2019 SiFive, Inc.
+ * Wesley Terpstra
+ * Paul Walmsley
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_SIFIVE_FU540_PRCI_H
+#define __DT_BINDINGS_CLOCK_SIFIVE_FU540_PRCI_H
+
+/* Clock indexes for use by Device Tree data and the PRCI driver */
+
+#define PRCI_CLK_COREPLL	       0
+#define PRCI_CLK_DDRPLL		       1
+#define PRCI_CLK_GEMGXLPLL	       2
+#define PRCI_CLK_TLCLK		       3
+
+#endif
-- 
2.20.1

