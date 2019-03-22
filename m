Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51D9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB92F2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfCVTUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbfCVTUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 15:20:03 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1990B2183E;
        Fri, 22 Mar 2019 19:20:02 +0000 (UTC)
Date:   Fri, 22 Mar 2019 15:20:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     frowand.list@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] tracing: initialize variable in create_dyn_event()
Message-ID: <20190322152000.0a357bb1@gandalf.local.home>
In-Reply-To: <1553237900-8555-1-git-send-email-frowand.list@gmail.com>
References: <1553237900-8555-1-git-send-email-frowand.list@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 23:58:20 -0700
frowand.list@gmail.com wrote:

> From: Frank Rowand <frank.rowand@sony.com>
> 
> Fix compile warning in create_dyn_event(): 'ret' may be used uninitialized
> in this function [-Wuninitialized].
> 
> Fixes: 5448d44c3855 ("tracing: Add unified dynamic event framework")
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>

Applied. Thanks Frank!

-- Steve

> ---
> 
> changes since v1:
>   - initialize to -ENODEV instead of 0, as suggested by Steve
> 
>  kernel/trace/trace_dynevent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
> index dd1f43588d70..fa100ed3b4de 100644
> --- a/kernel/trace/trace_dynevent.c
> +++ b/kernel/trace/trace_dynevent.c
> @@ -74,7 +74,7 @@ int dyn_event_release(int argc, char **argv, struct dyn_event_operations *type)
>  static int create_dyn_event(int argc, char **argv)
>  {
>  	struct dyn_event_operations *ops;
> -	int ret;
> +	int ret = -ENODEV;
>  
>  	if (argv[0][0] == '-' || argv[0][0] == '!')
>  		return dyn_event_release(argc, argv, NULL);

