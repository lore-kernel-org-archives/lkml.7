Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021D6FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B609B2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="TILqTlkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfKHNBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:01:32 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46556 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfKHNBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:01:31 -0500
Received: by mail-lj1-f194.google.com with SMTP id e9so6088614ljp.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7uK8xEnPEigQ7dFIza6M7Wg35/gDKz/RHXvPNwcggqY=;
        b=TILqTlkBAuI6LOruaKTEZxzFTZzeG4DApGwSCJnlKakYgy7KP0WRPjM1EGJV2b3OJD
         T8LUksBB2SOF1ipjFU8+h3T3RVUq3rPmEAI4MLhbWoap/mLn0Zb2aMx+Wo4G8VaJCWHr
         zhOuihFDFHqD+4SnIA6zEd5vQn63cVeNEZE8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7uK8xEnPEigQ7dFIza6M7Wg35/gDKz/RHXvPNwcggqY=;
        b=USGT8eVDV26ogO8jD5Nx10vpdXgNsdri6l7by8AMUWcy3NIAOniV5QQVjIFs5xvymR
         SEemjCLUW6eQS16BuWvr4u/MbKVpOtdFlDbb8Ijl7fW9kYKpasf9aueZUNmgxbJotRqu
         7dJMPR/u55EGcLBgD1ZlsrVzVSlZDSDf+oW1oqTJx1BqQaCgDLraERMPK56ex0rloG/d
         ch5jfBIYzwFomzkBpM+j0+uym1Mw/dd2FfvJwM+JeNNGICOI/BT1ejBqekm9KpzWAv4c
         hdr1Duy0HGVd0jmb0Y5bn0jY1LlYUamAHgkJBjwBcm+yT1+vjgfOXQt78TYDQn9nkOUn
         S0Ng==
X-Gm-Message-State: APjAAAWWeBHfrZznQYTh7CYckd/5HFpFl8dcXu+L4QACEB0opRjBTZtB
        SJDzgY8TBSnNa0pXiR1kc803gA==
X-Google-Smtp-Source: APXvYqx/4gr4npNtwela02AaJ5wBwQ4mC75A3/zTLGhWUSCRRkJJXBY71RvLrCS3I1ZkuT+Gn/IwPA==
X-Received: by 2002:a2e:9a53:: with SMTP id k19mr5918980ljj.246.1573218089195;
        Fri, 08 Nov 2019 05:01:29 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:01:28 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 01/47] soc: fsl: qe: remove space-before-tab
Date:   Fri,  8 Nov 2019 14:00:37 +0100
Message-Id: <20191108130123.6839-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 417df7e19281..2a0e6e642776 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -378,8 +378,8 @@ static int qe_sdma_init(void)
 	}
 
 	out_be32(&sdma->sdebcr, (u32) sdma_buf_offset & QE_SDEBCR_BA_MASK);
- 	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK |
- 					(0x1 << QE_SDMR_CEN_SHIFT)));
+	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK |
+		 (0x1 << QE_SDMR_CEN_SHIFT)));
 
 	return 0;
 }
-- 
2.23.0

