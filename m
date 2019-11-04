Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAE1CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D0C21D7D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QzEiccYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbfKDNXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 08:23:05 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45158 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfKDNXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:23:05 -0500
Received: by mail-lj1-f195.google.com with SMTP id n21so3941910ljg.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 05:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vg2dkF/2Ifi7G+ZcSBBl+nfqJx6J0UT9qBXqtWzzGRw=;
        b=QzEiccYQSDuMK2DgIFIezyexmyQOpxPdN2M47H0clKJStHoVH1bChOXtVPrJZGgmT3
         U1MQ8S8DrUZUJAIcc7NQtBikrQtNkTZAqCmZrYIDIK1L9NdEi29WmldPpx/Av1DDnDuS
         yXDXKpxFu8brtz1ejSioWZBvhJY+u8RxTLl6xz1yd65+jNxzGzL6hUcIV6SmxGQRP2uH
         UlhrZ/Y5RwJ5ML6UyNhyJSUF+BdEDsCEsWtL/1DlnIb8/gHEHvAu7IZoSdXVVzC04m9P
         u9RPh73zpoDA2t/PzbAVWVXBQMwu+405m875bil+4rC1ILPOCCrQKKtC5T85d1MQgaF6
         ICTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vg2dkF/2Ifi7G+ZcSBBl+nfqJx6J0UT9qBXqtWzzGRw=;
        b=spPLbglrjOGklTMqQ/f1vkCT0QCLBLt+rAgAEc6H+QFQ+D9iXqXDYtbgbApNhLQXCD
         1DL6PdW0ScadIOK3HJafEO63djDhMblx1pbidv6iMvRXluKj9rTexj+86OKCJhq6j2E8
         ttV0hwhyDKg/G4Jpty4fklL5GiwpULC2FZqOlo5dwrzm0DfxvW7ty6Md9czmros/l21a
         k1JBnsTg85MfXJkrJRBLNnsz040bNIjQ4g4hUZIg106+FmT4xfNMksnkiKRcsJq8UJz4
         TyyOs4VtX31iMA+K2UfPGEDJrKNnCHkvmKTDuvXMJ/qh3nyrXbrQ4jq5e9DK9RImy9zH
         S9TA==
X-Gm-Message-State: APjAAAUqibnLzfi6bDBk3a7u8IyA5F6a/1HK2k5HKX3FL/uY4zqkvq2z
        BxnOAtBQmW1jqSrPzPUB/XcPWw==
X-Google-Smtp-Source: APXvYqyr2DlrYIUmXxRcozCzuzKS2AReVQ05zDr4H4OrG0lgYHBfH5ZWUAhu7NyPOjJ0wbVwf3dlYA==
X-Received: by 2002:a05:651c:289:: with SMTP id b9mr13779760ljo.80.1572873783018;
        Mon, 04 Nov 2019 05:23:03 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id f5sm6480538ljn.24.2019.11.04.05.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 05:23:02 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Mark vub300 mmc driver as orphan
Date:   Mon,  4 Nov 2019 14:22:59 +0100
Message-Id: <20191104132259.32500-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony's email address from elandigitalsystems.com has bounced for a long
time. Let's update MAINTAINERS to mark the driver as orphan as to reflect
the situation.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 77fc3ff3cb23..be6a6539103b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17456,10 +17456,8 @@ S:	Maintained
 F:	drivers/hwmon/vt8231.c
 
 VUB300 USB to SDIO/SD/MMC bridge chip
-M:	Tony Olech <tony.olech@elandigitalsystems.com>
 L:	linux-mmc@vger.kernel.org
-L:	linux-usb@vger.kernel.org
-S:	Supported
+S:	Orphan
 F:	drivers/mmc/host/vub300.c
 
 W1 DALLAS'S 1-WIRE BUS
-- 
2.17.1

