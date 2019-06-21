Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169D1C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB3121537
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561126955;
	bh=4IkqAOqT0zuSMeh/3c4/6vzmwnG02ofkxfCVizW9ijs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gMHGW4IpblfldBWl7A2CI8r8mTK2YuV0ivOkjT4A/N4jyCI5ZReeEJCrVWYZcb8Qx
	 vHRvR+5Hw/G8dBiKkpbvTqG2v06ITiiT/Jc+I13Sm7u1cm4bpx2rCyVuxiUyW7w84r
	 ybFc39A7c4vIH7yjO19v+GhR1PCJuV3T3b+9Ns64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfFUOWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:22:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFUOWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:22:34 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1707206B7;
        Fri, 21 Jun 2019 14:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561126953;
        bh=4IkqAOqT0zuSMeh/3c4/6vzmwnG02ofkxfCVizW9ijs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BPTDbC7ngN+CpwQfUzE0r+b1tBpCeUldP1Pzj2Ch4HvUf+25FLweg32H7H5So/7Pj
         FcoGxR7pSjRLqNpdzYZhsIcXwI0vG0Y08AiKkpOEHj98rT9yVbOHUZ17EiORHjhkDF
         NR+XzLgBjtX1Ounqn3T6hfIwY6K0l6wQtpip49t8=
Date:   Fri, 21 Jun 2019 23:22:29 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Eiichi Tsukata <devel@etsukata.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, srikar@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing/uprobe: Fix NULL pointer dereference in
 trace_uprobe_create()
Message-Id: <20190621232229.9c488ee5ea260ea9bcc85a53@kernel.org>
In-Reply-To: <20190614074026.8045-1-devel@etsukata.com>
References: <20190614074026.8045-1-devel@etsukata.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2019 16:40:25 +0900
Eiichi Tsukata <devel@etsukata.com> wrote:

> Just like the case of commit 8b05a3a7503c ("tracing/kprobes: Fix NULL
> pointer dereference in trace_kprobe_create()"), writing an incorrectly
> formatted string to uprobe_events can trigger NULL pointer dereference.
> 
> Reporeducer:
> 
>   # echo r > /sys/kernel/debug/tracing/uprobe_events
> 
> dmesg:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 8000000079d12067 P4D 8000000079d12067 PUD 7b7ab067 PMD 0
>   Oops: 0000 [#1] PREEMPT SMP PTI
>   CPU: 0 PID: 1903 Comm: bash Not tainted 5.2.0-rc3+ #15
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-2.fc30 04/01/2014
>   RIP: 0010:strchr+0x0/0x30
>   Code: c0 eb 0d 84 c9 74 18 48 83 c0 01 48 39 d0 74 0f 0f b6 0c 07 3a 0c 06 74 ea 19 c0 83 c8 01 c3 31 c0 c3 0f 1f 84 00 00 00 00 00 <0f> b6 07 89 f2 40 38 f0 75 0e eb 13 0f b6 47 01 48 83 c
>   RSP: 0018:ffffb55fc0403d10 EFLAGS: 00010293
> 
>   RAX: ffff993ffb793400 RBX: 0000000000000000 RCX: ffffffffa4852625
>   RDX: 0000000000000000 RSI: 000000000000002f RDI: 0000000000000000
>   RBP: ffffb55fc0403dd0 R08: ffff993ffb793400 R09: 0000000000000000
>   R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>   R13: ffff993ff9cc1668 R14: 0000000000000001 R15: 0000000000000000
>   FS:  00007f30c5147700(0000) GS:ffff993ffda00000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000000 CR3: 000000007b628000 CR4: 00000000000006f0
>   Call Trace:
>    trace_uprobe_create+0xe6/0xb10
>    ? __kmalloc_track_caller+0xe6/0x1c0
>    ? __kmalloc+0xf0/0x1d0
>    ? trace_uprobe_create+0xb10/0xb10
>    create_or_delete_trace_uprobe+0x35/0x90
>    ? trace_uprobe_create+0xb10/0xb10
>    trace_run_command+0x9c/0xb0
>    trace_parse_run_command+0xf9/0x1eb
>    ? probes_open+0x80/0x80
>    __vfs_write+0x43/0x90
>    vfs_write+0x14a/0x2a0
>    ksys_write+0xa2/0x170
>    do_syscall_64+0x7f/0x200
>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Fixes: 0597c49c69d5 ("tracing/uprobes: Use dyn_event framework for uprobe events")
> Signed-off-by: Eiichi Tsukata <devel@etsukata.com>

Sorry, I missed this fix.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Steve, could you pick this as an urgent fix?

Thank you!

> ---
>  kernel/trace/trace_uprobe.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 0d60d6856de5..7dc8ee55cf84 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -443,10 +443,17 @@ static int trace_uprobe_create(int argc, const char **argv)
>  	ret = 0;
>  	ref_ctr_offset = 0;
>  
> -	/* argc must be >= 1 */
> -	if (argv[0][0] == 'r')
> +	switch (argv[0][0]) {
> +	case 'r':
>  		is_return = true;
> -	else if (argv[0][0] != 'p' || argc < 2)
> +		break;
> +	case 'p':
> +		break;
> +	default:
> +		return -ECANCELED;
> +	}
> +
> +	if (argc < 2)
>  		return -ECANCELED;
>  
>  	if (argv[0][1] == ':')
> -- 
> 2.21.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
