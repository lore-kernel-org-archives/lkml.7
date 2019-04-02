Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0471BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C038A2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R2faxDuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbfDBQOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:14:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44624 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbfDBQOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:14:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id y7so17377175wrn.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 09:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Cr9HTf+kNWrh6e/DF1i39MvM2+hXkkoSIyorjoDf6I=;
        b=R2faxDuYLS6/B2ZmwCj3GLJJRoKpQB8rXZA70X9KKEX/SgB5J44olq5NiENQZ4A6cN
         1Cm8DIhzuKlV2Inh3tqRyXPZckAcBCiHsc6SU8eYfAlsHH9ZKEl6I0hjwhRv4qZzCRYi
         p0GB5nMLo1FerYpXq5O7yR7XByivsSRzuauZ7lMf3o66zyKtLBhyO1N/deaNSSBR4MjC
         y0IrXXxzrqyfhe1mqDVzakrGU1GaG1z2kEoE54u7GjCZJhIVu8lwHNO1+E6340TQM7A3
         3KxJU87CMLoD7sacSfLq63pS5ZEvjhg9/j57/qyb1Gg5MlWvug6f0lRFiOvCV2xHZguA
         jw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0Cr9HTf+kNWrh6e/DF1i39MvM2+hXkkoSIyorjoDf6I=;
        b=JPv9iV9dHVn3F8DHuQMCR4/gfzy+UgnfGxw1pYepmuLxGwn/QSY+ibixre21nZW2Ps
         xxI3wTNwywy24ZIin89XBOAV9wqvgQvg4dC68qb1F8jgAnxhYxa4z8gt0owCc7W7wAXB
         PsulQGEZ4d4hzEukXFK4z2mmY5zIoyTUDiCPYbGKFSvdvdzOkc2kc4mLjlnWBZruy45q
         MxKuOC3SBbhUStE/YP/k5hNECkqsUzQaidNlJiaKiFYoaXWCbDcvo8Ml2M0/8csYZiVw
         YWvE1crQVcexVEPXrCDSxixYTwa3XVlZQsXTSCPJbhUZbwKlUXSrY+/tvIawEzcVAs4k
         CZ/g==
X-Gm-Message-State: APjAAAWO2wT1BIr1Bon/VtOZ07S72yr7Jifm3XkjH34We50DAkDXtZ2B
        EX+KxpN2UpdqbQo5aQ61+Db2UndtbmnUVg==
X-Google-Smtp-Source: APXvYqws+I2idgnBO9lS6V1nuDiIvVFOn+w3gxJy52WsbSTa0DyEZPapRt0mHBL+GYNMNGNjsgAG2A==
X-Received: by 2002:adf:de8d:: with SMTP id w13mr44731459wrl.26.1554221644717;
        Tue, 02 Apr 2019 09:14:04 -0700 (PDT)
Received: from mai.imgcgcw.net (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.gmail.com with ESMTPSA id a126sm17054999wmh.4.2019.04.02.09.14.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 09:14:04 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com, edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] thermal/drivers/core: Fix typo in the option name
Date:   Tue,  2 Apr 2019 18:12:49 +0200
Message-Id: <20190402161256.11044-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402161256.11044-1-daniel.lezcano@linaro.org>
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike the other options, the cpu cooling option is beginning
with a lowercase letter, changing to a uppercase.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index d8aa7fac8c56..83e95a4fb61b 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -148,7 +148,7 @@ config THERMAL_GOV_POWER_ALLOCATOR
 	  allocating and limiting power to devices.
 
 config CPU_THERMAL
-	bool "generic cpu cooling support"
+	bool "Generic cpu cooling support"
 	depends on CPU_FREQ
 	depends on THERMAL_OF
 	help
-- 
2.17.1

