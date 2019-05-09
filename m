Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A51EC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDE720644
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUDkSeo5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfEILLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 07:11:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53175 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfEILLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 07:11:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id g26so830836wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 04:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=56kLt7cMNMrr+o0ZwgjCRQvJlape+fGAyz5m6qcTE4M=;
        b=OUDkSeo5jS//BI4nd4Iw2q1H560rcJVPI6Y9yOotBlqntN+CEzQCtj6wosrjYYOuWI
         mflH36x6VO92/sfgaOUY53Sc234sKv+kAxp6K+rsnXL2XmaU3rWbyx94Psqj8NVsaIqA
         2qkbtaJQGuvcuYLR9MnrSV5nCmkHJb1IkMs0Svbky8cJRmXmKK9FVAI6svs/HVhX0B/R
         9m/lMBn3o6O/j+u+rrGOWjoRjtpe/Or5JGa6CQpnaEFzbkOFKl7GztJPsAehPDq8WwuZ
         y/kMf0M/BS69sZU8FIkBqJZOmSlqmFVh/iCzuSgtCwyPWy6nQaKsqKY7Dfta4ufA298a
         BUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=56kLt7cMNMrr+o0ZwgjCRQvJlape+fGAyz5m6qcTE4M=;
        b=K+cUB2nj/VDevAg8FlG7VeUu4gCtlESIxie5fhBAFhwtPDPn0WBDgCkseIKaqhoGDF
         clbShGcUq2FAe0ZtDm+l475X2pANHgtCTepyUgJE5ZjHTvjWGD6icJk4O+5JU7M7TSKU
         DLJ2oQfmPhu8XJZf4s3xSgLdU5cWQ6CEr+D/1ZIM2j7UqlbreGAX8dj0Xo3A15oPUfIZ
         1NU/DnNwk6wazzEDzQeoH5ZUf45PuB9i/lthey17ifBne9bLeyVjUBUDVt5K0i233NXy
         6euiUFx1MDw5MvTeprDQ4nHyELlvc6QpAtLJ8Pe7COljSIYvNtCwlsOFiTKsQIkU2bZe
         iIrw==
X-Gm-Message-State: APjAAAURhXUu5rwXTBBchcU+PF6rS05YNv1i1QY69q2OmP9CN8epfz0t
        gkIF6j4bjb89lp/CenEc/fVdLg==
X-Google-Smtp-Source: APXvYqwceeSFnhjqHe1YkAu8+jmsn3lRtw+7mkNa4j/TETQ8+gnf9SyGQm5VS8IwZVK2pFIt3BYF/A==
X-Received: by 2002:a1c:b4d4:: with SMTP id d203mr2410091wmf.34.1557400303570;
        Thu, 09 May 2019 04:11:43 -0700 (PDT)
Received: from mai.irit.fr ([141.115.39.235])
        by smtp.gmail.com with ESMTPSA id z7sm2299778wme.26.2019.05.09.04.11.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 04:11:42 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 13/15] clocksource/drivers/tcb_clksrc: Rename the file for consistency
Date:   Thu,  9 May 2019 13:10:46 +0200
Message-Id: <20190509111048.11151-13-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509111048.11151-1-daniel.lezcano@linaro.org>
References: <7e786ba3-a664-8fd9-dd17-6a5be996a712@linaro.org>
 <20190509111048.11151-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

For the sake of consistency, let's rename the file to a name similar
to other file names in this directory.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Makefile                            | 2 +-
 drivers/clocksource/{tcb_clksrc.c => timer-atmel-tcb.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/clocksource/{tcb_clksrc.c => timer-atmel-tcb.c} (100%)

diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index be6e0fbc7489..923b9b60c909 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -3,7 +3,7 @@ obj-$(CONFIG_TIMER_OF)		+= timer-of.o
 obj-$(CONFIG_TIMER_PROBE)	+= timer-probe.o
 obj-$(CONFIG_ATMEL_PIT)		+= timer-atmel-pit.o
 obj-$(CONFIG_ATMEL_ST)		+= timer-atmel-st.o
-obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= tcb_clksrc.o
+obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= timer-atmel-tcb.o
 obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
 obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
 obj-$(CONFIG_CS5535_CLOCK_EVENT_SRC)	+= timer-cs5535.o
diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/timer-atmel-tcb.c
similarity index 100%
rename from drivers/clocksource/tcb_clksrc.c
rename to drivers/clocksource/timer-atmel-tcb.c
-- 
2.17.1

