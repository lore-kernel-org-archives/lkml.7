Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2F9C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 08:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63212206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 08:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VibfO/Jb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfLWIqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 03:46:45 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42197 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfLWIqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 03:46:44 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so8833500pfz.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 00:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ff1G2isf3ENPBF2E46NZvxlde1YZeJauMKR6NxdElmA=;
        b=VibfO/Jbrl3zvORkS4IIjAcQRdVJEcsvyxUWPE9Wg6Or5bYbgt7kUvv+ERe/v0D8cK
         nCyXtShCcbVas+YSSIG5WREjXocauJsfW+gSN13hCSEapPMvBaBOR+t4HqmrCc9vfdC2
         +vYZYvr+AlU9nrV1dedvsFlSoq9mZVxwrjJBabYQJ5jgKmm4NDHgmSMdwtlryMvQxt4l
         Q/yDrCJD8wGcvm9NBzft+H9djtvGTP1NWtTad6QuTqpnWDjD/7ybs/fICaVaMYMigIwl
         24k3LbSz6g3jro7qyeXwKR6slev/8IhOb3nob8jRDncsu+jIJTCvS4hRIko3APXbncEJ
         Mf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ff1G2isf3ENPBF2E46NZvxlde1YZeJauMKR6NxdElmA=;
        b=r7a+MT/dJeHj6Tp211VEe5LNar/YgcSERMtdCYTZD+Sw0HfDv0oyEuZQaNm4ZPJhPO
         SYVDXgYZ4+nb0/t5E/Wfeh2l3DFWkzciK2LVNjQZlSF1IU60g8pJB0rsNAcqsNcQbigh
         Fi2GTLtw8twXxxGMBm3qRXmHS/Izjgt3Vy1uUP2qie4/5oolm+xw/a+mZx8VBJQhBJb/
         c4AZyQe1e6xughV/gwnXuKVUfD0FDWbxL4s+sF9PWwqBAqTiJN0ibKZD1per+BJJd/u2
         qePX641DJ6DWH8XLMm6dXv0/AFD4emF1cWgjFJWoSJaLfkU4wKIHqcJH9qdt6smSn3tx
         4UfA==
X-Gm-Message-State: APjAAAX8P+5s1DtJ7ig5CQTsmU+vvSl3STYz7TCZbHU8XVNOTa7JZ0sm
        j9sePZJCTRZaot0bNU+Hcds/yZQJVY8=
X-Google-Smtp-Source: APXvYqziyy9+w5umsVZLAP3PlpDcZfc5datLpMELsbD8i83kTAgMKYnXrd9Dl1fqOgSr7xzPGzo+Cw==
X-Received: by 2002:a63:62c2:: with SMTP id w185mr24538363pgb.271.1577090804127;
        Mon, 23 Dec 2019 00:46:44 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id m71sm22000516pje.0.2019.12.23.00.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 00:46:43 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, rostedt@goodmis.org,
        anup@brainfault.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 2/2] clocksource/drivers/riscv: add notrace to riscv_sched_clock
Date:   Mon, 23 Dec 2019 16:46:14 +0800
Message-Id: <20191223084614.67126-3-zong.li@sifive.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191223084614.67126-1-zong.li@sifive.com>
References: <20191223084614.67126-1-zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enabling ftrace graph tracer, it gets the tracing clock in
ftrace_push_return_trace. Eventually, it invokes the riscv_sched_clock to
get the clock. If add mcount instrument in riscv_sched_clock, it will
call ftrace_push_return_trace and cause infinite loop.

The result of failure as follow:

command: echo function_graph >current_tracer
[   46.176787] Unable to handle kernel paging request at virtual address ffffffe04fb38c48
[   46.177309] Oops [#1]
[   46.177478] Modules linked in:
[   46.177770] CPU: 0 PID: 256 Comm: $d Not tainted 5.5.0-rc1 #47
[   46.177981] epc: ffffffe00035e59a ra : ffffffe00035e57e sp : ffffffe03a7569b0
[   46.178216]  gp : ffffffe000d29b90 tp : ffffffe03a756180 t0 : ffffffe03a756968
[   46.178430]  t1 : ffffffe00087f408 t2 : ffffffe03a7569a0 s0 : ffffffe03a7569f0
[   46.178643]  s1 : ffffffe00087f408 a0 : 0000000ac054cda4 a1 : 000000000087f411
[   46.178856]  a2 : 0000000ac054cda4 a3 : 0000000000373ca0 a4 : ffffffe04fb38c48
[   46.179099]  a5 : 00000000153e22a8 a6 : 00000000005522ff a7 : 0000000000000005
[   46.179338]  s2 : ffffffe03a756a90 s3 : ffffffe00032811c s4 : ffffffe03a756a58
[   46.179570]  s5 : ffffffe000d29fe0 s6 : 0000000000000001 s7 : 0000000000000003
[   46.179809]  s8 : 0000000000000003 s9 : 0000000000000002 s10: 0000000000000004
[   46.180053]  s11: 0000000000000000 t3 : 0000003fc815749c t4 : 00000000000efc90
[   46.180293]  t5 : ffffffe000d29658 t6 : 0000000000040000
[   46.180482] status: 0000000000000100 badaddr: ffffffe04fb38c48 cause: 000000000000000f

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/clocksource/timer-riscv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 4e54856ce2a5..c4f15c4068c0 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -56,7 +56,7 @@ static unsigned long long riscv_clocksource_rdtime(struct clocksource *cs)
 	return get_cycles64();
 }
 
-static u64 riscv_sched_clock(void)
+static u64 notrace riscv_sched_clock(void)
 {
 	return get_cycles64();
 }
-- 
2.24.1

