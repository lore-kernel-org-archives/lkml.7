Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F772C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C98218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MyOtSiFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbfCVLnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:43:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38509 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730287AbfCVLnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:43:43 -0400
Received: by mail-lj1-f195.google.com with SMTP id p14so795372ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 04:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WrrOAdIl29CqUMATgYYAV3iygiD0JbDr1tHUUwiRwT8=;
        b=MyOtSiFpyiIbOfbTuuvF9mg25nst8need3cfrO5Qfj+HE+ZrttylWRjai3GnB/rXx3
         1e3LhFbdyOIBb7ibIe49q2jw1wHwhuRXcMhzsEcE/QGngCscH8fXz2T3GHIXndVdLx4x
         dPHp6oevHX0p7+uTnHSk3LnQvD/xjAQXN5sByW3wOPiM9io1kLiWu6XG1NlK1zHRCe8D
         2RTFYa9SFLrR0djl0wbR8LtK6ch5Ssaq2cuL5C3duA0gh9BNap7g55tP98F5X7YVraZt
         2SwgzR0BEXdAZ7rhawH8eNkuO2WhB/1UkCbqqysmcN8iGFSfc1rP3qPSi3ohifUv+c5N
         XWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WrrOAdIl29CqUMATgYYAV3iygiD0JbDr1tHUUwiRwT8=;
        b=Sry/Njn4ryHFykuVhNbFRA9yYU2rRDOb3fGUjZqhCtQzdFkTQTBoZO6/35X5ct5e3X
         iivM08l/r/MReRCPOMXRGcQL8gERzEu1EjSvEE8GEsM6lC+Kuj4zcHCwdviYAUVUF441
         TQ1rzWaiq2WZjrPDG6zGygNXzZWfVKV7Jp2vX7tQ6Ai/CTuwmfSRq7XT/hO1t2ZdgHy6
         CCWBMhsv9lX/LJEkH9U+mKNwKhtyxvr0xMvo3RbUtZyUmVDnncCJ57OxK4rbG2k9U3iP
         U4iZiPgBHDuLNDKDdWKfCGecsAYH9fgMjCwa2UQqhNS+rTRKLbgoOd5/pdSsQbk8UNaK
         SzPA==
X-Gm-Message-State: APjAAAW97JsMXqHtu40FwUZ2NbHAlhe8T+T3XazztnUA4efcHCY8/qrl
        zkN5aB/rPF1tQ7oVCzPw7r3W4A==
X-Google-Smtp-Source: APXvYqyssS6vRkAA/avsOWYA/D/4+0xMYne1kWwKAqdu2Lur77L6oDXzO3vJubJWJ3OsIjkSK/1jqA==
X-Received: by 2002:a2e:9d04:: with SMTP id t4mr5174777lji.80.1553255020984;
        Fri, 22 Mar 2019 04:43:40 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id x3sm339841lfn.64.2019.03.22.04.43.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 04:43:40 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, Alex Dubov <oakad@yahoo.com>,
        Alex Dubov <alex.dubov@gmail.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>
Subject: [PATCH 1/2] MAINTAINERS: Collect TI FLASH MEDIA drivers into one section
Date:   Fri, 22 Mar 2019 12:43:34 +0100
Message-Id: <20190322114334.26482-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current SONY MEMORYSTICK CARD SUPPORT section is pointing to the TI
flash media memorystick driver, which is a bit confusing. Let's make this
more clear by moving this part into TI FLASH MEDIA INTERFACE DRIVER
section, but rename the section to TI FLASH MEDIA MEMORYSTICK/MMC DRIVERS,
as to make it more clear.

Finally, add Alex Dubov to the SONY MEMORYSTICK STANDARD SUPPORT, as I
believe that has been the intention.

Cc: Alex Dubov <oakad@yahoo.com>
Cc: Alex Dubov <alex.dubov@gmail.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf70b548..61bdbade3daf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14463,14 +14463,9 @@ T:	git git://linuxtv.org/media_tree.git
 S:	Maintained
 F:	drivers/media/i2c/imx355.c
 
-SONY MEMORYSTICK CARD SUPPORT
-M:	Alex Dubov <oakad@yahoo.com>
-W:	http://tifmxx.berlios.de/
-S:	Maintained
-F:	drivers/memstick/host/tifm_ms.c
-
 SONY MEMORYSTICK STANDARD SUPPORT
 M:	Maxim Levitsky <maximlevitsky@gmail.com>
+M:	Alex Dubov <oakad@yahoo.com>
 S:	Maintained
 F:	drivers/memstick/core/ms_block.*
 
@@ -15497,9 +15492,11 @@ S:	Maintained
 F:	drivers/net/ethernet/ti/cpsw*
 F:	drivers/net/ethernet/ti/davinci*
 
-TI FLASH MEDIA INTERFACE DRIVER
+TI FLASH MEDIA MEMORYSTICK/MMC DRIVERS
 M:	Alex Dubov <oakad@yahoo.com>
 S:	Maintained
+W:	http://tifmxx.berlios.de/
+F:	drivers/memstick/host/tifm_ms.c
 F:	drivers/misc/tifm*
 F:	drivers/mmc/host/tifm_sd.c
 F:	include/linux/tifm.h
-- 
2.17.1

