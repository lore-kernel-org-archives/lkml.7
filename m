Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EBCC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08EA221019
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="lxfVS65g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfEVU7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:59:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34073 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbfEVU7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:59:16 -0400
Received: by mail-lj1-f193.google.com with SMTP id j24so3421964ljg.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 13:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Y9uvZwgB7bQqY2Q7B/JNHVKnOBJyiIUgun6Ue42g94=;
        b=lxfVS65gxJ31U3HidVwFh2ESyMciljPGQ9L3gzpuGCHBVhzezCVbAw66+Di4Ft31K4
         kQ39fmuWRKnTGBma6uY4/yr0VlPThYj7JYIYecnWxRIDNaGu5bb9xshfoQU1kJ6RzMeS
         SL4bmnzULado+sLuZkiCU+MBgSNqHDQYoKpoeBOTM9jZPfKxkR0h2iPOkJOQZzQSE7fl
         eOQxkLVYUt/kNos5MGA1ZCV0i2G9NqtxElTHyFm5HvxDmz85IDD1jTeHrDFoqzJDRKcV
         tdyRZdNcBS5VN0kZNnwAbV59Jkz+GNB3ohBbukRGe7+E6+l9kfZxq3XPJ+tESYugX50+
         16fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Y9uvZwgB7bQqY2Q7B/JNHVKnOBJyiIUgun6Ue42g94=;
        b=UGun57RUsOkZdxct3JONyyRX5D/6+/k88thCE6qr9enKGnfcM5bLm1tT1PNBp2/L+l
         vJSWusMa0AFbHwDSub5W5a23FUDypnw9fBjUBlf10m+R0vYljNvFTMQzlZ5cw3y/Try2
         THnDmceHz5xgTPB41kDaGguJiMtV2usbz4+ZEjIg1MZFhuUp1aX8BkNtOZ2VB2AtbYog
         QAh5MJwGXoqENjUwV+IbQpqvvub2R73ep56ZF7esvGP3OXNI6fK2oeZfFU1fAkf8jMw+
         jLtXX+Co9Rtdi/UAzn+refsoT16aJ3P3/Oq5Xw57GlegGuqSXFML+q97Yao5TeQkmYox
         AiFA==
X-Gm-Message-State: APjAAAV1lELoxJfU6PTo9Tj5LFIudEtI7x9Lzz4ndg6bzsz/WoUIe9Ft
        wtXz3A5NYt4lzkj3R/HQXIT7weJ9ucY6rA==
X-Google-Smtp-Source: APXvYqyGdS5NdVP1srxefaIKMMjWpNMjTYbtaDIKo9dqvGb7IPuC5SYawc7KqgHZJsYqKC8TN8aF9A==
X-Received: by 2002:a2e:7001:: with SMTP id l1mr19877192ljc.11.1558558754233;
        Wed, 22 May 2019 13:59:14 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id e12sm5506518lfb.70.2019.05.22.13.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 13:59:13 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH 5/6] staging: kpc2000: add space after comma in cell_probe.c
Date:   Wed, 22 May 2019 22:58:48 +0200
Message-Id: <20190522205849.17444-6-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522205849.17444-1-simon@nikanor.nu>
References: <20190522205849.17444-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl error "space required after that ','".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/cell_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
index 9a32660a56e2..7d4986502013 100644
--- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
+++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
@@ -323,7 +323,7 @@ static int probe_core_uio(unsigned int core_num, struct kp2000_device *pcard,
 	kudev->uioinfo.mem[0].size = (cte.length + PAGE_SIZE - 1) & ~(PAGE_SIZE - 1); // Round up to nearest PAGE_SIZE boundary
 	kudev->uioinfo.mem[0].memtype = UIO_MEM_PHYS;
 
-	kudev->dev = device_create(kpc_uio_class, &pcard->pdev->dev, MKDEV(0,0), kudev, "%s.%d.%d.%d", kudev->uioinfo.name, pcard->card_num, cte.type, kudev->core_num);
+	kudev->dev = device_create(kpc_uio_class, &pcard->pdev->dev, MKDEV(0, 0), kudev, "%s.%d.%d.%d", kudev->uioinfo.name, pcard->card_num, cte.type, kudev->core_num);
 	if (IS_ERR(kudev->dev)) {
 		dev_err(&pcard->pdev->dev, "probe_core_uio device_create failed!\n");
 		kfree(kudev);
-- 
2.20.1

