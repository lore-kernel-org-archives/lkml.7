Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972ECC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6075620644
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PWBiTlpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfEILLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 07:11:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43372 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfEILL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 07:11:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so2439269wro.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 04:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=btyjrIBgvEiFaw+UeR2po3KmpV02gWF8Za6NMh5yZW4=;
        b=PWBiTlppp3qNKNSeeS/VbeyXHbeoNzIgZOkqg0QoiRFGQ/PoyWUhxKj3BLPDmz8W6Y
         JzXPTH5kOri0av4o3+l7pnSkszbh2LqCnIXf4oU7wWhWtha3iWEYL7mQP6CFGfFbTFGr
         KOuc7K4lgMulVZGUEawzuC5yZkFF4RwYXvm9sF2F08eXrBZgq9NOsUh0frqjNdNgmn9X
         OYWoNik+J4XJ2wimnmZN/CyFgZHo3ggmQHf9szz/AttkvE0AwkumSzIT5DMZ9lacacVu
         AGRDb0WGfRrkeIcK07euzHhF1/GjcTl/yHabhuTGJRx+PkjlxWuUAdoFN7KiZeFFph6z
         W3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=btyjrIBgvEiFaw+UeR2po3KmpV02gWF8Za6NMh5yZW4=;
        b=GPUE8hu3VAzVblW4CVTuOdYBeB3E5x1mvgT2er7cVBsUdU0V4PzB+yaE6dczDSLZcN
         iEX61+ToF9n/GmoHNMhBD5xrkxoZtJqDOTrrhjvwSf4HoTqVEGHYj3eMhAuYGOboZZ6x
         OhIBC2GDWinG3/CKjHq4vaQ2HmWUdProbUqrpEcoWOQRcVB/ukQu1rBr7pDH0ym8yTHu
         7iY905cikIuJBIebwmV/kh19yWWXfpH7Ckrh5QmoBGDDIkQbDhzK4ovfAWBLoMxT+Q1B
         O3bUaQhzWdYANlFhK601jlx7dqPdw/h3mnQpxZALT6dxUdt9oWRKxu8mqDPn2v7rQXwr
         M8Ig==
X-Gm-Message-State: APjAAAU4hXR7zSqY8rdhkQJtzOSdwS7jxjukv3DQ6YOSmOpHd7lNXI05
        wS3keGsygLlWsRiPnbFJba3wZQ==
X-Google-Smtp-Source: APXvYqyRoSHdg558NkElF8rFinE7d1sCeJBjX1VLvJ9rN5APIFf6z35khSWZyITgkN0ZahCshSIy6g==
X-Received: by 2002:a5d:4648:: with SMTP id j8mr2745726wrs.53.1557400287888;
        Thu, 09 May 2019 04:11:27 -0700 (PDT)
Received: from mai.irit.fr ([141.115.39.235])
        by smtp.gmail.com with ESMTPSA id z7sm2299778wme.26.2019.05.09.04.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 04:11:26 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support)
Subject: [PATCH 01/15] clocksource/drivers/sun4i: Add a compatible for suniv
Date:   Thu,  9 May 2019 13:10:34 +0200
Message-Id: <20190509111048.11151-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <7e786ba3-a664-8fd9-dd17-6a5be996a712@linaro.org>
References: <7e786ba3-a664-8fd9-dd17-6a5be996a712@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mesih Kilinc <mesihkilinc@gmail.com>

The suniv (new F-series) chip has a timer with less functionality than
the A10 timer, e.g. it has only 3 channels.

Add a new compatible for it. As we didn't use the extra channels on A10
either now, the code needn't to be changed.

The suniv chip is based on ARM926EJ-S CPU, thus it has no architecture timer.

Register sun4i_timer as sched_clock on it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-sun4i.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-sun4i.c b/drivers/clocksource/timer-sun4i.c
index 6e0180aaf784..65f38f6ca714 100644
--- a/drivers/clocksource/timer-sun4i.c
+++ b/drivers/clocksource/timer-sun4i.c
@@ -186,7 +186,8 @@ static int __init sun4i_timer_init(struct device_node *node)
 	 */
 	if (of_machine_is_compatible("allwinner,sun4i-a10") ||
 	    of_machine_is_compatible("allwinner,sun5i-a13") ||
-	    of_machine_is_compatible("allwinner,sun5i-a10s"))
+	    of_machine_is_compatible("allwinner,sun5i-a10s") ||
+	    of_machine_is_compatible("allwinner,suniv-f1c100s"))
 		sched_clock_register(sun4i_timer_sched_read, 32,
 				     timer_of_rate(&to));
 
@@ -218,3 +219,5 @@ static int __init sun4i_timer_init(struct device_node *node)
 }
 TIMER_OF_DECLARE(sun4i, "allwinner,sun4i-a10-timer",
 		       sun4i_timer_init);
+TIMER_OF_DECLARE(suniv, "allwinner,suniv-f1c100s-timer",
+		       sun4i_timer_init);
-- 
2.17.1

