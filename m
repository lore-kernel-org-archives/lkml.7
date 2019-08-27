Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBD8C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AC92173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2Jm01hw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbfH0DDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 23:03:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46549 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfH0DDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 23:03:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id m3so11751200pgv.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 20:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yrnQxlRs86i/s4KE8dmXp4rew3gb/2U7+nHFO3UAIAU=;
        b=F2Jm01hw78AjHW7i1ufTsmGtC7C6ScZRJovECfz4/aVtX0gTeoJjAIYvCBolKqFWXo
         YXqIDJGDTC5sNF6HiDLNrx7Wy0l2EAx8QcFWfM4xscQt9flKeN6JWqa22xrd2Qgj3oaw
         woE4OrOgmn8bIMwJ0zG8XWxYUY+Qwe2b/Eqj2DqYbaziI+vSGIO+aoYknTs7DYF+YRtT
         K6rHo6GsQgWiBarBmWCAGUKU1OiOFZB+Fy2H+Rmh2VaK/stWZ/1NyrB56V1l4ZjXq7uz
         Hqg7Zhlj+5o2ZZUA8KPfK7quAikFYFxRIhbXbY4r/Q6LTLWd6oa3oexYP5tnP5XHGpYY
         qCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yrnQxlRs86i/s4KE8dmXp4rew3gb/2U7+nHFO3UAIAU=;
        b=tD2if3TW6sDGgwqU4PjiwD9BI1p/sf0PY6nmWJ7RhASCQ2dC+UzOWYD6YyYzWaUbSB
         ruuw/E3ITA5DcYjjil7Wz84feN73SPRtm0uPcUKvMiFi2NQEyu7DVcZdg3XGmZo8CzRu
         HlzuTO7OkpwfsnobbdYOk0d+nTwmIlzNCq2UjaPy1BHJ3OpTRRV99uhN+buYPwJd3q34
         OFx17G4DRCAFco1WvTCZCFc4+4Wwio6GNXHjXCNqydvWARey7ps9RAhL66SNOg/P++zB
         StEje9JckRCkIvVZMvWMlU0IIhdGPShizUHr3DymLLp28lc703ezTJTsBpErVmy5aZ7X
         ytjA==
X-Gm-Message-State: APjAAAWruSjFCowt6YMuoLkbLXZuULCayP6cZVgkiYUApPVFdjf2sit5
        49z6oCJsy+h+L6xc9DJ0Lw==
X-Google-Smtp-Source: APXvYqwJ0X06Cu4Kq1ZWHNntMxm0v1/Tf5DqZWvem13GzmH6hfsYQE01S2exvWHzd4aO7oykLksU9g==
X-Received: by 2002:a17:90a:b104:: with SMTP id z4mr23213301pjq.120.1566874999420;
        Mon, 26 Aug 2019 20:03:19 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s24sm11696535pgm.3.2019.08.26.20.03.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 20:03:18 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Drake <drake@endlessm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org
Subject: [PATCHv2 4/4] x86/smp: disallow MCE handler on rebooting AP
Date:   Tue, 27 Aug 2019 11:02:23 +0800
Message-Id: <1566874943-4449-5-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1566874943-4449-1-git-send-email-kernelfans@gmail.com>
References: <1566874943-4449-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"kexec -l" sends the rest cpu to halt state with local apic disabled. But
they can still respond to MCE.  Meanwhile the execution of MCE handler
relies on the 1st kernel's page table and text, which may be cracked during
the 2nd kernel bootup. Hence Before sending SIPI to AP in 2nd kernel, an
MCE event makes AP take the risk of running in weird context.

Heavily suppress it by disallowing MCE handler on rebooting AP.

Note: after this patch, "kexec -l" still has a little window vulnerable to
weird context, despite AP uses tlb cache and icache.  Consider the
scenario: The 1st kernel code native_halt() in stop_this_cpu() is modified
during the 2nd kernel bootup. Then AP is waken up by MCE after the
modification, and will continue in a weired context. This needs extra
effort.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Qian Cai <cai@lca.pw>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Daniel Drake <drake@endlessm.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org
---
 arch/x86/kernel/smp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 96421f9..55b0f11 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -157,11 +157,15 @@ void native_send_call_func_ipi(const struct cpumask *mask)
 
 static int smp_stop_nmi_callback(unsigned int val, struct pt_regs *regs)
 {
+	struct desc_ptr null_ptr = { 0 };
+
 	/* We are registered on stopping cpu too, avoid spurious NMI */
 	if (raw_smp_processor_id() == atomic_read(&stopping_cpu))
 		return NMI_HANDLED;
 
 	cpu_emergency_vmxoff();
+	/* prevent from dispatching MCE handler */
+	load_idt(&null_ptr);
 	stop_this_cpu(NULL);
 
 	return NMI_HANDLED;
@@ -173,8 +177,12 @@ static int smp_stop_nmi_callback(unsigned int val, struct pt_regs *regs)
 
 asmlinkage __visible void smp_reboot_interrupt(void)
 {
+	struct desc_ptr null_ptr = { 0 };
+
 	ipi_entering_ack_irq();
 	cpu_emergency_vmxoff();
+	/* prevent from dispatching MCE handler */
+	load_idt(&null_ptr);
 	stop_this_cpu(NULL);
 	irq_exit();
 }
-- 
2.7.5

