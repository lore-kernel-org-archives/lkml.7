Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56302C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF0320578
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="EpJVm8ye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbfHOQk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:40:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37929 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732164AbfHOQix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:38:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id m125so1773768wmm.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 09:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dL9l++YVhMS1vUANg97HkWJcLRzeENUcXOVPuVetnmo=;
        b=EpJVm8yedFbP7ws2KHD0t5g8oT9V2WGjpFV7M6IGfCJwLWfwTlR/CyL0KEqUwTRgnt
         wKf1ef6B6HG/uTBz1gxCKbjpANno/iDDvUJXRQhFW7Gahtvbx24hwrdc2wxOiVXdIvQY
         6lKqLPGCfnRC6gouEOfGSgtxo3gMTrFtYjp+GbjdEjoe8yUv9Xd7wEgkuMlu2SnNHMQE
         NoLi7zo/2yrpIfxqQrnUABbsT/xmHKBGZkj5izf7bnPsoTARRcC3PcNgFWArQkIp/UGP
         6QXxAovM8gPbP1TMzTjlqtRG8O3KzYFMx5uRca65oHKf7yZQslgksy9huQiB6oX7vtmR
         9chg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dL9l++YVhMS1vUANg97HkWJcLRzeENUcXOVPuVetnmo=;
        b=X+nq7L3bGAC4+OihB22R5JYaqOon+ST6D2+nOVgjIA7D4to8SY/HG65nY2YCXieZmh
         3rJmzmJxylkc4fgbNgr6muwntxRAvGgq4dpu7ZEVqD2s6g8qkS3RRjpVPSXqHMc7vtSh
         dZMyLuO1KoAKvupzAepZTL668+Zhhu00BhhVg3f0rroG+5BRteDXX5MA1LsvpXQpaHlo
         wU04PtHONBS3GmROPlsK6o5EsRTQtqRSgjIX9RpoLkxHG0hcei9R0g1+zrzGGKs4hHR5
         WIDnIhcVq3SGhYGJRilCZoccooU3RFhDgMYtLLSugaYwJMyI2mItVPMfliki9RcpxIy4
         wmyw==
X-Gm-Message-State: APjAAAVHwmkEGUXAs0ZAUtN70JYkZ3ZwcOGjtiUyjXJNKo1Y1uQjcwxG
        EETH43TfkEq1D2B/ptR1opf9d1UsfN0=
X-Google-Smtp-Source: APXvYqw7FhIRF4yLOgCVsu9ztsR64bM/BIX83L9pcSkrszhSAPNB2eSQ4/Ky2Bel072n387PuM+wzg==
X-Received: by 2002:a1c:c005:: with SMTP id q5mr3426900wmf.59.1565887131002;
        Thu, 15 Aug 2019 09:38:51 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:38:50 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
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
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCHv6 09/36] posix-clocks: Wire up clock_gettime() with timens offsets
Date:   Thu, 15 Aug 2019 17:38:09 +0100
Message-Id: <20190815163836.2927-10-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815163836.2927-1-dima@arista.com>
References: <20190815163836.2927-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@openvz.org>

Adjust monotonic and boottime clocks with per-timens offsets.
As the result a process inside time namespace will see timers and clocks
corrected to offsets that were set on creating namespace.

Note that applications usually go through vDSO to get time, which is not
yet adjusted. Further changes complete time namespace virtualisation
with vDSO support.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/alarmtimer.c   | 1 +
 kernel/time/posix-stubs.c  | 3 +++
 kernel/time/posix-timers.c | 5 +++++
 3 files changed, 9 insertions(+)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index c8f8cf3d7d08..fbf18b26faed 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -26,6 +26,7 @@
 #include <linux/freezer.h>
 #include <linux/compat.h>
 #include <linux/module.h>
+#include <linux/time_namespace.h>
 
 #include "posix-timers.h"
 
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 67df65f887ac..edaf075d1ee4 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -14,6 +14,7 @@
 #include <linux/ktime.h>
 #include <linux/timekeeping.h>
 #include <linux/posix-timers.h>
+#include <linux/time_namespace.h>
 #include <linux/compat.h>
 
 #ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
@@ -77,9 +78,11 @@ int do_clock_gettime(clockid_t which_clock, struct timespec64 *tp)
 		break;
 	case CLOCK_MONOTONIC:
 		ktime_get_ts64(tp);
+		timens_add_monotonic(tp);
 		break;
 	case CLOCK_BOOTTIME:
 		ktime_get_boottime_ts64(tp);
+		timens_add_boottime(tp);
 		break;
 	default:
 		return -EINVAL;
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 1d41c6a41d63..365ac40d46b1 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -30,6 +30,7 @@
 #include <linux/hashtable.h>
 #include <linux/compat.h>
 #include <linux/nospec.h>
+#include <linux/time_namespace.h>
 
 #include "timekeeping.h"
 #include "posix-timers.h"
@@ -195,6 +196,7 @@ static int posix_clock_realtime_adj(const clockid_t which_clock,
 static int posix_get_monotonic_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_ts64(tp);
+	timens_add_monotonic(tp);
 	return 0;
 }
 
@@ -209,6 +211,7 @@ static ktime_t posix_get_monotonic_ktime(clockid_t which_clock)
 static int posix_get_monotonic_raw(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_raw_ts64(tp);
+	timens_add_monotonic(tp);
 	return 0;
 }
 
@@ -223,6 +226,7 @@ static int posix_get_monotonic_coarse(clockid_t which_clock,
 						struct timespec64 *tp)
 {
 	ktime_get_coarse_ts64(tp);
+	timens_add_monotonic(tp);
 	return 0;
 }
 
@@ -235,6 +239,7 @@ static int posix_get_coarse_res(const clockid_t which_clock, struct timespec64 *
 int posix_get_boottime_timespec(const clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_boottime_ts64(tp);
+	timens_add_boottime(tp);
 	return 0;
 }
 
-- 
2.22.0

