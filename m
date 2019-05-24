Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10F2C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 20:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5192217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 20:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="RKKoulMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404204AbfEXUbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 16:31:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42264 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404009AbfEXUbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 16:31:06 -0400
Received: by mail-lf1-f68.google.com with SMTP id y13so8023282lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 13:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dXxgezPTBmcXK6U7eT+ZniYRkjIkHyj/4qWZKolWGME=;
        b=RKKoulMjCNtwd7QRzpp70GPC02OUG/Ev38XCNd/GOE9VruKM+ZkoKkfuD/KifFk5s/
         ucZmvOzaROhccsgdk1wbE2HFpvRGvI9RWvowIkXLPuBDBR/UnyZNWb0/0U0C/SZ+b04V
         JTNd/pWyddg74CN9vAqLZGyUbySTWiGt19XcXzFnmtH0EDGNpenkxDx08OfdmDgHoUq5
         BBolsDbVu+4YClxX2rC//HO0zO7gUzyeoiJADPggF9Na0qMQp8ZTLqqf2YRzIyTQUs7P
         zTo7qnhmYPsSfjWQBnQ/CsCYchDX4eWm+9yA7x0tfG8Cc3rattXYV5Km3deWA8u5HTib
         HeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dXxgezPTBmcXK6U7eT+ZniYRkjIkHyj/4qWZKolWGME=;
        b=pJya1UnshYgFUlIB/n3fFDMWy19LlI8gGSnNG07PJJK0XX6qbYjnQlBHtG+VOCPtmN
         +wpuyq5t+yMpD6vwYNBs0LUq23jr1AYcmHkEMXTcgZbXl9NvokEDZNZAgIAfWn05VWy1
         V4FJR512zjk5w6XXakSiW62GWWd40GrFgcS9GFm5/UzH+oP1VODKVKirqsAcqhl3WDKl
         awWQBQqud/+KlEbD+ENag85GIbjfZb1ZlxRrHCo9I+4CNT0Z/v/uzrvQ8uwt57FqpeoV
         jJYCIW0sPS3ObVa3YoaopizEyoXbnh4t8F3Wg8UioJTOfN+2U388k8jvsRkzetIBACjr
         rXJw==
X-Gm-Message-State: APjAAAW99R1qZRK1qwZcZeUWUVIeVucSh3x9DzFGXpLLSc8ak2lQBw8q
        pAZZME5czdVeJSDfyu0MXIc6Nw==
X-Google-Smtp-Source: APXvYqwzxomZi+ea9FMxZMee20ow0MR7W+LSI+IFkN2Zy3auBLCudMHe+NlRlo4M8MrcRwOwijdCBg==
X-Received: by 2002:a19:ca0e:: with SMTP id a14mr14823589lfg.3.1558729864890;
        Fri, 24 May 2019 13:31:04 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id j69sm921036ljb.72.2019.05.24.13.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 13:31:04 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, Matt.Sickler@daktronics.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: kpc2000: fix typo in Kconfig
Date:   Fri, 24 May 2019 22:30:57 +0200
Message-Id: <20190524203058.30022-2-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524203058.30022-1-simon@nikanor.nu>
References: <20190524203058.30022-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes two minor typos in kpc2000's Kconfig: s/Kaktronics/Daktronics

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/kpc2000/Kconfig b/drivers/staging/kpc2000/Kconfig
index fb5922928f47..c463d232f2b4 100644
--- a/drivers/staging/kpc2000/Kconfig
+++ b/drivers/staging/kpc2000/Kconfig
@@ -21,7 +21,7 @@ config KPC2000_CORE
 	  If unsure, say N.
 
 config KPC2000_SPI
-	tristate "Kaktronics KPC SPI device"
+	tristate "Daktronics KPC SPI device"
 	depends on KPC2000 && SPI
 	help
 	  Say Y here if you wish to support the Daktronics KPC PCI
@@ -33,7 +33,7 @@ config KPC2000_SPI
 	  If unsure, say N.
 
 config KPC2000_I2C
-	tristate "Kaktronics KPC I2C device"
+	tristate "Daktronics KPC I2C device"
 	depends on KPC2000 && I2C
 	help
 	  Say Y here if you wish to support the Daktronics KPC PCI
-- 
2.20.1

