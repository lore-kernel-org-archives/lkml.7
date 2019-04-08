Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23328C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 04:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D1B20879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 04:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPNk6rAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfDHEPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 00:15:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35777 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDHEPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 00:15:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id t21so4486700pfh.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 21:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fRwm8sfh9DaRwSmY0uIYEVCfl0MZAxx930Ob7GiFmDw=;
        b=BPNk6rApNJFX195d56FBIutE4Kod0nV92JNNjR4h+y8qS1lRveV0SY1fCOw+oPLukf
         HXMNTqdV/u5ccW/MIr0350cHzj7kqzmTNd8lkutyDJdmLATfcSBmwRyDU+x5ZDZw45qn
         W4JnqTYqRmYCiM+O9ArtAvPEm8fY8XE0mvGSMphEcqMlrGZvEuAMR7oFrvgC9lN9sr7W
         RZNJtpc/GTuJ4BndvC6KR5mEKxtzzGQep7JYlD+k6cBS927vy/NUsv7bGj6cfHYQbm+V
         voMaIHElWHZ58Nb0KLWrcnIouxfBRKThlWXDg7zSLYza+slfb+yquysA4N0I7U/eKhDP
         9KfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fRwm8sfh9DaRwSmY0uIYEVCfl0MZAxx930Ob7GiFmDw=;
        b=PYkWlFQ8LmWwZ5F2BHIBKTyAGXJ4oeP0XZknpDrAlYnOC220MrJm3zcVhUQtvdlXjr
         KVmBwQUD01NWvzOC0UuU1qwldnddjKTXDQN0ldmgEE+XmjJuWDGY7YL1151Ha00xcAMM
         vLdfkofRaNm6tl7s7JBocD+mdGcAt2czhDntCvnW19zvmNIF786shzZszZpvS79VVW+2
         wcoRpyW64j6jD8M9IHPdJSdIdjfq1Qtt/5AuDBbN1UbKPX6ahNDZoIm+A8qTTf+mIYlh
         iVSjVKPMkk/EdC8t0SdUWZzb9TMLNwx1fFWLrvbOSEAlBaUcKTy8LNx9ORa4RRttcyBx
         4SHw==
X-Gm-Message-State: APjAAAWDsIYhhQExffEKlczQt4+Wne9YbAYNGhXV3xHtsVO6oiXZWAmt
        M1l1/8rfPTig8cHI4zHeqzal4g1D
X-Google-Smtp-Source: APXvYqySjiTYIGSIqnfUc/YEQSvE97oFPwA7NbcEGOlSx5LW3LmPSnqelovcLZLya9/P1kQe6pVE1Q==
X-Received: by 2002:aa7:814e:: with SMTP id d14mr27525897pfn.101.1554696950048;
        Sun, 07 Apr 2019 21:15:50 -0700 (PDT)
Received: from localhost.localdomain (c-73-140-212-29.hsd1.wa.comcast.net. [73.140.212.29])
        by smtp.gmail.com with ESMTPSA id m23sm42374138pfa.117.2019.04.07.21.15.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 21:15:49 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH] alarmtimer: return correct remaining time
Date:   Sun,  7 Apr 2019 21:15:42 -0700
Message-Id: <20190408041542.26338-1-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To calculate a remaining time, we need to subtract the current time from
the expiration time. Currently, arguments of ktime_sub are swapped.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 kernel/time/alarmtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 2c97e8c2d29f..0519a8805aab 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -594,7 +594,7 @@ static ktime_t alarm_timer_remaining(struct k_itimer *timr, ktime_t now)
 {
 	struct alarm *alarm = &timr->it.alarm.alarmtimer;
 
-	return ktime_sub(now, alarm->node.expires);
+	return ktime_sub(alarm->node.expires, now);
 }
 
 /**
-- 
2.20.1

