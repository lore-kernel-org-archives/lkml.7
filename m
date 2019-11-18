Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E6AC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 14:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54EDA206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 14:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfKRO2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 09:28:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:46482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfKRO2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 09:28:47 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FF98206B6;
        Mon, 18 Nov 2019 14:28:46 +0000 (UTC)
Date:   Mon, 18 Nov 2019 09:28:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Hewenliang <hewenliang4@huawei.com>
Cc:     <acme@redhat.com>, <tstoyanov@vmware.com>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linfeilong@huawei.com>
Subject: Re: [PATCH v2] tools lib traceevent: Fix memory leakage in
 copy_filter_type
Message-ID: <20191118092844.7292ad26@oasis.local.home>
In-Reply-To: <20191025082312.62690-1-hewenliang4@huawei.com>
References: <20191025082312.62690-1-hewenliang4@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnaldo,

Can you take this patch?

Thanks!

-- Steve


On Fri, 25 Oct 2019 04:23:12 -0400
Hewenliang <hewenliang4@huawei.com> wrote:

> It is necessary to free the memory that we have allocated
> when error occurs.
> 
> Fixes: ef3072cd1d5c ("tools lib traceevent: Get rid of die in add_filter_type()")
> Signed-off-by: Hewenliang <hewenliang4@huawei.com>
> ---
>  tools/lib/traceevent/parse-filter.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
> index 552592d153fb..fbaa790d10d8 100644
> --- a/tools/lib/traceevent/parse-filter.c
> +++ b/tools/lib/traceevent/parse-filter.c
> @@ -1473,8 +1473,10 @@ static int copy_filter_type(struct tep_event_filter *filter,
>  	if (strcmp(str, "TRUE") == 0 || strcmp(str, "FALSE") == 0) {
>  		/* Add trivial event */
>  		arg = allocate_arg();
> -		if (arg == NULL)
> +		if (arg == NULL) {
> +			free(str);
>  			return -1;
> +		}
>  
>  		arg->type = TEP_FILTER_ARG_BOOLEAN;
>  		if (strcmp(str, "TRUE") == 0)
> @@ -1483,8 +1485,11 @@ static int copy_filter_type(struct tep_event_filter *filter,
>  			arg->boolean.value = 0;
>  
>  		filter_type = add_filter_type(filter, event->id);
> -		if (filter_type == NULL)
> +		if (filter_type == NULL) {
> +			free(str);
> +			free(arg);
>  			return -1;
> +		}
>  
>  		filter_type->filter = arg;
>  

