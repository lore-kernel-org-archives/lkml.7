Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CDCC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFA52083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389117AbfDRN7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:59:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729331AbfDRN7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:59:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0345307DAB7;
        Thu, 18 Apr 2019 13:59:04 +0000 (UTC)
Received: from treble (ovpn-124-190.rdu2.redhat.com [10.10.124.190])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A72B65C205;
        Thu, 18 Apr 2019 13:59:00 +0000 (UTC)
Date:   Thu, 18 Apr 2019 08:58:58 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livepatch: Convert error about unsupported reliable
 stacktrace into a warning
Message-ID: <20190418135858.n3lzq2oxkj52m6bi@treble>
References: <20190418112936.13295-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190418112936.13295-1-pmladek@suse.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 18 Apr 2019 13:59:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 01:29:36PM +0200, Petr Mladek wrote:
> The commit d0807da78e11d46f ("livepatch: Remove immediate feature") caused
> that any livepatch was refused when reliable stacktraces were not supported
> on the given architecture.
> 
> The limitation is too strong. User space processes are safely migrated
> even when entering or leaving the kernel. Kthreads transition would
> need to get forced. But it is safe when:
> 
>    + The livepatch does not change the semantic of the code.
>    + Callbacks do not depend on a safely finished transition.
> 
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/livepatch/core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index eb0ee10a1981..14f33ab6c583 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -1003,11 +1003,10 @@ int klp_enable_patch(struct klp_patch *patch)
>  		return -ENODEV;
>  
>  	if (!klp_have_reliable_stack()) {
> -		pr_err("This architecture doesn't have support for the livepatch consistency model.\n");
> -		return -EOPNOTSUPP;
> +		pr_warn("This architecture doesn't have support for the livepatch consistency model.\n");
> +		pr_warn("The livepatch transition may never complete.\n");
>  	}
>  
> -
>  	mutex_lock(&klp_mutex);
>  
>  	ret = klp_init_patch_early(patch);

Thanks Petr.  I would also suggest that we remove the WARN_ONCE() from
the weak version of save_stack_trace_tsk_reliable(), since we expect it
to be used in this case.

-- 
Josh
