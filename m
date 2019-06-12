Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2040C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602E520874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560326395;
	bh=Pira0v0ul7UVM3qZDyFYVAAR7J0PTPWa45CPlZcjChE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mH5JL1jwH7JdfR18HguAGCf24LpOD1IaDySaXYR4DlJrlkDhvg1BkSabm4qdRcDf0
	 WDDByL61Br5WRcUxlsqXV4X6ym2hUA3UhCUsILsTLDqFEpsUTXRR9YE9TH+im4ixGz
	 +HTs+9yB7/qPxMk68w0+N0GJ9ePuhsr6ZxXMJF/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbfFLH7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 03:59:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfFLH7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:59:53 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2253020684;
        Wed, 12 Jun 2019 07:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560326393;
        bh=Pira0v0ul7UVM3qZDyFYVAAR7J0PTPWa45CPlZcjChE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rSYgpNa88LpUX7DREW9OmfEVBvQegl1m6j3eVb9d/Y6i5sDYKGEvg4juGZ+HRlBDf
         TiKZxJQ40ANrjXh/NZrGou9oK3Zk52d5Bfj6gr2QQEWUHcWkPhGrsjv8rb0io9KYie
         VvmsF2lY2wlRanaCKNUaebPH3FkKvQZION6pwCFM=
Date:   Wed, 12 Jun 2019 16:59:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: Fix to init kprobes in subsys_initcall
Message-Id: <20190612165947.ba696696dac0faa3aa35a501@kernel.org>
In-Reply-To: <155956708268.12228.10363800793132214198.stgit@devnote2>
References: <20190603214105.715a4072472ef4946123dc20@kernel.org>
        <155956708268.12228.10363800793132214198.stgit@devnote2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Could you pick this to your ftrace/core branch?

Thank you,


On Mon,  3 Jun 2019 22:04:42 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Since arm64 kernel initializes breakpoint trap vector in arch_initcall(),
> initializing kprobe (and run smoke test) in postcore_initcall() causes
> a kernel panic.
> 
> To fix this issue, move the kprobe initialization in subsys_initcall()
> (which is called right afer the arch_initcall).
> 
> In-kernel kprobe users (ftrace and bpf) are using fs_initcall() which is
> called after subsys_initcall(), so this shouldn't cause more problem.
> 
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Fixes: b5f8b32c93b2 ("kprobes: Initialize kprobes at postcore_initcall")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/kprobes.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 54aaaad00a47..5471efbeb937 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2289,7 +2289,7 @@ static int __init init_kprobes(void)
>  		init_test_probes();
>  	return err;
>  }
> -postcore_initcall(init_kprobes);
> +subsys_initcall(init_kprobes);
>  
>  #ifdef CONFIG_DEBUG_FS
>  static void report_probe(struct seq_file *pi, struct kprobe *p,
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
