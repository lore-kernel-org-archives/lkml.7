Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3171C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC6020B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxUvV3Qx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfHEI7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 04:59:39 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46631 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEI7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 04:59:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id c2so36184809plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 01:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3ZX7vMu/4NbD1ABzKMngh4re81+FpB5xERWJgyHbVpA=;
        b=qxUvV3QxBX8svEaYjw4uGCTkZAUZViNO79y/2mxpYwa5a4wMBOziU41n3j9Zd++oN3
         0xN8Y+2fVxlsQBEsilV0bbIyJumft7XBTf9ynzyJVF9R8dUxu5yiArMBNg5zF/D1RmBC
         Nt4kxOwUDXZlVDtyDG5cXktlF4rgBJGqV07rnIyxoIHYBRa3eCcMxOPLurY4HlLNMn1+
         cV6z5ZuDlPUENxt8OeYwMYnuZpUIjqttP5PvlNZuNLfuGjrkpv5kNjeLM7v37oMBQcUp
         8NpS8j41QbWgIPwAADCMiBvCUcnOce1Cr/knnB6EjNrutyNDsHJZXaOFTIr3cAMS9hXj
         CNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3ZX7vMu/4NbD1ABzKMngh4re81+FpB5xERWJgyHbVpA=;
        b=dZg6qMHzkh83s8Eulya8OUspvperBSbgiCHfKzMxOkGVRxkHQrdt5ggWR/o+K8LBOK
         ubGdtv/Y/h8vZUOr3Nzn+SZrk49q9wFOQCyix8NvlCd96OWxHLes82z4UqKgXCQVd129
         AF+1H8ixCk6u7nD7o1dhbowqrFTdJeqcosjohsQPF/CPyqogWcyoG/mK/BgDPyP3d/jR
         3ieE+FkPaY+RVmMjf0HFgscGHkCcCseOQlQFa0El6oR5hDQHHUiWSrpjf6xgKvzZKBZw
         JSFubzWAYfM8mqnwoZmJR7D+9wRsej/E2yCNw29EN/2jX/h7DD6LRLRXFI6xGMrVNm1V
         8nnw==
X-Gm-Message-State: APjAAAUgOxwJOYlfIJsxfKQLl0E4/a7bHT6gd6npIE7odvS9WpeXTfqr
        om0kFBqAqu9agChdbjDmwQ==
X-Google-Smtp-Source: APXvYqy0sG3lsYbbHwd1UmpEYgnFYUP/xKZqbbxvjZkLLOV/uTzAibj1YOk5b2sAi60Lw22BcAeDQw==
X-Received: by 2002:a17:902:7d8b:: with SMTP id a11mr89435992plm.306.1564995578334;
        Mon, 05 Aug 2019 01:59:38 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v184sm82428375pfb.82.2019.08.05.01.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 01:59:37 -0700 (PDT)
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
Subject: [PATCH 0/4] x86/mce: protect nr_cpus from rebooting by broadcast mce
Date:   Mon,  5 Aug 2019 16:58:55 +0800
Message-Id: <1564995539-29609-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

