Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CC7C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E08206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="PmvTH0jT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbfHOQlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:41:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32848 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732168AbfHOQiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:38:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so2795540wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 09:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J743gudYC+Vn0u6LFT/hGGfOPXqCgEVpEzbH7ikqtlc=;
        b=PmvTH0jTZioACPR8TLF4RLdGr8hsN9S3wm1uZBZgK/CPxYnyzPrbJzBzV/oywIy8le
         inH1FU9V0aEsqnma/OG+5qYn1T6wan2/dxfRDHBhlK17dUvXwu1RgbMrz7IM6D2D8OYE
         nxs9PPhKDttFulLE5Nct3kpHiVYHUX1TFU3WHFz3sbgGgzdWubUI1J999Os87ZTvffGB
         LaDfdZeIQX/I7QGxTOpuP4fyNEpluBZld5L38HZ83jDuFhsM+vCkjvEZNR1H5Plilxtv
         TK2FAVKUfnQsUBl7GFcqwAwqaQDBWsPhlSmDKDKcv2nf2GXz4s3Dc2fAa2hJdWy4Jgm7
         kN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J743gudYC+Vn0u6LFT/hGGfOPXqCgEVpEzbH7ikqtlc=;
        b=eo5SGpPMaLYb4/KPyFGSJKs093mkLtiKPGYP0WP8tK/6+C8wmyxSQgcQuYjs7HuZXJ
         axD8rWOpoAQ3fkItrR2Q3KtZRO9DVzOBMNoZn6QWmuJnJSB4hkiESkut1p0s8J0baFfi
         BKWzit3y1HlPHk4gjN/aJD1milhPVSu+yT3aVzMCYckIli8fmu1ixu6l2r8hPEfx1hGn
         z7ji6Pr8L3o3LSwzgf6TNIotqFS8on63Xt4kJ/KzEwm/J6hJCM1E6SXN9RPst0fbTz+9
         84mqAmPF7l4/11UQBKX5lE1jQqOzFQbqLS+4Y7us1THChqb4e5xuUtx59KhgPhHME5Ak
         Oufg==
X-Gm-Message-State: APjAAAUpul7kOpV9Rdrphh4tyqSx0NbSslcJmK5EyntwMdQG3bYflmxu
        Kng3N6VhZ9CHDShHHAHkX8fUO1BRoz8=
X-Google-Smtp-Source: APXvYqxo2dhJ4dxROiCqUivIZNZiye2m3qyZsjYKYmzxlk4cAMMv2V2AYyOqit2iiBO1KQ8manTfDw==
X-Received: by 2002:adf:8541:: with SMTP id 59mr6368785wrh.298.1565887129651;
        Thu, 15 Aug 2019 09:38:49 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:38:49 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv6 08/36] posix-timers: Use clock_get_ktime() in common_timer_get()
Date:   Thu, 15 Aug 2019 17:38:08 +0100
Message-Id: <20190815163836.2927-9-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815163836.2927-1-dima@arista.com>
References: <20190815163836.2927-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Now, when the clock_get_ktime() callback exists, the suboptimal
timespec64-based conversion can be removed from common_timer_get().

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/posix-timers.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 7cf1216050d1..1d41c6a41d63 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -665,7 +665,6 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 {
 	const struct k_clock *kc = timr->kclock;
 	ktime_t now, remaining, iv;
-	struct timespec64 ts64;
 	bool sig_none;
 
 	sig_none = timr->it_sigev_notify == SIGEV_NONE;
@@ -683,12 +682,7 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 			return;
 	}
 
-	/*
-	 * The timespec64 based conversion is suboptimal, but it's not
-	 * worth to implement yet another callback.
-	 */
-	kc->clock_get_timespec(timr->it_clock, &ts64);
-	now = timespec64_to_ktime(ts64);
+	now = kc->clock_get_ktime(timr->it_clock);
 
 	/*
 	 * When a requeue is pending or this is a SIGEV_NONE timer move the
-- 
2.22.0

