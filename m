Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A90AC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D94C215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ktiIxgda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbfFLT20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:28:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52721 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbfFLT0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:26:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so7724993wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 12:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6qkjB3IOi28arCXhgllHnytCrvmzEqMgo82CEycz3eU=;
        b=ktiIxgdaWNMzSkpMdy2bSqkLdK0BWCP+FYYUgBqSc8jSuT4IS2YnUkDdsZGleIFXKn
         fR/JX1UldYmS0tYY7l2PVS/GwUmuNSkSpGsZ6NB3RJtdmF4bQGMeT17fXR7fEpnjTA0e
         4AdO3LPk6RpQ3hCcutrk1OYKHNKVH5j1r6kT9Fc6oHYe8Of1JSPBMAaBBX8CazEG0O/v
         cLDotMQ6rBGI+J/2CIewoBBCPkWH5BqYzQaJwYc3mp/SSGSZkHmTSwrnOhXrkX9L1PhN
         s2GsejSgP7P+sUGHrVtebHzfoVXqz3AAVSqRinTcgg39f5iDNOtUC94Pn0HC5JW4xgCj
         bCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6qkjB3IOi28arCXhgllHnytCrvmzEqMgo82CEycz3eU=;
        b=AhzN6AMUimdWpSAQSEg+UA7UCvc9QOIAmbAGe8X13GBrmGiND+WYtrd2LBFmqzVkc0
         pgXtYiN3HgzqG72LD9LXxnyjC1P0xEN2g1JM/5Bb/Bx8RwQblBhf1RA26DagW3RZ33/I
         SNVfSCVPmAgD+5GndXryqI9gSMmDoaX3ySrMZXhHnJ2x/nu6cdcl+x9QeI7SsFv7Wn/F
         nRFFhcQDJvYml1eGKvZWfYHeCBPX7HJxhtKaCKHLxfnqXMyeFp3C2ktYNufK7iwaIu1z
         2baNrHG1Vi6JRMiFwrJ+q0TglbN64YVp5K7JI2jsUYbBEXf7wD3yQGmGukG4c8lSyOhz
         E9Ag==
X-Gm-Message-State: APjAAAUcO3w8b9z6oa2lNf3Ec5iy24M/3ArJw0eKnO6+af3B4mO70WQw
        0G0UnavPvAOqBjLl7ycY6kWVzfhvyxw=
X-Google-Smtp-Source: APXvYqzb/Gj37ht5UhPIiWmr5OpmGFCzdSKaugZfvxBmgJnspXb+uV4sCorLCGUsWogXaswFY1SGwA==
X-Received: by 2002:a1c:5a56:: with SMTP id o83mr348100wmb.103.1560367602993;
        Wed, 12 Jun 2019 12:26:42 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:42 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
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
Subject: [PATCHv4 09/28] timens: Shift /proc/uptime
Date:   Wed, 12 Jun 2019 20:26:08 +0100
Message-Id: <20190612192628.23797-10-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Respect boottime inside time namespace for /proc/uptime

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
2.22.0

