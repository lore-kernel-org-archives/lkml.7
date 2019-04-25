Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B26AC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED50020651
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="i3T0oYje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfDYQQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:16:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42234 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbfDYQOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:14:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id l25so374591eda.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZUR3j6htod8TbyFy5p0r2ITUFYxuGwpF70tHqt6V82w=;
        b=i3T0oYjeJnwmJwEAud+bMH9716vwCpp8yZ+ieOczyz17Bpf3kpZjE8hQ3Jk3LwOrZ6
         yDTwWietn7CikD3BXgnIZA7X/gihLQQV18odEGB2iRvOy01ekLUc2n+3Gi4/y5EMdVxt
         WAzsL22/4FUQuIjfga7Wpd/xT3lPF8/qG2K41Bc2vLmnBDKUhPD1/Y3eNxlQvECWeRgv
         QxbyDmGv3crngiXXHy0jQLVSKTvKNhwu9P29VugL0wuQLUZLTkomCx6RWzfUGrSIeDvk
         LaNKiVDtdO8VjDx1ivgFdbFKJey0kLapc6MBceMvDAyHjYdkUfuBAz6eYcsZxU9yPfKz
         jgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZUR3j6htod8TbyFy5p0r2ITUFYxuGwpF70tHqt6V82w=;
        b=ANDs4LqhTzhQGX5tBObiFDw0ON06spnl2unXm7nLoX+Qqf/4nzrqOC8ngrjSUo//8Z
         4JPjMU8HcXF4sTkgYBAHWRUXRGSUojC7MBYyv0h9mvFVZ1eVpB80vlUaDr36JLJWU+Zf
         kzHq4KZpbLiXQ3C9PeViG5sjzDcFGmV0O6UBHsBuEveh/6Twz7ShuknyjjMdXbtL4zG2
         uB5yT0FDavycOCaysIm3vN7PEm4VRj9nkqvtfOoShNuVErMCNasbmtgdN3m1ofs2Ottq
         apjuhd5VYZoyCjGtpQ7Y7i3n6K36xn8O60at3370eVJ7wkj8E4rKBtr90yksdJd/XyJ4
         1Ayw==
X-Gm-Message-State: APjAAAXRvOpFyOpr6p3TF7BKB4plTV4t43zO+bJDrdVs4MoxM0Ski2xp
        xpC63ropKOXYET6vz/cq/6faNlqQJtc=
X-Google-Smtp-Source: APXvYqyaoanO8GKA8fKfWtEwaXr1QtRUm0dwQ0w2lGHjgjIhHUjg758nXoFyv/IB6zt0iq4ftD8c7w==
X-Received: by 2002:a17:906:1249:: with SMTP id u9mr15669932eja.58.1556208871185;
        Thu, 25 Apr 2019 09:14:31 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id br19sm4147042ejb.48.2019.04.25.09.14.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 09:14:30 -0700 (PDT)
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
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv3 08/27] timens: Shift /proc/uptime
Date:   Thu, 25 Apr 2019 17:13:57 +0100
Message-Id: <20190425161416.26600-9-dima@arista.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190425161416.26600-1-dima@arista.com>
References: <20190425161416.26600-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Respect boottime inside time namespace for /proc/uptime

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
2.21.0

