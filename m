Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC4AC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A542F208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfF0N3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 09:29:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfF0N3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 09:29:05 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CF132083B;
        Thu, 27 Jun 2019 13:29:03 +0000 (UTC)
Date:   Thu, 27 Jun 2019 09:29:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] x86/ftrace: Fix use of flags in
 ftrace_replace_code()
Message-ID: <20190627092902.253971d2@gandalf.local.home>
In-Reply-To: <abc56ad177f370ec423edcfc538d35b418c1808e.1561634177.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1561634177.git.naveen.n.rao@linux.vnet.ibm.com>
        <abc56ad177f370ec423edcfc538d35b418c1808e.1561634177.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019 16:53:50 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> In commit a0572f687fb3c ("ftrace: Allow ftrace_replace_code() to be
> schedulable), the generic ftrace_replace_code() function was modified to
> accept a flags argument in place of a single 'enable' flag. However, the
> x86 version of this function was not updated. Fix the same.
> 
> Fixes: a0572f687fb3c ("ftrace: Allow ftrace_replace_code() to be schedulable")

I don't mind this change, but it's not a bug, and I'm not sure it
should have the fixes tag. The reason being, the
FTRACE_MODIFY_ENABLE_FL is only set when ftrace is called by with the
command flag FTRACE_MAY_SLEEP, which is never done on x86.

That said, I'm fine with the change as it makes it more robust, but by
adding the fixes tag, you're going to get this into all the stable
code, and I'm not sure that's really necessary.

-- Steve


> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  arch/x86/kernel/ftrace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> index 0927bb158ffc..f34005a17051 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -573,8 +573,9 @@ static void run_sync(void)
>  		local_irq_disable();
>  }
>  
> -void ftrace_replace_code(int enable)
> +void ftrace_replace_code(int mod_flags)
>  {
> +	int enable = mod_flags & FTRACE_MODIFY_ENABLE_FL;
>  	struct ftrace_rec_iter *iter;
>  	struct dyn_ftrace *rec;
>  	const char *report = "adding breakpoints";

