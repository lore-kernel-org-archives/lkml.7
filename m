Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A41C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DE5214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Ec2GN/Lu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfJKBYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 21:24:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53559 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbfJKBYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 21:24:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id i16so8687855wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 18:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UlSPcxgshfLMhw3EbcZiOOBSSoRq90yYKe47xesnIkY=;
        b=Ec2GN/Lu4ImiQPapP0i8VcgtUCWETY61vHYsaYV/SxORC4RyaGZ28K7CCilDlVt5qb
         JS+yr3l80Le7kh1wmhfUMpJh8c2KH08uWiNz6ugAMuyi5/2TvEN2ZSEzUZpKzOmrvHFH
         gB9wV9nl2hJn7Lf6pgF+fk3pEnX4q73rfgDoBeU0D0/hJaPmT+QHcSYoBRIscpzxx+5Y
         kArxWi71nsLEMr+3Cj8R3wAj4Ll1jPLmQoJ7WGBUY2fqo8qnK+a4pRzYgWJC6TxJ6Mzk
         e1XRdWJrPtEFVAw0VYC0cQS82UMT8/QYbVqpRl4A0F7OYWY9I16dQF9nNP77zcghnbkP
         YeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UlSPcxgshfLMhw3EbcZiOOBSSoRq90yYKe47xesnIkY=;
        b=WVWqiHLPtSEhlxShMXeDhDiXATjfPC7mPlseC0i+T54S7owdfe94HUPUV+OrlJI98c
         Zo/+eK5GSPsMX+Epx7x2KpDV7v2SIEai9FH4Gf3vYQ4UImiFX4TkfgqBqA2vMH0jYBEG
         JnGAA8hqEf6nSG+0JIxkWVn31CfStiAabZAWoqEUnx9f8SOwy+zdAv2lO+Ob2ItlknJo
         WD+Jf61Exf0T0XsanVWUsWOx7XII+4lnfsowSCydd0yuELeXRvtj/F4iW3Td2mEMWDIX
         uLkT+SQx3UGtr6heuP/NAoYG6rel1H+jFUZTFuHkkcVOFOzKV/wIRjKpI811JEkNMvxd
         AmuQ==
X-Gm-Message-State: APjAAAXtp4QAPkwKPOReg5eEnB5s6eAy5TAREbOj9ErL4o9mdVSgD4Sh
        pALD7O8gWv9ZJkCIDDkqTZ9rk5c8urM=
X-Google-Smtp-Source: APXvYqzbdXl8pzjiXtARcoaD/S7l+wMoRGCoP62MS6GEa1mx0IRFrohqWqMjPNi9ZGqxhzKMGmM9Jw==
X-Received: by 2002:a7b:cd89:: with SMTP id y9mr1025304wmj.51.1570757040243;
        Thu, 10 Oct 2019 18:24:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:23:59 -0700 (PDT)
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
Subject: [PATCHv7 10/33] kernel: Add do_timens_ktime_to_host() helper
Date:   Fri, 11 Oct 2019 02:23:18 +0100
Message-Id: <20191011012341.846266-11-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011012341.846266-1-dima@arista.com>
References: <20191011012341.846266-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

The helper subtracts namespace's clock offset from the given time
and checks that the result is in [0, KTIME_MAX].

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/time_namespace.h | 14 +++++++++++++
 kernel/time/namespace.c        | 36 ++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 3d429c7ecca5..9a77d3854830 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -57,6 +57,15 @@ static inline void timens_add_boottime(struct timespec64 *ts)
 	*ts = timespec64_add(*ts, ns_offsets->boottime);
 }
 
+ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim,
+				struct timens_offsets *offsets);
+static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
+{
+	struct timens_offsets *offsets = &current->nsproxy->time_ns->offsets;
+
+	return do_timens_ktime_to_host(clockid, tim, offsets);
+}
+
 #else
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
 {
@@ -83,6 +92,11 @@ static inline int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *ts
 
 static inline void timens_add_monotonic(struct timespec64 *ts) {}
 static inline void timens_add_boottime(struct timespec64 *ts) {}
+
+static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
+{
+	return tim;
+}
 #endif
 
 #endif /* _LINUX_TIMENS_H */
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index c2a58e45fc4b..1a0fbaa5d2d4 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -16,6 +16,42 @@
 #include <linux/err.h>
 #include <linux/mm.h>
 
+ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim,
+				struct timens_offsets *ns_offsets)
+{
+	ktime_t offset;
+
+	switch (clockid) {
+	case CLOCK_MONOTONIC:
+		offset = timespec64_to_ktime(ns_offsets->monotonic);
+		break;
+	case CLOCK_BOOTTIME:
+	case CLOCK_BOOTTIME_ALARM:
+		offset = timespec64_to_ktime(ns_offsets->boottime);
+		break;
+	default:
+		return tim;
+	}
+
+	/*
+	 * Check that @tim value is in [offset, KTIME_MAX + offset]
+	 * and subtract offset.
+	 */
+	if (tim < offset) {
+		/*
+		 * User can specify @tim *absolute* value - if it's lesser than
+		 * the time namespace's offset - it's already expired.
+		 */
+		tim = 0;
+	} else {
+		tim = ktime_sub(tim, offset);
+		if (unlikely(tim > KTIME_MAX))
+			tim = KTIME_MAX;
+	}
+
+	return tim;
+}
+
 static struct ucounts *inc_time_namespaces(struct user_namespace *ns)
 {
 	return inc_ucount(ns, current_euid(), UCOUNT_TIME_NAMESPACES);
-- 
2.23.0

