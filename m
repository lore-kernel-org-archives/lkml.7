Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86902C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70EF924685
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfLTB4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 20:56:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:53240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727524AbfLTB4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 20:56:33 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABC8F227BF;
        Fri, 20 Dec 2019 01:56:32 +0000 (UTC)
Date:   Thu, 19 Dec 2019 20:56:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Hewenliang <hewenliang4@huawei.com>
Cc:     <acme@redhat.com>, <tstoyanov@vmware.com>,
        <linux-kernel@vger.kernel.org>, <linfeilong@huawei.com>
Subject: Re: [PATCH] tools lib traceevent: Fix memory leakage in
 filter_event
Message-ID: <20191219205631.2e12571c@rorschach.local.home>
In-Reply-To: <20191209063549.59941-1-hewenliang4@huawei.com>
References: <20191209063549.59941-1-hewenliang4@huawei.com>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Dec 2019 01:35:49 -0500
Hewenliang <hewenliang4@huawei.com> wrote:

> It is necessary to call free_arg(arg) when add_filter_type returns NULL in
> the function of filter_event.
> 
> Signed-off-by: Hewenliang <hewenliang4@huawei.com>

This looks fine.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Arnaldo, care to take this?

-- Steve

> ---
>  tools/lib/traceevent/parse-filter.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
> index f3cbf86e51ac..20eed719542e 100644
> --- a/tools/lib/traceevent/parse-filter.c
> +++ b/tools/lib/traceevent/parse-filter.c
> @@ -1228,8 +1228,10 @@ filter_event(struct tep_event_filter *filter, struct tep_event *event,
>  	}
>  
>  	filter_type = add_filter_type(filter, event->id);
> -	if (filter_type == NULL)
> +	if (filter_type == NULL) {
> +		free_arg(arg);
>  		return TEP_ERRNO__MEM_ALLOC_FAILED;
> +	}
>  
>  	if (filter_type->filter)
>  		free_arg(filter_type->filter);

