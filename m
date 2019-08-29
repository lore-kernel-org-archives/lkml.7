Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5923C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 04:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7052173E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 04:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RqZ3AJJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfH2EUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 00:20:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40276 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfH2EUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 00:20:47 -0400
Received: by mail-pl1-f195.google.com with SMTP id h3so956379pls.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 21:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qQI5iJC9ehaYt+kRey+tPIwzQxEitpVjxbpR7mvkHRQ=;
        b=RqZ3AJJ+5jSfK0VrydP0ijjVTMsqIdOjiqw6T9p6jny4M01N3lT8xm4rJrkhMpeJ6K
         8FPa6Y5Iyrt8EEVuc+Svsn+U0NCMwzfNvDeEvPvPe/RoTy3o3hAH1qmihyQG8dn1Ia//
         YUdZTUilVu3q7hCuB6iWkRn93U/GwNuuOXQ/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qQI5iJC9ehaYt+kRey+tPIwzQxEitpVjxbpR7mvkHRQ=;
        b=C1bXmZw+DGqrF1wfe5Rfu0n9SOC4jjmbMO0huu58w4P6ySuoMq6Wq75qa6Mz0X6lS9
         Iu4uqSkVQG6+g+bxS8YpvNEVbjuIrzDDDmmObYLRS9PBDFbpRPXKy7laUEzo6lOap5Vs
         tZwkR9rFm/zUC9xYyRV/746AQMPZnklZa9Noq+N5ovYunhHQha4RS8k2OQtJ6rDWYFBc
         e/zdTlM0Cwv74/evHum4Psy8qUa06w8l33zmqsyEltlgadBZl0/mH8lfrLkFSiNR4Ccn
         ApDVcc86kU+cBg5a4PTgp3WnUu/iyJ7rj7OV+fDhDExFZ8GCbGSPhFjgy4LpEFhva2aY
         91qg==
X-Gm-Message-State: APjAAAVGbZc33ZgmwoqYOZnz90Z7oQT1QzXseTafryDNnl5CK7rN7fYJ
        qdGHFAppDMEK40zhL0Y5r7E3kvTzLPmISg==
X-Google-Smtp-Source: APXvYqwlUu4LUSIqSJrsGi0ecG4deNc5qSiF+a7rYr9acICsCkxuqeztmmPDOUjSVLbfOu3Oi7W0MA==
X-Received: by 2002:a17:902:fa5:: with SMTP id 34mr7897357plz.285.1567052446342;
        Wed, 28 Aug 2019 21:20:46 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id n24sm821653pjq.21.2019.08.28.21.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 21:20:45 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH V2 1/1] spi: bcm-qspi: Make BSPI default mode
Date:   Thu, 29 Aug 2019 09:46:13 +0530
Message-Id: <1567052173-10256-1-git-send-email-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spi-nor controller defaults to BSPI mode, hence switch back
to its default mode after MSPI operations (write or erase)
are completed.

Changes from V1:
 - Address code review comment from Mark Brown.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/spi/spi-bcm-qspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 902bdbf..46a811a 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -897,6 +897,7 @@ static int bcm_qspi_transfer_one(struct spi_master *master,
 
 		read_from_hw(qspi, slots);
 	}
+	bcm_qspi_enable_bspi(qspi);
 
 	return 0;
 }
-- 
1.9.1

