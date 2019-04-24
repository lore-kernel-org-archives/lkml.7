Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F85C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764092084F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556102466;
	bh=F3A71PrMdLdNdQbOEHMWMx2WAB5ZlMboAMxAGcWPPms=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=FmBshi82PanOqd93VDzWIR4ICFGwcddy9q0UlER5djliS3mbug5atuJv89L7WBmd0
	 2VbD/Rj8h/UWQxfx+csw8MwHyhTH/Eodmz628pyvOimkfEhwVEZe5z17/1yla4Ewwp
	 RBK/Fqq5h/C7mWL6vbMdTBPrnAzppFM7fug46cx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfDXKlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:41:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfDXKlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:41:05 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3CD62084F;
        Wed, 24 Apr 2019 10:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556102464;
        bh=F3A71PrMdLdNdQbOEHMWMx2WAB5ZlMboAMxAGcWPPms=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=m/dNok4jUlWbd9Iq9jF0Vs+HcWQNHf7eUYWPd3IhDapP923nE/2AbVeMKMVmhjD7T
         IZboCOgXkCyFMfYXL68Ve7U6MrYO7Hm0lAt9KcajgAbbo/h5DpS++buY2XQYVqgn/A
         gim06cvPhpQhr8AHPXhd2agwt0cy6+iz23eOzRqM=
Date:   Wed, 24 Apr 2019 12:41:00 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] livepatch: Cleanup message handling in
 klp_try_switch_task()
In-Reply-To: <20190424085550.29612-4-pmladek@suse.com>
Message-ID: <nycvar.YFH.7.76.1904241239260.9803@cbobk.fhfr.pm>
References: <20190424085550.29612-1-pmladek@suse.com> <20190424085550.29612-4-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019, Petr Mladek wrote:

> WARN_ON_ONCE() could not be called safely under rq lock because
> of console deadlock issues. Fortunately, simple printk_deferred()
> is enough because the warning is printed from a well defined
> location and context.
> 
> Also klp_try_switch_task() is called under klp_mutex.
> Therefore, the buffer for debug messages could be static.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/livepatch/transition.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> index 9c89ae8b337a..e8183d18227f 100644
> --- a/kernel/livepatch/transition.c
> +++ b/kernel/livepatch/transition.c
> @@ -254,6 +254,7 @@ static int klp_check_stack_func(struct klp_func *func,
>  static int klp_check_stack(struct task_struct *task, char *err_buf)
>  {
>  	static unsigned long entries[MAX_STACK_ENTRIES];
> +	static int enosys_warned;
>  	struct stack_trace trace;
>  	struct klp_object *obj;
>  	struct klp_func *func;
> @@ -263,8 +264,16 @@ static int klp_check_stack(struct task_struct *task, char *err_buf)
>  	trace.nr_entries = 0;
>  	trace.max_entries = MAX_STACK_ENTRIES;
>  	trace.entries = entries;
> +
>  	ret = save_stack_trace_tsk_reliable(task, &trace);
> -	WARN_ON_ONCE(ret == -ENOSYS);
> +	if (ret == -ENOSYS) {
> +		if (!enosys_warned) {
> +			printk_deferred(KERN_WARNING "%s: save_stack_trace_tsk_reliable() not supported on this architecture.\n",
> +					__func__);
> +			enosys_warned = 1;

... abusing the fact that you are also printk maintainer :) ... looking at 
the above, wouldn't it make sense to introduce generic 
printk_deferred_once() instead?

-- 
Jiri Kosina
SUSE Labs

