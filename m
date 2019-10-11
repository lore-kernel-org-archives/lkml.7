Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE944C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CBB214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="SREuUiH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfJKBZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 21:25:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34286 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbfJKBYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 21:24:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id j11so9979673wrp.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 18:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iERz2FP0YlBkmC86yLcDq0+jGuy+OmV9tA9oUfgYUPk=;
        b=SREuUiH93YhFhC5Wk6DuJA9lF09LZo9G/0AScXGNMdjd1BAJugvPWp9DnSl59RjMnX
         qO2tvfFUKsFRHnB2WaGSHnb3jBBJQPhKVQwAanWssnis5KKeFRSsM64yuAWb8DheWK8U
         aXp4L6DhBB1BdwVZaGR1tACkG5ee/jky6efQuwP3ywWnZvyZPj+voEsEspZoG7JDF0RY
         UvJnKILLbNjhLJSolk3xGp75sE9yeVobfbJowSY4HQJyqSxCxjc2+/lJ+8KWDPZ/kVFN
         JZTj0STi6gFrmMQ1Y9L8W8C2QjIuFA705SFattbbMHANa1pUd0hqIsvMltaGmBxQHcFm
         MUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iERz2FP0YlBkmC86yLcDq0+jGuy+OmV9tA9oUfgYUPk=;
        b=N/340Aqy3BXZ7EcPrlv3z6n9MkzAX/nPeeHm8k7hEjYB+R/JtO9n32O+/z+hwyA+3x
         1Uwg/VmNbUK8LNCiJ/JTYzGoybVrFePzt6Yy7nCgACjgzcXh1ZM2nOdPaU65hqlbshVR
         x332MOZNgDFS3fV64q09j3OGOw94Ljbdal+V1EKa2fVLWDseW6A1J9FkZ7NOGSqUnbap
         uBM2VoFm5YMOR2pvJSbKrwCp/g8YvKNgYvQlfCECSVZgvVmlS5jXfOk3MYtKovW7Dew7
         MLhJMhAEFWPf1Gx2AEEyYWCwIvxpAGSn46iM7c4p28hG7us/DJIkrTrckL4DZFP2LnuC
         1yOQ==
X-Gm-Message-State: APjAAAVyh+84eBjwLpsXtVU26LB6Hyzbdl806PVF4unGr8Tux5XZaGF6
        alz7U3tMwY0fJl3l2hrtqY+Kv+umqn4=
X-Google-Smtp-Source: APXvYqy1yEYoyp6noua76ezIvjrnsLos8kkhjoGHWWcb1oezxvWWE8mjNfmD1TtOtdyK+apMpaHcng==
X-Received: by 2002:adf:f145:: with SMTP id y5mr153370wro.330.1570757043333;
        Thu, 10 Oct 2019 18:24:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:24:02 -0700 (PDT)
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
Subject: [PATCHv7 12/33] posix-timers: Make timer_settime() time namespace aware
Date:   Fri, 11 Oct 2019 02:23:20 +0100
Message-Id: <20191011012341.846266-13-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011012341.846266-1-dima@arista.com>
References: <20191011012341.846266-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Wire timer_settime() syscall into time namespace virtualization.

sys_timer_settime() calls the ktime->timer_set() callback. Right now,
common_timer_set() is the only implementation for the callback.

There user-supplied timer's value is converted from timespec64 to ktime
and then timens_ktime_to_host() can be used to convert namespace's time
to the host time.

Inside a time namespace kernel's time differ on a fixed offset from
a user-supplied, but only absolute values (TIMER_ABSTIME) must
be converted.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/posix-timers.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index d8b5bd4cbae1..6e350cc8f600 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -885,6 +885,8 @@ int common_timer_set(struct k_itimer *timr, int flags,
 
 	timr->it_interval = timespec64_to_ktime(new_setting->it_interval);
 	expires = timespec64_to_ktime(new_setting->it_value);
+	if (flags & TIMER_ABSTIME)
+		expires = timens_ktime_to_host(timr->it_clock, expires);
 	sigev_none = timr->it_sigev_notify == SIGEV_NONE;
 
 	kc->timer_arm(timr, expires, flags & TIMER_ABSTIME, sigev_none);
-- 
2.23.0

