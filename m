Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91447CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691912067D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="FJGEyUjD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbfKAMmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:42:22 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34448 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbfKAMmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:42:19 -0400
Received: by mail-lf1-f66.google.com with SMTP id f5so7149615lfp.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 05:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7uK8xEnPEigQ7dFIza6M7Wg35/gDKz/RHXvPNwcggqY=;
        b=FJGEyUjDMyY3qQwDxrXdaq6kbDtEuWaQ9DdM3JQbmkDv5/TqT279el/27e2uU9No1a
         f+iz8Vxf6Hy5Yia656Z3D2IFrlqCrNAHpa+4MZwbyXZwnzKLGOuyKeoeouKUynNENL+w
         9N/0jeI/nf5AWsvbX8qp/uDqSP/sxEhYzWMsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7uK8xEnPEigQ7dFIza6M7Wg35/gDKz/RHXvPNwcggqY=;
        b=A7bzGxqRS7+ZkEJaJG8E44yppyGLhS6dNeMb8DlDmPZ7qSH1EGy45WDHmys/uB6hn1
         h170SlVtCFtZoMGqMNt7brUVRMx1tpjrXFV+iRSor2/UPGeMYou142mognGUaOrg6TH5
         tTsJTfdAZRwbntlz3FE7+3imowQpnTL0v+E7fClk2OLH68/r7tttBALg5IKxXNN01Aij
         eG+59TppWghpq5sWFGtyYCvTcsf/MJ9/eYlKMeV461tHd/0Bspmp8MxDpF5gNBtJqfVx
         NkAU4G7+AZa0M5Qsn8rRjclhlQMqxvpr5DmbeAr4VVPFGkPUrongzKlTrolFDTg/xGGK
         pZdA==
X-Gm-Message-State: APjAAAVADongaoICOZSh1GjoSjQ3sT5LxWWhqD9wLw6EYQJcCR3a1YGX
        LyHLXoHcImwBEaGbHdPm7Fau5g==
X-Google-Smtp-Source: APXvYqx10tC45xnMYXxbHsIhOZZte50RDX5EOtgZaSoKO0iY2QuiQYHpnCYFw+LsHLxAu07eF6ZXqA==
X-Received: by 2002:ac2:424c:: with SMTP id m12mr7265781lfl.140.1572612136042;
        Fri, 01 Nov 2019 05:42:16 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2458540lfi.57.2019.11.01.05.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:42:15 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 01/36] soc: fsl: qe: remove space-before-tab
Date:   Fri,  1 Nov 2019 13:41:35 +0100
Message-Id: <20191101124210.14510-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101124210.14510-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-1-linux@rasmusvillemoes.dk>
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

