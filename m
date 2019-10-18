Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C696CCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A620321925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634140AbfJROOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:14:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633946AbfJROOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:14:40 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 546C921925;
        Fri, 18 Oct 2019 14:14:39 +0000 (UTC)
Date:   Fri, 18 Oct 2019 10:14:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>
Cc:     mingo@redhat.com, tom.zanussi@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: fix "gfp_t" format for synthetic events
Message-ID: <20191018101438.6cc4a25c@gandalf.local.home>
In-Reply-To: <20191018012034.6404-1-zhengjun.xing@linux.intel.com>
References: <20191018012034.6404-1-zhengjun.xing@linux.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019 09:20:34 +0800
Zhengjun Xing <zhengjun.xing@linux.intel.com> wrote:

> In the format of synthetic events, the "gfp_t" is shown as "signed:1",
> but in fact the "gfp_t" is "unsigned", should be shown as "signed:0".
> 
> The issue can be reproduced by the following commands:
> 
> echo 'memlatency u64 lat; unsigned int order; gfp_t gfp_flags; int migratetype' > /sys/kernel/debug/tracing/synthetic_events
> cat  /sys/kernel/debug/tracing/events/synthetic/memlatency/format
> 
> name: memlatency
> ID: 2233
> format:
>         field:unsigned short common_type;       offset:0;       size:2; signed:0;
>         field:unsigned char common_flags;       offset:2;       size:1; signed:0;
>         field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
>         field:int common_pid;   offset:4;       size:4; signed:1;
> 
>         field:u64 lat;  offset:8;       size:8; signed:0;
>         field:unsigned int order;       offset:16;      size:4; signed:0;
>         field:gfp_t gfp_flags;  offset:24;      size:4; signed:1;
>         field:int migratetype;  offset:32;      size:4; signed:1;
> 
> print fmt: "lat=%llu, order=%u, gfp_flags=%x, migratetype=%d", REC->lat, REC->order, REC->gfp_flags, REC->migratetype
> 

Tom,

Can you give a Reviewed-by for this?

-- Steve

> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> ---
>  kernel/trace/trace_events_hist.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 57648c5aa679..7482a1466ebf 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -679,6 +679,8 @@ static bool synth_field_signed(char *type)
>  {
>  	if (str_has_prefix(type, "u"))
>  		return false;
> +	if (strcmp(type, "gfp_t") == 0)
> +		return false;
>  
>  	return true;
>  }

