Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E344DC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B870420B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387920AbfJJM6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 08:58:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387764AbfJJM6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 08:58:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F23A2067B;
        Thu, 10 Oct 2019 12:58:48 +0000 (UTC)
Date:   Thu, 10 Oct 2019 08:58:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>, Jessica Yu <jeyu@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] ftrace/module: Allow ftrace to make only loaded module
 text read-write
Message-ID: <20191010085846.2e7cc625@gandalf.local.home>
In-Reply-To: <20191009223638.60b78727@oasis.local.home>
References: <20191009223638.60b78727@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2019 22:36:38 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2029,6 +2029,37 @@ static void module_enable_nx(const struct module *mod)
>  	frob_writable_data(&mod->init_layout, set_memory_nx);
>  }
>  

Also, if you are worried about these being used anywhere else, we can
add:

> +void set_module_text_rw(const struct module *mod)
> +{
> +	if (!rodata_enabled)
> +		return;
> +
> +	mutex_lock(&module_mutex);
> +	if (mod->state == MODULE_STATE_UNFORMED)

	if (mod->state == MODULE_STATE_UNFORMED ||
	    mod->state == MODULE_STATE_LIVE)

As this will keep it from being used on modules that are executing.

-- Steve


> +		goto out;
> +
> +	frob_text(&mod->core_layout, set_memory_rw);
> +	frob_text(&mod->init_layout, set_memory_rw);
> +out:
> +	mutex_unlock(&module_mutex);
> +}
> +
> +void set_module_text_ro(const struct module *mod)
> +{
> +	if (!rodata_enabled)
> +		return;
> +
> +	mutex_lock(&module_mutex);
> +	if (mod->state == MODULE_STATE_UNFORMED ||
> +	    mod->state == MODULE_STATE_GOING)
> +		goto out;
> +
> +	frob_text(&mod->core_layout, set_memory_ro);
> +	frob_text(&mod->init_layout, set_memory_ro);
> +out:
> +	mutex_unlock(&module_mutex);
> +}
> +
