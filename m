Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C96C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8A42073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="hq5GFBDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389272AbfG2V61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:58:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36808 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbfG2V6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:58:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so63544755wrs.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UpN4brfsFhqwubDyI7j+QXBI+7qrgWnZwpT+Z0DqDOU=;
        b=hq5GFBDv8gKlWCOZgFvZijCGjFdVa+5kRtXJPCuuDUazpPX2TW1CGRxQnY19ULONwY
         tc/TXErNAxf2iVv3zG/MKepJUvaOAnkvez5PIQVunL0eVYFmjDTfcK/jS6Rm7cviveUa
         Bg95CkoxsFTPzcwdswqcT2lMLiiumVUGC8Q2VGapzPp9GSagqK7j+I95y312yijfZ6mw
         8TarYxGfbMvIVkELoLNRLmkn9pNYQC6e9Rj71fVpa2BOoYt73gNK2qoSzp+wh7owtE2Q
         FeT5GqY/Toku76pD5myhCpV6rzp/WdgF4FlFhmceMCGNGNigNeVeb4Rq/JPKrkE1M+5B
         li2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UpN4brfsFhqwubDyI7j+QXBI+7qrgWnZwpT+Z0DqDOU=;
        b=C6SZci95y93bq8c+wYFTYiPXujwfrk8WTgeXqqysDv290oqSBvBDkMILDxItZOlfus
         ORMbtDLwfgdWx2I6Obeg5roY+xrR+ZRFVL2Adj+FCdZvn/oK9ZRDpgknMFedrmyiHAEy
         W1VCNPaVckPkkGkC9iBK42b40GCsgOOr6TWP6g22dW23vSwWu5/qh3NJ4QfWmuX1uHF2
         aHSltJkWcF02pm2u7RtvZzNW9CPp5QSqBJNIoQPK+OJ6aZ/3nVSn0nK1NQVpvTOD3Paj
         a3lbSzRj3DfecyD8Ne4RQwyLvP94ORgstv4MRidYlPK2yZUAWpfkaKZ5g/rF6QdPS8GF
         Y12A==
X-Gm-Message-State: APjAAAWL9tGcz+uHuOY8l3Hn1lPQhC09ddGgsTj7w27Yr+/kwuxMf2a0
        Bzm8zIYpsRBwNqB8dY4Le7lEgPd8Mx/KGkvLciPs1yjfcsnmwxZWOjv2kt70pZ8dbWG9UfspW8p
        2G+3q6T9wp6PTolVwJthLJnq2BLGMxFsR9y/QgHdGgdpcF2uA7NJ589aD05VXFqPiX+s4YQ4RJs
        KroLzgy6PG4HZN+S3WpWEdrbYrCGhXNUetAKDiPTU=
X-Google-Smtp-Source: APXvYqzx2nhcz1wHcMzK3Sptq3VSfBLgqvF7rAr/cPc/sQqamObOo58CXfcaEodYjLiKY52daB4ivA==
X-Received: by 2002:adf:f046:: with SMTP id t6mr5392205wro.307.1564437499523;
        Mon, 29 Jul 2019 14:58:19 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:18 -0700 (PDT)
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
Subject: [PATCHv5 14/37] alarmtimer: Make nanosleep time namespace aware
Date:   Mon, 29 Jul 2019 22:56:56 +0100
Message-Id: <20190729215758.28405-15-dima@arista.com>
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
index b1e82bb6cc6b..f21c743f6ede 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -825,6 +825,8 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 		ktime_t now = alarm_bases[type].get_ktime();
 
 		exp = ktime_add_safe(now, exp);
+	} else {
+		exp = timens_ktime_to_host(which_clock, exp);
 	}
 
 	ret = alarmtimer_do_nsleep(&alarm, exp, type);
-- 
2.22.0

