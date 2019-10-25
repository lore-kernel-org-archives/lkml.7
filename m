Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468B3CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1147021D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="GU8kE9rm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440283AbfJYMlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:41:05 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35474 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440242AbfJYMlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:41:05 -0400
Received: by mail-lf1-f68.google.com with SMTP id y6so1634803lfj.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 05:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7uK8xEnPEigQ7dFIza6M7Wg35/gDKz/RHXvPNwcggqY=;
        b=GU8kE9rmw7CxmGB90Y5Izc7LWqXMzqEnx4cZC7e5Ef+6pwtiG9RcGqXUnIzFpZ3t3U
         CU97Xc1WhzK+r82cnyFDuq5P1B/vMhbnBN/N6tdvSoWnVlIh44HGIJ8cZesgveR3SkSo
         M0pyyG+OPVFfGCQHHHNBUGHUCNNPbe9T16/FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7uK8xEnPEigQ7dFIza6M7Wg35/gDKz/RHXvPNwcggqY=;
        b=UKFHPWaZYxaTfjVnIeq3VDl7DoK2cavP0qTUWYd8ieB+DPaeQ+f0eDWIW5cfLWkAJ8
         ieeoChoYTp25njLe3vgK+CWW+ULuK0qtiB5GutGWknGIMTGxFAmf/4/rjivPqIwMNhfk
         4LHOFRNOOF1CluL/iUOcdHXEJYXxG2esFgC3/ECrBWWJOCcrgp9Z8TRTX6/r9Hfj9DOp
         78xidLmQTs1t0Rv8wfudD8LBZHunNbBg356YhWXjjuvEyNZ9e/aFC41uAvlnmmylj91e
         V5SncJ8a26XsTFZ5q08CxxxHYtyrcFPYIIgl7RBgMV0CVurtSP5U8edC3bQzAun/OYym
         rdFA==
X-Gm-Message-State: APjAAAWMN0u7Q8VHt45uIlVGwWAd4PtixhFrrftc+2Gt7aBO5IBhN9wz
        lmmFxzKx9Ug0+X5QKqQkoKN/CWOFj2jQUQ==
X-Google-Smtp-Source: APXvYqxqw6qAfANRoZ0GsCSZE1jfgTS6RZBtUbzWdgUXaR/01NaSFiZAQl3jp8GRzrDs35V36nIV4Q==
X-Received: by 2002:a19:8c1c:: with SMTP id o28mr2606108lfd.105.1572007263499;
        Fri, 25 Oct 2019 05:41:03 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 10sm821028lfy.57.2019.10.25.05.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 05:41:02 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Valentin Longchamp <valentin.longchamp@keymile.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 01/23] soc: fsl: qe: remove space-before-tab
Date:   Fri, 25 Oct 2019 14:40:36 +0200
Message-Id: <20191025124058.22580-2-linux@rasmusvillemoes.dk>
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

