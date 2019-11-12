Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2241C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3AC12196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="HpyA0Fu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfKLB1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:27:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53634 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfKLB1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:27:47 -0500
Received: by mail-wm1-f66.google.com with SMTP id u18so1292941wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 17:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8wrQtjXDEBeON+m5MSXDh9cF0WDhw/kV9ECREUgT5Nw=;
        b=HpyA0Fu7VObS4pFdF0w5PKswz+ASrhMXARZhXFS8aFB7Ktth5sbD+npAl+dNsJqy7R
         jKUezDaDypsdDgxDMBQ5Mez/s+jY9jkKVltxp8OTKH+g7T1I6vfhuxDNsu/VXgeWZ+Pd
         /lFV+OU3gYS/elTU7kHxzKShhOwXPG1CuPP7x+c6Snv9taHX0TzRiOUOWLbVBFCZQs61
         RUrouCwWonA8oGNqeYlTof0nSbL432XL38o35947PCgcY11E0g5n+0aaxlJMrRSYg2qA
         1eL8kHjN6JY8ZWVg0hUpmsRFPDXYrXphjEEM7UtrA3HLhDo91o0IccULk5cHaglPCBHq
         ZsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8wrQtjXDEBeON+m5MSXDh9cF0WDhw/kV9ECREUgT5Nw=;
        b=YrsblHanvslOf6c6b59KkBuPjO3cRYkz4Fm7ZuEmV/XJCUxHn9aWS9Nxs8J2Ve/5Vc
         ci386Z3O8/6Sxn64hR9AVAEVCjgjA8dtIjnklueKHHaatESRfiJ+uR/s1RTeGYO3oANc
         bTkpvcBYODQyjeMDHfheZvCZjLlim3BaLmYpXztHqa9zKX3Z4DYs4bVeHQDW6osFZmrA
         zyP42TwpFVP2vpyY694i7Fc5SItGnDYcFPcyTNHdfIr/gW9R/8ZXx12uZ2kgXqiUrqz5
         jtkLo1FRnUqTLSGNmZGtUyt/hIA+ICN16bEwHoqgZvvE5oCEheJkUHxvvK2DrniXqw/9
         BTmA==
X-Gm-Message-State: APjAAAXpVF8YHYUW8A7qR4dATCtD6VA+4LZXX6DQrEvCO4S9VsHWE8Zw
        HPX1MNmJqRyqrnlQvHlAikWXkfIP+YQ=
X-Google-Smtp-Source: APXvYqziaq4ziAfk8Dj9CBFCHlKWzX7CbywDJaQ72UNLms0rRz/i073D5fK54qGu4DVsyTrF/XhI5g==
X-Received: by 2002:a1c:6641:: with SMTP id a62mr1495575wmc.54.1573522065138;
        Mon, 11 Nov 2019 17:27:45 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:27:44 -0800 (PST)
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
Subject: [PATCHv8 10/34] posix-timers: Use clock_get_ktime() in common_timer_get()
Date:   Tue, 12 Nov 2019 01:26:59 +0000
Message-Id: <20191112012724.250792-11-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112012724.250792-1-dima@arista.com>
References: <20191112012724.250792-1-dima@arista.com>
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
index a1f6b968c5d8..fe1de4f71ace 100644
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
2.24.0

