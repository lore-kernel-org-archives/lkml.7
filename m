Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C13FC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E7A21771
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="gnMSL36D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfK1O6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:58:09 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41919 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfK1O6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:58:03 -0500
Received: by mail-lj1-f196.google.com with SMTP id m4so28806118ljj.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KUBWPv3JkV5Q2rpwN8YKM1iLDpQKFkQg1V9KmI5YIqA=;
        b=gnMSL36DxoMRWV5dmkqn64lmHepkAi/UCIfJXPlQpgy26UZTuq1MviK2Qwq0XpyewR
         plZczgrN/M/mdswUw9R50HmZN2QjhZiXFk34AyfSzViZWRYCFTF5rtIK7G5qaiGCCR/K
         jIf31rx5xnRhK1BzOC7zTsNV7YczeL2VTJkhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KUBWPv3JkV5Q2rpwN8YKM1iLDpQKFkQg1V9KmI5YIqA=;
        b=PEVjXpS1Kl7PjkeRkYGURp8oYO4mnNV573uOOR+GgtE9ZuhGVXxJz217UjNvJFiyWM
         xCXhdBGQWjv8K6dUyQVLX9KMY5TuKjTag/nvqAhSJe4JKU8+J4jC/v7GQh/IygS4ujv5
         D9PBAvvZBhgDex5hVrOTOIRyolGc5gygj1YasfwdT6aqJx43vv/q4z6NfqgbKqvPLDHC
         BMb8mwUeWrsXEFNamAfXTdZyHC7qxogsDnFyoUWpCKnphjBy461D74HAvZQt9rIP0FDM
         faEzM0r4Tlhn/+Jdcmkdp5lnGdMJiVNKwZkRrEPDiMIK+xVgsIvveXW2SwWMsXgzV2xV
         h9KQ==
X-Gm-Message-State: APjAAAU0Bt+e2cfcQdh8Ni+ih7VVBzBkjAueLxucOvvYRNDW1Uf92BNe
        WdKrrFSNkkE3hCXCixxkL9sVrQ==
X-Google-Smtp-Source: APXvYqxZ7tTPDopj2M7w11v+y/JLwNd0sGMUxyWwupXPa/c1vlU0GkGXVop9xXN6GCNtZPzQf300Zg==
X-Received: by 2002:a2e:b056:: with SMTP id d22mr22072255ljl.73.1574953079877;
        Thu, 28 Nov 2019 06:57:59 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:59 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 42/49] soc: fsl: qe: drop pointless check in qe_sdma_init()
Date:   Thu, 28 Nov 2019 15:55:47 +0100
Message-Id: <20191128145554.1297-43-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sdma member of struct qe_immap is not at offset zero, so even if
qe_immr wasn't initialized yet (i.e. NULL), &qe_immr->sdma would not
be NULL.

Reviewed-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 5bf279c679ef..96c2057d8d8e 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -367,9 +367,6 @@ static int qe_sdma_init(void)
 	struct sdma __iomem *sdma = &qe_immr->sdma;
 	static s32 sdma_buf_offset = -ENOMEM;
 
-	if (!sdma)
-		return -ENODEV;
-
 	/* allocate 2 internal temporary buffers (512 bytes size each) for
 	 * the SDMA */
 	if (sdma_buf_offset < 0) {
-- 
2.23.0

