Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C027EC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BFCC24A11
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfFDJGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 05:06:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbfFDJGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:06:36 -0400
Received: from oasis.local.home (unknown [146.247.46.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C2EE24ABF;
        Tue,  4 Jun 2019 09:06:34 +0000 (UTC)
Date:   Tue, 4 Jun 2019 05:06:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: Fix to init kprobes in subsys_initcall
Message-ID: <20190604050629.11c7ef12@oasis.local.home>
In-Reply-To: <155956708268.12228.10363800793132214198.stgit@devnote2>
References: <20190603214105.715a4072472ef4946123dc20@kernel.org>
        <155956708268.12228.10363800793132214198.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Hi Masami,

Is this really a fix, or is this just needed to add kprobes to the command line?

-- Steve


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

