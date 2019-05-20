Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA5BC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DA4213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733306AbfETNI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:08:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730570AbfETNIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:08:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99DCC20815;
        Mon, 20 May 2019 13:08:53 +0000 (UTC)
Date:   Mon, 20 May 2019 09:08:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/4] ftrace: Expose flags used for
 ftrace_replace_code()
Message-ID: <20190520090852.66f6f629@gandalf.local.home>
In-Reply-To: <f2aa621d26056aa9fc8a6b82e3ceeaf44201d86d.1558115654.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1558115654.git.naveen.n.rao@linux.vnet.ibm.com>
        <f2aa621d26056aa9fc8a6b82e3ceeaf44201d86d.1558115654.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 May 2019 00:32:45 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Since ftrace_replace_code() is a __weak function and can be overridden,
> we need to expose the flags that can be set. So, move the flags enum to
> the header file.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>  include/linux/ftrace.h | 5 +++++
>  kernel/trace/ftrace.c  | 5 -----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 20899919ead8..835e761f63b0 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -162,6 +162,11 @@ enum {
>  	FTRACE_OPS_FL_TRACE_ARRAY		= 1 << 15,
>  };
>  
> +enum {
> +	FTRACE_MODIFY_ENABLE_FL		= (1 << 0),
> +	FTRACE_MODIFY_MAY_SLEEP_FL	= (1 << 1),
> +};
> +
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  /* The hash used to know what functions callbacks trace */
>  struct ftrace_ops_hash {
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index b920358dd8f7..38c15cd27fc4 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -78,11 +78,6 @@
>  #define ASSIGN_OPS_HASH(opsname, val)
>  #endif
>  
> -enum {
> -	FTRACE_MODIFY_ENABLE_FL		= (1 << 0),
> -	FTRACE_MODIFY_MAY_SLEEP_FL	= (1 << 1),
> -};
> -
>  struct ftrace_ops ftrace_list_end __read_mostly = {
>  	.func		= ftrace_stub,
>  	.flags		= FTRACE_OPS_FL_RECURSION_SAFE | FTRACE_OPS_FL_STUB,

