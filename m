Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12190C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE76526E93
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRkrCqB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfEaTu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 15:50:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34753 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfEaTu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 15:50:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id f8so7264330wrt.1;
        Fri, 31 May 2019 12:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7tc5vOLLu+HreBcYMWgxGiK7sq+jdmoDNrvR3Of5K5E=;
        b=IRkrCqB/HXD8WgqmwkH+9cJFSMi3QlXZ7BKExZI5s2euOodFoM9cUbsOw/xN9xfaRe
         I/G3E3eKOoky8EZvtf9YF7vpKWLuMEqEueopYulECz3On/7y0Rpb1U1RqZ9kA5Q3iSZ6
         xlAmg6xSAY+eojPT8fstvEifhX9CCdS/FVs8jdiUEHS6pPKTWT+wk/K3s1bLvbdvOw+1
         GmlqUjY2XZgEXlx9Fx/TL3eDOv/9P7PiyjktwPs3P/W+Edjo3W7w7b3y19zxuzRg6vvO
         7ZBcDTAUKGQSlynIO4BnFqcH2HFTbogk5W6ziGOQPMt19/J4jQmEKqUaiL/qp0E3SJrl
         K0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7tc5vOLLu+HreBcYMWgxGiK7sq+jdmoDNrvR3Of5K5E=;
        b=cUzA5D03y9rp1+RWcAro1jlvdqw2C5XjN82QxXBXwGHvobAiM+xg0yuFTGsucui38S
         VmVQqGkVJkMV3bw5Ljhaa7ik34CFEWMipBohbxxZgKG2CBtTECugn5KAsBXiAL1MogIM
         RetoYcM4taWkK0q4qfFt8LW5qPa507ySHv8FgPKxpffZMJReHK3fXPvOcFcveT+Ph79R
         EZEFBJJ9DQJbZ9h/aQlk8iEB65OD5ajU29bhr3gfreWdKIoQKlOx+remGocup5QQwll7
         4LthChp6+Loob1gx6GoxdpiIDB9q5UJuCKRpfTgRXQUv4RWl7FmtQmDbR/axPvo0uqyd
         9MGQ==
X-Gm-Message-State: APjAAAXvCVnPn3DqwQDfcDKxMth88v0trtO36LC9FU9Tep7g0KlVGFwS
        t0kxGHZ4JiW8Hy20CqwsY5w=
X-Google-Smtp-Source: APXvYqzhLeLBRsxa5+cyyA5twgiDNU9Gu03zY5gYV+fjRU+kMFQVhgKLfCXkiJbNKRb9M8SdqSMK0g==
X-Received: by 2002:adf:e4d2:: with SMTP id v18mr7313750wrm.189.1559332224231;
        Fri, 31 May 2019 12:50:24 -0700 (PDT)
Received: from Thor.lan (89.red-2-139-173.staticip.rima-tde.net. [2.139.173.89])
        by smtp.gmail.com with ESMTPSA id y1sm4716107wma.14.2019.05.31.12.50.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 12:50:23 -0700 (PDT)
From:   Albert Vaca Cintora <albertvaka@gmail.com>
To:     albertvaka@gmail.com, akpm@linux-foundation.org,
        rdunlap@infradead.org, mingo@kernel.org, jack@suse.cz,
        ebiederm@xmission.com, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, mbrugger@suse.com
Subject: [PATCH v3 2/3] kernel/ucounts: expose count of inotify watches in use
Date:   Fri, 31 May 2019 21:50:15 +0200
Message-Id: <20190531195016.4430-2-albertvaka@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190531195016.4430-1-albertvaka@gmail.com>
References: <20190531195016.4430-1-albertvaka@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a readonly 'current_inotify_watches' entry to the user sysctl table.
The handler for this entry is a custom function that ends up calling
proc_dointvec. Said sysctl table already contains 'max_inotify_watches'
and it gets mounted under /proc/sys/user/.

Inotify watches are a finite resource, in a similar way to available file
descriptors. The motivation for this patch is to be able to set up
monitoring and alerting before an application starts failing because
it runs out of inotify watches.

Signed-off-by: Albert Vaca Cintora <albertvaka@gmail.com>
Acked-by: Jan Kara <jack@suse.cz>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 kernel/ucount.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 909c856e809f..05b0e76208d3 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -118,6 +118,26 @@ static void put_ucounts(struct ucounts *ucounts)
 	kfree(ucounts);
 }
 
+#ifdef CONFIG_INOTIFY_USER
+int proc_read_inotify_watches(struct ctl_table *table, int write,
+		     void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ucounts *ucounts;
+	struct ctl_table fake_table;
+	int count = -1;
+
+	ucounts = get_ucounts(current_user_ns(), current_euid());
+	if (ucounts != NULL) {
+		count = atomic_read(&ucounts->ucount[UCOUNT_INOTIFY_WATCHES]);
+		put_ucounts(ucounts);
+	}
+
+	fake_table.data = &count;
+	fake_table.maxlen = sizeof(count);
+	return proc_dointvec(&fake_table, write, buffer, lenp, ppos);
+}
+#endif
+
 static int zero = 0;
 static int int_max = INT_MAX;
 #define UCOUNT_ENTRY(name)				\
@@ -140,6 +160,12 @@ static struct ctl_table user_table[] = {
 #ifdef CONFIG_INOTIFY_USER
 	UCOUNT_ENTRY("max_inotify_instances"),
 	UCOUNT_ENTRY("max_inotify_watches"),
+	{
+		.procname	= "current_inotify_watches",
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= proc_read_inotify_watches,
+	},
 #endif
 	{ }
 };
-- 
2.21.0

