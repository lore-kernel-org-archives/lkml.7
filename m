Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93D7C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA1C208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561128106;
	bh=Zx8Cb3sL7YY/8HdLMmq9f5WsUHM/Py3MlcVld2ei5Jo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WvHLIU6f2kXB+FFpMLAcgnGpxbT6/eVZbKa7qU1v5VCBRGKY8k0+pyMjBa1gk3dQJ
	 7k7POSrgDQaGWkKmSpMixvwpJNOVQvJpUg0qT73NgWUXWqZRqc5BIt1JuwwjrIZ2QF
	 KQ3rg8714eximfUs3K6MkB3eRiW90uKPBYd87+Uc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfFUOlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:41:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbfFUOlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:41:44 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A2FF2089E;
        Fri, 21 Jun 2019 14:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561128104;
        bh=Zx8Cb3sL7YY/8HdLMmq9f5WsUHM/Py3MlcVld2ei5Jo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=z8vJLfX+AQ0JZQfXq307TNp2IDXglTStolUHvFcBpgj1DxYpi4qD386PJeQeLg4TN
         uND0xqA5PxXmC8Dtf8w1p0JZ6mGe+/8eVM/D6U797f+mt07uppsqnVP9Ly2cXalJGi
         hptA7WUg5PQJ2Vt63iDJpgVvfw67y8nb/MnSvsRw=
Date:   Fri, 21 Jun 2019 23:41:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/7] kprobes/ftrace: Use ftrace_location() when
 [dis]arming probes
Message-Id: <20190621234140.5604fcd4ae5260b1020deccb@kernel.org>
In-Reply-To: <4fedad69107b7fd81b9324315ce4fbf6287e5084.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
        <4fedad69107b7fd81b9324315ce4fbf6287e5084.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019 20:17:05 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Ftrace location could include more than a single instruction in case of
> some architectures (powerpc64, for now). In this case, kprobe is
> permitted on any of those instructions, and uses ftrace infrastructure
> for functioning.
> 
> However, [dis]arm_kprobe_ftrace() uses the kprobe address when setting
> up ftrace filter IP. This won't work if the address points to any
> instruction apart from the one that has a branch to _mcount(). To
> resolve this, have [dis]arm_kprobe_ftrace() use ftrace_function() to
> identify the filter IP.

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  kernel/kprobes.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 445337c107e0..282ee704e2d8 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -978,10 +978,10 @@ static int prepare_kprobe(struct kprobe *p)
>  /* Caller must lock kprobe_mutex */
>  static int arm_kprobe_ftrace(struct kprobe *p)
>  {
> +	unsigned long ftrace_ip = ftrace_location((unsigned long)p->addr);
>  	int ret = 0;
>  
> -	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
> -				   (unsigned long)p->addr, 0, 0);
> +	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops, ftrace_ip, 0, 0);
>  	if (ret) {
>  		pr_debug("Failed to arm kprobe-ftrace at %pS (%d)\n",
>  			 p->addr, ret);
> @@ -1005,13 +1005,14 @@ static int arm_kprobe_ftrace(struct kprobe *p)
>  	 * non-empty filter_hash for IPMODIFY ops, we're safe from an accidental
>  	 * empty filter_hash which would undesirably trace all functions.
>  	 */
> -	ftrace_set_filter_ip(&kprobe_ftrace_ops, (unsigned long)p->addr, 1, 0);
> +	ftrace_set_filter_ip(&kprobe_ftrace_ops, ftrace_ip, 1, 0);
>  	return ret;
>  }
>  
>  /* Caller must lock kprobe_mutex */
>  static int disarm_kprobe_ftrace(struct kprobe *p)
>  {
> +	unsigned long ftrace_ip = ftrace_location((unsigned long)p->addr);
>  	int ret = 0;
>  
>  	if (kprobe_ftrace_enabled == 1) {
> @@ -1022,8 +1023,7 @@ static int disarm_kprobe_ftrace(struct kprobe *p)
>  
>  	kprobe_ftrace_enabled--;
>  
> -	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
> -			   (unsigned long)p->addr, 1, 0);
> +	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops, ftrace_ip, 1, 0);
>  	WARN_ONCE(ret < 0, "Failed to disarm kprobe-ftrace at %pS (%d)\n",
>  		  p->addr, ret);
>  	return ret;
> -- 
> 2.22.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
