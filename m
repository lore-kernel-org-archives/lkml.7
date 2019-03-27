Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24764C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7B321855
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710013;
	bh=0zeaaPljIQNgHD4p47tYv9YtYYNS+0P6iJy7RfmHxoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zQbKeSiFwbTOeMa1E9rW9w8szD2ChtVEnw65YqsPzJLQkWUlpGS95imkH6B4E+8LL
	 K6Q7fdwh/0mhuSsuvDskBfHJ/HE6vJN9AmTfi/hww7/yqlfIKQbocjFU6cH1R+WOZD
	 1gTppWMBkGrumt2+OClbFy8uM5ZUFTSkeuISGiHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388036AbfC0SGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:06:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388009AbfC0SGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:06:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D590421734;
        Wed, 27 Mar 2019 18:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710004;
        bh=0zeaaPljIQNgHD4p47tYv9YtYYNS+0P6iJy7RfmHxoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eqn5Giw1AiJL9OQtJDYnPekdvUQGejXuRz2ViIQwWmFEDTCbJCCYyIzuUvi969VM1
         Pvlq4CGwvzUoImJkKGwcFgXletoCws63KF8vy5poBDs3ovea3b4a1Z4sTWKy1DF4nO
         HRTukyJuMHsGts29p3hBPxweNQ2BSuNbsTvk/z60=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrea Righi <righi.andrea@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 152/262] x86/kprobes: Prohibit probing on IRQ handlers directly
Date:   Wed, 27 Mar 2019 14:00:07 -0400
Message-Id: <20190327180158.10245-152-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 0eae81dc9f026d899c70f3931bf3bca6d7aa6938 ]

Prohibit probing on IRQ handlers in irqentry_text because
if it interrupts user mode, at that point we haven't changed
to kernel space yet and which eventually leads a double fault.
E.g.

 # echo p apic_timer_interrupt > kprobe_events
 # echo 1 > events/kprobes/enable
 PANIC: double fault, error_code: 0x0
 CPU: 1 PID: 814 Comm: less Not tainted 4.20.0-rc3+ #30
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
 RIP: 0010:error_entry+0x12/0xf0
 [snip]
 Call Trace:
  <ENTRY_TRAMPOLINE>
  ? native_iret+0x7/0x7
  ? async_page_fault+0x8/0x30
  ? trace_hardirqs_on_thunk+0x1c/0x1c
  ? error_entry+0x7c/0xf0
  ? async_page_fault+0x8/0x30
  ? native_iret+0x7/0x7
  ? int3+0xa/0x20
  ? trace_hardirqs_on_thunk+0x1c/0x1c
  ? error_entry+0x7c/0xf0
  ? int3+0xa/0x20
  ? apic_timer_interrupt+0x1/0x20
  </ENTRY_TRAMPOLINE>
 Kernel panic - not syncing: Machine halted.
 Kernel Offset: disabled
 ---[ end Kernel panic - not syncing: Machine halted. ]---

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrea Righi <righi.andrea@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/154998796400.31052.8406236614820687840.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/kprobes/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 4ba75afba527..a034cb808e7e 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1028,6 +1028,13 @@ NOKPROBE_SYMBOL(kprobe_fault_handler);
 
 int __init arch_populate_kprobe_blacklist(void)
 {
+	int ret;
+
+	ret = kprobe_add_area_blacklist((unsigned long)__irqentry_text_start,
+					 (unsigned long)__irqentry_text_end);
+	if (ret)
+		return ret;
+
 	return kprobe_add_area_blacklist((unsigned long)__entry_text_start,
 					 (unsigned long)__entry_text_end);
 }
-- 
2.19.1

