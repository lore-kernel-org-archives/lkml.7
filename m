Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECB2C28CC6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 01:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08727207E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 01:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ST94zn4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfFEBKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 21:10:17 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35423 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfFEBKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 21:10:11 -0400
Received: by mail-qt1-f196.google.com with SMTP id d23so16197272qto.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 18:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VlHxMBMSfeEvLUylf2B3zOxUXUQHYZ4p3EWUpLSdpOU=;
        b=ST94zn4fENWmSqKcu/gQgcIVE9zAdBriCQX2zGUJSwk0C7O+5PbAsWtzJCLX7xKdBL
         jrPAGArOVsdsrgTV7odUJ0kbosYG/UUaYTrGW3oMstkM9jLO524ZBYjq5Zy06sq4R8h4
         yT+B+8iL3Glz8ktqMAM8Q2vq1ke5XeC3nwDEDHsAS3lNqszkxVeOabFm8RvJdwXbyvuI
         ImiDA9uy3cYHmVKtXJH1OKVeOgZNsoQVOp1qCN6meDeVxwH79K4qYnY5c0VXXlzEVdgR
         zuzE7TXlgCe/WvIbo2cHZ7DL4t242LHkioV666WPo7jY3DHs6wJ+FWjj7gxYyZNhsckz
         pqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VlHxMBMSfeEvLUylf2B3zOxUXUQHYZ4p3EWUpLSdpOU=;
        b=dzEl/Hj5aSauAcSddQIQSkXm2uiJfcePHXRSFYmWFJdzi5j9UPCYN1PxFLCZENbEi8
         nZmZhdcO7Jd0BIHR9gg/zQeACVWYi6yzqpbPLDAcXvGvqpyGwmB9pHHNIrGcQuBZl8Nm
         7Qie98IziLKb0rs4aVrLk2ZQ/8ZZ2DodllLTXTiZAyTG6M57HU2cLJUK8XBLcFy8Blg8
         3TCOt9ifAVV+Z5QPEX8iMQRFwXmVzSPWjfOQIvoQmB8Qlcvl2N/nudKhQHEL91HXx8ED
         t+lvLoa+WEDSyn17u2sKBtGbm3PS/3/tc7ieAk39Y4ZEQvoasa++XJnHydpBDaAFcWuQ
         J+sw==
X-Gm-Message-State: APjAAAV71bKm7vQCOddEohEUNuO8bj2AZv6yaNOQvcwjH8gPsftXCggr
        uDJIt/Y+aC3jSS7XNvOVT3g=
X-Google-Smtp-Source: APXvYqzplwYfbrveGGdc41Cn+cXNTkIaqn8/G6QpmVKJvO/KV1g/L9F+8xljTJs4ZA749Pnt0Cs3PQ==
X-Received: by 2002:a0c:fde5:: with SMTP id m5mr10497044qvu.192.1559697010532;
        Tue, 04 Jun 2019 18:10:10 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.md.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id v41sm7169401qta.78.2019.06.04.18.10.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 18:10:10 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Geordan Neukum <gneukum1@gmail.com>,
        Mao Wenan <maowenan@huawei.com>,
        Jeremy Sowden <jeremy@azazel.net>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] staging: kpc2000: kpc_spi: remove unnecessary cast in [read|write]_reg()
Date:   Wed,  5 Jun 2019 01:09:13 +0000
Message-Id: <243b8c78084e46606e78bed26a575181648099fd.1559696611.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559696611.git.gneukum1@gmail.com>
References: <cover.1559696611.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kpc_spi driver unnecessarily casts from a (u64 __iomem *) to a (void
*) when invoking readq and writeq which both take a (void __iomem *) arg.
There is no need for this cast, and it actually harms us by discarding
the sparse cookie, __iomem. Make the driver stop performing this casting
operation.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 4f517afc6239..28132e9e260d 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -167,7 +167,7 @@ kp_spi_read_reg(struct kp_spi_controller_state *cs, int idx)
 	if ((idx == KP_SPI_REG_CONFIG) && (cs->conf_cache >= 0)){
 		return cs->conf_cache;
 	}
-	val = readq((void*)addr);
+	val = readq(addr);
 	return val;
 }
 
@@ -176,7 +176,7 @@ kp_spi_write_reg(struct kp_spi_controller_state *cs, int idx, u64 val)
 {
 	u64 __iomem *addr = cs->base;
 	addr += idx;
-	writeq(val, (void*)addr);
+	writeq(val, addr);
 	if (idx == KP_SPI_REG_CONFIG)
 		cs->conf_cache = val;
 }
-- 
2.21.0

