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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FEDC282CE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 01:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD6F20848
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 01:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mML4dgqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfFEBKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 21:10:30 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39468 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfFEBKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 21:10:08 -0400
Received: by mail-qk1-f193.google.com with SMTP id i125so4146373qkd.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 18:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zQKkpwtYkmsAlAHS1/A4fUvJkej14tNEkYhCxUI7UmE=;
        b=mML4dgqZiU8wAr0d5ViMsn+/5YALz6+FqkNUxcR95xosVUMIBi6CodrS3m6LUmE7yq
         N0F3JXgJcb1GrLlzx5hFiCb0Vy7BGKqS09iQ8rxnyjB1ogbN/tXJBEs0BTvdZhyFodrE
         vlN2ULSryR+pLbKQ2+otlPq6cGq3E4yw8AW59O6bwCneCoXbyoTguYBOdEgou7Q1hXJe
         ZH9flwTsYEX4uhJPyhF/UI9IT1KYIBswMCgdS2x0kGXn3NFKogznM2Q9kJwEuE6dhDjY
         rVjphXLFxgl7LTBv3lmLRWsggp/UsoU8fcYAwJVXddBeunRLMW6wfZNdqtXo8GFUc8a/
         FwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zQKkpwtYkmsAlAHS1/A4fUvJkej14tNEkYhCxUI7UmE=;
        b=es2T0DJsVePi77lyIHq4+XMQVj5kC6lPL10RBVnH/67AF4QPto+45LzGqAcSfljWi4
         ItU9st05DLxcmBqLGk77uHjBeZFCCE11rPfAggNFdEVZ9Kt9z09RvC1my4jgWWmR3J2m
         JnqHuQFKV/gBEfIeoafqDZ0CyvRBDDlQ7omdhZb00vrYTtV5ccsI0b/oLhSG0rtAWw4R
         CalYJIh35k8p+QXZw8EWpS+d8rJRqVUQDoBv7shH2QnmW8uG36/Qv692nJwthGxF1XSE
         f+yAuMqtogody98l2wURMJFkSMsPKDt/hjTh4fN8W2jOAsqUb9bQhs/niByuXVhwT0MJ
         MmWw==
X-Gm-Message-State: APjAAAXIthHQ2CwG7yuvw+eYYd+rd/ZYCG35IoxNbt0SC9By/k3BOiq0
        qk/C6wVCSnyJfy2tCfOt4TJOOSYcUco=
X-Google-Smtp-Source: APXvYqzPJdWBc2QIMT3Y6iL4ReXMlGY1hQuJNW76I+wcdqm0YiOxcQSdaP6E9QroOX3kgbi3s4xLBQ==
X-Received: by 2002:a37:6086:: with SMTP id u128mr10837297qkb.270.1559697007568;
        Tue, 04 Jun 2019 18:10:07 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.md.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id v41sm7169401qta.78.2019.06.04.18.10.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 18:10:07 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Geordan Neukum <gneukum1@gmail.com>,
        Mao Wenan <maowenan@huawei.com>,
        Jeremy Sowden <jeremy@azazel.net>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] staging: kpc2000: kpc_spi: remove unnecessary struct member word_len
Date:   Wed,  5 Jun 2019 01:09:10 +0000
Message-Id: <16f6ea93695137a9347203f66aff36874730cc26.1559696611.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559696611.git.gneukum1@gmail.com>
References: <cover.1559696611.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure kp_spi_controller_state, defined in the kpc2000_spi
driver, contains a member named word_len which is never used after
initialization. Therefore, it should be removed for simplicity's sake.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 1d89cb3b861f..61296335313b 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -110,7 +110,6 @@ struct kp_spi {
 struct kp_spi_controller_state {
 	void __iomem   *base;
 	unsigned char   chip_select;
-	int             word_len;
 	s64             conf_cache;
 };
 
@@ -269,7 +268,6 @@ kp_spi_setup(struct spi_device *spidev)
 		}
 		cs->base = kpspi->base;
 		cs->chip_select = spidev->chip_select;
-		cs->word_len = spidev->bits_per_word;
 		cs->conf_cache = -1;
 		spidev->controller_state = cs;
 	}
@@ -369,7 +367,6 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 			if (transfer->bits_per_word) {
 				word_len = transfer->bits_per_word;
 			}
-			cs->word_len = word_len;
 			sc.bitfield.wl = word_len-1;
 
 			/* ...chip select */
-- 
2.21.0

