Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300C2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DDC21900
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731888AbfDXPzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:55:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730620AbfDXPzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:55:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6146730A819D;
        Wed, 24 Apr 2019 15:55:38 +0000 (UTC)
Received: from treble (ovpn-123-99.rdu2.redhat.com [10.10.123.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 612F21001E7C;
        Wed, 24 Apr 2019 15:55:34 +0000 (UTC)
Date:   Wed, 24 Apr 2019 10:55:32 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] livepatch: Cleanup message handling in
 klp_try_switch_task()
Message-ID: <20190424155532.3uyxyxwm4c5dqsf5@treble>
References: <20190424085550.29612-1-pmladek@suse.com>
 <20190424085550.29612-4-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190424085550.29612-4-pmladek@suse.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 24 Apr 2019 15:55:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 10:55:50AM +0200, Petr Mladek wrote:
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
> +		}
> +		return ret;
> +	}

We already have a similar printk in patch 1, so is this warning really
needed?

-- 
Josh
