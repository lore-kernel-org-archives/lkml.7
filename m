Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AA1C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 22:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0B320870
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 22:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yylhghcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfDUWHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 18:07:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55303 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfDUWHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 18:07:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id o25so12457395wmf.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 15:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nsoP6WtBm9TQ+F3I/vc+FC4VDTmyeJwEJbWxylw3i1Q=;
        b=YylhghcpoqnPkOiDs0u713mlas4nFSV6LASf1KAzarsAnHNi1Hy1nWUgvIrRQH8Lvi
         mm5J6u8uMni7rKXBO/edvrCP6ADmlXGJ9yO1SKa7oOGcATFemfNnxQunlLSop5hnrwYI
         WG8yGZn5HvUlhMkiWtlfnlPfNwNZe6m++AX+hobQvFtjFv+Zrz9XB4ClmROlS5kmSYE+
         uSjm5ENr+Zpof47Kc4ft+ja+hc7TDzM43Gjuduzma2YFv8zHtjIM5QLFOEy3yE+nRDhF
         mI1TdmT2/7OrBiyvRJvjQ5xzExKHp8EIm/5Axar2T7RDzJ8chzatlg7lum7pG6yvXSLg
         Q9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nsoP6WtBm9TQ+F3I/vc+FC4VDTmyeJwEJbWxylw3i1Q=;
        b=AavLUra1z0dzuYAoryBIo+BMmb3lTEdblilJ5Nto+pXkp43NWC6W+0JMxvgwLMEelD
         hMPNuqJ1W/pF+SvLtO/m0HaPTfD9lINekN8GDOr69opTtcZyOw45oAlX/9LPP0eaFirc
         ZnXwl6nMeJGEbUhLzILg762S4d6/oJXWCebCLrK8JuZo7IwexfG2jbfPcV8kaEDm69fP
         B3rP2q3/m3PVVgOSIl1udu1E9Iis0ZcecpdAGsCUua/rEEWT3l+R0Ma11u7d1WA3IWAC
         DcLj7PYcS1JNF8Ib+0bhjKUzXGsO6uW/j8sqGDkg0ydOL2eSvEWfUHdqBaomlBMjFJM6
         FVRw==
X-Gm-Message-State: APjAAAVd5L9ZMg+7UfGArUCBxFqCvpnVpMWQqP+mhLQPgYlQzXvTEDBP
        wTyaUWGqJJvviKU/1ujHkA==
X-Google-Smtp-Source: APXvYqwsNCAF0HfON276cORGP/QqbmycgpoH9wBip4pAplUehmjxX5k+kuCKpWcdI5uxSZuLm1yBdA==
X-Received: by 2002:a1c:e904:: with SMTP id q4mr9652751wmc.43.1555884436888;
        Sun, 21 Apr 2019 15:07:16 -0700 (PDT)
Received: from avx2 ([46.53.240.200])
        by smtp.gmail.com with ESMTPSA id e12sm9609951wrt.94.2019.04.21.15.07.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 15:07:15 -0700 (PDT)
Date:   Mon, 22 Apr 2019 01:07:13 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v2] x86_64: uninline TASK_SIZE
Message-ID: <20190421220713.GA32469@avx2>
References: <20190421160600.GA31092@avx2>
 <20190421182842.GD35603@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190421182842.GD35603@gmail.com>
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
load_elf_binary                            11761   11111    -650  <===

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/include/asm/processor.h |    4 ++--
 arch/x86/kernel/process_64.c     |    6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

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
 
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -827,3 +827,9 @@ unsigned long KSTK_ESP(struct task_struct *task)
 {
 	return task_pt_regs(task)->sp;
 }
+
+unsigned long _task_size(void)
+{
+	return test_thread_flag(TIF_ADDR32) ? IA32_PAGE_OFFSET : TASK_SIZE_MAX;
+}
+EXPORT_SYMBOL(_task_size);
