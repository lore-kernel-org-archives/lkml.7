Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0ACC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A063320644
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PEP2HOwr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfEILLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 07:11:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51120 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfEILLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 07:11:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id y17so1799032wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 04:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b6Iva+4zZfXyJB7DwiHORWnnmSZxQ4pOGmjZY+dIVDQ=;
        b=PEP2HOwr8dTpKTODv67FCdAAeaMvo1GbBsvxZpvan9VHumzGIEVdNmEI/4KPNTV9F+
         i8WZY67DFmzBQD8mteV3ZcgNP8wbELue3o5z+BTWPS+dia1PvYOQ0pxQBN2jZUwnguzV
         NNaohDH6j58oyGx/i9QS7ZlFuY7P5frzcx8xWMKIIcT19+mqLHldvo6OXxTpNojki+Jj
         9VjC897nYoFTMl9I8Lf08Fw7F59MXsB+kWKLIHzTqbrPOB9NB3hpSEirz+FTR1ZPQEbG
         PC+/m7SYv2EeOY6QpUMjpAnzHZ83kyYGvx/+1iVvRIzZfJZzCvSfBbJRKeoqKANyxm78
         uIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b6Iva+4zZfXyJB7DwiHORWnnmSZxQ4pOGmjZY+dIVDQ=;
        b=Nkkg+imGjutf+IOy9IbZD8ZAwRlJ6AOZWTcwRlsXlIKw0y73k8NR0hvTEqvW/Nt/Xr
         h9l8cgJS8D1o6IcBNLJ6pWUjQ3iqOuXL0mRm2bWHtSO5udMoB0Gv6R+R4HuVGxIeqP73
         9xyIFugnNUGlw2H0HHeBR/eOS0/DQccmXs8wwV5OlUjbm0TpGhaDIcPIjO4o6VZ9aiaj
         0400FUNXGaUacUse+XKAf86AvFkZeEYC13mjH3PgKgcp55tpurBvKuxOfgLajNGgatns
         xUb+yd2W0hYYqK1o5QZc89DtSP2tP5ExgP14IA89nZweevISAfVEmJDle33wYXoJDp3d
         VUAw==
X-Gm-Message-State: APjAAAXqCAvnFjipRLT0aCGYT+yN+cZt1JHuJAgwq9RhZvFCnMxd5/YW
        Km2rPBwfWWw5p6P1T1pkVxGTig==
X-Google-Smtp-Source: APXvYqwUjrA5GwivQYe5DoVtouOCccNByFOr5x2N6wy3cB+tdL4j1tDBHoNVzOXcIWE7M55nD4qIZQ==
X-Received: by 2002:a05:600c:40f:: with SMTP id q15mr2487200wmb.92.1557400289207;
        Thu, 09 May 2019 04:11:29 -0700 (PDT)
Received: from mai.irit.fr ([141.115.39.235])
        by smtp.gmail.com with ESMTPSA id z7sm2299778wme.26.2019.05.09.04.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 04:11:28 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE)
Subject: [PATCH 02/15] clocksource/drivers/sp804: Add COMPILE_TEST to CONFIG_ARM_TIMER_SP804
Date:   Thu,  9 May 2019 13:10:35 +0200
Message-Id: <20190509111048.11151-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509111048.11151-1-daniel.lezcano@linaro.org>
References: <7e786ba3-a664-8fd9-dd17-6a5be996a712@linaro.org>
 <20190509111048.11151-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Abdurachmanov <david.abdurachmanov@gmail.com>

This is only used on arm and arm64 platforms. Add COMPILE_TEST option.

Tested with 5.1-rc3+ on Fedora/RISCV. CONFIG_ARM_TIMER_SP804 no more shows
up in riscv config.

Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 171502a356aa..ede5d20299b9 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -379,7 +379,7 @@ config ARM_GLOBAL_TIMER
 	  This options enables support for the ARM global timer unit
 
 config ARM_TIMER_SP804
-	bool "Support for Dual Timer SP804 module"
+	bool "Support for Dual Timer SP804 module" if COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK && CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select TIMER_OF if OF
-- 
2.17.1

