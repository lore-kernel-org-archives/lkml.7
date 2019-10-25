Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9ADCCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AF6222CE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ER2j/UqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440307AbfJYMlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:41:10 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43858 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440295AbfJYMlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:41:08 -0400
Received: by mail-lj1-f196.google.com with SMTP id s4so1662424ljj.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 05:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IwcdyWxRDO/TUjQjvqfZVlSTaDYPWlQZLs741mWfW6c=;
        b=ER2j/UqVSwUAHLo4Mrnww4RdyHncxOt+lyD7CK40XfpSeF9zh46mxSVrXefq1dbdQq
         SK4pLpEx+99DSzB5FVd7ww025gdapgUXdzjPaYkwswtuzB6r0p/cjvuKl9Mra2EQzJbT
         Y1X9gx7BA1Twme6NVkPv2WJNBYSm15HQ3WcTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IwcdyWxRDO/TUjQjvqfZVlSTaDYPWlQZLs741mWfW6c=;
        b=qlpzXNDDVgXbDH6Dq+nQz86It7KbdO2w2AXtysxk4qikYO/TnvORAM+EoHr1mazW4Q
         Tcb4nMmhqoRERI4xwW1qcH7O/8g5/rCPsGXOzopmrKYEBgximcbvKL18PZhESUG1ev/Z
         Kslis5eOWPngC7wDU/NJ5c27x8g+k4F8J8U1ZJnqTBuHz4oXrsXiDrZP3a69lOc2Zad1
         N6yGybeyg54+caWopHQPF0hnjyT8SkLDrxuwqd1X6NN+1/jvBZlR/Wc63cazY86KldjU
         X9KsUfaPoKiKZlxy5QDtE6o2AAvZAQYWAamBygFZCKZpjw5mB92ke/6WsA3MWUyhjm4x
         q4xQ==
X-Gm-Message-State: APjAAAUQRKlDb0iQj2dcDjD7jtrzKQdcuAo40o2jCmvRhy1IDe3dYdTL
        oHqXDvatv1C2kSJySEfycTdTdw==
X-Google-Smtp-Source: APXvYqwysahdkFyTq3euhj9wcjVsQd23ylHoZzA6rJqlxIRVMOBd4gyepST20slS+5sWHRyxTpKKuQ==
X-Received: by 2002:a2e:8652:: with SMTP id i18mr2441361ljj.86.1572007264655;
        Fri, 25 Oct 2019 05:41:04 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 10sm821028lfy.57.2019.10.25.05.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 05:41:04 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Valentin Longchamp <valentin.longchamp@keymile.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 02/23] soc: fsl: qe: drop volatile qualifier of struct qe_ic::regs
Date:   Fri, 25 Oct 2019 14:40:37 +0200
Message-Id: <20191025124058.22580-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191025124058.22580-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The actual io accessors (e.g. in_be32) implicitly add a volatile
qualifier to their address argument. Remove volatile from the struct
definition and the qe_ic_(read/write) helpers, in preparation for
switching from the ppc-specific io accessors to generic ones.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.c | 4 ++--
 drivers/soc/fsl/qe/qe_ic.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 9bac546998d3..791adcd121d1 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -171,12 +171,12 @@ static struct qe_ic_info qe_ic_info[] = {
 		},
 };
 
-static inline u32 qe_ic_read(volatile __be32  __iomem * base, unsigned int reg)
+static inline u32 qe_ic_read(__be32  __iomem *base, unsigned int reg)
 {
 	return in_be32(base + (reg >> 2));
 }
 
-static inline void qe_ic_write(volatile __be32  __iomem * base, unsigned int reg,
+static inline void qe_ic_write(__be32  __iomem *base, unsigned int reg,
 			       u32 value)
 {
 	out_be32(base + (reg >> 2), value);
diff --git a/drivers/soc/fsl/qe/qe_ic.h b/drivers/soc/fsl/qe/qe_ic.h
index 08c695672a03..9420378d9b6b 100644
--- a/drivers/soc/fsl/qe/qe_ic.h
+++ b/drivers/soc/fsl/qe/qe_ic.h
@@ -72,7 +72,7 @@
 
 struct qe_ic {
 	/* Control registers offset */
-	volatile u32 __iomem *regs;
+	u32 __iomem *regs;
 
 	/* The remapper for this QEIC */
 	struct irq_domain *irqhost;
-- 
2.23.0

