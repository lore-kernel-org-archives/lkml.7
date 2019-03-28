Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363E1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046F1204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfC1Ahq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:37:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727270AbfC1Ahq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 20:37:46 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39B952075E;
        Thu, 28 Mar 2019 00:37:45 +0000 (UTC)
Date:   Wed, 27 Mar 2019 20:37:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Ingo Molnar <mingo@redhat.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fix potential null pointer dereference on
 rctr_end
Message-ID: <20190327203743.751ce68b@oasis.local.home>
In-Reply-To: <20180927224700.13739-1-colin.king@canonical.com>
References: <20180927224700.13739-1-colin.king@canonical.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I just found this in the depths of my inbox (which is now managed by a
local Patchwork system, so no more lost patches!)

On Thu, 27 Sep 2018 23:47:00 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently rctr_end may assigned null if strchr() fails leading to
> a null pointer dereference in the following check on *(rctr_end + 1).
> Fix this by also adding a null pointer check before the dereference.
> 
> Detected by CoverityScan, CID#1473700 ("Dereference null return value")
> 
> Fixes: 1cc33161a83d ("uprobes: Support SDT markers having reference count (semaphore)")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  kernel/trace/trace_uprobe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 3a7c73c40007..c5514651e61f 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -477,7 +477,7 @@ static int create_trace_uprobe(int argc, char **argv)
>  	rctr = strchr(arg, '(');
>  	if (rctr) {
>  		rctr_end = strchr(rctr, ')');
> -		if (rctr > rctr_end || *(rctr_end + 1) != 0) {
> +		if (!rctr_end || rctr > rctr_end || *(rctr_end + 1) != 0) {

I think this is a false positive.

rctr and rctr_end are pointers. Thus, they are compared as unsigned.

To get into this code, rctr must be non NULL (greater than zero)

The first compare of the if conditional is:

	rctr > rctr_end

If rctr_end is NULL, then that is guaranteed to be true!

Which means, the rctr_end will not be access, and we exit out safely.

-- Steve

>  			ret = -EINVAL;
>  			pr_info("Invalid reference counter offset.\n");
>  			goto fail_address_parse;

