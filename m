Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A39C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB202206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbfH0OBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:01:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfH0OA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:00:59 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 85F9A81F19;
        Tue, 27 Aug 2019 14:00:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.63])
        by smtp.corp.redhat.com (Postfix) with SMTP id E794F60BF7;
        Tue, 27 Aug 2019 14:00:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 27 Aug 2019 16:00:58 +0200 (CEST)
Date:   Tue, 27 Aug 2019 16:00:55 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sebastian Mayr <me@sam.st>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: get_unmapped_area && in_ia32_syscall (Was: [PATCH] uprobes/x86: fix
 detection of 32-bit user mode)
Message-ID: <20190827140055.GA6291@redhat.com>
References: <20190728152617.7308-1-me@sam.st>
 <alpine.DEB.2.21.1908232343470.1939@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908232343470.1939@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 27 Aug 2019 14:00:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for delay, vacation.

On 08/24, Thomas Gleixner wrote:
>
> And sadly this was already mentioned here:
>
>    8faaed1b9f50 ("uprobes/x86: Introduce sizeof_long(), cleanup adjust_ret_addr() and arch_uretprobe_hijack_return_addr()")

Yes, and I even posted a similar fix but forgot to send it officially ...

Thanks Sebastian! I am sure it was not easy to debug this problem.


But to remind, there is another problem with in_ia32_syscall() && uprobes.

get_unmapped_area() paths use in_ia32_syscall() and this is wrong in case
when the caller is xol_add_vma(), in this case TS_COMPAT won't be set.

Usually the addr = TASK_SIZE - PAGE_SIZE passed to get_unmapped_area() should
work, mm->get_unmapped_area() won't be even called. But if this addr is already
occupied get_area() can return addr > TASK_SIZE.

Test-case:

	#include <sys/mman.h>

	void func(void)
	{
	}

	int main(void)
	{
		// 0xffffd000 == TASK_SIZE - PAGE_SIZE
		mmap((void*)0xffffd000, 4096, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1,0);

		func();

		return 0;
	}

	$ cc -m32 -Wall -g T.c -o ./t
	$ perf probe -x ./t func+1		# +1 to avoid push_emulate_op()
	$ perf record -e probe_t:func -aR ./t

perf-record "hangs" because ./t endlessly restarts the probed insn while
get_xol_area() can't succeed.

I verified that the "patch" below fixes the problem, any idea how to fix
it properly?

Oleg.

--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1387,6 +1387,8 @@ void uprobe_munmap(struct vm_area_struct *vma, unsigned long start, unsigned lon
 		set_bit(MMF_RECALC_UPROBES, &vma->vm_mm->flags);
 }
 
+#include <asm/mmu_context.h>
+
 /* Slot allocation for XOL */
 static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 {
@@ -1402,9 +1404,13 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 	}
 
 	if (!area->vaddr) {
+		if(!is_64bit_mm(mm))
+			current_thread_info()->status |= TS_COMPAT;
 		/* Try to map as high as possible, this is only a hint. */
 		area->vaddr = get_unmapped_area(NULL, TASK_SIZE - PAGE_SIZE,
 						PAGE_SIZE, 0, 0);
+		if(!is_64bit_mm(mm))
+			current_thread_info()->status &= ~TS_COMPAT;;
 		if (area->vaddr & ~PAGE_MASK) {
 			ret = area->vaddr;
 			goto fail;


