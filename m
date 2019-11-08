Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AA2C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DE4206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="DMLQ9nUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbfKHNEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:04:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32858 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbfKHNBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:01:43 -0500
Received: by mail-lj1-f196.google.com with SMTP id t5so6155678ljk.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=td9IeMtAnKP3TNZfmfJvazvskLsY9wm2/Illqt7TzBU=;
        b=DMLQ9nUi/AbgTBbJ3HQVt3S0hzf3vXc00jBHDaFBntgkl2BTiXVwIDJ/98hlURH5xi
         Fs8QirI31MeGV4shgHaQ0WBywX4sGE+Pkg+PmRddhK4zvBzkMBVVR5DB3sKZ1o1xZ8k4
         YkMCzlDg87IAVaAjLDSvANrSeF4AmSQ+EJgXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=td9IeMtAnKP3TNZfmfJvazvskLsY9wm2/Illqt7TzBU=;
        b=SPUchYyUUrtCVXKYsTQqtTIcNmhMHKOTRUV7NrJ86UobsqVMF9LHa7l0lDB46lkpIf
         0fVhVAITzVEtYb1vYWwEj5OLkfAya9rTE8DJc8qygfTvR96K+Xa+eI8JRfse1GlNv2D1
         q4DnfxD9CXRaXbevz2+PluwUyY6O4aFUx9L3HPl6LL1wMmG87yvPdvd6zn4BTV4gNbs6
         uqgx8p7rag3tyaphtxc6ToXOQltDoE2b3wkOIWI5vPM5byZtLOHyhVxJZEY+kN/yUWcB
         QKeyFYHc83KjA8vlLz7XqhAou5Bh7iT0+qPk6M3fBtdA6qq5sHXmgCNP4hKJW7pa/EGR
         En4w==
X-Gm-Message-State: APjAAAWlOZhi8Vm7wUieNXetdVIzMpf2LMFADQnAhPtKezrPF2ox1fQ6
        WVBw4/nvPFD4j16OySaNzHXQ0w==
X-Google-Smtp-Source: APXvYqyxlnBPq1NoCHx0PDNAwhYb5u9L3MYUqw3oNmiwy+4LPvN4tGWz6tWvL/Vb3qkNfPZOcqdSpw==
X-Received: by 2002:a2e:9659:: with SMTP id z25mr6859818ljh.132.1573218099542;
        Fri, 08 Nov 2019 05:01:39 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:01:38 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 09/47] soc: fsl: qe: drop assign-only high_active in qe_ic_init
Date:   Fri,  8 Nov 2019 14:00:45 +0100
Message-Id: <20191108130123.6839-10-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

high_active is only assigned to but never used. Remove it.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 8c874372416b..4b03060d8079 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -320,7 +320,7 @@ void __init qe_ic_init(struct device_node *node, unsigned int flags,
 {
 	struct qe_ic *qe_ic;
 	struct resource res;
-	u32 temp = 0, ret, high_active = 0;
+	u32 temp = 0, ret;
 
 	ret = of_address_to_resource(node, 0, &res);
 	if (ret)
@@ -366,10 +366,8 @@ void __init qe_ic_init(struct device_node *node, unsigned int flags,
 		temp |= CICR_GRTB;
 
 	/* choose destination signal for highest priority interrupt */
-	if (flags & QE_IC_HIGH_SIGNAL) {
+	if (flags & QE_IC_HIGH_SIGNAL)
 		temp |= (SIGNAL_HIGH << CICR_HPIT_SHIFT);
-		high_active = 1;
-	}
 
 	qe_ic_write(qe_ic->regs, QEIC_CICR, temp);
 
-- 
2.23.0

