Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2845FC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74F82196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="FBgvS9St"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfKLB1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:27:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33308 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfKLB1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:27:36 -0500
Received: by mail-wm1-f68.google.com with SMTP id a17so1138910wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 17:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EXlJ2YFckPR8V8xWSBCOU8yH5VaIFEt1z2vjnbA1Vqg=;
        b=FBgvS9Stb70KGT/SCpMR1ljW5rbP51a7BQQ5MMbHqTGJwwHoWrvOCokxMQK0nYu3T8
         pHXl90L93qpU7YxeySoM9Digv0kfm75Qi5Aty7rLWH+b88PJMvEEg+q3LTBd3oxYTkXD
         kRJvIySTgkvSzuZMovjwD3rpGPbypA+ummFaVGC72pRWuVc8R4bVbEVspsgRt2IBBVu2
         bRPOvP07oYhVFagQR5yiKKW4//FdRggDgDFMIfwaABpjtFaRGztylu4ZcWEj0QSFfiTK
         J5wlxf0nXrSYiYazfnM80RvLWwerjVLGNMD7PgJFKtEwR/TyJze4D8glC/FKny1kKtqT
         IjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EXlJ2YFckPR8V8xWSBCOU8yH5VaIFEt1z2vjnbA1Vqg=;
        b=TReXuCWoQ1WkkLfCFPUxksIQ4aE9H83K2h7goxpCl702d39rrQIzS+qTQpWn5GMVjn
         O2KV5v6R90HQO+mlCG/yGGPegIrnKpMM18SXf9KGHQNyflfZdRewe4R7NuKp90n6qfkw
         laNe0gEZAKxmplmmL7PQVllrRpYjkFWPQ6SFQc45UAT3vvtKPj03i2RLZrEPOYJMZd43
         DOL5Zw9ySIYHqm6o8kJmh/b79a92XsebGhhe2qZI9segR36bv3T544NrbLHK5Bql2Lny
         IhlraOLBB50lmE5S//Qq37sGd/+odzR2CCJsi/pUDnKxe6XirTw6Sbm4C/q7bC2boB9k
         EVvw==
X-Gm-Message-State: APjAAAXFjs+k7oYbZh2+rpJxReyPY4EIgNplYuc59HkXQ/pTXQJq1VEg
        OEAFosCSKtVgpZ3arhKZ3hdx4b5Tf08=
X-Google-Smtp-Source: APXvYqzCIUeA9B05Tti6XwcruEz9VAnsxAj3oSdeEFb6EAk3/7iprE/8I6PqL84TbdzHhbPe7H6zPg==
X-Received: by 2002:a1c:62c5:: with SMTP id w188mr1442436wmb.77.1573522053935;
        Mon, 11 Nov 2019 17:27:33 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:27:33 -0800 (PST)
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
Subject: [PATCHv8 02/34] lib/vdso: make do_hres and do_coarse as __always_inline
Date:   Tue, 12 Nov 2019 01:26:51 +0000
Message-Id: <20191112012724.250792-3-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112012724.250792-1-dima@arista.com>
References: <20191112012724.250792-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Performance numbers for Intel(R) Core(TM) i5-6300U CPU @ 2.40GHz
(more clock_gettime() cycles - the better):

clock            | before     | after      | diff
----------------------------------------------------------
monotonic        |  153222105 |  166775025 | 8.8%
monotonic-coarse |  671557054 |  691513017 | 3.0%
monotonic-raw    |  147116067 |  161057395 | 9.5%
boottime         |  153446224 |  166962668 | 9.1%

The improvement for arm64 for monotonic and boottime is around 3.5%.

clock            | before     | after      | diff
==================================================
monotonic          17326692     17951770     3.6%
monotonic-coarse   43624027     44215292     1.3%
monotonic-raw      17541809     17554932     0.1%
boottime           17334982     17954361     3.5%

Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 lib/vdso/gettimeofday.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 45f57fd2db64..9923e1eab9db 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -38,7 +38,7 @@ u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
 }
 #endif
 
-static int do_hres(const struct vdso_data *vd, clockid_t clk,
+static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
 		   struct __kernel_timespec *ts)
 {
 	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
@@ -68,7 +68,7 @@ static int do_hres(const struct vdso_data *vd, clockid_t clk,
 	return 0;
 }
 
-static void do_coarse(const struct vdso_data *vd, clockid_t clk,
+static __always_inline void do_coarse(const struct vdso_data *vd, clockid_t clk,
 		      struct __kernel_timespec *ts)
 {
 	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
@@ -97,12 +97,16 @@ __cvdso_clock_gettime_common(clockid_t clock, struct __kernel_timespec *ts)
 	 */
 	msk = 1U << clock;
 	if (likely(msk & VDSO_HRES)) {
-		return do_hres(&vd[CS_HRES_COARSE], clock, ts);
+		vd = &vd[CS_HRES_COARSE];
+out_hres:
+		return do_hres(vd, clock, ts);
 	} else if (msk & VDSO_COARSE) {
 		do_coarse(&vd[CS_HRES_COARSE], clock, ts);
 		return 0;
 	} else if (msk & VDSO_RAW) {
-		return do_hres(&vd[CS_RAW], clock, ts);
+		vd = &vd[CS_RAW];
+		/* goto allows to avoid extra inlining of do_hres. */
+		goto out_hres;
 	}
 	return -1;
 }
-- 
2.24.0

