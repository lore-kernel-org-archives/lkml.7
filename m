Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2699FC10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA112084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tWfpYMa9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbfDBGce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:32:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33447 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDBGcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:32:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id b12so6042339pgk.0;
        Mon, 01 Apr 2019 23:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K6TR0MKKqFzv/JFHfNJSn6dvEeDvf9PGgMl6oDHsxv8=;
        b=tWfpYMa96jMsAtI81uTIs8XCZhfcLaS9GLo3Dd7VzEK6cFQ/WIuOeMD0Nkb2AT+Oyr
         3itfZf9n5FTWIsKsP8SDdbhoMElcO8dxM23B8Fu2bJvUXGqzpSgq0+A64JOP1gxyUalV
         5s2VuiyIDl+wusnIn5wMUfuEKyWs33YFC2UoREMWi1xwRVcXlgSr5jfM5lN/WJG14ukc
         dHGeuSTjZwpGnK5vfWlr0XHy936RKfCewLVP4MLil/9Ksbe4JtK9Kits9FFXZS2V9vZn
         SsSQ4XwTQbna90UmjOiXxdUwahdDmtxjbYS411OCZINncA1cIS4jgHUJJWxYF9dygxyg
         6y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K6TR0MKKqFzv/JFHfNJSn6dvEeDvf9PGgMl6oDHsxv8=;
        b=UylSZ1eecvC2+uAeEd2749SPXCfYGu3TmWSh5fF2cizshfuTJQ+eAmSRKnozqW8zw+
         h043iaxdY4vDbgKXbs2Gy3Kj/khevpYsYq9XluTlgGnQNzf0BAo+5R6S1HmZho7m+0HQ
         3H2A24i2RTSLZmBK5Dn0MithO2IQcsc9Chj/mQEf0rD3M2WVGvYX9fndAEAC/XE28K+l
         DXuq1UebXVtC/MwPqfArgt2J3a/Jlpl4R8bSn4ru75sFUD2r7fsJMiqqlQIQNEAt36uX
         K4x/KJNwUnYQlZZ2Zz1xlgxZjw/PRC49dZjcoa8SnJIPehr4+x25SiOvWW4AwUKxWTm0
         N4uw==
X-Gm-Message-State: APjAAAXEGEptypDUL9/mslqyPekGaXRgy8DVPYWi/J3z5RA6dykqd3of
        7Anyg2bacpgNbLj99BFQo64=
X-Google-Smtp-Source: APXvYqxUCf1DUO7AHQFTZnrD2AGP+LDmUH4BvwkVqG3BeFLDf7eDaNAqWzFjlu69dzeioMteXtkqHg==
X-Received: by 2002:a63:e14e:: with SMTP id h14mr63716873pgk.184.1554186752567;
        Mon, 01 Apr 2019 23:32:32 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:4ce0:c70:4af9:86e2:2])
        by smtp.gmail.com with ESMTPSA id a17sm19327289pfj.123.2019.04.01.23.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 23:32:32 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jic23@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, akpm@linux-foundation.org, david@lechnology.com,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        thierry.reding@gmail.com, esben@haabendal.dk,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        patrick.havelange@essensium.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v10 14/18] drivers/clocksource: timer-fsl-ftm: use common header for FlexTimer #defines
Date:   Tue,  2 Apr 2019 15:30:49 +0900
Message-Id: <c82ce954006d9a228c7a6ebb0eabade48bd2c149.1554184734.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1554184734.git.vilhelm.gray@gmail.com>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Havelange <patrick.havelange@essensium.com>

Common #defines have been moved to "linux/fsl/ftm.h". Thus making use of
this file.
Also FTM_SC_CLK_SHIFT has been renamed to FTM_SC_CLK_MASK_SHIFT.

Reviewed-by: Esben Haabendal <esben@haabendal.dk>
Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/clocksource/timer-fsl-ftm.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/clocksource/timer-fsl-ftm.c b/drivers/clocksource/timer-fsl-ftm.c
index 846d18daf893..e1c34b2f53a5 100644
--- a/drivers/clocksource/timer-fsl-ftm.c
+++ b/drivers/clocksource/timer-fsl-ftm.c
@@ -19,20 +19,9 @@
 #include <linux/of_irq.h>
 #include <linux/sched_clock.h>
 #include <linux/slab.h>
+#include <linux/fsl/ftm.h>
 
-#define FTM_SC		0x00
-#define FTM_SC_CLK_SHIFT	3
-#define FTM_SC_CLK_MASK	(0x3 << FTM_SC_CLK_SHIFT)
-#define FTM_SC_CLK(c)	((c) << FTM_SC_CLK_SHIFT)
-#define FTM_SC_PS_MASK	0x7
-#define FTM_SC_TOIE	BIT(6)
-#define FTM_SC_TOF	BIT(7)
-
-#define FTM_CNT		0x04
-#define FTM_MOD		0x08
-#define FTM_CNTIN	0x4C
-
-#define FTM_PS_MAX	7
+#define FTM_SC_CLK(c)	((c) << FTM_SC_CLK_MASK_SHIFT)
 
 struct ftm_clock_device {
 	void __iomem *clksrc_base;
-- 
2.21.0

