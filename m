Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B5FC606BF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB15216E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562598340;
	bh=edfd8gxt8OBtIc5W0aoP4KDd4QCIx+idpXQ+g1Hx0o8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=bpZyEZGUGy3NCBGVIZ0sjpqU1cfi6x2qKVhesBeZuPqKeCUPkY/p7Z8somaVZrQWn
	 RbxOBK7cYYyqtGTPfHKfMR1PGtbqba9u0GC+6NuOwqMkfhZfFVtyGRcbECdxjohmm3
	 K8WrE1xWSL3XG/ApX8MlePa7lQpUBhEJEizkF7KQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732111AbfGHPFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:05:39 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35273 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732090AbfGHPFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:05:35 -0400
Received: by mail-qk1-f193.google.com with SMTP id r21so13264936qke.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 08:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=20M7KDomLReO6Q78cKUuYTnw9RHJCW0JDgM2rMub9R0=;
        b=P924lFGZNuV/svf8YXzItmS/LAVxKLsBHau52bFCkGnCmNGGENEC5f0bQ7r0soGX78
         AYVgsxOnS4c+iZgFwmq2aJgOPR0aPZAtxZKVHRnvSC3mLhzAFx1YstHoeILVSmXiPKPO
         8+KqSdEOVfX+DnYb928MBF654w7F2EaqRLVAPyb31zKO0TbOCiwDH5abhLQirS0GsIad
         0LD+hJpMfvwxqVCde6JBe+jgftLKG687hJCkAMDaUd1WFgVQMi34JHP0a5oo7d0aXyDJ
         gB5C3Lbq5GL4mzHhzn4NETxjIbypfnyeajmE3EE1EVE1i27l6MUHVzIbcW9Wq9LcJhBl
         AUAg==
X-Gm-Message-State: APjAAAVqPjSOqM/XOQkXii7hnoRRjI0SpLVlzfHMl+C9s67RiZfex4YL
        EAPtvq5ia0sZNp6JndIMMLk=
X-Google-Smtp-Source: APXvYqzaXu29O4BsQ5xcZ0Kye2zBoQDtCA69U6z63UZcnxNvtOex5ISkiTcVAA6I8WS3glgv7KrIgQ==
X-Received: by 2002:a05:620a:68c:: with SMTP id f12mr14608641qkh.197.1562598334612;
        Mon, 08 Jul 2019 08:05:34 -0700 (PDT)
Received: from dennisz-mbp ([2620:10d:c091:500::3:8b5a])
        by smtp.gmail.com with ESMTPSA id g54sm8989306qtc.61.2019.07.08.08.05.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 08:05:33 -0700 (PDT)
Date:   Mon, 8 Jul 2019 11:05:32 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: kasan: paging percpu + kasan causes a double fault
Message-ID: <20190708150532.GB17098@dennisz-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey, Alexander, and Dmitry,

It was reported to me that when percpu is ran with param
percpu_alloc=page or the embed allocation scheme fails and falls back to
page that a double fault occurs.

I don't know much about how kasan works, but a difference between the
two is that we manually reserve vm area via vm_area_register_early().
I guessed it had something to do with the stack canary or the irq_stack,
and manually mapped the shadow vm area with kasan_add_zero_shadow(), but
that didn't seem to do the trick.

RIP resolves to the fixed_percpu_data declaration.

Double fault below:
[    0.000000] PANIC: double fault, error_code: 0x0
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.2.0-rc7-00007-ge0afe6d4d12c-dirty #299
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
[    0.000000] RIP: 0010:no_context+0x38/0x4b0
[    0.000000] Code: df 41 57 41 56 4c 8d bf 88 00 00 00 41 55 49 89 d5 41 54 49 89 f4 55 48 89 fd 4c8
[    0.000000] RSP: 0000:ffffc8ffffffff28 EFLAGS: 00010096
[    0.000000] RAX: dffffc0000000000 RBX: ffffc8ffffffff50 RCX: 000000000000000b
[    0.000000] RDX: fffff52000000030 RSI: 0000000000000003 RDI: ffffc90000000130
[    0.000000] RBP: ffffc900000000a8 R08: 0000000000000001 R09: 0000000000000000
[    0.000000] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
[    0.000000] R13: fffff52000000030 R14: 0000000000000000 R15: ffffc90000000130
[    0.000000] FS:  0000000000000000(0000) GS:ffffc90000000000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffffc8ffffffff18 CR3: 0000000002e0d001 CR4: 00000000000606b0
[    0.000000] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.000000] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.000000] Call Trace:
[    0.000000] Kernel panic - not syncing: Machine halted.
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.2.0-rc7-00007-ge0afe6d4d12c-dirty #299
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
[    0.000000] Call Trace:
[    0.000000]  <#DF>
[    0.000000]  dump_stack+0x5b/0x90
[    0.000000]  panic+0x17e/0x36e
[    0.000000]  ? __warn_printk+0xdb/0xdb
[    0.000000]  ? spurious_kernel_fault_check+0x1a/0x60
[    0.000000]  df_debug+0x2e/0x39
[    0.000000]  do_double_fault+0x89/0xb0
[    0.000000]  double_fault+0x1e/0x30
[    0.000000] RIP: 0010:no_context+0x38/0x4b0
[    0.000000] Code: df 41 57 41 56 4c 8d bf 88 00 00 00 41 55 49 89 d5 41 54 49 89 f4 55 48 89 fd 4c8
[    0.000000] RSP: 0000:ffffc8ffffffff28 EFLAGS: 00010096
[    0.000000] RAX: dffffc0000000000 RBX: ffffc8ffffffff50 RCX: 000000000000000b
[    0.000000] RDX: fffff52000000030 RSI: 0000000000000003 RDI: ffffc90000000130
[    0.000000] RBP: ffffc900000000a8 R08: 0000000000000001 R09: 0000000000000000
[    0.000000] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
[ 0.000000] R13: fffff52000000030 R14: 0000000000000000 R15: ffffc90000000130

Thanks,
Dennis
