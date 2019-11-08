Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64BAFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CB5206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="XVACoOOu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731517AbfKHNDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:03:03 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34255 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730799AbfKHNCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:02:25 -0500
Received: by mail-lf1-f68.google.com with SMTP id f5so4431846lfp.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2QjvBFt/Ahp0rywmkIDhfkZ7dAuBAKpWua4zqIA54R0=;
        b=XVACoOOuXlxl4Cy3V/J8sGSeCCFw8ZKOKZ7FqB/K3JgCxUCJ1xCj/Mqawr8e2qIujx
         O7k1zBR8675/UVFNVWJud7B7gGy4eRxvGFDaQiIdBxLuh/UvxbGJ2jiZIbbPNPtq2kf0
         ZABUDJvpYchPCeIhdPhVBPmgejb6251Cuy5iE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2QjvBFt/Ahp0rywmkIDhfkZ7dAuBAKpWua4zqIA54R0=;
        b=VRhwAVMXgidrgP9FUMsPJR63Uk2Tzk0X/msf1a/rcHgpVtFYskj4djQKuWkb/pgdj0
         LO/XQwDAu07+dLv35XyFQaaUhRCbRP7rm6WWvbfgQQIzRSOqFWUcwQuGIrpxGuExZzRF
         2OtXky2FGwB8t6SUj8pkIxWHbygSjhYtBlrIyTyXFajW+yqJAHsogyc4emQxJ3k+ZMWi
         4eQdo2Dw+mI84GidphlLFe/fw/CksiBqbKBZOwIBwVRaRaRmHnlQsUZo2Jv/58wV7lmQ
         IlS88JMNApo2A4S0Oa83jFj5HPukkfPbRgFAqxdeGeRzqZZvNozopciVhwiuJ6PuCMdR
         /LfA==
X-Gm-Message-State: APjAAAX/XiLwX4H1yNK5tFtqaj2IvmMXYOAQm6cWxvO920ZWa9HBC7aO
        KAK6zphIO3ob5U1J7zS0xXkaAQ==
X-Google-Smtp-Source: APXvYqwScoFAHiImQMnrTZk87e9zBJh2EkwdHqWoi9bG9XRi4pfN3RXUv9ZB5CXwEIsQqOH7j53G/g==
X-Received: by 2002:a19:820e:: with SMTP id e14mr6605403lfd.29.1573218143917;
        Fri, 08 Nov 2019 05:02:23 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:02:23 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org
Subject: [PATCH v4 45/47] net/wan/fsl_ucc_hdlc: reject muram offsets above 64K
Date:   Fri,  8 Nov 2019 14:01:21 +0100
Message-Id: <20191108130123.6839-46-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qiang Zhao points out that these offsets get written to 16-bit
registers, and there are some QE platforms with more than 64K
muram. So it is possible that qe_muram_alloc() gives us an allocation
that can't actually be used by the hardware, so detect and reject
that.

Reported-by: Qiang Zhao <qiang.zhao@nxp.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 8d13586bb774..f029eaa7cfc0 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -245,6 +245,11 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
 		ret = -ENOMEM;
 		goto free_riptr;
 	}
+	if (riptr != (u16)riptr || tiptr != (u16)tiptr) {
+		dev_err(priv->dev, "MURAM allocation out of addressable range\n");
+		ret = -ENOMEM;
+		goto free_tiptr;
+	}
 
 	/* Set RIPTR, TIPTR */
 	iowrite16be(riptr, &priv->ucc_pram->riptr);
-- 
2.23.0

