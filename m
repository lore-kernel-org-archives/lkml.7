Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419E9C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1770921744
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfD3LAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:00:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:60260 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726294AbfD3LAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:00:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E174CAE63;
        Tue, 30 Apr 2019 11:00:05 +0000 (UTC)
Date:   Tue, 30 Apr 2019 13:00:05 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     "Tobin C. Harding" <tobin@kernel.org>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] livepatch: Use correct kobject cleanup function
In-Reply-To: <20190430001534.26246-3-tobin@kernel.org>
Message-ID: <alpine.LSU.2.21.1904301256550.8507@pobox.suse.cz>
References: <20190430001534.26246-1-tobin@kernel.org> <20190430001534.26246-3-tobin@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2019, Tobin C. Harding wrote:

> The correct cleanup function after a call to kobject_init_and_add() has
> succeeded is kobject_del() _not_ kobject_put().  kobject_del() calls
> kobject_put().
> 
> Use correct cleanup function when removing a kobject.
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
>  kernel/livepatch/core.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 98a7bec41faa..4cce6bb6e073 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -589,9 +589,8 @@ static void __klp_free_funcs(struct klp_object *obj, bool nops_only)
>  
>  		list_del(&func->node);
>  
> -		/* Might be called from klp_init_patch() error path. */

Could you leave the comment as is? If I am not mistaken, it is still 
valid. func->kobj_added check is here exactly because the function may be 
called as mentioned.

One could argue that the comment is not so important, but the change does 
not belong to the patch anyway in my opinion.

>  		if (func->kobj_added) {
> -			kobject_put(&func->kobj);
> +			kobject_del(&func->kobj);
>  		} else if (func->nop) {
>  			klp_free_func_nop(func);
>  		}
> @@ -625,9 +624,8 @@ static void __klp_free_objects(struct klp_patch *patch, bool nops_only)
>  
>  		list_del(&obj->node);
>  
> -		/* Might be called from klp_init_patch() error path. */

Same here.

>  		if (obj->kobj_added) {
> -			kobject_put(&obj->kobj);
> +			kobject_del(&obj->kobj);
>  		} else if (obj->dynamic) {
>  			klp_free_object_dynamic(obj);
>  		}
> @@ -676,7 +674,7 @@ static void klp_free_patch_finish(struct klp_patch *patch)
>  	 * cannot get enabled again.
>  	 */
>  	if (patch->kobj_added) {
> -		kobject_put(&patch->kobj);
> +		kobject_del(&patch->kobj);
>  		wait_for_completion(&patch->finish);
>  	}

Miroslav
