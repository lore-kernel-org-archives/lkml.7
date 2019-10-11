Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE8AC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4709321D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="OOjW2/nc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfJKBYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 21:24:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34296 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbfJKBYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 21:24:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id j11so9979809wrp.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 18:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kXHCe8suyXLAPPOgvlaGi669iqKxC1qw0xREw7xoOxU=;
        b=OOjW2/nc6OKJ5HF5CJpoSYLbs7IXjCX2YdRkxHLuLncL8B8N6z3OQwgivoiTiQuQl8
         +OL4pMOVrI1IWTlHcGB10VP9TUX6IsabTk5wHu2ABHv9Cusa7hu8939xznFCQakXltFN
         Yt1zKFYEihQippfYy0Z8XO9CJjbRd7p8tLP1jd2XWqNwSxJPSbV8ac6fe1VfZ+7dSC/S
         JkYNKMM3uzuVHISXwIZomAJrVda170W8yTBpCHn/uin2mhuNSZ5KK91e8jebxxghx0l0
         /EmR0AHLih/NExS7PJA578sa73oAiM+9jh/LdutNbfR55OweLKYTGYfeuMCs+W5GEmOg
         FthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kXHCe8suyXLAPPOgvlaGi669iqKxC1qw0xREw7xoOxU=;
        b=N+FBoPzAKhECZdv3iMnZmqOuAJ1SIex7HEvMAWWDNQ9i6/0zWhnh6b2eP/CSHw4BAz
         CNDrCsUmXCAne9Lt6sgU69jazqbzjEhoyh9D8MlTDLPXIPmiI1UGK+Fk2ib+l8n49fon
         y2TJPDKZLCuJkjHpUyKnNWHo2VKMHnEX4oWKdKvg7Nx/jG8Euc1XiGvLwFDfV+QQXCax
         /6pbeAa+AF6phe0sLULos/Vy2sXknNmuq5oWbjXb/7wQJxZWp8ucX9avHz3xLAft3lEj
         vOj1L+nVKncAQFZoC/f5hnL7xfSyAiE8cJJ7X3OsAkkFfRHspf24OZ3n9a/mPvc+gE6r
         H3Ng==
X-Gm-Message-State: APjAAAW6c52/QYPnb2zZFljQx84Id2xELY/aMglv8uitAzqs+UchnKUw
        lT8LImjTtT1129XWIqAfaA3g5VCSIT0=
X-Google-Smtp-Source: APXvYqwYBiTGo4zV2uEXwIqXGs5okRcejNUE5yISYtbQFRToEkwxNNZbtod6ktVg5ib7lz9i3yxbIg==
X-Received: by 2002:a5d:4287:: with SMTP id k7mr10339057wrq.283.1570757049526;
        Thu, 10 Oct 2019 18:24:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:24:08 -0700 (PDT)
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
Subject: [PATCHv7 16/33] fs/proc: Respect boottime inside time namespace for /proc/uptime
Date:   Fri, 11 Oct 2019 02:23:24 +0100
Message-Id: <20191011012341.846266-17-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011012341.846266-1-dima@arista.com>
References: <20191011012341.846266-1-dima@arista.com>
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
2.23.0

