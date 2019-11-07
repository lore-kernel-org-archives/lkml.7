Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D22BC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B73021D7B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573129291;
	bh=/CBNPYIW3GnfP7g0URGAIYD+PsjlBoE9nX4fBO1Dw2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0TNUUKaNd4Pf2cctfzQRb2Dnw0/n1uZRWtz1fKlwBhCuN4AWHDvWP9euOjEe/SsuH
	 ePRtT5hsdlOfH3zqmxhtQ5TmxvmXjdeJD/sb7zx96KA3bhokoY3xiQYaF1KtgVgQGz
	 pgV8PatgMtLIQorLYNEzAYThakKCJDf02tEKulHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388621AbfKGMVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 07:21:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:36880 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388407AbfKGMV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:21:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 21757B24A;
        Thu,  7 Nov 2019 12:21:26 +0000 (UTC)
Date:   Thu, 7 Nov 2019 13:21:25 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] mm: memcg: switch to css_tryget() in
 get_mem_cgroup_from_mm()
Message-ID: <20191107122125.GS8314@dhcp22.suse.cz>
References: <20191106225131.3543616-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106225131.3543616-1-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06-11-19 14:51:30, Roman Gushchin wrote:
> We've encountered a rcu stall in get_mem_cgroup_from_mm():
> 
>  rcu: INFO: rcu_sched self-detected stall on CPU
>  rcu: 33-....: (21000 ticks this GP) idle=6c6/1/0x4000000000000002 softirq=35441/35441 fqs=5017
>  (t=21031 jiffies g=324821 q=95837) NMI backtrace for cpu 33
>  <...>
>  RIP: 0010:get_mem_cgroup_from_mm+0x2f/0x90
>  <...>
>  __memcg_kmem_charge+0x55/0x140
>  __alloc_pages_nodemask+0x267/0x320
>  pipe_write+0x1ad/0x400
>  new_sync_write+0x127/0x1c0
>  __kernel_write+0x4f/0xf0
>  dump_emit+0x91/0xc0
>  writenote+0xa0/0xc0
>  elf_core_dump+0x11af/0x1430
>  do_coredump+0xc65/0xee0
>  ? unix_stream_sendmsg+0x37d/0x3b0
>  get_signal+0x132/0x7c0
>  do_signal+0x36/0x640
>  ? recalc_sigpending+0x17/0x50
>  exit_to_usermode_loop+0x61/0xd0
>  do_syscall_64+0xd4/0x100
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> The problem is caused by an exiting task which is associated with
> an offline memcg.

Hmm, how can we have a task in an offline memcg? I thought that any
existing task will prevent cgroup removal from proceeding. Is this some
sort of race where the task managed to disassociate from the cgroup
while there is still a binding to a memcg existing? What am I missing?

-- 
Michal Hocko
SUSE Labs
