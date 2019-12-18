Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70FDC2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9670721D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfLRTdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:33:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbfLRTdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:33:54 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DC99206D8;
        Wed, 18 Dec 2019 19:33:52 +0000 (UTC)
Date:   Wed, 18 Dec 2019 14:33:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, nachukannan@gmail.com,
        saiprakash.ranjan@outlook.com
Subject: Re: [PATCH v2] docs: ftrace: Specifies when buffers get clear
Message-ID: <20191218143351.03a34e00@gandalf.local.home>
In-Reply-To: <20191218191553.q4lwyxmquvtjzjfz@frank-laptop>
References: <20191218191553.q4lwyxmquvtjzjfz@frank-laptop>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2019 14:15:53 -0500
"Frank A. Cancio Bello" <frank@generalsoftwareinc.com> wrote:

> Clarify a few places where the ring buffer and the "snapshot" buffer
> are cleared as a side effect of an operation.
> 
> This will avoid users lost of tracing data because of these so far
> undocumented behavior.
> 
> Signed-off-by: Frank A. Cancio Bello <frank@generalsoftwareinc.com>

Thanks for the update.

Jon, do you want to take this?

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
> Changes in v2:
>   - Per Steven comment correct the fact that the "snapshot" buffer is
>     not touched when writing in the "trace" file.
>   - Use tab instead of spaces for alignment.
> 
>  Documentation/trace/ftrace.rst | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index d2b5657ed33e..46df39300d22 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -95,7 +95,8 @@ of ftrace. Here is a list of some of the key files:
>    current_tracer:
>  
>  	This is used to set or display the current tracer
> -	that is configured.
> +	that is configured. Changing the current tracer clears
> +	the ring buffer content as well as the "snapshot" buffer.
>  
>    available_tracers:
>  
> @@ -126,7 +127,8 @@ of ftrace. Here is a list of some of the key files:
>  	This file holds the output of the trace in a human
>  	readable format (described below). Note, tracing is temporarily
>  	disabled when the file is open for reading. Once all readers
> -	are closed, tracing is re-enabled.
> +	are closed, tracing is re-enabled. Opening this file for
> +	writing with the O_TRUNC flag clears the ring buffer content.
>  
>    trace_pipe:
>  
> @@ -490,6 +492,9 @@ of ftrace. Here is a list of some of the key files:
>  
>  	  # echo global > trace_clock
>  
> +	Setting a clock clears the ring buffer content as well as the
> +	"snapshot" buffer.
> +
>    trace_marker:
>  
>  	This is a very useful file for synchronizing user space

