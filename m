Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AA2C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 23:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9445F24658
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 23:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="X9WHG7rg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfLEXO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 18:14:27 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:42612 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfLEXO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 18:14:27 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 47TWkp1jHlz9vklR
        for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2019 23:14:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0GIaP6le0V1G for <linux-kernel@vger.kernel.org>;
        Thu,  5 Dec 2019 17:14:26 -0600 (CST)
Received: from mail-yw1-f71.google.com (mail-yw1-f71.google.com [209.85.161.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 47TWkp0WvCz9vklF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2019 17:14:26 -0600 (CST)
Received: by mail-yw1-f71.google.com with SMTP id i70so3760256ywe.23
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 15:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oSYnes0/l1u+4rIUZLMW/yKpeiqYc5kOnZtn2XTe1+4=;
        b=X9WHG7rgvwbxw7JgkQDFD0KoZjBvbTkWObbXVHZ2899dH/a4k32yNqM14o9vSaifdk
         y0ODLMeZIUC96L+JdSPfLbLcI/yEApv/yVGB3FzktZqL+ZBKQ6NhWKBAmqrmZj1LV/OO
         14gIkdUKkJXjIXt5L/UC2fKDhoQv6TJPhYX4cjlqmxsQyMime7tgHwuQrqXOJjmUraJV
         uIRVeyUfyRyLcsC3fA2UTx3a9MsMK9voa5m9oXcbUyeJolSY7MeFSBzkNuOJxmlRcfP5
         D1tUy8qpYW/YuBUN21HwKjywMavWUB1lT0GyA4mBsMuRwhwm0ULlplKhT4s+s0doRzuz
         tTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oSYnes0/l1u+4rIUZLMW/yKpeiqYc5kOnZtn2XTe1+4=;
        b=LPdRt2AEDkyHnfnLmyznAbFkmoVj3ZA5uO3/0fG0nTc0oIYBasJq4GfSecOcY1B07s
         fceWO7zzqSA4gdDLNTD3LlM8A2DdAU0aaTBDKIntAWccNo4W2kb8cnq1ubF5GW6CUE3d
         agQ774z3XYqtp5mGmnG/ji8zp2txopb5Zxwlm/Z1PTNw7Q0p51RCMZLDbyJ87x50H/A/
         cd0Tck+QHGRgN6oaKjjCYOjFHQRhkfQdogEA1TLv4lPNv/YWFpM7PCZzYUnnhZqVsYg6
         vAuoQMCJO/eAWvfMBX4siKtpoLXrtK3wAyDcazALsq0exhhlnah8V2CK1DkztsAq5Pm5
         Qvjg==
X-Gm-Message-State: APjAAAXQYNK9dmjvaEjM2ZWO9SUjxrHzqJlEQmpHE3n562wZ9vA3ZlhY
        jI2crrXXtBzjkCsJUYLiuhrcsU/C7wQKxOZzjuJrEWjbJaiiKPa7wwyidNBp6j2vIE08EHaet9/
        j1Px1p475zZyILytJRWu0lzBRcf95
X-Received: by 2002:a25:7c44:: with SMTP id x65mr7863558ybc.382.1575587665408;
        Thu, 05 Dec 2019 15:14:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqyLAnU6KbwAtj46DpMUNEmC9R9ezFXcb1I4FJWdCTx69wIk0nVCGHH0hGfZCalPe1Upg56GnQ==
X-Received: by 2002:a25:7c44:: with SMTP id x65mr7863541ybc.382.1575587665127;
        Thu, 05 Dec 2019 15:14:25 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id e198sm5681470ywa.51.2019.12.05.15.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 15:14:24 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: dw: Avoid BUG_ON() in case of host failure
Date:   Thu,  5 Dec 2019 17:14:21 -0600
Message-Id: <20191205231421.9333-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If dws is NULL in dw_spi_host_add(), we return the error to the
upper callers instead of crashing. The patch replaces BUG_ON by
returning -EINVAL to the caller.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/spi/spi-dw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index a92aa5cd4fbe..a160d9a141ea 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -460,7 +460,8 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	struct spi_controller *master;
 	int ret;
 
-	BUG_ON(dws == NULL);
+	if (!dws)
+		return -EINVAL;
 
 	master = spi_alloc_master(dev, 0);
 	if (!master)
-- 
2.17.1

