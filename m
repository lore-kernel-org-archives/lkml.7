Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2840FC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 16:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA66720821
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 16:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6tH5HRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfDUQGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 12:06:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36267 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDUQGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 12:06:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so11925858wml.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 09:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PUUGf/EwkC1j+ueXT0MgB2y+SfSt3+mpIjOPBUt+F78=;
        b=e6tH5HRTwqJnGw14ZJEmH6UA2zTYW0hZH6Rbzm0RMiMILgutvfXQcziIoaXEePtuPo
         R/fAt0Llc4+V26suolEmYMqnxoQQn1p7OWirPfEc0JxQh76aq4MfaTHl9NsONMiDeNAu
         6DtVb7AIRODFecQ21dmzd2y4MiOFnHeY/1ngtHbdAPhEO5QVI3vWtLt8Mpk5GkifH4HO
         EwT7i53rdsoIY+41SXUHo0pGfDW/kfFva36Hjbfemlkvo4BEgpQ9llnDuQhmMj0aujAT
         2vra1vVXqcsL+Tj+AYCcCx66wO0dd8El1+g3LYaZu63SM3+vAvpiB9cGnyOT8thOqqb2
         +yBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PUUGf/EwkC1j+ueXT0MgB2y+SfSt3+mpIjOPBUt+F78=;
        b=LaUfq+Wr50GWNZjXRXIWCKFctwty0U3qw2kjNkPDy7hFvUwHEhCSIJkDtRVYN1iNk/
         Yo3QculgpBAwiXUIu/q1JGM7+uqV6M4SxvlRvBDgyLQUe2QPu4HKWZC51qzx1FjB6QwS
         HnwUZ6HwdXwPjV4Mv2CPUoFaAhdpeosMOF18b8aINIjRhMeyX9OI9lNl0tyJ0xea/4EV
         uJ/zAjgDq+hAX22UjD1fiBoWQUYcrAtf1p97Gz6z9+cB0D4E/iSuHQykjlJ5sROJp7bk
         6X5Ep8rq1chVxlfUgNI9b/AsBWyf1fPE7n+Rl5t8zaMwKYXPI+AnW/O42UjiKtvIqoW+
         ZbUw==
X-Gm-Message-State: APjAAAXjMGtsvp+jtLksAoaoumh3AdXeXvrTixeYUiu55Un1/Ng0JtEJ
        9KepyOMdyxZ/sBYDCwiMUw==
X-Google-Smtp-Source: APXvYqwYmywt7LvEYPkCup+PRtrpp+QERWrUT2kFfMjUbZOzY7eIIEFCr8zSH0drUqt/C/8rM0OOHg==
X-Received: by 2002:a1c:dc84:: with SMTP id t126mr8944928wmg.143.1555862763213;
        Sun, 21 Apr 2019 09:06:03 -0700 (PDT)
Received: from avx2 ([46.53.240.200])
        by smtp.gmail.com with ESMTPSA id f1sm8671707wml.28.2019.04.21.09.06.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 09:06:02 -0700 (PDT)
Date:   Sun, 21 Apr 2019 19:06:00 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH] x86_64: uninline TASK_SIZE
Message-ID: <20190421160600.GA31092@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TASK_SIZE macro is quite deceptive: it looks like a constant but in fact
compiles to 50+ bytes.

Space savings on x86_64 defconfig:

add/remove: 1/0 grow/shrink: 3/24 up/down: 77/-2247 (-2170)
Function                                     old     new   delta
_task_size                                     -      52     +52
mpol_shared_policy_init                      344     363     +19
shmem_get_unmapped_area                       92      97      +5
__rseq_handle_notify_resume.cold              34      35      +1
copy_from_user_nmi                           123     113     -10
mmap_address_hint_valid                       92      56     -36
arch_get_unmapped_area_topdown               471     435     -36
tlb_gather_mmu                               164     126     -38
hugetlb_get_unmapped_area                    774     736     -38
__create_xol_area                            497     458     -39
arch_tlb_gather_mmu                          160     120     -40
setup_new_exec                               380     336     -44
__x64_sys_mlockall                           378     333     -45
__ia32_sys_mlockall                          378     333     -45
tlb_flush_mmu                                235     189     -46
unmap_page_range                            2098    2048     -50
copy_mount_options                           518     465     -53
__get_user_pages                            1737    1675     -62
get_unmapped_area                            270     204     -66
perf_prepare_sample                         1176    1098     -78
perf_callchain_user                          549     469     -80
mremap_to.isra                               545     457     -88
arch_tlb_finish_mmu                          394     305     -89
__do_munmap                                 1039     927    -112
elf_map                                      527     409    -118
prctl_set_mm                                1509    1335    -174
__rseq_handle_notify_resume                 1116     906    -210
load_elf_binary                            11761   11111    -650
Total: Before=14121337, After=14119167, chg -0.02%

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/include/asm/processor.h |    4 ++--
 arch/x86/kernel/Makefile         |    1 +
 arch/x86/kernel/task_size_64.c   |    9 +++++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -887,8 +887,8 @@ static inline void spin_lock_prefetch(const void *x)
 
 #define TASK_SIZE_LOW		(test_thread_flag(TIF_ADDR32) ? \
 					IA32_PAGE_OFFSET : DEFAULT_MAP_WINDOW)
-#define TASK_SIZE		(test_thread_flag(TIF_ADDR32) ? \
-					IA32_PAGE_OFFSET : TASK_SIZE_MAX)
+unsigned long _task_size(void);
+#define TASK_SIZE		_task_size()
 #define TASK_SIZE_OF(child)	((test_tsk_thread_flag(child, TIF_ADDR32)) ? \
 					IA32_PAGE_OFFSET : TASK_SIZE_MAX)
 
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -46,6 +46,7 @@ CFLAGS_irq.o := -I$(src)/../include/asm/trace
 
 obj-y			:= process_$(BITS).o signal.o
 obj-$(CONFIG_COMPAT)	+= signal_compat.o
+obj-$(CONFIG_X86_64)	+= task_size_64.o
 obj-y			+= traps.o idt.o irq.o irq_$(BITS).o dumpstack_$(BITS).o
 obj-y			+= time.o ioport.o dumpstack.o nmi.o
 obj-$(CONFIG_MODIFY_LDT_SYSCALL)	+= ldt.o
new file mode 100644
--- /dev/null
+++ b/arch/x86/kernel/task_size_64.c
@@ -0,0 +1,9 @@
+#include <linux/export.h>
+#include <linux/sched.h>
+#include <linux/thread_info.h>
+
+unsigned long _task_size(void)
+{
+	return test_thread_flag(TIF_ADDR32) ? IA32_PAGE_OFFSET : TASK_SIZE_MAX;
+}
+EXPORT_SYMBOL(_task_size);
