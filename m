Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EF8C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 15:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61EBE22DA9
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 15:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfHaP6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 11:58:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfHaP6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 11:58:38 -0400
Received: from oasis.local.home (rrcs-24-39-165-138.nys.biz.rr.com [24.39.165.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1614421874;
        Sat, 31 Aug 2019 15:58:37 +0000 (UTC)
Date:   Sat, 31 Aug 2019 11:58:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Wu <peter@lekensteyn.nl>
Cc:     Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v2] docs: ftrace: clarify when tracing is disabled by
 the trace file
Message-ID: <20190831115835.0a03b914@oasis.local.home>
In-Reply-To: <20190831153500.7399-1-peter@lekensteyn.nl>
References: <20190830175108.0ffa6ef1@gandalf.local.home>
        <20190831153500.7399-1-peter@lekensteyn.nl>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Aug 2019 16:35:00 +0100
Peter Wu <peter@lekensteyn.nl> wrote:

> The current text could mislead the user into believing that only read()
> disables tracing. Clarify that any open() call that requests read access
> disables tracing.
> 
> Link: https://lkml.kernel.org/r/CAADnVQ+hU6QOC_dPmpjnuv=9g4SQEeaMEMqXOS2WpMj=q=LdiQ@mail.gmail.com
> Signed-off-by: Peter Wu <peter@lekensteyn.nl>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Jon care to take this in your tree?

Thanks!

-- Steve

> ---
> v2: fix typo s/trace_file/trace_pipe/ (spotted by Steven)
> ---
>  Documentation/trace/ftrace.rst | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index f60079259669..e3060eedb22d 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -125,7 +125,8 @@ of ftrace. Here is a list of some of the key files:
>  
>  	This file holds the output of the trace in a human
>  	readable format (described below). Note, tracing is temporarily
> -	disabled while this file is being read (opened).
> +	disabled when the file is open for reading. Once all readers
> +	are closed, tracing is re-enabled.
>  
>    trace_pipe:
>  
> @@ -139,8 +140,9 @@ of ftrace. Here is a list of some of the key files:
>  	will not be read again with a sequential read. The
>  	"trace" file is static, and if the tracer is not
>  	adding more data, it will display the same
> -	information every time it is read. This file will not
> -	disable tracing while being read.
> +	information every time it is read. Unlike the
> +	"trace" file, opening this file for reading will not
> +	temporarily disable tracing.
>  
>    trace_options:
>  
> @@ -3153,7 +3155,10 @@ different. The trace is live.
>  
>  
>  Note, reading the trace_pipe file will block until more input is
> -added.
> +added. This is contrary to the trace file. If any process opened
> +the trace file for reading, it will actually disable tracing and
> +prevent new entries from being added. The trace_pipe file does
> +not have this limitation.
>  
>  trace entries
>  -------------

