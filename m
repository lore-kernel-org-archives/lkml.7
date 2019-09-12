Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2910FC4CEC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 21:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE7E208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 21:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ih1UML0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbfILVk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 17:40:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44858 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfILVk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 17:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=brx/+x7ZIQk1UPXUZM8Lmqw9bdD0N9lMuY2fIny/ccs=; b=ih1UML0/3qIDns2xuPQ1k7xIE
        TfxJyp76RfyUNN3Ik4X+ItYKGyHDiS+svZRckcMV425XV7P0pqPh6TqTPj2vxpJV9eLmvcJvxCIlg
        teC/oVAmyTBQJG/Jn2J/FfbLu+/iLwrxCs1FA76NiODds24X6nDAm3mlTZG231r5gaRMkSMECjqXR
        4bmJIvOdbv/hJNU7ZR/qlO2j/bH1s2CoZx7w7f0wIPqtNSIXQA7qkF6mHxwsNOHEjugIXhkbqkjjs
        rJ15A081PWP+tI/MsR6+s5bW1yhU4RSsWKRn/65z9YcMQ70wtxe163d+VyQ57NWDZiOjJGkwI8gBJ
        sNxccpYxA==;
Received: from c-73-157-219-8.hsd1.or.comcast.net ([73.157.219.8] helo=[10.0.0.252])
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i8WpA-0005hc-2s; Thu, 12 Sep 2019 21:40:20 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: problem starting /sbin/init (32-bit 5.3-rc8)
To:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <a6010953-16f3-efb9-b507-e46973fc9275@infradead.org>
Date:   Thu, 12 Sep 2019 14:40:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is 32-bit kernel, just happens to be running on a 64-bit laptop.
I added the debug printk in __phys_addr() just before "[cut here]".

CONFIG_HARDENED_USERCOPY=y

The BUG is this line in arch/x86/mm/physaddr.c:
		VIRTUAL_BUG_ON((phys_addr >> PAGE_SHIFT) > max_low_pfn);
It's line 83 in my source file only due to adding <linux/printk.h> and
a conditional pr_crit() call.


[   19.730409][    T1] debug: unmapping init [mem 0xdc7bc000-0xdca30fff]
[   19.734289][    T1] Write protecting kernel text and read-only data: 13888k
[   19.737675][    T1] rodata_test: all tests were successful
[   19.740757][    T1] Run /sbin/init as init process
[   19.792877][    T1] __phys_addr: max_low_pfn=0x36ffe, x=0xff001ff1, phys_addr=0x3f001ff1
[   19.796561][    T1] ------------[ cut here ]------------
[   19.797501][    T1] kernel BUG at ../arch/x86/mm/physaddr.c:83!
[   19.802799][    T1] invalid opcode: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC
[   19.803782][    T1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.3.0-rc8 #6
[   19.803782][    T1] Hardware name: Dell Inc. Inspiron 1318                   /0C236D, BIOS A04 01/15/2009
[   19.803782][    T1] EIP: __phys_addr+0xaf/0x100
[   19.803782][    T1] Code: 85 c0 74 67 89 f7 c1 ef 0c 39 f8 73 2e 56 53 50 68 90 9f 1f dc 68 00 eb 45 dc e8 ec b3 09 00 83 c4 14 3b 3d 30 55 cf dc 76 11 <0f> 0b b8 7c 3b 5c dc e8 45 53 4c 00 90 8d 74 26 00 89 d8 e8 39 cd
[   19.803782][    T1] EAX: 00000044 EBX: ff001ff1 ECX: 00000000 EDX: db90a471
[   19.803782][    T1] ESI: 3f001ff1 EDI: 0003f001 EBP: f41ddea0 ESP: f41dde90
[   19.803782][    T1] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010216
[   19.803782][    T1] CR0: 80050033 CR2: dc218544 CR3: 1ca39000 CR4: 000406d0
[   19.803782][    T1] Call Trace:
[   19.803782][    T1]  __check_object_size+0xaf/0x3c0
[   19.803782][    T1]  ? __might_sleep+0x80/0xa0
[   19.803782][    T1]  copy_strings+0x1c2/0x370
[   19.803782][    T1]  copy_strings_kernel+0x2b/0x40
[   19.803782][    T1]  __do_execve_file+0x4ca/0x810
[   19.803782][    T1]  ? kmem_cache_alloc+0x1c7/0x370
[   19.803782][    T1]  do_execve+0x1b/0x20
[   19.803782][    T1]  run_init_process+0x31/0x40
[   19.803782][    T1]  try_to_run_init_process+0x11/0x40
[   19.803782][    T1]  kernel_init+0xda/0x120
[   19.803782][    T1]  ? rest_init+0x130/0x130
[   19.803782][    T1]  ret_from_fork+0x2e/0x38
[   19.803782][    T1] Modules linked in:
[   19.876679][    T1] ---[ end trace 2b8071cbe5f1eece ]---
[   19.879467][    T1] EIP: __phys_addr+0xaf/0x100
[   19.882125][    T1] Code: 85 c0 74 67 89 f7 c1 ef 0c 39 f8 73 2e 56 53 50 68 90 9f 1f dc 68 00 eb 45 dc e8 ec b3 09 00 83 c4 14 3b 3d 30 55 cf dc 76 11 <0f> 0b b8 7c 3b 5c dc e8 45 53 4c 00 90 8d 74 26 00 89 d8 e8 39 cd
[   19.889474][    T1] EAX: 00000044 EBX: ff001ff1 ECX: 00000000 EDX: db90a471
[   19.892635][    T1] ESI: 3f001ff1 EDI: 0003f001 EBP: f41ddea0 ESP: f41dde90
[   19.895806][    T1] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010216
[   19.899106][    T1] CR0: 80050033 CR2: dc218544 CR3: 1ca39000 CR4: 000406d0
[   19.902276][    T1] Kernel panic - not syncing: Fatal exception
[   19.903268][    T1] Kernel Offset: 0x1a800000 from 0xc1000000 (relocation range: 0xc0000000-0xf77fdfff)
[   19.903268][    T1] ---[ end Kernel panic - not syncing: Fatal exception ]---


Full boot log or kernel .config file are available if wanted.

-- 
~Randy
