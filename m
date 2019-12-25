Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E43EC2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 07:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB8A2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 07:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtmFxivQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfLYHoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 02:44:13 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38156 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfLYHoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 02:44:12 -0500
Received: by mail-pl1-f193.google.com with SMTP id f20so9260027plj.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 23:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VnWaByxSuThcNDr6RgDflaqiHFBl/kk6IlTVbqeabtI=;
        b=XtmFxivQ5byk+uSMLnq81rtYd5OwtBVQ4SbKkYp9OAqlPmUxJ/bnEGGUQhteEOEmpC
         ZeiQ8U1v9YKNnyLtKMtu5xTqN7NKHAm4IC8cRWX4QptXgHrSZwUAkZV4q0Z2vmopJVTr
         R9KlkF7KgvENLSrzLWzEeSmykSTiI36SdYhncHZSro5g44ePQhEMAusaMQPYQIQlgTkb
         FEYeA+ejuKsnolNZ9v9KzUVvHN87Sr837nIvnP8cSX7UT0w0N/4RiKxjBtKmd0cI6rq/
         yQqH+BNU39y95sujdWZwLCUJUx6yeC25j2o/fhsiIhk+7UpG6GNKuL8cjFgwh80UCKRx
         roHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VnWaByxSuThcNDr6RgDflaqiHFBl/kk6IlTVbqeabtI=;
        b=hFVQGq0Y19ulmyX9wzAHWVwsmqRcWVZucdAF5+/kFZ/4kbItn5bwl9NjWMiP5etXEr
         YuhEQFkFs36D8QQ//rOw83keTvauup0iNTu3Qg5e/BwvkdDtfs3bnaeyMbxF/6yCOAqR
         8jEhPMa0QXYjhj2T2/mKeUdbUsWev7ANAhwdhohTs2nrIhbTUoRsQYxNQkrSKy9Ks6/m
         Raj3U1PBPsnf8kB+D1ZzFZiqpfAQeo/eXhkA11aqTPX6ir67TtDB0KBtEcR8s9aOy0On
         xw7psNKnyK2nZTRcuD6s7JG2ZWjxuFkCKtLEkQSW67qXKZ/l/enSfLFO/1vDZlS6qSl+
         FzWw==
X-Gm-Message-State: APjAAAXvdAEK62nlkT98DgQvjbsZXLJOtSqjZ1M/9s4EAwBDZ2szQ9Ip
        u7CuPqXXXy5xM6XTlMt2QJg=
X-Google-Smtp-Source: APXvYqxR26g/z0d6N7wcisWdVzeD7t/M8wlqKfT/xMoaNLfotZAzx2vfmfv3p84jd1kE+/8NdVY5yA==
X-Received: by 2002:a17:90a:8008:: with SMTP id b8mr11513134pjn.37.1577259852082;
        Tue, 24 Dec 2019 23:44:12 -0800 (PST)
Received: from BJ08491PCU01.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c68sm32240806pfc.156.2019.12.24.23.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Dec 2019 23:44:11 -0800 (PST)
From:   Li Guanglei <guangleix.li@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        guangleix.li@gmail.com, guanglei.li@unisoc.com
Subject: [PATCH v01] sched/core: uclamp: fix rq.uclamp memory size of initialization
Date:   Wed, 25 Dec 2019 15:44:04 +0800
Message-Id: <1577259844-12677-1-git-send-email-guangleix.li@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Guanglei <guanglei.li@unisoc.com>

uclamp_rq for each clamp id(UCLAMP_CNT) should be initialized when call
init_uclamp.

Signed-off-by: Li Guanglei <guanglei.li@unisoc.com>
---
 kernel/sched/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 44123b4..05f870b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1252,7 +1252,8 @@ static void __init init_uclamp(void)
 	mutex_init(&uclamp_mutex);
 
 	for_each_possible_cpu(cpu) {
-		memset(&cpu_rq(cpu)->uclamp, 0, sizeof(struct uclamp_rq));
+		memset(&cpu_rq(cpu)->uclamp, 0,
+				sizeof(struct uclamp_rq)*UCLAMP_CNT);
 		cpu_rq(cpu)->uclamp_flags = 0;
 	}
 
-- 
2.7.4

