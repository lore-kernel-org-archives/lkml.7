Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9ECC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 09:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08CC21900
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 09:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553334327;
	bh=qdOcipUroHZFD3vacwH0cgyvXy+P8C2hbDp/mb055nQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gc4qR8SeAKAkgD/ulG0G30ogTtHJHtgFOZO3xjHbJAlCntYM//q8oRIWRgAixu1nN
	 ma/aBWiALDnuVOpnqX9Ezf5lf7JNAIhvi3T4TBQ+AGZj4Q4BrE6lIm3MjqJQLqgxaA
	 XLR7Eh2iFUZVcdBkwGiVYfsBrbyEU+aoGV/yyS70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfCWJp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 05:45:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbfCWJp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 05:45:26 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34282218E2;
        Sat, 23 Mar 2019 09:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553334325;
        bh=qdOcipUroHZFD3vacwH0cgyvXy+P8C2hbDp/mb055nQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IgxzZk9Qe9jlXTcg3oMUrDG3+fpLVjjudffvV/jaR4XgJqEJGoyTYbgPRsnc8AzNH
         MTZwx6/5r9/BJuo0BaazQhiv6dYiK825++5o+ZDJNQLVZLzmbN7mq05mGHqXA41Lfd
         izMtei/7yzJQd+km5HX5915EHsNUFpGkkA28VrUc=
Date:   Sat, 23 Mar 2019 18:45:21 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     x86@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        mhiramat@kernel.org
Subject: Re: [PATCH 11/17] x86/kprobes: Make trampoline_handler global and
 visible
Message-Id: <20190323184521.a443cc741997cb0d3ed26395@kernel.org>
In-Reply-To: <20190321220009.29334-12-andi@firstfloor.org>
References: <20190321220009.29334-1-andi@firstfloor.org>
        <20190321220009.29334-12-andi@firstfloor.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 15:00:03 -0700
Andi Kleen <andi@firstfloor.org> wrote:

> From: Andi Kleen <ak@linux.intel.com>
> 
> This function is referenced from assembler, so in LTO
> it needs to be global and visible to not be optimized away.
> 

I got it.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Andi, out of curiousity, that is not only for x86, but
does all arch have to care it?

Thank you,

> Cc: mhiramat@kernel.org
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  arch/x86/kernel/kprobes/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 31ab91c9c4e9..1309a4eb3119 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -752,7 +752,7 @@ STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
>  /*
>   * Called from kretprobe_trampoline
>   */
> -static __used void *trampoline_handler(struct pt_regs *regs)
> +__used __visible void *trampoline_handler(struct pt_regs *regs)
>  {
>  	struct kretprobe_instance *ri = NULL;
>  	struct hlist_head *head, empty_rp;
> -- 
> 2.20.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
