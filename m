Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92F4C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7725520870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBCdtmNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393568AbfHVVZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:25:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37765 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390775AbfHVVZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:25:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id z11so6730680wrt.4;
        Thu, 22 Aug 2019 14:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OEsmb3YYUM/UceoBs6jItgKL8PKPLrTMhWm1PQG7Dps=;
        b=YBCdtmNu1zpehJ3oO3X3RDjFGx8UCQ9ORJTfqEQyZyGNPy9CdYH1xSyZZgBtWQpO78
         k8RKFNQPBgsU7H8GE8gHEb6WYaujZyCQBGFCcv5SIKT7gZr58/mkSXzdT2eG9cUpiOJg
         mfcOUbzyjMoPWqT7xbCQwpqIljRJhRPVfCbPHBP0cXe39gScrOY0BgLZnPEFFBWHr94V
         eBg52T6W6Tt0wQ78PJQ96d72KDwynu2I2VwcLpjBKFxug9aQWE/DnL0qmUL92xgEjOGZ
         M4I8yJPb7zyF82H0r/SvATluZNJbHquvoK5Fux3P7GhmhNcaOEV5cLTH/etcoLOwtkcY
         tOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OEsmb3YYUM/UceoBs6jItgKL8PKPLrTMhWm1PQG7Dps=;
        b=S7I/bTrGvLTKC2gsumN7QebZougEfesBRM25/b/BIkxEMvcD9j6+XTOciPa/FtoPyf
         aqxZSmzvPHCFHO+eebssO65xXF6i6zm/3zYjIy5hkVKAYju1xRly98Gxz8GZLZWjyzgs
         iLwA5W+NzZp3eleihS7zjuT0/setAGvSu2W3t0YlYvcppCXsrBkU0Qs7JJN4U/SFEOCS
         01bvHTdTOGsi2n+AXqD9jffISX2IGNqf0xXqM97JgxaltmunTDAVXBc4ERj3nQmYoz4Y
         oendRrJLBh9j/8JG/xGG1FWp+5s0i6JsMkpRUf7EM3V9c+chsFILIfvJoyzXSYAuRfH0
         Kzig==
X-Gm-Message-State: APjAAAUcfsoISiGa/DYASRKFL8GkZyCVw2rh7O0gXZOfxznp0xEwaDXF
        LDXN4zJz4hoiavxIp+VcjQcxuWwz
X-Google-Smtp-Source: APXvYqxgwZedlUxMAhUXie3ccIVgjuCbvTQTaqxtanBCp4io6Z+/e7yJy5HT9q3EkYTRWFjdqNSPbA==
X-Received: by 2002:a5d:63c8:: with SMTP id c8mr1061504wrw.21.1566509099026;
        Thu, 22 Aug 2019 14:24:59 -0700 (PDT)
Received: from localhost.localdomain ([86.126.25.232])
        by smtp.gmail.com with ESMTPSA id 7sm463135wmj.46.2019.08.22.14.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 14:24:58 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH 1/1] spi: spi-fsl-dspi: Exit the ISR with IRQ_NONE when it's not ours
Date:   Fri, 23 Aug 2019 00:24:50 +0300
Message-Id: <20190822212450.21420-2-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190822212450.21420-1-olteanv@gmail.com>
References: <20190822212450.21420-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DSPI interrupt can be shared between two controllers at least on the
LX2160A. In that case, the driver for one controller might misbehave and
consume the other's interrupt. Fix this by actually checking if any of
the bits in the status register have been asserted.

Fixes: 13aed2392741 ("spi: spi-fsl-dspi: use IRQF_SHARED mode to request IRQ")
Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 5e10dc5c93a5..6c2a30f9d85b 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -874,9 +874,11 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 					trans_mode);
 			}
 		}
+
+		return IRQ_HANDLED;
 	}
 
-	return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 static const struct of_device_id fsl_dspi_dt_ids[] = {
-- 
2.17.1

