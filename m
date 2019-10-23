Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413C8CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 19:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEA121929
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 19:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405003AbfJWT3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 15:29:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403801AbfJWT3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 15:29:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D883021872;
        Wed, 23 Oct 2019 19:29:33 +0000 (UTC)
Date:   Wed, 23 Oct 2019 15:29:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v2 4/4] jump_label,module: Fix module lifetime for
 __jump_label_mod_text_reserved
Message-ID: <20191023152932.217ef516@gandalf.local.home>
In-Reply-To: <20191007082700.20088974.3@infradead.org>
References: <20191007082541.64146933.7@infradead.org>
        <20191007082700.20088974.3@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Oct 2019 10:25:45 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Nothing ensures the module exists while we're iterating
> mod->jump_entries in __jump_label_mod_text_reserved(), take a module
> reference to ensure the module sticks around.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>  kernel/jump_label.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -539,19 +539,25 @@ static void static_key_set_mod(struct st
>  static int __jump_label_mod_text_reserved(void *start, void *end)
>  {
>  	struct module *mod;
> +	int ret;
>  
>  	preempt_disable();
>  	mod = __module_text_address((unsigned long)start);
>  	WARN_ON_ONCE(__module_text_address((unsigned long)end) != mod);
> +	if (!try_module_get(mod))
> +		mod = NULL;
>  	preempt_enable();
>  
>  	if (!mod)
>  		return 0;
>  
> -
> -	return __jump_label_text_reserved(mod->jump_entries,
> +	ret = __jump_label_text_reserved(mod->jump_entries,
>  				mod->jump_entries + mod->num_jump_entries,
>  				start, end);
> +
> +	module_put(mod);
> +
> +	return ret;
>  }
>  
>  static void __jump_label_mod_update(struct static_key *key)
> 

