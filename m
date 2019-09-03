Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E47AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D51B23711
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="ESXVtTHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbfICO1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:27:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35992 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbfICO1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:27:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id p13so18564415wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 07:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ztizy0u6H258Ae8Jp90WnU8QSxT6Zt2zjZWBgoNCqd4=;
        b=ESXVtTHUIucPYUIW1KPWDFAOdL8m9NXsKyjVChp9ailvsURMWpL7cAjJpYWKtpfyjo
         aTUNFlhzx6/Uq94sFsvnuBW77/sqooIEgBNaNA4TsxyKcHoNmQS0YMQyxnbuPyrmZOPR
         cpErI4PE/vbSEEH5mbgzmNSiX7hRQGC7xEm+EbJGk1tC92VvuI0loiD31fgwhPjboX3a
         qJo6ZVACakyH82ZNpOAXG9DIdiVdv3mn9Fsm73/XCSgMszSoIvOySfYbCxJC3P+zXxzo
         OKGPDAeu/vXEfiXZ6b7vjDUb+xgQ9uLTU9sZSBed+ptPt9/IqNFyFw/YCSGsthvlUds+
         xeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ztizy0u6H258Ae8Jp90WnU8QSxT6Zt2zjZWBgoNCqd4=;
        b=bu6X7HE6qjZoe9mgOesm13Yi6igf1fUcjoG99g3DpPt+Db25chEAb+op/YSbru9qHx
         YeVBwo/L3qqrPWPAkwmiitFwIJy197lNROy2BMEsMHt0euzHpBohJHYPc4rob2BJKO5i
         gLe6rkdqgUoe5eV8MiVj2vU696lm9ntq6BdDuMn4kr4UfDrdk3047jQdhfYbk4TRB+8s
         dKzFLjd2SKd2DVAPrUMYPOfTNeEKVIX47mzOPgd98pZaQ6GeYb0fjJov8MwxWrGr72hG
         NQ/INjhRcI/XLaWWNSNQuAqT6FJqJ4MGqjwJntmg+fk+ZSwWibjxM864TjI6klHN8/I0
         x5bQ==
X-Gm-Message-State: APjAAAXfT3xeVe+MZqXc8ZmD3667KXdLpxmngnrjo1q7TGs0ZO2sX6Gh
        VdfmshKKJ7WoUN5qeL/In4Gcsw==
X-Google-Smtp-Source: APXvYqxwSZ6oVFY6ZQ+MXwrwDJGE2SrgSvya83qum4+mf2S+HXiY1Ja9udjVszHndrpe58MWjHIOPw==
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr355823wmj.73.1567520855044;
        Tue, 03 Sep 2019 07:27:35 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e751:37a0:1e95:e65d])
        by smtp.gmail.com with ESMTPSA id n1sm862908wrg.67.2019.09.03.07.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 07:27:34 -0700 (PDT)
Date:   Tue, 3 Sep 2019 15:27:32 +0100
From:   Alessio Balsini <balsini@android.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        luca.abeni@santannapisa.it, bristot@redhat.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
Subject: Re: [RFC][PATCH 00/13] SCHED_DEADLINE server infrastructure
Message-ID: <20190903142732.GA35593@google.com>
References: <20190726145409.947503076@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726145409.947503076@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

While testing your series (peterz/sched/wip-deadline 7a9e91d3fe951), I ended up
in a panic at boot on a x86_64 kvm guest, would you please have a look?  Here
attached the backtrace.
Happy to test any suggestion that fixes the issue.

Thanks,
Alessio
---
------>8------
[    0.798326] ------------[ cut here ]------------       
[    0.798328] kernel BUG at kernel/sched/deadline.c:1542!            
[    0.798335] invalid opcode: 0000 [#1] SMP PTI                                  
[    0.798339] CPU: 4 PID: 0 Comm: swapper/4 Not tainted 5.3.0-rc6+ #28
[    0.798340] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[    0.798349] RIP: 0010:enqueue_dl_entity+0x3f8/0x440
[    0.798351] Code: ff 48 8b 85 60 0a 00 00 8b 48 28 85 c9 0f 85 99 fd ff ff c7 40 28 01 00 00 00 e9 8d fd ff ff 85 c0 75 20 f                                                                                                                             
[    0.798353] RSP: 0000:ffffb68e40154f10 EFLAGS: 00010096
[    0.798356] RAX: 0000000000000020 RBX: ffff974bc74d0c00 RCX: ffff974bc751b200
[    0.798358] RDX: 0000000000000001 RSI: ffff974bc7929410 RDI: ffff974bc7929410
[    0.798359] RBP: 0000000000000009 R08: 00000000a73eb274 R09: 00000000000f4887
[    0.798361] R10: 0000000000000000 R11: 0000000000000000 R12: ffff974bc74d0c80
[    0.798362] R13: 0000000000000000 R14: ffff974bc74d0d00 R15: 0000000000000000
[    0.798365] FS:  0000000000000000(0000) GS:ffff974bc7900000(0000) knlGS:0000000000000000
[    0.798371] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 
[    0.798372] CR2: 00000000ffffffff CR3: 000000000480a000 CR4: 00000000000006e0
[    0.798374] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.798375] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.798376] Call Trace:                       
[    0.798397]  <IRQ>                                                
[    0.798402]  enqueue_task_fair+0xe69/0x11d0   
[    0.798407]  activate_task+0x58/0x90                                
[    0.798412]  ? kvm_sched_clock_read+0xd/0x20              
[    0.798416]  ttwu_do_activate.isra.96+0x3a/0x50                 
[    0.798420]  sched_ttwu_pending+0x5e/0x90                                              
[    0.798424]  scheduler_ipi+0x9f/0x120               
[    0.798430]  reschedule_interrupt+0xf/0x20           
[    0.798432]  </IRQ>                                                                           
[    0.798436] RIP: 0010:default_idle+0x20/0x140   
[    0.798438] Code: 90 90 90 90 90 90 90 90 90 90 41 55 41 54 55 65 8b 2d f4 40 d7 70 53 0f 1f 44 00 00 e9 07 00 00 00 0f 00 5                                                                                                                             
[    0.798440] RSP: 0000:ffffb68e40083ec0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff02
[    0.798442] RAX: ffffffff8f29c250 RBX: 0000000000000004 RCX: ffff974bc7916000               
[    0.798444] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff974bc791ca80
[    0.798445] RBP: 0000000000000004 R08: 000000009d74022b R09: 0000004d7ebb5820
[    0.798447] R10: 0000000000000400 R11: 0000000000000400 R12: 0000000000000000
[    0.798448] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    0.798451]  ? __cpuidle_text_start+0x8/0x8 
[    0.798455]  do_idle+0x19e/0x210              
[    0.798458]  cpu_startup_entry+0x14/0x20
[    0.798464]  start_secondary+0x144/0x170                       
[    0.798467]  secondary_startup_64+0xa4/0xb0   
[    0.798469] Modules linked in:              
[    0.798478] ---[ end trace c2be7729c78a55ad ]---
[    0.798482] RIP: 0010:enqueue_dl_entity+0x3f8/0x440                                   
[    0.798484] Code: ff 48 8b 85 60 0a 00 00 8b 48 28 85 c9 0f 85 99 fd ff ff c7 40 28 01 00 00 00 e9 8d fd ff ff 85 c0 75 20 f                                                                                                                             
[    0.798485] RSP: 0000:ffffb68e40154f10 EFLAGS: 00010096
[    0.798487] RAX: 0000000000000020 RBX: ffff974bc74d0c00 RCX: ffff974bc751b200
[    0.798489] RDX: 0000000000000001 RSI: ffff974bc7929410 RDI: ffff974bc7929410
[    0.798490] RBP: 0000000000000009 R08: 00000000a73eb274 R09: 00000000000f4887
[    0.798491] R10: 0000000000000000 R11: 0000000000000000 R12: ffff974bc74d0c80
[    0.798493] R13: 0000000000000000 R14: ffff974bc74d0d00 R15: 0000000000000000
[    0.798495] FS:  0000000000000000(0000) GS:ffff974bc7900000(0000) knlGS:0000000000000000
[    0.798500] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.798501] CR2: 00000000ffffffff CR3: 000000000480a000 CR4: 00000000000006e0
[    0.798502] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.798504] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.798505] Kernel panic - not syncing: Fatal exception in interrupt
[    0.799522] Kernel Offset: 0xd800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[    0.875144] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
------8<------

