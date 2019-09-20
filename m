Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F60C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C3D2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b+RPPisf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406684AbfITSc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 14:32:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46417 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406628AbfITSct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 14:32:49 -0400
Received: by mail-pf1-f196.google.com with SMTP id q5so5033917pfg.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 11:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p7IfU61KE2txhnLC8mG/Pzm9PBv785Nvfxd4FYtvCwc=;
        b=b+RPPisf/2hxQhW05ru7RW/KG9Jpf2rSHMmfrV2LDB4v3ZsUDOhf+sdejyVBzrvSFQ
         f7PXa7Z0tMhC7VqrXtpsCmIcaOL6hs00kaYfKCIgi/MFzGo3tYmK8XJZ23HZWuaZjrfv
         Z6mFQHxasieOupjhCYo951/yeGWwoYwlMJlu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p7IfU61KE2txhnLC8mG/Pzm9PBv785Nvfxd4FYtvCwc=;
        b=Z3iuOoIXRxBP9bBRu/w+3RP2o7TJOKMJp0c+A1NB0+0GQcA9jLGHTOqKsipjxMnmJ+
         yoYIZuffqKHdgCzzsUhoPJ9u/apx7fjaO37PAyTj2VlLvz7sugeuT0+XirexChTKLdAp
         YIQRp8sQ9lpNmRLZq6ANfEK4X5xXRhHwKxjMaOBRs2Fes7h7cjtj09qWtyXf/wlMAFva
         ZPQtXja8P0FlrqEuukMmJgQcMAEWgxWNjRwjpiwvxyifHHvgYpqm6yCYbtwZ9L+Z2qeV
         wW070wSGnC89H81GrrrW4LuvI4kRXflsjVyUDDeSBBzEkrlhRIFdLoRLJjekjq5loRGb
         VFAQ==
X-Gm-Message-State: APjAAAURagALbKGcUG0zL94sPe41+TDnfrB4iyGVamGJxL3vDJXVd9Dm
        O3COKp5f8D5iITEcBlRPjTGiPw==
X-Google-Smtp-Source: APXvYqy8nLBGPA5Ce5MY1hxDTwMj6VGdu3MYCiEfKtWTCTtQj3T/I+08bq/MEAKVkaCJRyy09HhEEQ==
X-Received: by 2002:a63:5d0e:: with SMTP id r14mr16656526pgb.15.1569004368198;
        Fri, 20 Sep 2019 11:32:48 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b69sm4436072pfb.132.2019.09.20.11.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 11:32:47 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v7 6/6] tpm: tpm_tis_spi: Drop THIS_MODULE usage from driver struct
Date:   Fri, 20 Sep 2019 11:32:40 -0700
Message-Id: <20190920183240.181420-7-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
In-Reply-To: <20190920183240.181420-1-swboyd@chromium.org>
References: <20190920183240.181420-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module_spi_driver() macro already inserts THIS_MODULE into the
driver .owner field. Remove it to save a line.

Cc: Andrey Pronin <apronin@chromium.org>
Cc: Duncan Laurie <dlaurie@chromium.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/char/tpm/tpm_tis_spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index ec703aee7e7d..d1754fd6c573 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -283,7 +283,6 @@ MODULE_DEVICE_TABLE(acpi, acpi_tis_spi_match);
 
 static struct spi_driver tpm_tis_spi_driver = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "tpm_tis_spi",
 		.pm = &tpm_tis_pm,
 		.of_match_table = of_match_ptr(of_tis_spi_match),
-- 
Sent by a computer through tubes

