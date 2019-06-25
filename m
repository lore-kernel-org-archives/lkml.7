Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A13C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4797215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="h+1idvdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbfFYIlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:41:46 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44692 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730843AbfFYIll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:41:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id k18so15367482ljc.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 01:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sT0YZ5enr1IjgWnf7+8eOaRAS62hBp5cUSkc0cP/3oI=;
        b=h+1idvdy1rIsuqzSoEQ6L53/Rpk7LktZhBSjZo+AZ10Ery6goReuZ+HMVjmB6zv1NK
         +7A0if8oT1XPrYcsyYjfpDIC62nTFZHD8bzx3CJmXIQ8fE1hxX6sTf2OY9i8pXY1y6Fh
         3awRBU4mRA+r/0qe8y//xNgWHaFd0UKQaL6BIOGxb4dnlJExg/9liuH6LNiNtkgElb1l
         TqU1JBIxFXXbvginUp+Db5+Phl1ndLnOYNFg50UbE+5yQkn9dvEKoS5DLVrzBNxyWzwz
         xJLDVv3vKbW5mWddxa+wuMRtrwfodZ4qvKwQ0zzDaTEdjX61fcXmIpCyu8ykOhPg3C07
         s4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sT0YZ5enr1IjgWnf7+8eOaRAS62hBp5cUSkc0cP/3oI=;
        b=bNqjfotzAEZLoDP2KFdwXHS2JkmhA+hdVNDt1seZ15NnbrCJXAURVP5pJgzhh7LGx2
         u9jCeytHkFOqdVORKKYIgQuUG5jbUz8wnssYg5+GnCVF6zFjM89GRxwvOrzbi3jhaqKS
         xu9vHyx8HODbwd41IugUXT0gb96xGggnGn3CwnWvucnL/j4wMWHQQCOs0CGNOAAX3hIY
         PHDKnGEw/lpxhx3cS5U+mFNQW0y4p7PvXtL3bGTQUxmedmcUXN025O5EqI+xfMWozdKr
         jk7x0jwgCmkmW5VEjt4RfFPu/Xk5nPihAMa0pV3h/wCvD0LlIJtHsrJjGsoywB968V9e
         shZw==
X-Gm-Message-State: APjAAAUNA5DF7kaCwNAfoZV42EHOlytkPgcWNpNYYJoIMOtEkOCn+FmU
        qYvPMBIb7vvfg0fJ+uDEMM3aLA==
X-Google-Smtp-Source: APXvYqyhNRxe+Iyz0E8lvH38qfGCePVTqLsSX/TK9reum1lySDwVSWS9NIeoWyoXNZM6UksA24MGHA==
X-Received: by 2002:a2e:12dc:: with SMTP id 89mr20550744ljs.40.1561452099620;
        Tue, 25 Jun 2019 01:41:39 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id h78sm341564ljf.88.2019.06.25.01.41.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 01:41:39 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH 4/4] staging: kpc2000: fix brace issues in kpc2000_spi.c
Date:   Tue, 25 Jun 2019 10:41:30 +0200
Message-Id: <20190625084130.1107-5-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625084130.1107-1-simon@nikanor.nu>
References: <20190625084130.1107-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch errors: "else should follow close brace '}'" and
"braces {} are not necessary for single statement blocks".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 68b049f9ad69..4b1468137703 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -164,9 +164,9 @@ kp_spi_read_reg(struct kp_spi_controller_state *cs, int idx)
 	u64 val;
 
 	addr += idx;
-	if (idx == KP_SPI_REG_CONFIG && cs->conf_cache >= 0) {
+	if (idx == KP_SPI_REG_CONFIG && cs->conf_cache >= 0)
 		return cs->conf_cache;
-	}
+
 	val = readq(addr);
 	return val;
 }
@@ -222,8 +222,7 @@ kp_spi_txrx_pio(struct spi_device *spidev, struct spi_transfer *transfer)
 			kp_spi_write_reg(cs, KP_SPI_REG_TXDATA, val);
 			processed++;
 		}
-	}
-	else if (rx) {
+	} else if (rx) {
 		for (i = 0 ; i < c ; i++) {
 			char test = 0;
 
@@ -261,9 +260,8 @@ kp_spi_setup(struct spi_device *spidev)
 	cs = spidev->controller_state;
 	if (!cs) {
 		cs = kzalloc(sizeof(*cs), GFP_KERNEL);
-		if (!cs) {
+		if (!cs)
 			return -ENOMEM;
-		}
 		cs->base = kpspi->base;
 		cs->conf_cache = -1;
 		spidev->controller_state = cs;
-- 
2.20.1

