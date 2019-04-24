Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63201C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27251218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfDXMIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:08:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfDXMIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:08:31 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C7E6218B0;
        Wed, 24 Apr 2019 12:08:30 +0000 (UTC)
Date:   Wed, 24 Apr 2019 08:08:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools lib traceevent: Change tag string for error
Message-ID: <20190424080829.0043469b@gandalf.local.home>
In-Reply-To: <20190424013802.27569-1-leo.yan@linaro.org>
References: <20190424013802.27569-1-leo.yan@linaro.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019 09:38:02 +0800
Leo Yan <leo.yan@linaro.org> wrote:

> The traceevnt lib is used by perf tool, when execute 'perf test -v 6' it
> outputs error log on ARM64 platform:
> 
>   running test 33 '*:*'trace-cmd: No such file or directory
> 
>   [...]
> 
>   trace-cmd: Invalid argument
> 
> The trace event parsing code originally came from trace-cmd so it keeps
> the tag string "trace-cmd" for errors, this easily introduces the
> impression that perf tool launches trace-cmd command for trace event
> parsing, but in fact the related parsing is accomplished by traceevent
> lib.
> 
> This patch changes the tag string to "libtraceevent" so can avoid
> confusion and let users to be more easily to connect the error with
> traceevent lib.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Arnaldo,

Can you pull this into your tree.

-- Steve

> ---
>  tools/lib/traceevent/parse-utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/traceevent/parse-utils.c b/tools/lib/traceevent/parse-utils.c
> index 77e4ec6402dd..e99867111387 100644
> --- a/tools/lib/traceevent/parse-utils.c
> +++ b/tools/lib/traceevent/parse-utils.c
> @@ -14,7 +14,7 @@
>  void __vwarning(const char *fmt, va_list ap)
>  {
>  	if (errno)
> -		perror("trace-cmd");
> +		perror("libtraceevent");
>  	errno = 0;
>  
>  	fprintf(stderr, "  ");

