Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0F5C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B3121774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="h5Ofrh1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfK1O6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:58:08 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34002 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbfK1O6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:58:02 -0500
Received: by mail-lf1-f67.google.com with SMTP id l18so2230425lfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A3LxCwaWF3+EjSkH3Z11+aFYy5ZGZLaMI8GPoISP0aQ=;
        b=h5Ofrh1lS1SdvEU2TywQndew2wv/s6SlshVIlXBQI587u1AT3EXJXpyq2oJdPtVTHA
         ffPQYYcE3fOicrEVwVc9YzvRFsFG48tQ72uf4CxV3GNrG6HUW7b3FV+oHlayfUO2uleS
         drOU4bl3A8RKImHPPcr3Gta017yms39ACmP2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A3LxCwaWF3+EjSkH3Z11+aFYy5ZGZLaMI8GPoISP0aQ=;
        b=hWRaQXqTythx8O+bRz37qV9LP10MElstnQltZWD18sdd1P8pOstmOu4OVzuyDFUyzH
         Rv5ZhgfFedWoBF5a+EUe0QvTycH/Swe0hw5WoQlIO7xeEBTnorcejPAmNDWNZUn9CyvZ
         43p2A1yhq0cWTQiCkcIRMaPr+PgSbFBp0KaHgG1Ch1ihCl9LZbK0SVnw5cDLokcfUXdc
         7zSurUqweJ9cOa3uuE/kg/PyEe535odeK8/QaVirluzic8cnWj9ukzQmeAkw6tMmAsxB
         mckVbBZFWkDAn72SLNosZ+Q0SKjQEIE1XIRZ21XiVFF5q2F7vcGYXaBmVGvtEUoFrqOM
         mKPw==
X-Gm-Message-State: APjAAAVksQNsCamzkaHy+pc5fVk51IchfMzu3Y+Yt/RpbZ0Jdrbmryr0
        vb+Nl2/GoHwCVm9qOWMivMcoYg==
X-Google-Smtp-Source: APXvYqyficCStsKpAiJlZ+/UQRHEGEEI0ZQvcoo+FRiOWz4LSGBEVSlvdyU5SdjwjnSIc9iZd4E/Rg==
X-Received: by 2002:a19:c3ca:: with SMTP id t193mr19540921lff.40.1574953078637;
        Thu, 28 Nov 2019 06:57:58 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:58 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v6 41/49] soc: fsl: qe: drop use of IS_ERR_VALUE in qe_sdma_init()
Date:   Thu, 28 Nov 2019 15:55:46 +0100
Message-Id: <20191128145554.1297-42-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that qe_muram_alloc() returns s32, adapt qe_sdma_init() and avoid
another few IS_ERR_VALUE() uses.

Reviewed-by: Timur Tabi <timur@kernel.org>
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

