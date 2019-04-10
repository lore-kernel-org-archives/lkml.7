Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8C3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18C620850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfDJULQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 16:11:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfDJULP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 16:11:15 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C44B2077C;
        Wed, 10 Apr 2019 20:11:14 +0000 (UTC)
Date:   Wed, 10 Apr 2019 16:11:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, mathieu.desnoyers@efficios.com,
        Jessica Yu <jeyu@kernel.org>,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        rcu@vger.kernel.org
Subject: Re: [PATCH v3 3/3] module: Make __tracepoints_ptrs as read-only
Message-ID: <20190410161112.540017d9@gandalf.local.home>
In-Reply-To: <20190410195708.162185-3-joel@joelfernandes.org>
References: <20190410195708.162185-1-joel@joelfernandes.org>
        <20190410195708.162185-3-joel@joelfernandes.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019 15:57:08 -0400
"Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:

> This series hardens the tracepoints in modules by making the array of
> pointers referring to the tracepoints as read-only. This array is needed
> during module unloading to verify that the tracepoint is quiescent.
> There is no reason for the array to be to be writable after init, and
> can cause security or other hidden bugs. Mark these as ro_after_init.
> 
> Suggested-by: paulmck@linux.vnet.ibm.com
> Suggested-by: keescook@chromium.org
> Suggested-by: mathieu.desnoyers@efficios.com
> Cc: rostedt@goodmis.org
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/module.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 8b9631e789f0..be980aaa8804 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3320,6 +3320,12 @@ static const char * const ro_after_init_sections[] = {
>  	 * by the SRCU notifiers
>  	 */
>  	"___srcu_struct_ptrs",
> +
> +	/*
> +	 * Array of tracepoint pointers used for checking if tracepoints are
> +	 * quiescent during unloading.
> +	 */
> +	"__tracepoints_ptrs",

Do we ever modify the __tracepoint_ptrs section? I know the jump_label
sections are sorted on load, which means they need to be writable
during init, but if __tracepoint_ptrs is not sorted or touched during
load, why not just put them in the rodata section to begin with?

-- Steve

>  };
>  
>  static struct module *layout_and_allocate(struct load_info *info, int flags)

