Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAD5C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 11:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB49920873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 11:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G+u2/xbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfEBLDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 07:03:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46890 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfEBLDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 07:03:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id j11so917497pff.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 04:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yOyR8oq8IHtcYKwMKo5EmKseTdIOzma0iWv4YEXZ/yU=;
        b=G+u2/xbqv6XKQ3fv5UFhAhQ2alxc+A4E//ftmby4grYjd6VJc/kaLWBhvcS4uHCgx6
         eJqbuhHu2WHoKmVbxyReWdZeyqDVPFQNceYC8OuPq5mCh02u3iDyyyMQT9wAqJRX+NhX
         qHt4NFJbJ5NCXR/uOXqA0SLEmNtH0PklLxk0fS76ZrZShSLPl7/bJZ9aO0iiyGHCplov
         TfFYz9uw75S9dQvk0Dwqc8iaZqnOe4lEyGtDLBannLR1V5EXH55KTWrlzTBWS201axA3
         e+fpO/R7a6rdSFQ4dN3kaeIQ5BeaTfxJdAjfhhtZB9qajt5mRBM8LPeQmCKJX+F6ATQX
         W6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yOyR8oq8IHtcYKwMKo5EmKseTdIOzma0iWv4YEXZ/yU=;
        b=LBlwghY6CX7ZdN/3CA/5CJ/T3WSkUw4bT2JswFgxqVVwQ9NX2tVEyEzltpq+3bsF1B
         LVJGfpw90nxVaDzFnml5Rod2un6kSCG+iSNeyzezCVf7R8JinhF2ub2JueOH3C8lmAt9
         gIGZ0gjpNa5XAgv3Wfg13XycCELwdtSdU87HnFKLn92xFkAtiSkir0Uo52HbJ16Ybp+e
         02tKkO9CaYp+r+KDyzxjal6hpwkf4cNIQTC0vrtlLfwQUHlmMAoDgXFeesTC52zSajFY
         mPIVGr2GQjV+DdrSCX5jUDeA9H8xIQBcw5TghlCFDQay5r+4cMAXp0zEnlyfxtaX0k5T
         nE6A==
X-Gm-Message-State: APjAAAV7rVsHJSO1xEQRZgL5bhSKt03/WIUXVE/u5t3I+9/OWsLcxQen
        Do8+XNtNqucEmsNddEGbjNOrLHkJtQ==
X-Google-Smtp-Source: APXvYqy0UGf59Nz+0AnUFACQfMkiY8Zj96iYY+0Sr6qQKLX6BawDpJ4WJhU0prn9RT1py936s+POrQ==
X-Received: by 2002:a63:f115:: with SMTP id f21mr3291821pgi.65.1556794985829;
        Thu, 02 May 2019 04:03:05 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6284:a261:31df:f367:f70b:ed86])
        by smtp.gmail.com with ESMTPSA id s79sm111595271pfa.31.2019.05.02.04.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 04:03:04 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] ARM: multi_v7_defconfig: Enable panic and disk LED triggers
Date:   Thu,  2 May 2019 16:32:47 +0530
Message-Id: <20190502110247.681-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most development boards and devices have one or more LEDs. It is
useful during debugging if they can be wired to show different
behaviours such as disk or cpu activity or a load-average dependent
heartbeat. Enable panic and disk activity triggers so they can be tied
to LED activity during debugging as well.

There was a similar patch which added these triggers for ARM64 as well:
https://patchwork.kernel.org/patch/10042681/

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2e9fa5312616..466ccc305a05 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -821,6 +821,8 @@ CONFIG_LEDS_TRIGGER_GPIO=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_LEDS_TRIGGER_TRANSIENT=y
 CONFIG_LEDS_TRIGGER_CAMERA=y
+CONFIG_LEDS_TRIGGER_PANIC=y
+CONFIG_LEDS_TRIGGER_DISK=y
 CONFIG_EDAC=y
 CONFIG_EDAC_HIGHBANK_MC=y
 CONFIG_EDAC_HIGHBANK_L2=y
-- 
2.17.1

