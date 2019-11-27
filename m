Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A811DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 06:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7960020678
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 06:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574837351;
	bh=9ldrzBJmwO+Jph+4hUc2W8SiUAnvuynMDMoN792iorA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hJk1Xi7OpGCItQhtgTJN6chU60uCbOQRY5+CqWhxZxmZ4mtR7lcd9pnWZgfAj5bAq
	 NvlbyIh0oxwtuPZsD4efMoI/4ikOfyYzcx1jmgbl8igR4qY9k4ShCaYxpGcvqj2/k/
	 91G0jfCqFm2i9VTPUez1Ea8TAvw6nxeNS7YRmbec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfK0GtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 01:49:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42041 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfK0GtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 01:49:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id a15so25288834wrf.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 22:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d3gsKpaM9qDs52kNb00tNlXX2VGKZqjcpLMpQMfPMiU=;
        b=J4wCmVLPCrib5q3ZsmvcJakJnVZZJcQzpUAzK5n4v1D85yjW/7h8TXdffxDZ8Yx6sC
         1oWKD4IstJ18xRk/+zwGO/c+WORRvFhk8rrPKPCV+75snx9MXQiI4upVi+4M2cNTbt4i
         TL/7IBMqpU3uwkf6ppqN1gzDBY1pG/cwRjKC/WkSVZGekqFr9PahO6ulebUUGhfT+/bq
         M6hcvJW63gb1zS6Z5dpGv+djHIPRGqWaiWYjCKTB/SpNeLIlJJLKYF6v0na3Qpr3aazM
         SFtuBgtWlX6rrCRmLKl6Ouwndgogg1uD6tfytMsfB8hhdquzpNCBX+Q5G/LzW93HZhKJ
         RoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=d3gsKpaM9qDs52kNb00tNlXX2VGKZqjcpLMpQMfPMiU=;
        b=bu32WsqFZ62A4WHHGT+xU1CjFReP22Gz1Zmwmnu2k4chOJMwKYxjNK44mvtZi3/lPf
         s/BBcBTqLnAwYY7+7B7YnngnQyT2JH5qTkjOop60sC+7eG9ygOjJGtCzKaY3BD3fcVQO
         L2B/867cSA3iVbNQ3Ch/qZNXrVetHXMdbLiNffbBsrux3cmL8QD6p2wouDY1oqYMN41O
         +na6Bc8SCyeckvcGPR58DAinT8V/hSZI2KCOpWWJ/I1dtBhaR57zGTXMDnnU3lgcF9fG
         UTwoRPH79bcEtWlhuOu4MoYnlKCz358L5XIC8IjP8qnTNxtfm9kS/FTG2jOoh5ejvaOw
         9Reg==
X-Gm-Message-State: APjAAAVyTuCnpVe0aeS4PHsmyvGXaVS5DAtbj3eeNfhp8lKr3htUnd/a
        67OsFIpGM+hp94QZ8sVYwqwJVGUS
X-Google-Smtp-Source: APXvYqwgj0Xq8r9RwssGXQnkUFArcDuV8iZyRnyN7cvp9qdyYbgNpvneEE0n3vVMdpROrT2q7Xe51Q==
X-Received: by 2002:adf:f20f:: with SMTP id p15mr38233763wro.370.1574837346981;
        Tue, 26 Nov 2019 22:49:06 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id t187sm5622588wma.16.2019.11.26.22.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 22:49:06 -0800 (PST)
Date:   Wed, 27 Nov 2019 07:49:04 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, namit@vmware.com, hpa@zytor.com,
        luto@kernel.org, ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        jeyu@kernel.org
Subject: Re: [PATCH -tip 2/2] kprobes: Set unoptimized flag after
 unoptimizing code
Message-ID: <20191127064904.GA52731@gmail.com>
References: <157483420094.25881.9190014521050510942.stgit@devnote2>
 <157483422375.25881.13508326028469515760.stgit@devnote2>
 <20191127061910.nbfmzds4k5wxorwz@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127061910.nbfmzds4k5wxorwz@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Wed, Nov 27, 2019 at 02:57:04PM +0900, Masami Hiramatsu wrote:
> > Fix to set unoptimized flag after confirming the code is completely
> > unoptimized. Without this fix, when a kprobe hits the intermediate
> > modified instruction (the first byte is replaced by int3, but
> > latter bytes still be a jump address operand) while unoptimizing,
> > it can return to the middle byte of the modified code. And it causes
> > an invalid instruction exception in the kernel.
> > 
> > Usually, this is a rare case, but if we put a probe on the function
> > called while text patching, it always causes a kernel panic as below.
> > (text_poke() is used for patching the code in optprobe)
> > 
> >  # echo p text_poke+5 > kprobe_events
> >  # echo 1 > events/kprobes/enable
> >  # echo 0 > events/kprobes/enable
> >  invalid opcode: 0000 [#1] PREEMPT SMP PTI
> >  CPU: 7 PID: 137 Comm: kworker/7:1 Not tainted 5.4.0-rc8+ #29
> >  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> >  Workqueue: events kprobe_optimizer
> >  RIP: 0010:text_poke+0x9/0x50
> >  Code: 01 00 00 5b 5d 41 5c 41 5d c3 89 c0 0f b7 4c 02 fe 66 89 4c 05 fe e9 31 ff ff ff e8 71 ac 03 00 90 55 48 89 f5 53 cc 30 cb fd <1e> ec 08 8b 05 72 98 31 01 85 c0 75 11 48 83 c4 08 48 89 ee 48 89
> >  RSP: 0018:ffffc90000343df0 EFLAGS: 00010686
> >  RAX: 0000000000000000 RBX: ffffffff81025796 RCX: 0000000000000000
> >  RDX: 0000000000000004 RSI: ffff88807c983148 RDI: ffffffff81025796
> >  RBP: ffff88807c983148 R08: 0000000000000001 R09: 0000000000000000
> >  R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff82284fe0
> >  R13: ffff88807c983138 R14: ffffffff82284ff0 R15: 0ffff88807d9eee0
> >  FS:  0000000000000000(0000) GS:ffff88807d9c0000(0000) knlGS:0000000000000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 000000000058158b CR3: 000000007b372000 CR4: 00000000000006a0
> >  Call Trace:
> >   arch_unoptimize_kprobe+0x22/0x28
> >   arch_unoptimize_kprobes+0x39/0x87
> >   kprobe_optimizer+0x6e/0x290
> >   process_one_work+0x2a0/0x610
> >   worker_thread+0x28/0x3d0
> >   ? process_one_work+0x610/0x610
> >   kthread+0x10d/0x130
> >   ? kthread_park+0x80/0x80
> >   ret_from_fork+0x3a/0x50
> >  Modules linked in:
> >  ---[ end trace 83b34b22a228711b ]---
> > 
> > This can happen even if we blacklist text_poke() and other functions,
> > because there is a small time window which showing the intermediate
> > code to other CPUs.
> > 
> > Fixes: 6274de4984a6 ("kprobes: Support delayed unoptimizing")
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Awesome. It fixes the crash for me.
> Tested-by: Alexei Starovoitov <ast@kernel.org>

Thanks guys - I just pushed out a rebased tree, based on an upstream 
version that has both the BPF tree and most x86 trees merged, into 
tip:WIP.core/kprobes. This includes these two fixes as well.

Thanks,

	Ingo
