Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0F2C76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A642173E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J94PBbim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389043AbfGPWpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 18:45:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40856 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388944AbfGPWpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 18:45:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so9803354pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 15:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=72sm/MNTwsNcY36VTGuC/LZLkp7KY9tFB/Nl1CF7FuQ=;
        b=J94PBbim+Yv1GJt8vVgj6+wcSDxVIhoI24sx6Ohj38GaoLPK5smv0nkb3SYd2el77t
         vhonBa6mPzCYZBG5IGCaD7sBcIrd7SlCQO0LYmBNL8zSlXInCc6ICRsQN0Y4g8SQtwpS
         mYIMo0LaCbF6Ir8WNqnrThYgyhYz5bABz7R+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=72sm/MNTwsNcY36VTGuC/LZLkp7KY9tFB/Nl1CF7FuQ=;
        b=lz24Rs6O7CByq5KPcK8Y8mbloxbIQdR67EYxmwsRCJBC2do2eEZ7RcYDBL0KyMHIbi
         I6K7NkFNoWN5yNcEWFA7xk4N8MZe87NkA59YifkauEIOAxVDyuiINc5rfXBLYdk6pEkF
         XrrwoX3DhJ6r1px9RBLb0aHCWDDmx7QFFZjnQF++MzPWJC62uDXBtTs9QA2gmTVNeZ+Y
         WzEkr4ayG7YSxgWpAVJmLOFAbt8F4egb69Gr0e/0JxB3VsjM4ApIF3Pf5g7QVG8RcaYC
         UCFMpY/FJvqXTuGeiSCS+XAHNsC3FmIG1Hr3gBw79xLLaVP5FnOhPfOJ6u2zs2nM4pp6
         1U9A==
X-Gm-Message-State: APjAAAXjvU/O99Hx0e0MdvLDB9h4DCjocRnZ12iR/3++xFvjehTQGoAb
        8GtTXcVFENk54G8AhOUPwHE1Kw==
X-Google-Smtp-Source: APXvYqxPLoiQ/fQgpBzDfuDCkw0cAWxIoJ+jwZaN3mgwgHT7TpOVZgKqLx0rU89mFfmaN1nGc7j+/A==
X-Received: by 2002:a63:2006:: with SMTP id g6mr36282313pgg.287.1563317122894;
        Tue, 16 Jul 2019 15:45:22 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 64sm22182562pfe.128.2019.07.16.15.45.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 15:45:22 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>
Subject: [PATCH v2 3/6] tpm_tis_spi: add max xfer size
Date:   Tue, 16 Jul 2019 15:45:15 -0700
Message-Id: <20190716224518.62556-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190716224518.62556-1-swboyd@chromium.org>
References: <20190716224518.62556-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Pronin <apronin@chromium.org>

Reject burstcounts larger than 64 bytes reported by tpm.
SPI Hardware Protocol defined in section 6.4 of TCG PTP
Spec supports up to 64 bytes of data in a transaction.

Signed-off-by: Andrey Pronin <apronin@chromium.org>
Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/char/tpm/tpm_tis_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index 19513e622053..27393275a3f0 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -190,6 +190,7 @@ static const struct tpm_tis_phy_ops tpm_spi_phy_ops = {
 	.read16 = tpm_tis_spi_read16,
 	.read32 = tpm_tis_spi_read32,
 	.write32 = tpm_tis_spi_write32,
+	.max_xfer_size = MAX_SPI_FRAMESIZE,
 };
 
 static int tpm_tis_spi_probe(struct spi_device *dev)
-- 
Sent by a computer through tubes

