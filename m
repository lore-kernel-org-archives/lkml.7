Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D9FCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B052080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xb5T9zfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbfJaSqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 14:46:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36323 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbfJaSqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:46:38 -0400
Received: by mail-pl1-f194.google.com with SMTP id g9so3086293plp.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 11:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WuFs+AMjdDKhamzQV8PIhDJ9khhpt9bix4gVbxAEv5k=;
        b=xb5T9zfHZejq85gO7jFd2zwpcyRjEnFCa9jXw/a1BGYBwqiwPHqwXTp9crC//hhHBa
         P5W8qYXn5P38liorEw8r1uSL0xAUNDvmDxyV+IVzflal+6BpyC+0RAJnGsV9zkXPiSV3
         NX3O2JYP5+8nsz4MK9QAd6yQZBiDXV1dsxyAWjiOPlDrwyipQhs4yUn3P8XJnLyou9Le
         oaQvShGAI9coypED6Vks17iWdIGWBU2/ZB9RbsWxUc0skHGl4Q3zuT6JWaQBQBh7/W3g
         hVni+YYwokAHkK52tCBKlRATf5xhM3BGYzJ1whHDf8BZuN4gW5CxqdtN5W01iF31EAgG
         Th0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WuFs+AMjdDKhamzQV8PIhDJ9khhpt9bix4gVbxAEv5k=;
        b=lgFNXmfXceVfJTVjxFKY8QiFkjgDC+LCtcbhyCoOtUHOkfyVJjB4r5qqmG1m7Kn9fk
         2YhWlh+hMMWCvHzCQR8b0fB6C8LPcl56MBVS8Mcm1ajBporcLMFZbuyGpORmOuNcVyhG
         Ppu6+4KPpdqvx3DaCOHw4TdOVwawJI4iuMpH77QPWasxs8jjlnNG6FAEi2HG4wbkXNat
         UOIcz0tSwroUyYT2aM99wg6g8WigNK/76g7BhIrqvzt2tRWYJjGr/vqzLJIpI/gG5wur
         pskP2eL4Rt4JhjHnRjXf6fGDUWH0iMaj8AbGH1l6yeKqmMhnUhgD6a0dRv2L6lSsONQU
         NaLA==
X-Gm-Message-State: APjAAAV8qg4Hi3PFtxXSBAZyfFGSVGjCb91XwHy4LLZSu7BRAl0zEaoi
        nGjgBWWOw0RJ8EPTC/1yCt9fug==
X-Google-Smtp-Source: APXvYqxKWUYn0+yrgxpPU2r080t3eP3XdoiS3bDXrFSoHsxoPngV5s+zNQngefMMk3otTAvzQpcJow==
X-Received: by 2002:a17:902:b612:: with SMTP id b18mr7933212pls.309.1572547597107;
        Thu, 31 Oct 2019 11:46:37 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b82sm3950874pfb.33.2019.10.31.11.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 11:46:36 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>, stable@vger.kernel.org
Subject: [PATCH 1/2] remoteproc: qcom_q6v5_mss: Don't reassign mpss region on shutdown
Date:   Thu, 31 Oct 2019 11:46:31 -0700
Message-Id: <20191031184632.2938295-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031184632.2938295-1-bjorn.andersson@linaro.org>
References: <20191031184632.2938295-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to reclaim mpss memory while the mba is not running causes the
system to crash on devices with security fuses blown, so leave it
assigned to the remote on shutdown and recover it on a subsequent boot.

Fixes: 6c5a9dc2481b ("remoteproc: qcom: Make secure world call for mem ownership switch")
Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index de919f2e8b94..f4a02105d539 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -875,11 +875,6 @@ static void q6v5_mba_reclaim(struct q6v5 *qproc)
 		writel(val, qproc->reg_base + QDSP6SS_PWR_CTL_REG);
 	}
 
-	ret = q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm,
-				      false, qproc->mpss_phys,
-				      qproc->mpss_size);
-	WARN_ON(ret);
-
 	q6v5_reset_assert(qproc);
 
 	q6v5_clk_disable(qproc->dev, qproc->reset_clks,
@@ -969,6 +964,10 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 			max_addr = ALIGN(phdr->p_paddr + phdr->p_memsz, SZ_4K);
 	}
 
+	/* Try to reset ownership back to Linux */
+	q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm, false,
+				qproc->mpss_phys, qproc->mpss_size);
+
 	mpss_reloc = relocate ? min_addr : qproc->mpss_phys;
 	qproc->mpss_reloc = mpss_reloc;
 	/* Load firmware segments */
@@ -1111,10 +1110,6 @@ static int q6v5_start(struct rproc *rproc)
 	return 0;
 
 reclaim_mpss:
-	xfermemop_ret = q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm,
-						false, qproc->mpss_phys,
-						qproc->mpss_size);
-	WARN_ON(xfermemop_ret);
 	q6v5_mba_reclaim(qproc);
 
 	return ret;
-- 
2.23.0

