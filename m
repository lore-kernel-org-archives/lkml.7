Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34962C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00875222CD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Pki/A7gi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfKLB2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:28:01 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51991 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfKLB1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:27:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id q70so1308814wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 17:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yBdLYJdhjeFT5w6s0m0U5Bo50muPeSkrn41Bj/OgNzU=;
        b=Pki/A7gikh7SOzuzY9xY1WmR5BVkRnRJkPpCiLW3ZBTdz1AO8TfPMEABrrbko7vpZ0
         nx1KWMSlCNsK9ABxXGzNEKs/BMfxok/Y4JQ5THAhur3SWePd23N9ddaVTNL0SufASqNM
         aUi1P+fbMz06GB1aaAMKQAEMCXd0Lj0V0clQFEZKklv0zrvp9MxolF1cpHC+YbZmMjQx
         UCGYOGtMab6yZ1VuSbJz82YnYu3ewMUX592H7yeY4A3cTgtcagwJHx0TxkQUlOEcXQso
         Y9l4GZSrUlyezIAy9EUA9r2oqQv5rJswnevUXtlnLCYLI1DCR9OyQ62FlKRxfIF3Eltq
         NdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yBdLYJdhjeFT5w6s0m0U5Bo50muPeSkrn41Bj/OgNzU=;
        b=M42OILj8RqF+FN6o5PkhnXxebL99JHS8pctYZj52zPwlbSIy6S0neqI6Imd1LuM7IX
         yYN3frVwngYAwjoNdfqTgDxDq4DHu24oaGGlWIB4ZB43cm/SzjxVJVUE1wqA1CYQA2tE
         PQB2mHtKKvZSOoKtDc0GkexKp7f81/C6wRP+OBw3NSNqJbVfK0ynN89HPbCmdIdpJJxj
         ZNFoRANNzAAtHxfFQThCFb/p6uN/jQUMqCkkuRD9f3k9LcydbDZmRQU6g10V9IHWS2w1
         t2tTymOTRDXTUhd1lQylwrZPF+wTjGtk8K8ZryuwcsPBkt6FgAeBLvVK7v8BLcLKQSyo
         8aUw==
X-Gm-Message-State: APjAAAXTEcl9X+xk2lOFvCmQv67m7TPvVZ2RrZk419BsGzcSz0u5cDRk
        DzvLugYGlKigIwpJGg8oWukTIP+7z5M=
X-Google-Smtp-Source: APXvYqz3Y1ZxljDDH+9AJcIgAzsfMqPySbX9a/6ixpOXwB//28V58jMYIKISZ2Ag1RcsS4He9XRvrQ==
X-Received: by 2002:a1c:f404:: with SMTP id z4mr1525920wma.12.1573522070554;
        Mon, 11 Nov 2019 17:27:50 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:27:50 -0800 (PST)
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
Subject: [PATCHv8 14/34] posix-timers: Make timer_settime() time namespace aware
Date:   Tue, 12 Nov 2019 01:27:03 +0000
Message-Id: <20191112012724.250792-15-dima@arista.com>
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
index d26b915b227a..473082b0b57f 100644
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
2.24.0

