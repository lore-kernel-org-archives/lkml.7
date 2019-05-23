Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FBDC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3504520856
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="Y7bYLdd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbfEWLgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 07:36:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34820 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729949AbfEWLgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 07:36:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id h11so5152119ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 04:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=11qH4y9SfuGcGcjlxGwKTBKKhuVs5qvrsowrYqhLe+k=;
        b=Y7bYLdd5Ld95lBElF+p+gMQOuiWb+w+At7YDGkJortepcdHgqXw+vHsr1Xovdn4ayt
         uKHewJa0wAPLm+49BFZcWJJfwwa5okbo15J4pvBUL97sPQ1tPBVt1/WHPREEnTc/V2Ww
         LBx3h2a4Y4jwQ8Krho6kRDZ8661Nh2AFQGLaJSAbc7xW0mJYvyN5BRDl0XWzKaw1Kgu9
         IPBg6Moi5NMkx2Bc5pTlUiBVndC3ywvVa3KvyTXNuu0CYsalbzvf/OPhFH3mEZ65rkra
         aK1o/gBc1xZ2zhUGbgOfhJb98Xu9CrU10tUaWu0vyDKABymiAthp/J3HN/aENf8FsO3S
         O8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=11qH4y9SfuGcGcjlxGwKTBKKhuVs5qvrsowrYqhLe+k=;
        b=n16iAXi/pRl27te8qNEZ+MQOvRQRQse2ItNWhlq5hyXRJ/30uI+hEVO4eGL07L2G+q
         gLxSqrPCf6GXNUJfTBn5LlOCQCnEClur5Dw6yC/dACVxmYx6v/Y8t6sgjVB9UmDIzwLR
         bpyM8Yc8UmISehm6PfudKlr38/OwDN1H1xACLCYHLik0V2+37r4HXsY9qZRtHEC38JyU
         S3y95QtoPTNld9dQDbPQ2VwCqLDWD6voiWPKAlzAXpQtUfU/+JeRyGwCW7cfhG5HZP8I
         oS4lLkOciLW6HUFz4pFWHtbQQnNKKNALOfAwJdwcEJkLuaEuKL89d8kN8UEBbl1ViyuJ
         xMQw==
X-Gm-Message-State: APjAAAUb+DxaSwxSgpoSZoCbBDijWNW4uFzgzDOd0SYSwwsb5PKpkl7o
        U5aV1r7oifDicdjMsNb14Ze1xw==
X-Google-Smtp-Source: APXvYqx7pRnYxk6XRIEXgy9Ad7KNNYeIcOE4OGgp6hRV2gwnbrOOVxc7iNVI2ZGrwynKkeYyjbKcEg==
X-Received: by 2002:a2e:9259:: with SMTP id v25mr5166102ljg.46.1558611396410;
        Thu, 23 May 2019 04:36:36 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id d68sm5269287lfg.23.2019.05.23.04.36.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 04:36:35 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] staging: kpc2000: use kzalloc(sizeof(var)...) in cell_probe.c
Date:   Thu, 23 May 2019 13:36:11 +0200
Message-Id: <20190523113613.28342-7-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523113613.28342-1-simon@nikanor.nu>
References: <20190523113613.28342-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl warning "Prefer kzalloc(sizeof(*kudev)...) over
kzalloc(sizeof(struct kpc_uio_device)...)"

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/cell_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
index 0da41ca17eb7..8d9254db9498 100644
--- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
+++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
@@ -292,7 +292,7 @@ static int probe_core_uio(unsigned int core_num, struct kp2000_device *pcard,
 
 	dev_dbg(&pcard->pdev->dev, "Found UIO core:   type = %02d  dma = %02x / %02x  offset = 0x%x  length = 0x%x (%d regs)\n", cte.type, KPC_OLD_S2C_DMA_CH_NUM(cte), KPC_OLD_C2S_DMA_CH_NUM(cte), cte.offset, cte.length, cte.length / 8);
 
-	kudev = kzalloc(sizeof(struct kpc_uio_device), GFP_KERNEL);
+	kudev = kzalloc(sizeof(*kudev), GFP_KERNEL);
 	if (!kudev) {
 		dev_err(&pcard->pdev->dev, "%s: failed to kzalloc kpc_uio_device\n",
 			__func__);
-- 
2.20.1

