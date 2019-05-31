Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531A9C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D02A268EE
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 12:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfEaMhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 08:37:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:35664 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726233AbfEaMhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 08:37:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2DA53AD9C;
        Fri, 31 May 2019 12:37:53 +0000 (UTC)
Date:   Fri, 31 May 2019 14:37:52 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] livepatch: Use static buffer for debugging messages
 under rq lock
In-Reply-To: <20190531074147.27616-4-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1905311433230.742@pobox.suse.cz>
References: <20190531074147.27616-1-pmladek@suse.com> <20190531074147.27616-4-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 May 2019, Petr Mladek wrote:

> The err_buf array uses 128 bytes of stack space.  Move it off the stack
> by making it static.  It's safe to use a shared buffer because
> klp_try_switch_task() is called under klp_mutex.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Acked-by: Miroslav Benes <mbenes@suse.cz>
> Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> ---
>  kernel/livepatch/transition.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> index 1bf362df76e1..5c4f0c1f826e 100644
> --- a/kernel/livepatch/transition.c
> +++ b/kernel/livepatch/transition.c
> @@ -280,11 +280,11 @@ static int klp_check_stack(struct task_struct *task, char *err_buf)
>   */
>  static bool klp_try_switch_task(struct task_struct *task)
>  {
> +	static char err_buf[STACK_ERR_BUF_SIZE];
>  	struct rq *rq;
>  	struct rq_flags flags;
>  	int ret;
>  	bool success = false;
> -	char err_buf[STACK_ERR_BUF_SIZE];
>  
>  	err_buf[0] = '\0';
>  
> @@ -327,7 +327,6 @@ static bool klp_try_switch_task(struct task_struct *task)
>  		pr_debug("%s", err_buf);
>  
>  	return success;
> -
>  }

This could go in separately as it is not connected to the rest of the 
series.

Miroslav
