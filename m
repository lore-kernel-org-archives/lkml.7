Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A064BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7299820C01
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="g1q/BkZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbfG2WBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 18:01:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54778 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389267AbfG2V60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:58:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so55158476wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uBAXcNmS3l3nfaiqDJOSvjXWDET+01IZ2JhTywzQRP4=;
        b=g1q/BkZMUq4el8iFlMlE2qzEkE7J7+rd1DrZqn3UcvHHX2Du2fxG9Z0DDNHr5oVrJ+
         1Bxb98mT/fjQcQKWJva03y4yz82D14gv4jdRlqzV2hhwMSna4jSOLGfbfOirH28IYrTc
         W60RLQS8L+tZBl0NbRkSq/1DiLiC+lUiVsBXwjjOXHw8gXxkZKf/spkYWt8dP05SBtxF
         bTxglugbOuelSJ01Uj1DhSI9c8egDb8kOj19tHiHMfd3fmISNJBGTAdnBO75pS2H7J7Q
         lI+azQYIqSjR6z2IlEhXX8Wf2U+l2ww8dFlEKvbhF/SchTCpj5V8wbN/ORqhHKnPqt0+
         Sdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uBAXcNmS3l3nfaiqDJOSvjXWDET+01IZ2JhTywzQRP4=;
        b=X9Y/dg3Nna8IfH2OHGE6ZDNNc1pojchhux0uZiLjU/9tM+zLiDx6+kJyUowtNVbC2c
         1f2OgZFphvUMKNteSQeyeN+6gp22pH8GhS2ASWoJPzln7GIuq1aakzf7eg/8uFrorFqY
         B6kCZYZ1W7r/Gf/T7PKdhSzpX/vt7V1lbxK8Ya6dryUEhsiSVU2NQAsabRAHGUBZZsvK
         HoKmuUKrq20kJiPkotfh4vRE5yB1mPvrTKv1/MBDKusU4qju+aJFgjNqXXxh+SZBMx+4
         p/34KM8CZh9BSCF6QbIsUIfEd9CgyX8fVgCF4Iqg7mB20T6xYI/ldzaE9mrg4N466ewV
         rUAw==
X-Gm-Message-State: APjAAAXq9d3tkvpNXvEZpb2a9y4PwKbPThtplV1axtSU4bUpG+2CoOze
        ku2kyavsiF9d63zSHJpiJ5WpkvLt8MAAmEyTLVBWklwyoZAtnaHuokgJ/LvNhdsI1P4tqVO09gZ
        bHDXbbXfA0wR5vBgcn7Pg95rHTctNLNk9Mk+gf4zEbnZIcKyCep3GYVYzsdkmct3E+VCvbCXp8r
        dZbIf5/1pLNZgScOPSaoZR2TFY5bnVcCG6KNbBgpQ=
X-Google-Smtp-Source: APXvYqyzsOlLiIxvCd/A4+OkbZ3kiGOeGsnV+RFBRn/XHct9ebVfv42p6MhTkWgwqVkj+rzPZitpZw==
X-Received: by 2002:a1c:9696:: with SMTP id y144mr100565206wmd.73.1564437503760;
        Mon, 29 Jul 2019 14:58:23 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:23 -0700 (PDT)
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
Subject: [PATCHv5 17/37] fd/proc: Respect boottime inside time namespace for /proc/uptime
Date:   Mon, 29 Jul 2019 22:56:59 +0100
Message-Id: <20190729215758.28405-18-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729215758.28405-1-dima@arista.com>
References: <20190729215758.28405-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
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
2.22.0

