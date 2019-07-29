Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA268C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0F020C01
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ON4VHzES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389250AbfG2V6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:58:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33220 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfG2V6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:58:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so63568974wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aoCU6uPiHr0PzNNlgylsAXV9auaD7Fl9k+QB3VPTwmU=;
        b=ON4VHzES+B/jfG7vTOtWjSgEGPQD0zrGmt6jz5giNgVQbhqIMvOUOlN1gM3JzvUWe/
         IGqMM+pYFQ78AaNJ9Hsa3w8YxDkSggEmShReMrE3WotwdxfcPAHGELp2Z80/g0iLM77/
         wSrKM5XBdZ0uxHW/6eMOUBRWn4YeC1ab6BgVoHXwqx6I49mzpZhSVuqq8m2vv9SLoTO6
         zr0MsayJMMyNQ/5pc+UiVp3rjnytJIvrcPhuzdNWyij3bZpks8ed8L+PMhy3b2ZVWCBV
         3bIC8zze+cAte15hHO5VIBL434b7TtsT9s2GJyYaNewFiy9I3KpZdy/hUdSh2TWmy0Bk
         lTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aoCU6uPiHr0PzNNlgylsAXV9auaD7Fl9k+QB3VPTwmU=;
        b=YSCFtqikMaTT9juHCY/MYIrYQjdqyWJJAsFDl4f5oJAgq3LVo9t6beLxvCO8IyYU9D
         OVXiCxvggxLK9cmJz/Cqzlp35SB50Uk6rG4dQq9HDsdxChFcCujyqIw0fq+s73kfIXzI
         ixVtLx+AfX/RbsUE0onkvY/GGhR0dlz+yx6uOmnUMl8i+jiilixguotKJrHlx4HA8eKZ
         Jq3rMnBA5x0+dxz6xhMKP8KsXy1QjXi8XonsBjhGgL3zHKWFgx+5AIzj2No9W9egKf05
         IldXGRBQejwjweC0VIHEOxrLKx3Bq0uXCF2hxb9PSwkj/0EvU4db730mMOxhACBXuItB
         PG1A==
X-Gm-Message-State: APjAAAW3152cibgatTgchEZ0QyEtFMV/9xE6wkQdvrKkO90y4uSoM/WQ
        sKehqL9Y/zuHl7R/gTvmHDIeAC2ThlXTfRSj1i94D75dfJhq4TXs5buW+8K/bMrVAZE+MEOvteL
        jK6/EQGRltZMACQk73Feu84z5suRDhTspiue6058AZgp690GvwefF+3yjb7ZtMRSve/AH5fKVUy
        wMMWnAeODiIpneWcKFvw1JnFRAN+qAbhccGXisOQU=
X-Google-Smtp-Source: APXvYqy/FnJSSgTdo+YzH4zB+N6B3pvg4EGHaqm2wFVzFyIWkxDAQd6vkEhzCcSp8QPncdlXdQc8TA==
X-Received: by 2002:a5d:4950:: with SMTP id r16mr19690168wrs.136.1564437498092;
        Mon, 29 Jul 2019 14:58:18 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:17 -0700 (PDT)
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
Subject: [PATCHv5 13/37] posix-timers: Make timer_settime() time namespace aware
Date:   Mon, 29 Jul 2019 22:56:55 +0100
Message-Id: <20190729215758.28405-14-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729215758.28405-1-dima@arista.com>
References: <20190729215758.28405-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
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
index 265fbc816520..c979e720a5a1 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -857,6 +857,8 @@ int common_timer_set(struct k_itimer *timr, int flags,
 
 	timr->it_interval = timespec64_to_ktime(new_setting->it_interval);
 	expires = timespec64_to_ktime(new_setting->it_value);
+	if (flags & TIMER_ABSTIME)
+		expires = timens_ktime_to_host(timr->it_clock, expires);
 	sigev_none = timr->it_sigev_notify == SIGEV_NONE;
 
 	kc->timer_arm(timr, expires, flags & TIMER_ABSTIME, sigev_none);
-- 
2.22.0

