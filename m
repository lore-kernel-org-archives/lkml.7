Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E48C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA2920C01
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="J/yMUgi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfG2WBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 18:01:48 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:40243 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389255AbfG2V6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:58:18 -0400
Received: by mail-wm1-f52.google.com with SMTP id v19so54829144wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s8TNpPfRzkd/STVPqA/OmSveOcsf2nPj4laDcq0UFS8=;
        b=J/yMUgi7iMEAQ2WpRqDSNy6MFsL7kyNsDQu8Yi4RlvU6lloGIOeUeFvcMpb5kPY2N0
         Gxkcp/BjRuLchidbhOtgSwup/V35CZHd7VHsru3aHwngyl+hRdK6FjhtBK9At4mvD7ar
         KMYMBtfNKHePWUWFEdzL0JAYRq0hLB3z5luoUHvQXJV6CISw24ahW4oW3qlGkV12wYBl
         IT7urvkxHJjWRScu6Mcg3fMKVJmsOYKLqV1IKGMzxlNi2FWaw2KY8thOvrRg/8lTiXUg
         Ef67SrP0z3GKttqi6QNH6tAB5ek+uo9Rnlex07Nl3oGJl7gvOrtC3wwMFZwPUKdwtJ2j
         qXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s8TNpPfRzkd/STVPqA/OmSveOcsf2nPj4laDcq0UFS8=;
        b=XsZ1gi0JhWk88uugZpynCJlOgY/JyG41iqeOELnICiYXTLhdNR+toEoW510ReluP0u
         Ul6wtKPZVK3f4p3cqLdFsu0HciqBqZEWdwaJbPeJKwAXH9ZkkDCOv5ZGae9q9o/9VopF
         b+rxbHP5xCWnnQLvrdv5tFS+UYyUuLrPHPLwSBOUEKaVEq5AvFqlE3LK8NEN6Z8LYaqr
         7zYLkj9l001pgXzDdFq+nB/BPnGuEYH1lVE2aBBcpVJ5SlXFAZPzr/tztqV+lRXBzYQy
         /rF61UpDEx9zjvAC75nOyHiX6iQWfV7Ir5j2P6VgIyqK/xTBS4m9Y3gAQnpckNbSN9QZ
         CWuw==
X-Gm-Message-State: APjAAAU50M7UhWGdAttOo1S2/3xzGj95v+ERVi7HF7FXp7pbOZaOI1vl
        6yNvG5NvWBPQGapfMZvV5hugBfp5MetGzzd1TGykPXX5modcNnowlPpnVS3sWzP9kVt/ZPwUxD4
        lzHRKSCA4wDEcZ6775NL1SHLk7UuTIv0SiaDjLO3KqYlqx/vO+I2HNgX4SbieMmKwLX+hZOqrPM
        Au/SzJ1LT1PSW4QR6npPpTjOkoI5uDN565KsTb7pE=
X-Google-Smtp-Source: APXvYqz4176aOTeCNi73iY0yQuzJl+7nAo4SUM4laukIpgBNIU5mgcUz6o/ihZnr144Lr2TFEiP/bQ==
X-Received: by 2002:a7b:c8d4:: with SMTP id f20mr104786959wml.90.1564437496783;
        Mon, 29 Jul 2019 14:58:16 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:16 -0700 (PDT)
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
Subject: [PATCHv5 12/37] timerfd: Make timerfd_settime() time namespace aware
Date:   Mon, 29 Jul 2019 22:56:54 +0100
Message-Id: <20190729215758.28405-13-dima@arista.com>
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

timerfd_settime() accepts an absolute value of the experation time if
TFD_TIMER_ABSTIME is specified. This value is in task's time namespace
and has to be converted to the host's time namespace.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/timerfd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index 6a6fc8aa1de7..9b0c2f65e7e8 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -26,6 +26,7 @@
 #include <linux/syscalls.h>
 #include <linux/compat.h>
 #include <linux/rcupdate.h>
+#include <linux/time_namespace.h>
 
 struct timerfd_ctx {
 	union {
@@ -196,6 +197,8 @@ static int timerfd_setup(struct timerfd_ctx *ctx, int flags,
 	}
 
 	if (texp != 0) {
+		if (flags & TFD_TIMER_ABSTIME)
+			texp = timens_ktime_to_host(clockid, texp);
 		if (isalarm(ctx)) {
 			if (flags & TFD_TIMER_ABSTIME)
 				alarm_start(&ctx->t.alarm, texp);
-- 
2.22.0

