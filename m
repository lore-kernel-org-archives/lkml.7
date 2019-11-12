Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2202C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39B82184C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="no7ak0lp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfKLB2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:28:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39826 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbfKLB1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:27:54 -0500
Received: by mail-wr1-f68.google.com with SMTP id l7so5100326wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 17:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1znNAGw/Z1q6zMts4RvOzjAIKcNOTR5cC9VZjL6t0T4=;
        b=no7ak0lp9bxnBWXhC4+Tx+Ld3kfGjWGcwqMxHG6k1Jesn3stq1RTFYQvubLhKR8H4P
         M9YDX9NrHZhKHxHF1s2VvzBK5lBOzfFycGG7oxUSFBJXYHfxyV+76234bOF16UmArQEM
         GYENaeByzCN5GCGPTvEISHJgxSpMgeA8mpVALKx6yDLmfILABsljASkq0qXrVazyHDW/
         Wg5tmh51mW9+xE3rV6a/8f4QVhrQObsWvsmgnUi1CXQOlF3t3WvSSJQU/SUtyAEjfnLU
         yCVCVBUq4QPtwdF5vl8XANMH/2WyZG9X1r/doDnXU5Iv006YwcXzRa9JOWihNlRCwOTK
         iGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1znNAGw/Z1q6zMts4RvOzjAIKcNOTR5cC9VZjL6t0T4=;
        b=K4JgxyrCUgSmoXhlPy28RuBiMMxhvKy4rqQaAIEqNL5BstG8C/Un7ZSYBN9orqea1L
         k84m8Rffn186nqOzcccDmwi8JfgNnLRz6y8VVMTpsDdZmja0rhoD5KSnYZglBlMiq88W
         LMWhHKyjh7yM3ZWKve7tvlzGFQ4WXelwJ0tD8IzujmYfcpCpo3l3PvyKbVV1rbZZYNOT
         PRhrjPO4s5P0a9IUsrg4MP3/1yLsGzUSepyX53opRGhmPDHFCol9jGt5KbmsYpTqFdXH
         zmi37pFI02iRBS4n+//ixPi1tU1vldIFuo30eumZrcttCusNzh1l5m7OugYySYL6e6BN
         Snkg==
X-Gm-Message-State: APjAAAXGqRlppKsh5g4VG5syLdFr0AArnK1RYD+XaqYxBufucQ3DA1aG
        7Xy5QOIfF8pRmUZDEfy4TBwZAnyfUAA=
X-Google-Smtp-Source: APXvYqw1sQ5638emNp4oXahicRk566L49rP3h7hLu+1ZakVzvyAqS3EF8A2tV4rgYhA06BYSYjrp7w==
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr24275641wrr.72.1573522071918;
        Mon, 11 Nov 2019 17:27:51 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:27:51 -0800 (PST)
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
Subject: [PATCHv8 15/34] alarmtimer: Make nanosleep time namespace aware
Date:   Tue, 12 Nov 2019 01:27:04 +0000
Message-Id: <20191112012724.250792-16-dima@arista.com>
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
index 9a8e81bc4ec2..b51b36e533c4 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -839,6 +839,8 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 		ktime_t now = alarm_bases[type].get_ktime();
 
 		exp = ktime_add_safe(now, exp);
+	} else {
+		exp = timens_ktime_to_host(which_clock, exp);
 	}
 
 	ret = alarmtimer_do_nsleep(&alarm, exp, type);
-- 
2.24.0

