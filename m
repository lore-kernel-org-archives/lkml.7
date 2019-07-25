Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC88C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 00:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB42F21855
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 00:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564014735;
	bh=1mjgJzVFWoTFmtz+Kx3DxsVaXR0QOiC5wxT60be6Mig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=BkqaexD+fZ5uxIM8tLcUmzT/s1/92Rc3bk+baGK8hGirhWqhH53qI0gOByHvfQehp
	 0boiz4DC+k9t6iACOl1RJ+CUSrDZ28nS9mNe3w0DXy1Twtda4FZdj4Nb+NfMnXsFoU
	 mlbWSGnpbbeXY2sllJ1quacCFA1pkOt+4zTNqEGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfGYAcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 20:32:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfGYAcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 20:32:12 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA5BD21855;
        Thu, 25 Jul 2019 00:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564014731;
        bh=1mjgJzVFWoTFmtz+Kx3DxsVaXR0QOiC5wxT60be6Mig=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qx/pMKIWOm70Fp5OEaQP8a05ekhlUusjXCybkzUsEAOt7qojI8ewhEJZgh8UluQYF
         0aLorIkZKEpKHgBy9ynJSONokjpZr0ty0An1lhyqFyZNO9HVHPsglussnt1t6UY+GV
         CWwkncKQf6EbHM/CVvBHp0ybR17qrttA0ale+Vnw=
Date:   Thu, 25 Jul 2019 09:32:08 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: kprobes, livepatch and FTRACE_OPS_FL_IPMODIFY
Message-Id: <20190725093208.343db9d54f6a0f5abc99af7b@kernel.org>
In-Reply-To: <20190724151942.GA7205@redhat.com>
References: <20190724151942.GA7205@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2019 11:19:42 -0400
Joe Lawrence <joe.lawrence@redhat.com> wrote:

> Hi Masami,
> 
> I wanted to revisit FTRACE_OPS_FL_IPMODIFY blocking of kprobes and
> livepatch, at least in cases where kprobe pre_handlers don't modify
> regs->ip.

OK, now I think we can pass a flag to kprobe_register() to modify regs->ip
or not. Then we can introduce 2 different ftrace_ops for IPMODIFY
or just requires REGS.

> (We've discussed this previously at part of a kpatch github issue #47:
> https://github.com/dynup/kpatch/issues/47)
> 
> The particular use case I was wondering about was perf probing a
> particular function, then attempting to livepatch that same function:
> 
>   % uname -r
>   5.3.0-rc1+
> 
>   % dmesg -C
>   % perf probe --add cmdline_proc_show
>   Added new event:
>     probe:cmdline_proc_show (on cmdline_proc_show)
> 
>   You can now use it in all perf tools, such as:
> 
>           perf record -e probe:cmdline_proc_show -aR sleep 1
> 
>   % perf record -e probe:cmdline_proc_show -aR sleep 30 &
>   [1] 1007
>   % insmod samples/livepatch/livepatch-sample.ko
>   insmod: ERROR: could not insert module samples/livepatch/livepatch-sample.ko: Device or resource busy
>   % dmesg
>   [  440.913962] livepatch_sample: tainting kernel with TAINT_LIVEPATCH
>   [  440.917123] livepatch_sample: module verification failed: signature and/or required key missing - tainting kernel
>   [  440.942493] livepatch: enabling patch 'livepatch_sample'
>   [  440.943445] livepatch: failed to register ftrace handler for function 'cmdline_proc_show' (-16)
>   [  440.944576] livepatch: failed to patch object 'vmlinux'
>   [  440.945270] livepatch: failed to enable patch 'livepatch_sample'
>   [  440.946085] livepatch: 'livepatch_sample': unpatching complete
> 
> This same behavior holds in reverse, if we want to probe a livepatched
> function:
> 
>   % insmod samples/livepatch/livepatch-sample.ko
>   % perf probe --add cmdline_proc_show
>   Added new event:
>     probe:cmdline_proc_show (on cmdline_proc_show)
> 
>   You can now use it in all perf tools, such as:
> 
>           perf record -e probe:cmdline_proc_show -aR sleep 1
> 
>   % perf record -e probe:cmdline_proc_show -aR sleep 30
>   Error:
>   The sys_perf_event_open() syscall returned with 16 (Device or resource busy) for event (probe:cmdline_proc_show).
>   /bin/dmesg | grep -i perf may provide additional information.
> 
> 
> Now, if I read kernel/trace/trace_kprobe.c :: kprobe_dispatcher()
> correctly, it's only going to return !0 (indicating a modified regs->ip)
> when kprobe_perf_func() returns !0, i.e. regs->ip changes over a call to
> trace_call_bpf().
> 
> Aside: should kprobe_ftrace_handler() check that FTRACE_OPS_FL_IPMODIFY
> is set when a pre_handler returns !0?

NO, that flag has been shared among all ftrace-based kprobes, and checked
when registering. So what we need is to introduce a new kprobe flag which
states that this kprobe doesn't modify regs->ip. And kprobe prepare 2 ftrace_ops
1 is for IPMODIFY and 1 is for !IPMODIFY.


> 
> In kpatch #47, Josh suggested:
> 
> - If a kprobe handler needs to modify IP, user sets KPROBE_FLAG_IPMODIFY
>   flag to register_kprobe, and then kprobes sets FTRACE_OPS_FL_IPMODIFY
>   when registering with ftrace for that probe.
> 
> - If KPROBE_FLAG_IPMODIFY is not used, kprobe_ftrace_handler() can
>   detect when a kprobe handler changes regs->ip and restore it to its
>   original value (regs->ip = ip).
> 
> Is this something that could still be supported?  In cases like perf
> probe, could we get away with not setting FTRACE_OPS_FL_IPMODIFY?  The
> current way that we're applying that flag, kprobes and livepatch are
> mutually exclusive (for the same function).

It is not supported yet. But I can make it. wait a bit :)

Thank you,

> 
> Regards,
> 
> -- Joe


-- 
Masami Hiramatsu <mhiramat@kernel.org>
