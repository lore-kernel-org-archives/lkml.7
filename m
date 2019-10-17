Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441AAFA372B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1086F20872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xp7T+boU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pG3iCBce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407850AbfJQGyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 02:54:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44394 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407840AbfJQGyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 02:54:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1A93460923; Thu, 17 Oct 2019 06:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571295242;
        bh=TUEyRIXpBOcNh80ePunfHerPi1V0e5HVNw4VrDuB7WQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Xp7T+boUd25xvhCmdRyV2HRKBzwlkHjGQ9GjBs1kZdoPNwD6IYp7cJv4dF1oF0Te7
         e+xNUOrC/0LLdyeOfGY8xKKiHFQnMZfQJmQ4WCokqNGdEah++iaELIp4ql+x0IBi5O
         tXHKP8G94NIFG7KdmdzhTicVAGSVLmsrlTtwGNxQ=
Received: from [10.204.79.19] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: prsood@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 16E986081E;
        Thu, 17 Oct 2019 06:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571295240;
        bh=TUEyRIXpBOcNh80ePunfHerPi1V0e5HVNw4VrDuB7WQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pG3iCBcev0ylRacADOpGZsvDpwWDBJxr3MOnNuSIIu4kXpBro4XxNtlH5t6h3pFPk
         X7NzV2ZVvn6B+zUUpduW2yE1fF00qUrB7cTwDsvubcnXkfKr7/bRagT54Bkn3ueel/
         SRVhTbaxX1xNQhgGtVotdbgx2v1U3QPNAf1dTXIg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 16E986081E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=prsood@codeaurora.org
Subject: Re: [PATCH] trace: fix race in perf_trace_buf initialization
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, kaushalk@codeaurora.org
References: <1571120245-4186-1-git-send-email-prsood@codeaurora.org>
From:   Prateek Sood <prsood@codeaurora.org>
Message-ID: <cba8fc4b-b048-b59b-d21a-050027f17f5c@codeaurora.org>
Date:   Thu, 17 Oct 2019 12:23:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1571120245-4186-1-git-send-email-prsood@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/19 11:47 AM, Prateek Sood wrote:
> [  943.034988] Unable to handle kernel paging request at virtual address 0000003106f2003c
> [  943.043653] Mem abort info:
> [  943.046679]   ESR = 0x96000045
> [  943.050428]   Exception class = DABT (current EL), IL = 32 bits
> [  943.056643]   SET = 0, FnV = 0
> [  943.060168]   EA = 0, S1PTW = 0
> [  943.063449] Data abort info:
> [  943.066474]   ISV = 0, ISS = 0x00000045
> [  943.070856]   CM = 0, WnR = 1
> [  943.074016] user pgtable: 4k pages, 39-bit VAs, pgdp = ffffffc034b9b000
> [  943.081446] [0000003106f2003c] pgd=0000000000000000, pud=0000000000000000
> [  943.088862] Internal error: Oops: 96000045 [#1] PREEMPT SMP
> [  943.141700] Process syz-executor (pid: 18393, stack limit = 0xffffffc093190000)
> [  943.164146] pstate: 80400005 (Nzcv daif +PAN -UAO)
> [  943.169119] pc : __memset+0x20/0x1ac
> [  943.172831] lr : memset+0x3c/0x50
> [  943.176269] sp : ffffffc09319fc50
> 
> [  943.557593]  __memset+0x20/0x1ac
> [  943.560953]  perf_trace_buf_alloc+0x140/0x1a0
> [  943.565472]  perf_trace_sys_enter+0x158/0x310
> [  943.569985]  syscall_trace_enter+0x348/0x7c0
> [  943.574413]  el0_svc_common+0x11c/0x368
> [  943.578394]  el0_svc_handler+0x12c/0x198
> [  943.582459]  el0_svc+0x8/0xc
> 
> In Ramdumps:
> total_ref_count = 3
> perf_trace_buf = (
>     0x0 -> NULL,
>     0x0 -> NULL,
>     0x0 -> NULL,
>     0x0 -> NULL)
> 
> event_call in perf_trace_sys_enter()
> event_call = 0xFFFFFF900CB511D8 -> (
>     list = (next = 0xFFFFFF900CB4E2E0, prev = 0xFFFFFF900CB512B0),
>     class = 0xFFFFFF900CDC8308,
>     name = 0xFFFFFF900CDDA1D8,
>     tp = 0xFFFFFF900CDDA1D8,
>     event = (
>       node = (next = 0x0, pprev = 0xFFFFFF900CB80210),
>       list = (next = 0xFFFFFF900CB512E0, prev = 0xFFFFFF900CB4E310),
>       type = 21,
>       funcs = 0xFFFFFF900CB51130),
>     print_fmt = 0xFFFFFF900CB51150,
>     filter = 0x0,
>     mod = 0x0,
>     data = 0x0,
>     flags = 18,
>     perf_refcount = 1,
>     perf_events = 0xFFFFFF8DB8E54158,
>     prog_array = 0x0,
>     perf_perm = 0x0)
> 
> perf_events added on CPU0
> (struct hlist_head *)(0xFFFFFF8DB8E54158+__per_cpu_offset[0]) -> (
>     first = 0xFFFFFFC0980FD0E0 -> (
>       next = 0x0,
>       pprev = 0xFFFFFFBEBFD74158))
> 
> Could you please confirm:
> 1) the race mentioned below exists or not.
> 2) if following patch fixes it.
> 
> 
>> 8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8
> 
> A race condition exists while initialiazing perf_trace_buf from
> perf_trace_init() and perf_kprobe_init().
> 
>       CPU0                                        CPU1
> perf_trace_init()
>   mutex_lock(&event_mutex)
>     perf_trace_event_init()
>       perf_trace_event_reg()
>         total_ref_count == 0
> 	buf = alloc_percpu()
>         perf_trace_buf[i] = buf
>         tp_event->class->reg() //fails       perf_kprobe_init()
> 	goto fail                              perf_trace_event_init()
>                                                  perf_trace_event_reg()
>         fail:
> 	  total_ref_count == 0
> 
>                                                    total_ref_count == 0
>                                                    buf = alloc_percpu()
>                                                    perf_trace_buf[i] = buf
>                                                    tp_event->class->reg()
>                                                    total_ref_count++
> 
>           free_percpu(perf_trace_buf[i])
>           perf_trace_buf[i] = NULL
> 
> Any subsequent call to perf_trace_event_reg() will observe total_ref_count > 0,
> causing the perf_trace_buf to be NULL always. This can result in perf_trace_buf
> getting accessed from perf_trace_buf_alloc() without being initialized. Acquiring
> event_mutex in perf_kprobe_init() before calling perf_trace_event_init() should
> fix this race.
> 
> Signed-off-by: Prateek Sood <prsood@codeaurora.org>
> ---
>  kernel/trace/trace_event_perf.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
> index 4629a61..48ee92c 100644
> --- a/kernel/trace/trace_event_perf.c
> +++ b/kernel/trace/trace_event_perf.c
> @@ -272,9 +272,11 @@ int perf_kprobe_init(struct perf_event *p_event, bool is_retprobe)
>  		goto out;
>  	}
>  
> +	mutex_lock(&event_mutex);
>  	ret = perf_trace_event_init(tp_event, p_event);
>  	if (ret)
>  		destroy_local_trace_kprobe(tp_event);
> +	mutex_unlock(&event_mutex);
>  out:
>  	kfree(func);
>  	return ret;
> @@ -282,8 +284,10 @@ int perf_kprobe_init(struct perf_event *p_event, bool is_retprobe)
>  
>  void perf_kprobe_destroy(struct perf_event *p_event)
>  {
> +	mutex_lock(&event_mutex);
>  	perf_trace_event_close(p_event);
>  	perf_trace_event_unreg(p_event);
> +	mutex_unlock(&event_mutex);
>  
>  	destroy_local_trace_kprobe(p_event->tp_event);
>  }
> 

Folks, 

Could you please help with this query/patch?


Thanks

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
