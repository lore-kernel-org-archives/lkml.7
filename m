Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1FEC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98183205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbfLKQNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:13:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:55724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730292AbfLKPIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:08:14 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CBBC24679;
        Wed, 11 Dec 2019 15:08:13 +0000 (UTC)
Date:   Wed, 11 Dec 2019 10:08:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Cc:     takafumi.kubota1012@sslab.ics.keio.ac.jp,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Avoid memory leak in process_system_preds()
Message-ID: <20191211100811.17dc5fbe@gandalf.local.home>
In-Reply-To: <20191211091258.11310-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
References: <20191211091258.11310-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019 09:12:58 +0000
Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp> wrote:

> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -1662,7 +1662,7 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
>  	parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
>  	return -EINVAL;
>   fail_mem:
> -	kfree(filter);
> +	__free_filter(filter);
>  	/* If any call succeeded, we still need to sync */
>  	if (!fail)
>  		tracepoint_synchronize_unregister();

Applied. Thanks Keita!

-- Steve
