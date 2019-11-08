Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F669FC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FEDC2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="eGaarsbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbfKHNCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:02:31 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40450 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730134AbfKHNCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:02:20 -0500
Received: by mail-lj1-f195.google.com with SMTP id q2so6132974ljg.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zHMD7aDRcAnceTlZ0tE45j1n7viMV+uwJbkB9Il7bT8=;
        b=eGaarsbw1EKw6pefhZScDY8YR32XWY0OK62VQmAXGwS02Lsok7Cew24ssbH7+23CdV
         pCNtXVY4hCMr1BBWQwaJnKG9A3nmttVVy/tw2ceMFowkpf0wPbzqZCdgPNs2LC+HYuL1
         fGPRoMpFjxf4hp3B19FgA4ZCX5/HrxQzcKJAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zHMD7aDRcAnceTlZ0tE45j1n7viMV+uwJbkB9Il7bT8=;
        b=Z6neywXBVqrMoyYkbeqsmAzjQB52RlldKSk2LiXps6ezUNrbq1paGhzh9bfe9hpgjf
         NI4LQCXyB4m7L1jmqbXbHfWe52jOs0hbBqYMmsskzTjYl6iYx0Dvvluyg1NuIVe+ubaM
         woB8lPnozerbgyPE/e+OXUJhXuUvJLos0cjlqm7+p2bGzBuRL1R9AGfsykNUkatXLPpu
         O31+IkMOpJnrFeV5UR6+s1vNd7WPj6j8GDu2f9ge+lv+AbCGXmvYFGhW/PvEzx2Odq6E
         PtMJUcDwDBoO7raOpok8y0YHZflxC05ogvfs7EeKQGe/0tOZ9dDiHEWwuVmCmDE2wqbR
         ciLQ==
X-Gm-Message-State: APjAAAWHynuUD7icRwSNMqRCP02EUsFc5y14fuR+oZKdwZhAKbF1Bvbh
        PmcP30OiZnK2IrNAnC2zqhS4nw==
X-Google-Smtp-Source: APXvYqyMeD/Z3Mfx+EKRD5Ea/1OpAHbYHw/xX9JRktv3gCIUdIApbq1aUzUWDJoePEO2SvwM0dFnVg==
X-Received: by 2002:a2e:94d6:: with SMTP id r22mr6708575ljh.7.1573218138299;
        Fri, 08 Nov 2019 05:02:18 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:02:17 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 40/47] soc: fsl: qe: drop use of IS_ERR_VALUE in qe_sdma_init()
Date:   Fri,  8 Nov 2019 14:01:16 +0100
Message-Id: <20191108130123.6839-41-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that qe_muram_alloc() returns s32, adapt qe_sdma_init() and avoid
another few IS_ERR_VALUE() uses.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index ec511840db3c..5bf279c679ef 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -365,16 +365,16 @@ EXPORT_SYMBOL(qe_put_snum);
 static int qe_sdma_init(void)
 {
 	struct sdma __iomem *sdma = &qe_immr->sdma;
-	static unsigned long sdma_buf_offset = (unsigned long)-ENOMEM;
+	static s32 sdma_buf_offset = -ENOMEM;
 
 	if (!sdma)
 		return -ENODEV;
 
 	/* allocate 2 internal temporary buffers (512 bytes size each) for
 	 * the SDMA */
-	if (IS_ERR_VALUE(sdma_buf_offset)) {
+	if (sdma_buf_offset < 0) {
 		sdma_buf_offset = qe_muram_alloc(512 * 2, 4096);
-		if (IS_ERR_VALUE(sdma_buf_offset))
+		if (sdma_buf_offset < 0)
 			return -ENOMEM;
 	}
 
-- 
2.23.0

