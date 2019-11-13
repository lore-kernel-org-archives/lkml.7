Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EB0C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 02:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E7322313
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 02:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfKSCB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 21:01:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:36960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbfKSCB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 21:01:59 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E7C9222F2;
        Tue, 19 Nov 2019 02:01:58 +0000 (UTC)
Date:   Wed, 13 Nov 2019 16:09:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        andriy.shevchenko@intel.com, cezary.rojewski@intel.com,
        gustaw.lewandowski@intel.com
Subject: Re: [PATCH v2 2/2] tracing: Use seq_buf_hex_dump() to dump buffers
Message-ID: <20191113160922.1b1f0fc0@gandalf.local.home>
In-Reply-To: <1573130738-29390-2-git-send-email-piotrx.maziarz@linux.intel.com>
References: <1573130738-29390-1-git-send-email-piotrx.maziarz@linux.intel.com>
        <1573130738-29390-2-git-send-email-piotrx.maziarz@linux.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Nov 2019 13:45:38 +0100
Piotr Maziarz <piotrx.maziarz@linux.intel.com> wrote:

> diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
> index 4ecdfe2..7089760 100644
> --- a/include/trace/trace_events.h
> +++ b/include/trace/trace_events.h
> @@ -340,6 +340,12 @@ TRACE_MAKE_SYSTEM_STR();
>  		trace_print_array_seq(p, array, count, el_size);	\
>  	})
>  
> +#undef __print_hex_dump
> +#define __print_hex_dump(prefix_str, prefix_type,			\
> +			 rowsize, groupsize, buf, len, ascii)		\
> +	trace_print_hex_dump_seq(p, prefix_str, prefix_type,		\
> +				 rowsize, groupsize, buf, len, ascii)
> +
>  #undef DECLARE_EVENT_CLASS
>  #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
>  static notrace enum print_line_t					\

OK, so the __print_hex_dump() will be exported to the format files.

Would you be willing to add a function to handle __print_hex_dump() in
tools/lib/traceevent/event-parse.c, like __print_flags(),
__print_symbolic(), and other __print_*() functions are handled. This
will allow trace-cmd and perf to be able to parse the data when you
used it via the userspace tools.

This can be a separate patch, but ideally before any trace events start
using this.

Thanks,

-- Steve
