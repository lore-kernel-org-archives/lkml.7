Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B6DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5722184C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="FYI6HTFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfKLB3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:29:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35361 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbfKLB15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:27:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id 8so1226040wmo.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 17:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=14h9vFCPokwSzv6HoNFRi92QbmDZesI+ZDkQN0up0HI=;
        b=FYI6HTFHZJlXLBU4xrLxMBlPA50h62FqV47C1cRotvc8PUmv2q4RtH+0YIfpQxePoG
         Se8fnG/78iLr5M5RlHJqVG0r86rGOMD01cP2reElcv+fNfG6nK3Deed98vgUHDiAKZlz
         /HPfohCSqcbIHCcfcfeKBAL223kl/sgTnV+2WUFjVHZVVOKHMhxQUP+IUNTj42DqZ8IP
         +YeMMEWFnd+PKhqAWqwF3un0nF4QBisAsKbJk519OGrRO/9IhY/Ws774SQfMU+ycGSy+
         2iVqYpZioA4yVbLYc+TbmxCPVQzAW70jRbBY52NN/AznKdRsl4PLOZWwd7ZBTYwngduY
         jDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=14h9vFCPokwSzv6HoNFRi92QbmDZesI+ZDkQN0up0HI=;
        b=moyBUodInAXF7TGv7y0fGlRPJnD7MpcZyn7DziE4UO71802cfISU8BZYIaSIqzEE/n
         in9uuwFuNv0XGxUbcoiqiYgNId3Gk4+rk7Oj5Os9SRtvjZI41t/LPHQl2dpdh3F4moCD
         u0LfSlQJMISy9ExvRanwWaaj+cGTMrac5PRQi1sqdTFXUWSGt4a9bN4s26kcVGnmOk1M
         WdoU3eNDqz0YQdvN6j/tLkk07qoT0eAqKnJFgrUoei+1MxF9i42iond6eh25o6p5cEH0
         QqziMv4xfwKAvVDTQM/QAqvRWwFhb/R0qtXRshCTIgV55q6CRW5nvYJMNC/rBOffRG8l
         bzvw==
X-Gm-Message-State: APjAAAUKArAc24NzhJYvy61kOC3K2TPBYM823BNNeemyZIblsYwfIW9r
        XGCqAXyfwtwUAPISSipsLkNeOlDA2NM=
X-Google-Smtp-Source: APXvYqzRYWbXynaSfskNf1zXWZ+1HG/EQfCPzqhtvrtJxlv3s8syqZivAed9FAXZbai7CCJjPrI9bA==
X-Received: by 2002:a05:600c:2919:: with SMTP id i25mr1522555wmd.158.1573522075902;
        Mon, 11 Nov 2019 17:27:55 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:27:55 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
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
Subject: [PATCHv8 18/34] fs/proc: Respect boottime inside time namespace for /proc/uptime
Date:   Tue, 12 Nov 2019 01:27:07 +0000
Message-Id: <20191112012724.250792-19-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112012724.250792-1-dima@arista.com>
References: <20191112012724.250792-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/proc/uptime.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/proc/uptime.c b/fs/proc/uptime.c
index a4c2791ab70b..5a1b228964fb 100644
--- a/fs/proc/uptime.c
+++ b/fs/proc/uptime.c
@@ -5,6 +5,7 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/time.h>
+#include <linux/time_namespace.h>
 #include <linux/kernel_stat.h>
 
 static int uptime_proc_show(struct seq_file *m, void *v)
@@ -20,6 +21,8 @@ static int uptime_proc_show(struct seq_file *m, void *v)
 		nsec += (__force u64) kcpustat_cpu(i).cpustat[CPUTIME_IDLE];
 
 	ktime_get_boottime_ts64(&uptime);
+	timens_add_boottime(&uptime);
+
 	idle.tv_sec = div_u64_rem(nsec, NSEC_PER_SEC, &rem);
 	idle.tv_nsec = rem;
 	seq_printf(m, "%lu.%02lu %lu.%02lu\n",
-- 
2.24.0

