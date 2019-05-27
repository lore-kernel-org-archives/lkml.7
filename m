Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62691C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422BC20883
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfE0M7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:59:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfE0M7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:59:31 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 733AE20859;
        Mon, 27 May 2019 12:59:29 +0000 (UTC)
Date:   Mon, 27 May 2019 08:59:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Roman Gushchin <guro@fb.com>, Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 4/4] mm/vmap: move BUG_ON() check to the unlink_va()
Message-ID: <20190527085927.19152502@gandalf.local.home>
In-Reply-To: <20190527093842.10701-5-urezki@gmail.com>
References: <20190527093842.10701-1-urezki@gmail.com>
        <20190527093842.10701-5-urezki@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 May 2019 11:38:42 +0200
"Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:

> Move the BUG_ON()/RB_EMPTY_NODE() check under unlink_va()
> function, it means if an empty node gets freed it is a BUG
> thus is considered as faulty behaviour.

Can we switch it to a WARN_ON(). We are trying to remove all BUG_ON()s.
If a user wants to crash on warning, there's a sysctl for that. But
crashing the system can make it hard to debug. Especially if it is hit
by someone without a serial console, and the machine just hangs in X.
That is very annoying.

With a WARN_ON, you at least get a chance to see the crash dump.

-- Steve


> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 371aba9a4bf1..340959b81228 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -533,20 +533,16 @@ link_va(struct vmap_area *va, struct rb_root *root,
>  static __always_inline void
>  unlink_va(struct vmap_area *va, struct rb_root *root)
>  {
> -	/*
> -	 * During merging a VA node can be empty, therefore
> -	 * not linked with the tree nor list. Just check it.
> -	 */
> -	if (!RB_EMPTY_NODE(&va->rb_node)) {
> -		if (root == &free_vmap_area_root)
> -			rb_erase_augmented(&va->rb_node,
> -				root, &free_vmap_area_rb_augment_cb);
> -		else
> -			rb_erase(&va->rb_node, root);
> +	BUG_ON(RB_EMPTY_NODE(&va->rb_node));
>  
> -		list_del(&va->list);
> -		RB_CLEAR_NODE(&va->rb_node);
> -	}
> +	if (root == &free_vmap_area_root)
> +		rb_erase_augmented(&va->rb_node,
> +			root, &free_vmap_area_rb_augment_cb);
> +	else
> +		rb_erase(&va->rb_node, root);
> +
> +	list_del(&va->list);
> +	RB_CLEAR_NODE(&va->rb_node);
>  }
>  
>  #if DEBUG_AUGMENT_PROPAGATE_CHECK
> @@ -1187,8 +1183,6 @@ EXPORT_SYMBOL_GPL(unregister_vmap_purge_notifier);
>  
>  static void __free_vmap_area(struct vmap_area *va)
>  {
> -	BUG_ON(RB_EMPTY_NODE(&va->rb_node));
> -
>  	/*
>  	 * Remove from the busy tree/list.
>  	 */

