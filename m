Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A97C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E45A21019
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="ZALnQcpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbfEVU7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:59:17 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44785 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730223AbfEVU7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:59:15 -0400
Received: by mail-lj1-f194.google.com with SMTP id e13so3379953ljl.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 13:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wVzM4niY3zy81NT2oIqGefdVIsRifRFmdGCA5K8Tg8E=;
        b=ZALnQcpZJWxdmxktc+lG6HWKrFJgYqg1MSWtcFQID+vDGms4ojbKoIDiQYoDaGTZwX
         OrC6QUvcTSuuoKlNbj/etZi8Iz/cOmPn3ivI5L0lq1SI2po/vIDwgrKfr7SRhpBhOTwE
         dwMOm0MNKWPT+mFi4henWIG+PDYwANHw51y4mZvAyjnVGbE1LCnCi1KZvu5kP7IRSyBB
         pBBzaAEjJIGqoXeFAq+S047w2dzfEFNks4VZQcNokha6ww1DUb1iUAJKCnjSSFq/WPak
         jnZDi+cuT143W5me8K8ilJMiBcSDE/3no3GAq1ngB6wLq1cAIxdNHPH0F5vGwUm4fLRN
         R3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wVzM4niY3zy81NT2oIqGefdVIsRifRFmdGCA5K8Tg8E=;
        b=bohInC2QzbtTBh+wLIiut/bTgtIapf3bVsR+UorrD6jQjEmjBYL5yq1WifzFIUMePa
         yuo/XpPXApj6naaSqAAuv/2qhaBDxYZrK2fcLlMGL99pGKJexTdwtLiTZzUdTQSwpn6X
         lj18adApefmDSbhuwRhbx+iuDHpXrLED/3w7+7Gz75mqbPdjKs3QIahfcRTqM1SA4xsK
         Uu8NAR3q2iQYhNcMpZmotA+y1z4pOJYtbyfFZLimXxplIqnO6Akz8N5XzjxYibnXHq05
         tbX/uth3hqkWK6nSlWfGd+LGbah3TQiq4PijeFiWIPDp3KLugbYPFdsoBkfoaITzcR95
         wYIw==
X-Gm-Message-State: APjAAAXZdBBNf1RcbR581raVFNGNnCCoJhZ5fpENvVFRGYVclweC+mEf
        4hO0YlaO9ThQI8eW2EUMZdaexw==
X-Google-Smtp-Source: APXvYqzlDnuezIlpumyRk2FhBGetW1bsvoKFXD8eRP7YxAABh6CrWw+07WX8l81EY0f0OBE8EqBuhw==
X-Received: by 2002:a2e:96da:: with SMTP id d26mr36992761ljj.9.1558558753363;
        Wed, 22 May 2019 13:59:13 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id e12sm5506518lfb.70.2019.05.22.13.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 13:59:12 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH 4/6] staging: kpc2000: add spaces around operators in cell_probe.c
Date:   Wed, 22 May 2019 22:58:47 +0200
Message-Id: <20190522205849.17444-5-simon@nikanor.nu>
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

Fixes checkpatch.pl warning "spaces preferred around that <op>".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/cell_probe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
index 4742f909db79..9a32660a56e2 100644
--- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
+++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
@@ -320,7 +320,7 @@ static int probe_core_uio(unsigned int core_num, struct kp2000_device *pcard,
 
 	kudev->uioinfo.mem[0].name = "uiomap";
 	kudev->uioinfo.mem[0].addr = pci_resource_start(pcard->pdev, REG_BAR) + cte.offset;
-	kudev->uioinfo.mem[0].size = (cte.length + PAGE_SIZE-1) & ~(PAGE_SIZE-1); // Round up to nearest PAGE_SIZE boundary
+	kudev->uioinfo.mem[0].size = (cte.length + PAGE_SIZE - 1) & ~(PAGE_SIZE - 1); // Round up to nearest PAGE_SIZE boundary
 	kudev->uioinfo.mem[0].memtype = UIO_MEM_PHYS;
 
 	kudev->dev = device_create(kpc_uio_class, &pcard->pdev->dev, MKDEV(0,0), kudev, "%s.%d.%d.%d", kudev->uioinfo.name, pcard->card_num, cte.type, kudev->core_num);
@@ -399,7 +399,7 @@ static int  kp2000_setup_dma_controller(struct kp2000_device *pcard)
 	for (i = 0 ; i < 32 ; i++) {
 		capabilities_reg = readq( pcard->dma_bar_base + KPC_DMA_C2S_BASE_OFFSET + (KPC_DMA_ENGINE_SIZE * i) );
 		if (capabilities_reg & ENGINE_CAP_PRESENT_MASK) {
-			err = create_dma_engine_core(pcard, (KPC_DMA_C2S_BASE_OFFSET + (KPC_DMA_ENGINE_SIZE * i)), 32+i,  pcard->pdev->irq);
+			err = create_dma_engine_core(pcard, (KPC_DMA_C2S_BASE_OFFSET + (KPC_DMA_ENGINE_SIZE * i)), 32 + i,  pcard->pdev->irq);
 			if (err)
 				goto err_out;
 		}
@@ -481,7 +481,7 @@ int  kp2000_probe_cores(struct kp2000_device *pcard)
 	// Finally, instantiate a UIO device for the core_table.
 	cte.type                = 0; // CORE_ID_BOARD_INFO
 	cte.offset              = 0; // board info is always at the beginning
-	cte.length              = 512*8;
+	cte.length              = 512 * 8;
 	cte.s2c_dma_present     = false;
 	cte.s2c_dma_channel_num = 0;
 	cte.c2s_dma_present     = false;
-- 
2.20.1

