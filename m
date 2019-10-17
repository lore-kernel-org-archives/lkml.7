Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8D7FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DC721835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571322430;
	bh=M1ucFBFcifo6VuiFzNF/QyK07Ut/0yJx9vvkXV040Pc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=YaNXqkwb61WXCLs6Ny16J+T0NrP76f2wr+oG/rnuCcwUrGvOLDk9KgrVrxAqSO+JN
	 /MkrCbgctFx1ZhTOczPiaims+BJQK3cnQjJupQSzlqqHYsiQdfI8nRg/LGDHiwJVua
	 rdF2dA/07NZKfRdsHS2+HpawDIulQCv//PoaD7z0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437852AbfJQO1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:27:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbfJQO1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:27:09 -0400
Received: from tzanussi-mobl9 (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D18C3214E0;
        Thu, 17 Oct 2019 14:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571322428;
        bh=M1ucFBFcifo6VuiFzNF/QyK07Ut/0yJx9vvkXV040Pc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dI35jmjmO7wAr1RdI3l64+XbXFazbFWT4VoOxk5d1r80QCIqGpMXNZPS+d3P3Rsp+
         sQdqcC7ZoHug+AGTmeWhRYg8kLKk1ysck+uRLRE5Is9mZRknxE6MMNL78As5wz5InI
         yd6SJlzLLk6vCzDz/1Pz1dKh7P7lcEXmbB3WXm7s=
Message-ID: <1571322426.21909.13.camel@kernel.org>
Subject: Re: [PATCH] tracing: fix "gfp_t" format for synthetic events
From:   Tom Zanussi <zanussi@kernel.org>
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>, rostedt@goodmis.org,
        mingo@redhat.com, tom.zanussi@linux.intel.com
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 17 Oct 2019 09:27:06 -0500
In-Reply-To: <20191017083813.31768-1-zhengjun.xing@linux.intel.com>
References: <20191017083813.31768-1-zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhengjun,

On Thu, 2019-10-17 at 16:38 +0800, Zhengjun Xing wrote:
> In the format of synthetic events, the "gfp_t" is shown as
> "signed:1",
> but in fact the "gfp_t" is "unsigned", should be shown as "signed:0".
> The offset should be increased by the real size of each field, rather
> than by the size of "u64".
> 
> The issue can be reproduced by the following commands:
> 
> echo 'memlatency u64 lat; unsigned int order; gfp_t gfp_flags; int
> migratetype' > /sys/kernel/debug/tracing/synthetic_events
> cat  /sys/kernel/debug/tracing/events/synthetic/memlatency/format
> 
> name: memlatency
> ID: 2233
> format:
>         field:unsigned short
> common_type;       offset:0;       size:2; signed:0;
>         field:unsigned char
> common_flags;       offset:2;       size:1; signed:0;
>         field:unsigned char
> common_preempt_count;       offset:3;       size:1; signed:0;
>         field:int common_pid;   offset:4;       size:4; signed:1;
> 
>         field:u64 lat;  offset:8;       size:8; signed:0;
>         field:unsigned int order;       offset:16;      size:4;
> signed:0;
>         field:gfp_t gfp_flags;  offset:24;      size:4; signed:1;
>         field:int migratetype;  offset:32;      size:4; signed:1;
> 
> print fmt: "lat=%llu, order=%u, gfp_flags=%x, migratetype=%d", REC-
> >lat, REC->order, REC->gfp_flags, REC->migratetype
> 
> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> ---
>  kernel/trace/trace_events_hist.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c
> b/kernel/trace/trace_events_hist.c
> index 57648c5aa679..7d70321d03b1 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -665,7 +665,7 @@ static int synth_event_define_fields(struct
> trace_event_call *call)
>  			offset += STR_VAR_LEN_MAX;
>  			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
>  		} else {
> -			offset += sizeof(u64);
> +			offset += size;
>  			n_u64++;
>  		}
>  	}

This part isn't correct - currently, all the synthetic event fields are
u64, so doing this alone will mess things up.  The synthetic fields
were defined to be u64 in order to simplify event generation - if we
want to use the actual sizes, it would take a more extensive patch
including the generation code as well.  Not sure the added complexity
is worth it to save a few bytes in the ring buffer.

> @@ -679,6 +679,8 @@ static bool synth_field_signed(char *type)
>  {
>  	if (str_has_prefix(type, "u"))
>  		return false;
> +	if (strcmp(type, "gfp_t") == 0)
> +		return false;
>  
>  	return true;
>  }


This part is fine and makes sense.

Thanks,

Tom
