Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2E2C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E4220675
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfD3Ko5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 06:44:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:55462 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726262AbfD3Ko5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 06:44:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 14421AD7C;
        Tue, 30 Apr 2019 10:44:56 +0000 (UTC)
Date:   Tue, 30 Apr 2019 12:44:55 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     "Tobin C. Harding" <tobin@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] livepatch: Fix kobject memleak
In-Reply-To: <20190430084254.GB11737@kroah.com>
Message-ID: <alpine.LSU.2.21.1904301235450.8507@pobox.suse.cz>
References: <20190430001534.26246-1-tobin@kernel.org> <20190430001534.26246-2-tobin@kernel.org> <20190430084254.GB11737@kroah.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2019, Greg Kroah-Hartman wrote:

> On Tue, Apr 30, 2019 at 10:15:33AM +1000, Tobin C. Harding wrote:
> > Currently error return from kobject_init_and_add() is not followed by a
> > call to kobject_put().  This means there is a memory leak.
> > 
> > Add call to kobject_put() in error path of kobject_init_and_add().
> > 
> > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Well, it does not even compile...

On Tue, 30 Apr 2019, Tobin C. Harding wrote:

> Currently error return from kobject_init_and_add() is not followed by a
> call to kobject_put().  This means there is a memory leak.
> 
> Add call to kobject_put() in error path of kobject_init_and_add().
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
>  kernel/livepatch/core.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index eb0ee10a1981..98a7bec41faa 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -727,7 +727,9 @@ static int klp_init_func(struct klp_object *obj, struct klp_func *func)
>  	ret = kobject_init_and_add(&func->kobj, &klp_ktype_func,
>  				   &obj->kobj, "%s,%lu", func->old_name,
>  				   func->old_sympos ? func->old_sympos : 1);
> -	if (!ret)
> +	if (ret)
> +		kobject_put(&func->kobj);
> +	else
>  		func->kobj_added = true;
>  
>  	return ret;
> @@ -803,8 +805,10 @@ static int klp_init_object(struct klp_patch *patch, struct klp_object *obj)
>  	name = klp_is_module(obj) ? obj->name : "vmlinux";
>  	ret = kobject_init_and_add(&obj->kobj, &klp_ktype_object,
>  				   &patch->kobj, "%s", name);
> -	if (ret)
> +	if (ret) {
> +		kobject_put(&func->kobj);

kobject_put(&obj->kobj); I suppose.

>  		return ret;
> +	}
>  	obj->kobj_added = true;
>  
>  	klp_for_each_func(obj, func) {
> @@ -862,8 +866,10 @@ static int klp_init_patch(struct klp_patch *patch)
>  
>  	ret = kobject_init_and_add(&patch->kobj, &klp_ktype_patch,
>  				   klp_root_kobj, "%s", patch->mod->name);
> -	if (ret)
> +	if (ret) {
> +		kobject_put(&func->kobj);

kobject_put(&patch->kobj);

Thanks,
Miroslav

