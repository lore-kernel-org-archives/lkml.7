Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03BDC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949122196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Us0eegau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfKLB3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:29:41 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42424 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbfKLB1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:27:45 -0500
Received: by mail-ed1-f65.google.com with SMTP id m13so13524938edv.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 17:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wD/wwAHLjZ1B5QvP10crTIZpNywwbZoY/NaK2tNP0GY=;
        b=Us0eegausdXzsw+yzOk4TbinmVhVi/v1kGrSS23JiMjgXV7vRxxQFqoD3EK7sYXO3/
         eIHEKOcr6lmsldUh09dHyLgb6NIqCuioISlEWnYLxuK65fKrovhh8pWHzcdNeXLypYX6
         gQEtUY6+1t/fSEo0I3C2nf+JhiKZHfr97M/PfaRn4qynv8T5FNyTGv41WbxGNAM3d9oC
         ClNJbT3iJ+o6VOvM48oHSBxNrExteVkK8Ed4E2PYb18D8iWsjT9b3pJd53na9fj7FJK+
         P+6RC0Mi3c6xLOJyMonWxI8Er4JW+t9bYNQwpmVIHAKVFsKjY0EPaCam/iR1uQHQqNG1
         AT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wD/wwAHLjZ1B5QvP10crTIZpNywwbZoY/NaK2tNP0GY=;
        b=lHODgrzdj2j5cQ18P5IUUNLEHwSin1FMWp+Nr0VtifmVxYia8mFO5nvbLMLMieFn+6
         sI3AyKVmGeBabO9lj5SdziXmGIrOMrgk5ErL5WHzr/z2RRLmW48d/OhsiMeZnZHx5KBG
         WjEqLnodeQIrtsXJBgfZ3E1ROICgwC6Vy/5fZ2lscWnW1+SG5vsh/RSPNQz8dhkYukY1
         UFwdLpvfh0QJEoYOkgoMs/7p+o532ZIcGfUUKC7/flCHhkFr1dg7xEOdhZh7ZXupN5vn
         C6FTizeXB0gAc7NTFTOPHLwOEgCwgzjKr+2IHdwxt7NsFWbRM78ObfwnOCUlqlzNIj+j
         CS/Q==
X-Gm-Message-State: APjAAAXyNxPoFJGbAqQALSYBC7lGwHokfW4W4oVmNPZg4EO5+GxS07ex
        yx1nD705C+kCXMwVV9ZcPkaoE8H9FQw=
X-Google-Smtp-Source: APXvYqyyM6t6zlkKc3nzHD8hl+qWWSRSqKbxwoa7FgOqeA3JgYRXLE+D/518S7LqMFoLtlDj/HhtDg==
X-Received: by 2002:adf:e70d:: with SMTP id c13mr10749829wrm.78.1573522062347;
        Mon, 11 Nov 2019 17:27:42 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:27:41 -0800 (PST)
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
Subject: [PATCHv8 08/34] alarmtimer: Provide get_timespec() callback
Date:   Tue, 12 Nov 2019 01:26:57 +0000
Message-Id: <20191112012724.250792-9-dima@arista.com>
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

The upcoming support for time namespaces requires to have access to:
  - The time in a task's time namespace for sys_clock_gettime()
  - The time in the root name space for common_timer_get()

Wire up alarm bases with get_timespec().

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/alarmtimer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 22b6f9b133b2..357be1fe6e1f 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -37,12 +37,14 @@
  * @lock:		Lock for syncrhonized access to the base
  * @timerqueue:		Timerqueue head managing the list of events
  * @get_ktime:		Function to read the time correlating to the base
+ * @get_timespec:	Function to read the namespace time correlating to the base
  * @base_clockid:	clockid for the base
  */
 static struct alarm_base {
 	spinlock_t		lock;
 	struct timerqueue_head	timerqueue;
 	ktime_t			(*get_ktime)(void);
+	void			(*get_timespec)(struct timespec64 *tp);
 	clockid_t		base_clockid;
 } alarm_bases[ALARM_NUMTYPE];
 
@@ -670,7 +672,8 @@ static int alarm_clock_get_timespec(clockid_t which_clock, struct timespec64 *tp
 	if (!alarmtimer_get_rtcdev())
 		return -EINVAL;
 
-	*tp = ktime_to_timespec64(base->get_ktime());
+	base->get_timespec(tp);
+
 	return 0;
 }
 
@@ -883,8 +886,10 @@ static int __init alarmtimer_init(void)
 	/* Initialize alarm bases */
 	alarm_bases[ALARM_REALTIME].base_clockid = CLOCK_REALTIME;
 	alarm_bases[ALARM_REALTIME].get_ktime = &ktime_get_real;
+	alarm_bases[ALARM_REALTIME].get_timespec = ktime_get_real_ts64,
 	alarm_bases[ALARM_BOOTTIME].base_clockid = CLOCK_BOOTTIME;
 	alarm_bases[ALARM_BOOTTIME].get_ktime = &ktime_get_boottime;
+	alarm_bases[ALARM_BOOTTIME].get_timespec = ktime_get_boottime_ts64;
 	for (i = 0; i < ALARM_NUMTYPE; i++) {
 		timerqueue_init_head(&alarm_bases[i].timerqueue);
 		spin_lock_init(&alarm_bases[i].lock);
-- 
2.24.0

