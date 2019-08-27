Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC096C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9A72070B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0ygqP0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfH0DCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 23:02:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41984 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbfH0DCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 23:02:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id y1so10989377plp.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 20:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ftoGiq3xK+pQxUGAJR7kxnUXFgdZwJFU6Ox1JMGKAXw=;
        b=H0ygqP0vpOBEcqE1x8oCLF2z0FRkylvUL/nDmV/LzbdyTYXJor/eeeYEQZ8LAprEN5
         E/rRAxQYnQCXzI9V3dZl/AQH8n8PwdSR6Kvgz7MAmP7rNhrKEUp+Qwg6RppyuP2WOPfR
         lgSv1tmDLjEKDl56baL975w3ttShcxiBbV65H9Y163qlkUdE9R/AtVVzMACC5UOjgoJB
         ShczzaFDLHN+yS0Jna6PtHcIRysXNFVI9D6osQ49g9/FYj6v2zzKik1JQU6iLzmTwWYL
         aPYch0r6nso2LHuQbldKEMph1Mpriqy/dkxpwOZ7lep7+ppF0HfilUestOHPVmjw/uku
         BQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ftoGiq3xK+pQxUGAJR7kxnUXFgdZwJFU6Ox1JMGKAXw=;
        b=OwilXCxoe3jOvhtfDhbYTbDchSTF0pXeJBZ+xpBQ2gm08CiK1/XSdU1byHLEAh37mp
         yxmWnz5a8a1vb0usbWGtoqIFJ6QElan/bG2QkRGJpAPsxSTzM9eKrqhU3QWPKkOOVRVe
         SUx58no0JErNIKzeNZOjvqAE7b/FoDm0BTUyaCQMyCa2UNEgt/f7UHWTSmwhMp56kdEc
         IEamkJHh/L+cOU5GkTi53qYqu74ZxVut943lbReIbJ0+iS1+xvL/rcvBW75K5CQJRy1R
         FEoav1rm5qLYj/HMPwY5rwRf3sUSPDQZoyXs+s0FfxFB0Y1zwjcn7MChIn6xxXZA139X
         quow==
X-Gm-Message-State: APjAAAUhyh0NmrW1Njvaz8pJT5uNR+qUROvXv76xI/UOKPfggn6FIxto
        zn5Y5U+K58H22/pXZ2A+VY50kQ8=
X-Google-Smtp-Source: APXvYqwrwu7Afilzmnk9LI5uLA8Jdsl36xS0kpWP1Xm839jwbTCh2QYc5W1rWMov4fdEOfngS+Fyjg==
X-Received: by 2002:a17:902:6842:: with SMTP id f2mr22747658pln.39.1566874968466;
        Mon, 26 Aug 2019 20:02:48 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s24sm11696535pgm.3.2019.08.26.20.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 20:02:47 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>,
        x86@kernel.org
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
Subject: [PATCHv2 0/4] x86/mce: protect nr_cpus from rebooting by broadcast mce
Date:   Tue, 27 Aug 2019 11:02:19 +0800
Message-Id: <1566874943-4449-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2: fix compile warning and error on x86_32


This series include two related groups:
[1-3/4]: protect nr_cpus from rebooting by broadcast mce
[4/4]: improve "kexec -l" robustness against broadcast mce

When I tried to fix [1], Thomas raised concern about the nr_cpus' vulnerability
to unexpected rebooting by broadcast mce. After analysis, I think only the
following first case suffers from the rebooting by broadcast mce. [1-3/4] aims
to fix that issue.

*** Back ground ***

On x86 it's required to have all logical CPUs set CR4.MCE=1. Otherwise, a
broadcast MCE observing CR4.MCE=0b on any core will shutdown the machine.

The option 'nosmt' has already complied with the above rule by Thomas's patch.
For detail, refer to 506a66f3748 (Revert "x86/apic: Ignore secondary threads if
nosmt=force")

But for nr_cpus option, the exposure to broadcast MCE is a little complicated,
and can be categorized into three cases.

-1. boot up by BIOS. Since no one set CR4.MCE=1, nr_cpus risks rebooting by
broadcast MCE.

-2. boot up by "kexec -p nr_cpus=".  Since the 1st kernel has all cpus'
CR4.MCE=1 set before kexec -p, nr_cpus is free of rebooting by broadcast MCE.
Furthermore, the crashed kernel's wreckage, including page table and text, is
not touched by capture kernel. Hence if MCE event happens on capped cpu,
do_machine_check->__mc_check_crashing_cpu() runs smoothly and returns
immediately, the capped cpu is still pinned on "halt".

-3. boot up by "kexec -l nr_cpus=". As "kexec -p", it is free of rebooting by
broadcast MCE. But the 1st kernel's wreckage is discarded and changed.  when
capped cpus execute do_machine_check(), they may crack the new kernel.  But
this is not related with broadcast MCE, and need an extra fix.

*** Solution ***
"nr_cpus" can not follow the same way as "nosmt".  Because nr_cpus limits the
allocation of percpu area and some other kthread memory, which is critical to
cpu hotplug framework.  Instead, developing a dedicated SIPI callback
make_capped_cpu_stable() for capped cpu, which does not lean on percpu area to
work.

[1]: https://lkml.org/lkml/2019/7/5/3

To: Gleixner <tglx@linutronix.de>
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
Pingfan Liu (4):
  x86/apic: correct the ENO in generic_processor_info()
  x86/apic: record capped cpu in generic_processor_info()
  x86/smp: send capped cpus to a stable state when smp_init()
  x86/smp: disallow MCE handler on rebooting AP

 arch/x86/include/asm/apic.h  |  1 +
 arch/x86/include/asm/smp.h   |  3 ++
 arch/x86/kernel/apic/apic.c  | 23 ++++++++----
 arch/x86/kernel/cpu/common.c |  7 ++++
 arch/x86/kernel/smp.c        |  8 +++++
 arch/x86/kernel/smpboot.c    | 83 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/smp.c                 |  6 ++++
 7 files changed, 124 insertions(+), 7 deletions(-)

-- 
2.7.5

