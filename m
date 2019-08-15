Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BA6C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFE3217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="c0EWi/tw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732338AbfHOQjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:39:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39786 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732132AbfHOQi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:38:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id i63so1770518wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 09:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w21U5bngFKdXilclts2n7wOqJHCEbT1u5FIRizZ1S/c=;
        b=c0EWi/twY78jUReda0WJdBQZxG7p7jMo7yZUFT+ZysCUNvfYOP8Kts7S5VTmjQRoQU
         6FOzf037WHegLsWhnMG6hI8HuG4H5CipsuXbgAKSQb/hCcdV8n1TDWBoQtOTYKChwvQ4
         p0qeczdoZtw0c9kynyj3Xx6vSWxGGGz/ktAawJgmLv5M96xjPN/gSnA5QvwIxYt0bJsQ
         O/PrWgc1K/Uj+5AeXo7CLAN+YQc35R2UTStxfLQvvJQq5ao7BX9J0WF7o5LXSY6mfqmM
         0hUfqAJhfUzJ7CQl9O4FIXMWiF9qYwSw/W1peKZnMckIcIaLFIg0SMLIonYLPH3xh1NQ
         2xFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w21U5bngFKdXilclts2n7wOqJHCEbT1u5FIRizZ1S/c=;
        b=rklJrFnVL+1Hb/WInn3F/yRW9I/7FhCbQNqhjB+0EQ0TcnevG+PspAIs88b9bPTZVM
         fjdH0Tt0XyhHU1m164ilnGYqdfdpUxTZ3DesYMhNlh+OiF/5FdnICbFt5ncS0i4DxFGj
         Fhh9tTCCdE6Y/vczFl7MTgMJuLV7xWokwZd99Uv+tKojL5IpjhFaWTixsRYqBNcQA1jW
         XIN9FsjVqlgat6epRlq01XS8QHrv6GSfkWGIgR+8+vF3YdONIDZ7jUWKrWkj6e9svmPD
         ofRetBG5JU8qcD6cKoxiWy+UV2soC14Uq8/fztT98nXOKMPjB8gworf6YFXeuffhdact
         M3DQ==
X-Gm-Message-State: APjAAAWrS45uamfq9ARJ9NO6WuquNUon/PAYO2R/hhAJjL+0f9/jVcAH
        B+ofq2/Mnq4hKKH1KkluC37idZ6U1og=
X-Google-Smtp-Source: APXvYqwwrNuAVCRNzu8wppGx0EnQgu1Gb+ZKGzc9YDUNUlRiz+Y2bm1lbJ5d/QemI5aVxWM5VDuYqQ==
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr3528853wmg.155.1565887137141;
        Thu, 15 Aug 2019 09:38:57 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:38:56 -0700 (PDT)
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
Subject: [PATCHv6 13/36] alarmtimer: Make nanosleep time namespace aware
Date:   Thu, 15 Aug 2019 17:38:13 +0100
Message-Id: <20190815163836.2927-14-dima@arista.com>
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

clock_nanosleep() accepts absolute values of expiration time when
TIMER_ABSTIME flag is set. This absolute value is inside the task's
time namespace, and has to be converted to the host's time.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/alarmtimer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index fbf18b26faed..751ed7f3cab2 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -825,6 +825,8 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 		ktime_t now = alarm_bases[type].get_ktime();
 
 		exp = ktime_add_safe(now, exp);
+	} else {
+		exp = timens_ktime_to_host(which_clock, exp);
 	}
 
 	ret = alarmtimer_do_nsleep(&alarm, exp, type);
-- 
2.22.0

