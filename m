Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2D8C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B52F2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556781158;
	bh=a4vsmkRT/YqiHtnSj6HjWrvWp+m23XNS2L56x09x+Dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QT3vc3055AaPKTsTxNDoZBeDv8aFYaJQZacm3Kf/IY5Cq9F6MQNmliBtLfJBoEvHZ
	 zOxlBn1PT7pgq7f7TbmDdRdSjepDfd9gCkRz9+4JiL5dUIlhsgR3R3rTQ/4Aw1V40G
	 VWlgVQp8rKYYENUenLYZMWdzT7W9ZBTerPLOFmiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfEBHMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:12:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfEBHMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:12:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B05F82085A;
        Thu,  2 May 2019 07:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556781155;
        bh=a4vsmkRT/YqiHtnSj6HjWrvWp+m23XNS2L56x09x+Dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ACEmOVXh9UquCm10yyqI5N7dznFL8uGxTRyD/S2sW2z71Abwct83ikmAhd+nL6mO9
         bnMnJZQ9VbbkKscP6HKPxRAQL1vKr1VgRVbvWtJLmzN4Q8Alo+1MzlWN6XqFLXWo0W
         v5ze9RFBDlKiDwVBiERNLLVdwzT5Afi2c/DCuNIs=
Date:   Thu, 2 May 2019 09:12:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 5/5] livepatch: Do not manually track kobject
 initialization
Message-ID: <20190502071232.GB16247@kroah.com>
References: <20190502023142.20139-1-tobin@kernel.org>
 <20190502023142.20139-6-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502023142.20139-6-tobin@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 12:31:42PM +1000, Tobin C. Harding wrote:
> Currently we use custom logic to track kobject initialization.  Recently
> a predicate function was added to the kobject API so we now no longer
> need to do this.
> 
> Use kobject API to check for initialized state of kobjects instead of
> using custom logic to track state.
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
>  include/linux/livepatch.h |  6 ------
>  kernel/livepatch/core.c   | 18 +++++-------------
>  2 files changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> index 53551f470722..955d46f37b72 100644
> --- a/include/linux/livepatch.h
> +++ b/include/linux/livepatch.h
> @@ -47,7 +47,6 @@
>   * @stack_node:	list node for klp_ops func_stack list
>   * @old_size:	size of the old function
>   * @new_size:	size of the new function
> - * @kobj_added: @kobj has been added and needs freeing
>   * @nop:        temporary patch to use the original code again; dyn. allocated
>   * @patched:	the func has been added to the klp_ops list
>   * @transition:	the func is currently being applied or reverted
> @@ -86,7 +85,6 @@ struct klp_func {
>  	struct list_head node;
>  	struct list_head stack_node;
>  	unsigned long old_size, new_size;
> -	bool kobj_added;
>  	bool nop;
>  	bool patched;
>  	bool transition;
> @@ -126,7 +124,6 @@ struct klp_callbacks {
>   * @node:	list node for klp_patch obj_list
>   * @mod:	kernel module associated with the patched object
>   *		(NULL for vmlinux)
> - * @kobj_added: @kobj has been added and needs freeing
>   * @dynamic:    temporary object for nop functions; dynamically allocated
>   * @patched:	the object's funcs have been added to the klp_ops list
>   */
> @@ -141,7 +138,6 @@ struct klp_object {
>  	struct list_head func_list;
>  	struct list_head node;
>  	struct module *mod;
> -	bool kobj_added;
>  	bool dynamic;
>  	bool patched;
>  };
> @@ -154,7 +150,6 @@ struct klp_object {
>   * @list:	list node for global list of actively used patches
>   * @kobj:	kobject for sysfs resources
>   * @obj_list:	dynamic list of the object entries
> - * @kobj_added: @kobj has been added and needs freeing
>   * @enabled:	the patch is enabled (but operation may be incomplete)
>   * @forced:	was involved in a forced transition
>   * @free_work:	patch cleanup from workqueue-context
> @@ -170,7 +165,6 @@ struct klp_patch {
>  	struct list_head list;
>  	struct kobject kobj;
>  	struct list_head obj_list;
> -	bool kobj_added;
>  	bool enabled;
>  	bool forced;
>  	struct work_struct free_work;
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 98295de2172b..0b94aa5b38c9 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -590,7 +590,7 @@ static void __klp_free_funcs(struct klp_object *obj, bool nops_only)
>  		list_del(&func->node);
>  
>  		/* Might be called from klp_init_patch() error path. */
> -		if (func->kobj_added) {
> +		if (kobject_is_initialized(&func->kobj)) {
>  			kobject_put(&func->kobj);
>  		} else if (func->nop) {
>  			klp_free_func_nop(func);

This feels really odd to me, why do we need to keep track of this type
of thing?

How can the kobject _not_ be initialized?  If it's just because we don't
want to write two separate error cleanup paths, that's not ok.

> @@ -626,7 +626,7 @@ static void __klp_free_objects(struct klp_patch *patch, bool nops_only)
>  		list_del(&obj->node);
>  
>  		/* Might be called from klp_init_patch() error path. */
> -		if (obj->kobj_added) {
> +		if (kobject_is_initialized(&obj->kobj)) {
>  			kobject_put(&obj->kobj);
>  		} else if (obj->dynamic) {
>  			klp_free_object_dynamic(obj);

Same here, let's not be lazy.

The code should "know" if the kobject has been initialized or not
because it is the entity that asked for it to be initialized.  Don't add
extra logic to the kobject core (like the patch before this did) just
because this one subsystem wanted to only write 1 "cleanup" function.

thanks,

greg k-h
