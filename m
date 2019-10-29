Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D70CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F91720717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1LXRm2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731658AbfJ2JQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:16:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39808 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfJ2JQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:16:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id p12so9099955pgn.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 02:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aUKSB/eobGAaYzA+zetYK7qwC81TH5UGLLG8mpvrqjM=;
        b=E1LXRm2easraBHhl0bFqL+Sv1AmJlB9T0/8t3VfA3fsQilSW3EY5WftU8nv//nlavL
         /0lcqaazaFPP03R2wR1yqcf1qs8ql3uv8VobnKuMWRzzJQbSxDm+Em4jStO8LGOFf4qP
         BBQfJbgrARGgedUq6M9dhhfnbDreSrZOTOZcawMwJ/RP73wXOejjhRf9PuvYPnYYVwKE
         IX+5LDblg8gvAeOS5RkceXL8KGSH+OtaA69DwWKzx9ozsZtCngV8wUs/3B3W5rYt3HCU
         bt6lcj67T4yQ1/e59gYhs0gfu0wvPBeBFQUs6dZRwv5TZG34nrw+Uv2cMf5FW5hIaoZH
         M2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aUKSB/eobGAaYzA+zetYK7qwC81TH5UGLLG8mpvrqjM=;
        b=hyP+Iu82mW0iNKwDVjr+I1GsW47Y2ywD+EhjOJ9EnsZNn3UMdaIcGzc2BebPo4wT4M
         8SpKCGH1KESSO3pHtdVQFWOZ5heLzgCMHc9/8OvndougieShiIVZCCQLRf5+V8C8b6JO
         j2bwZ9HoTg2z8Io12qr6k/nmu8NWKRsGAbxFVcoAY6SYqoUXzal1DCqQZkyI4n5sFZqP
         dN5KukXPOAqtZwXY9XwtuPOy3YyKEZefBC2OynfMf7Kp6ZzW4vwMjp77s/N40eB5wwU5
         ggEjv0x0XXf4WLyzyegyV85EQ0U09TJm48GHforBaX6UUx4TfcvevwvHHH05z8HwUeTv
         eZDg==
X-Gm-Message-State: APjAAAXdMhx80vZGc2+3+kKnNuAbKWAN1YkyMBckYW3kIzYpbrqhZkjq
        Ds7ryUeyGWaZc91oMIjF7Gg=
X-Google-Smtp-Source: APXvYqzA3PKI84VfLy3qlQweRNsJMm7ikBuFnWYQfY+/SKdze3mgarhB8+wNPHvBUFC4UQEXezPPrw==
X-Received: by 2002:a63:b60b:: with SMTP id j11mr14496261pgf.116.1572340610675;
        Tue, 29 Oct 2019 02:16:50 -0700 (PDT)
Received: from localhost.localdomain ([45.52.215.209])
        by smtp.gmail.com with ESMTPSA id g18sm9910556pfh.51.2019.10.29.02.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 02:16:50 -0700 (PDT)
From:   Chandra Annamaneni <chandra627@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, dan.carpenter@oracle.com,
        michael.scheiderer@fau.de, fabian.krueger@fau.de,
        chandra627@gmail.com, simon@nikanor.nu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] staging: KPC2000: kpc2000_spi.c: Fix style issues (misaligned brace)
Date:   Tue, 29 Oct 2019 02:16:36 -0700
Message-Id: <20191029091638.16101-2-chandra627@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191029091638.16101-1-chandra627@gmail.com>
References: <20191029091638.16101-1-chandra627@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resolved: ERROR: else should follow close brace '}'

Signed-off-by: Chandra Annamaneni <chandra627@gmail.com>
---
Previous versions of these patches were not split into different 
patches, did not have different patch numbers and did not have the
keyword staging. The previous version of this patch had the wrong 
description and subject.
 drivers/staging/kpc2000/kpc2000_spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 5712a88c8788..929136cdc3e1 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -226,8 +226,7 @@ kp_spi_txrx_pio(struct spi_device *spidev, struct spi_transfer *transfer)
 			kp_spi_write_reg(cs, KP_SPI_REG_TXDATA, val);
 			processed++;
 		}
-	}
-	else if (rx) {
+	} else if (rx) {
 		for (i = 0 ; i < c ; i++) {
 			char test = 0;
 
-- 
2.20.1

