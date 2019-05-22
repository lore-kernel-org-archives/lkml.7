Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4EDC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABC32173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="mHwA7YTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbfEVU7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:59:16 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39474 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbfEVU7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:59:14 -0400
Received: by mail-lf1-f67.google.com with SMTP id f1so2736958lfl.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 13:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nBcwAIJBojrtdqg80WX3GBGuPC1aGkjKfZtc25mU2xI=;
        b=mHwA7YTiRl3tcjY7IZH08jaAw1X6kLH9D401Yd0O6lQofsTlxKhEo1J6LwOih5wH56
         Wf4uXVOyRQZ7QENzezj63OaSZSUyEz5QJ2iFIJ5wsqzLxL03phIRRdzQB8s0LK5kDg6t
         ksH9S5fJi0xyUYiuKPUuro8W3wt0UWrwUJLkZpuDUDiRaH94lX+VOTdg5oR+LaQCIXkp
         4sqfKgKkRJnlwIh6hzUXi2Q0q5E7hUtf51fmn0dYQhPmkpndEz6QRRqV8sAm8Kji0mu0
         XSNZk1LUu+Ips78zGfTUXVpvdndBr5GWKceTI8ZCGmR1vNmZdHxlOBPIMU08k4rROidR
         +ulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nBcwAIJBojrtdqg80WX3GBGuPC1aGkjKfZtc25mU2xI=;
        b=ZXLQ4qoknmOzZekxVKIzUZLgtQnyYpIjlOjfyNbZpMcF0QonW4P7U8pJtAo98ka7kk
         Is/CUA88FSH19Kjjipl++kWGJxr6XdbSjugz7FfprTFaMP4FjGv2H2WJ2DEqe/J8aaez
         M29sFoymg59Qnd6p8WmqVyX+m7CHA6K3++1x9Lmct6yI9xq1YUTJSD0agYBihDeqm/U0
         QUevy8X2t2+VGNRqvxHVK3SkYw+/jaIOCGZ8U2OjkjhjtW4d2NxnXcnCMjNsLSZXVuCP
         m2a5tEQZn6v0Ht4OTXpy77MYCwCFM0WV5JcWlYd1pEcR1VtZDN0SbPcFZm7k34f0M9/o
         5qAw==
X-Gm-Message-State: APjAAAVPugea8JNtvR7DejX94nRYhciNvu8DJ+UT0yF8boQpCLPrHSqs
        81f8dktgFnbvWpK2gRoPyupoHw==
X-Google-Smtp-Source: APXvYqwD8NEtYyDa9LYguQ9SN+QBu7M7VTzW16Hl6rhwezsrQ7sZDOZafPKbd8reK3iPgYDtd0oCIQ==
X-Received: by 2002:a19:a50b:: with SMTP id o11mr31695834lfe.2.1558558752360;
        Wed, 22 May 2019 13:59:12 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id e12sm5506518lfb.70.2019.05.22.13.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 13:59:11 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH 3/6] staging: kpc2000: fix invalid linebreaks in cell_probe.c
Date:   Wed, 22 May 2019 22:58:46 +0200
Message-Id: <20190522205849.17444-4-simon@nikanor.nu>
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

Fixes checkpatch.pl error "else should follow close brace '}'" and
"trailing statements should be on next line".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/cell_probe.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
index 51d32970f025..4742f909db79 100644
--- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
+++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
@@ -85,8 +85,12 @@ static
 void parse_core_table_entry(struct core_table_entry *cte, const u64 read_val, const u8 entry_rev)
 {
 	switch (entry_rev) {
-	case 0: parse_core_table_entry_v0(cte, read_val); break;
-	default: cte->type = 0; break;
+	case 0:
+		parse_core_table_entry_v0(cte, read_val);
+		break;
+	default:
+		cte->type = 0;
+		break;
 	}
 }
 
@@ -387,7 +391,8 @@ static int  kp2000_setup_dma_controller(struct kp2000_device *pcard)
 		capabilities_reg = readq( pcard->dma_bar_base + KPC_DMA_S2C_BASE_OFFSET + (KPC_DMA_ENGINE_SIZE * i) );
 		if (capabilities_reg & ENGINE_CAP_PRESENT_MASK) {
 			err = create_dma_engine_core(pcard, (KPC_DMA_S2C_BASE_OFFSET + (KPC_DMA_ENGINE_SIZE * i)), i,  pcard->pdev->irq);
-			if (err) goto err_out;
+			if (err)
+				goto err_out;
 		}
 	}
 	// C2S Engines
@@ -395,7 +400,8 @@ static int  kp2000_setup_dma_controller(struct kp2000_device *pcard)
 		capabilities_reg = readq( pcard->dma_bar_base + KPC_DMA_C2S_BASE_OFFSET + (KPC_DMA_ENGINE_SIZE * i) );
 		if (capabilities_reg & ENGINE_CAP_PRESENT_MASK) {
 			err = create_dma_engine_core(pcard, (KPC_DMA_C2S_BASE_OFFSET + (KPC_DMA_ENGINE_SIZE * i)), 32+i,  pcard->pdev->irq);
-			if (err) goto err_out;
+			if (err)
+				goto err_out;
 		}
 	}
 
@@ -418,7 +424,8 @@ int  kp2000_probe_cores(struct kp2000_device *pcard)
 	dev_dbg(&pcard->pdev->dev, "kp2000_probe_cores(pcard = %p / %d)\n", pcard, pcard->card_num);
 
 	err = kp2000_setup_dma_controller(pcard);
-	if (err) return err;
+	if (err)
+		return err;
 
 	INIT_LIST_HEAD(&pcard->uio_devices_list);
 
-- 
2.20.1

