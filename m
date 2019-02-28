Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C522DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E277218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbfB1Cmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:42:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730263AbfB1Cmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 21:42:49 -0500
Received: from vmware.local.home (unknown [208.91.3.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B938F21850;
        Thu, 28 Feb 2019 02:42:47 +0000 (UTC)
Date:   Wed, 27 Feb 2019 21:42:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 5/5] tracing/probe: Support user-space dereference
Message-ID: <20190227214245.39d6563f@vmware.local.home>
In-Reply-To: <155127868250.32576.2419537726154240743.stgit@devbox>
References: <155127853496.32576.3705994926675037747.stgit@devbox>
        <155127868250.32576.2419537726154240743.stgit@devbox>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019 23:44:42 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index a7012de37a00..0efef172db17 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -239,6 +239,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
>  {
>  	struct fetch_insn *code = *pcode;
>  	unsigned long param;
> +	int deref = FETCH_OP_DEREF;
>  	long offset = 0;
>  	char *tmp;
>  	int ret = 0;
> @@ -301,8 +302,17 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
>  		break;
>  
>  	case '+':	/* deref memory */
> -		arg++;	/* Skip '+', because kstrtol() rejects it. */
>  	case '-':
> +		if (arg[0] == '+') {
> +			arg++;	/* Skip '+', because kstrtol() rejects it. */
> +			if (arg[0] == 'u') {
> +				deref = FETCH_OP_UDEREF;
> +				arg++;
> +			}
> +		} else if (arg[1] == 'u') {	/* Start with "-u" */
> +			deref = FETCH_OP_UDEREF;
> +			*(++arg) = '-';
> +		}

What about:

		if (arg[1] == 'u') {
			deref = FETCH_OP_UDEREF;
			arg[1] = arg[0];
			arg++;
		}
		if (arg[0] == '+')
			arg++; /* Skip '+', because kstrtol() rejects it. */

A bit less messy.


>  		tmp = strchr(arg, '(');
>  		if (!tmp)
>  			return -EINVAL;
> @@ -328,7 +338,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
>  				return -E2BIG;
>  			*pcode = code;
>  
> -			code->op = FETCH_OP_DEREF;
> +			code->op = deref;
>  			code->offset = offset;
>  		}
>  		break;
> @@ -444,13 +454,14 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
>  	/* Store operation */
>  	if (!strcmp(parg->type->name, "string") ||
>  	    !strcmp(parg->type->name, "ustring")) {
> -		if (code->op != FETCH_OP_DEREF && code->op != FETCH_OP_IMM &&
> -		    code->op != FETCH_OP_COMM) {
> +		if (code->op != FETCH_OP_DEREF && code->op != FETCH_OP_UDEREF
> +		    && code->op != FETCH_OP_IMM && code->op != FETCH_OP_COMM) {
>  			pr_info("string only accepts memory or address.\n");
>  			ret = -EINVAL;
>  			goto fail;
>  		}
> -		if (code->op != FETCH_OP_DEREF || parg->count) {
> +		if ((code->op == FETCH_OP_IMM && code->op == FETCH_OP_COMM)
> +		    || parg->count) {

How would "code->op == FETCH_OP_IMM && code->op == FETCH_OP_COMM" ever be true?

Did you mean || ?

-- Steve

>  			/*
>  			 * IMM and COMM is pointing actual address, those must
>  			 * be kept, and if parg->count != 0, this is an array
> @@ -463,7 +474,8 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
>  			}
>  		}
>  		/* If op == DEREF, replace it with STRING */
> -		if (!strcmp(parg->type->name, "ustring"))
> +		if (!strcmp(parg->type->name, "ustring") ||
> +		    code->op == FETCH_OP_UDEREF)
>  			code->op = FETCH_OP_ST_USTRING;
>  		else
>  			code->op = FETCH_OP_ST_STRING;
