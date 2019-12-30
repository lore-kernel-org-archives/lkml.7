Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1491C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 11:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABAD2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 11:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnPlqgi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfL3Lzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 06:55:31 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36611 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfL3Lzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 06:55:31 -0500
Received: by mail-pj1-f67.google.com with SMTP id n59so8025929pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 03:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QmvUyOThLKgIMmAYLq0yhUeeOF7gjd7fkLseJ1QqBz0=;
        b=cnPlqgi+FQx6/QEMcrf8L3berGqTWJqZpi1LDYXdPHSFSKbij9MzBTZqYdNLXJeNeA
         EEHPXp3J1dIz6iVi0+vzngX0t4bl144PzH3rElS1AOp9Tn81oLdwPeu+hUm0CKehq+0Q
         mS5jKidKmcVa+UAWJpuZ4uKyeE+D0atLbPHaxdeoX6NvNRYfO6lf5btSY3GHeNWmSpjx
         6D7CqXeaGTk3wzPbKkIP+A32DnRNRXjSqDEkkawAQMBURMnE2ANwDQzFlvdw3UY2Nk7q
         UhsyGd9KMgttFpivz3Ic+CRnHNWicbfkuidoWK9B16W5Y0wqlPPBGDU/CRmpj4rCQuve
         7UcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QmvUyOThLKgIMmAYLq0yhUeeOF7gjd7fkLseJ1QqBz0=;
        b=KwmR3f52YXuM8dSwaATzpEYw5uC056wW/YdpkMoxziZd40ONL1CYQLhLnq80DSvNiU
         S16vqFUXqR4A3NmaqWdB8nUDtqzmt60WBi8K0FM1AKLWz3mrm9td/dZTlA3lM3CvC74f
         reqACdtHl5Hi/R8APTFG6YtCHXIoQjKlrrgKes+Y8WpKF9uU2tqinZ21PfvTq4NBY3rv
         kX3oTgmUFCsUva8hHu4e0xXmzkoezjw5XxpEj7ei9YGrIuT9JCJhiEhu9uUR3zytSAER
         Dv4bKw+EcUfxI9bgFmgR+Ne5gHWGWKVreXxxvRt1yOo+mUE5xfsbePW1XHG0azjBdakn
         OkHg==
X-Gm-Message-State: APjAAAUGOLRQQtfYFVcEhRaYfY7MdDIraBkR9KwEU7lBj7+WJSGBiVy4
        4dFSbqLeug1y0dEEOhcpfho=
X-Google-Smtp-Source: APXvYqwMc3BA+RXuQW9mKgvrslgYpCpOTZDjadt25dHNTHzW1D8P3wuDgx6NI5gOvt4aK3eqRGaLIg==
X-Received: by 2002:a17:902:8207:: with SMTP id x7mr42684646pln.286.1577706930056;
        Mon, 30 Dec 2019 03:55:30 -0800 (PST)
Received: from localhost ([49.207.54.121])
        by smtp.gmail.com with ESMTPSA id c19sm53990746pfc.144.2019.12.30.03.55.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Dec 2019 03:55:29 -0800 (PST)
Date:   Mon, 30 Dec 2019 17:25:27 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [RFC PATCH 2/2] ARM: !MMU: v7-M: preemption support
Message-ID: <c24f8d1c8e813eef62d642b5e620e0062c52c9a8.1577705829.git.afzal.mohd.ma@gmail.com>
References: <cover.1577705829.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1577705829.git.afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ICSR RETTOBASE bit indicates whether there is any active exception other
than the exception indicated by current value of IPSR. Existing code
already makes use of it to find whether interrupt occurred during
user(thread) mode. Add preemption support in the code path that executes
upon finding an active exception other than the current interrupt.

Having an active exception during interrupt exception indicates that
the interrupt occurred during SVC or PendSV with current Linux exception
setup. On PendSV, interrupts are disabled at exception entry (applicable
to all) & enabled back just before returning from exception. Hence it
has been assumed that active exception during interrupt is indicating
SVC interruption. This would have to be revisited.

With this change, there is some effect, but not enough to make it
usable, this is being debugged.

A simple character driver that does infinite while loop during read was
used to test it as follows (/dev/mymisc corresponds to the node for the
character driver),

A. Before this change,

A.1
~ # cat /dev/mymisc
[   28.099225] mymisc_open
[   28.101625] mymisc_read: enter

command prompt is not usable (expected), interrupts do happen during
this time.

A.2
~ # cat /dev/mymisc &
[1] 39 cat /dev/mymisc
~ # [   11.699880] mymisc_open
[   11.702274] mymisc_read: enter

command prompt is not usable (expected as preemption not supported).

B. After this change,

B.1
~ # cat /dev/mymisc
[   27.374821] mymisc_open
[   27.377349] mymisc_read: enter

though user will not get control back (as expected as it is fg process),
entering on prompt causes new line, doesn't know what to make out of
this behaviour, this doesn't happen in the A.1 case. Interrupts happen
here as well.

B.2
~ # cat /dev/mymisc &
[1] 41 cat /dev/mymisc
~ # [   44.836417] mymisc_open
[   44.838814] mymisc_read: enter

though prompt is available under the control of user, upon typing
anything on the prompt (typed character doesn't get echoed), it crashes
as follows,

[   44.838814] mymisc_read: enter
[   51.710314]
[   51.710314] Unhandled exception: IPSR = 00000006 LR = fffffffd
[   51.717576] CPU: 0 PID: 37 Comm: sh Not tainted 5.5.0-rc4-00004-g2328d01dbd85 #105
[   51.725078] Hardware name: STM32 (Device Tree Support)
[   51.730206] PC is at 0x90195958
[   51.733329] LR is at 0x901c4df3
[   51.736471] pc : [<90195958>]    lr : [<901c4df3>]    psr: 21000000
[   51.742713] sp : 901e5a58  ip : 00000000  fp : 901d89fc
[   51.747911] r10: 00000000  r9 : 00000000  r8 : 00000001
[   51.753143] r7 : 000000a8  r6 : 901e5a58  r5 : 901e5b08  r4 : ffffffff
[   51.759643] r3 : 000000a8  r2 : ffffffff  r1 : 00000001  r0 : 00000001
[   51.766122] xPSR: 21000000
[   51.768866] CPU: 0 PID: 37 Comm: sh Not tainted 5.5.0-rc4-00004-g2328d01dbd85 #105
[   51.776369] Hardware name: STM32 (Device Tree Support)
[   51.781594] [<0800c0c9>] (unwind_backtrace) from [<0800b25b>] (show_stack+0xb/0xc)
[   51.789166] [<0800b25b>] (show_stack) from [<0800b9eb>] (__invalid_entry+0x4b/0x4c)

It is a Usage Fault happening while in thread(user) mode. PC & LR in the
dump is strange in the sense that they do not point to text section.

The change here has been made based on how Cortex-A handles preemption.
Since PAN is not applicable and since it seemed that saving & restoring
thread_info::addr_limit does not make difference on the !MMU Cortex-M
due to single address space being used, there was no additional save &
restore of 'dacr' & 'addr_limit' as done in the case of interrupt during
system call on Cortex-A. Also as DUT was UP Cortex-M4, it seemed that
cache related would not affect in anyway w.r.t preemption, as currently
cache is not enabled for M4 in Linux.

As mentioned above, it was assumed that active exception during
interrupt meant SVC was interrupted, though it could have been PendSV as
well. To ensure that issue is not due to interrupt during PendSV, the
PendSV handling of pending work was lifted & sticked onto __irq_entry
and setting PendSV removed as well. Still the behaviour is same.

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---
 arch/arm/kernel/entry-v7m.S | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
index 581562dbecf3..e671115767d2 100644
--- a/arch/arm/kernel/entry-v7m.S
+++ b/arch/arm/kernel/entry-v7m.S
@@ -55,14 +55,29 @@ strerr:	.asciz	"\nUnhandled exception: IPSR = %08lx LR = %08lx\n"
 	ldr	r1, =BASEADDR_V7M_SCB
 	ldr	r0, [r1, V7M_SCB_ICSR]
 	tst	r0, V7M_SCB_ICSR_RETTOBASE
-	beq	2f
+	beq	101f
 
 	ldr	r2, [tsk, #TI_FLAGS]
 	tst	r2, #_TIF_WORK_MASK
 	beq	2f			@ no work pending
 	mov	r0, #V7M_SCB_ICSR_PENDSVSET
 	str	r0, [r1, V7M_SCB_ICSR]	@ raise PendSV
+	b	2f
+
+101:
+#ifdef CONFIG_PREEMPT
+	ldr	r2, [tsk, #TI_PREEMPT]
+	teq	r2, #0			@ preempt count != 0 ?
+	bne	2f
 
+	ldr	r0, [tsk, #TI_FLAGS]
+	tst	r0, #_TIF_NEED_RESCHED	@ __TIF_NEED_RESCHED set ?
+	beq	2f
+102:	bl	preempt_schedule_irq
+	ldr	r0, [tsk, #TI_FLAGS]
+	tst	r0, #_TIF_NEED_RESCHED	@ __TIF_NEED_RESCHED set ?
+	bne	102b
+#endif
 2:
 	pop	{lr}
 
-- 
2.24.1

