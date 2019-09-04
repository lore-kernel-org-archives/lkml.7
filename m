Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3722FC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D22622CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567602843;
	bh=ApIlzumSG2XRizv2fQ/w6se2CSvynXPZsfEwE6QrSSw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=ObPCa//ovyn+px0MYMHWdq16A7de9oDFYw+/n0Gj65R7fBkfDGKw3GQZHTyhYkixu
	 efLcPgkz2244pTfcudSSr8I4QBaMgMVs+gip3VKLh2HANYBiYHLBJv5EFJ2X7Agres
	 KWrjaoRjUvjv/Y5slPonwrpLNbik4sRukUdSHbkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbfIDNOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 09:14:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729471AbfIDNOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 09:14:01 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ED202168B;
        Wed,  4 Sep 2019 13:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567602840;
        bh=ApIlzumSG2XRizv2fQ/w6se2CSvynXPZsfEwE6QrSSw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ul7jJOLhJySRF7/S/f4iXEa53oVHhmU76IJFh1/2KWvuSuYyEUO0DcqyBlL5MPomC
         XR9Ob8O6Goc77LDaYRilBSiLYbafmGso7CPpi+jA7WFcsrnx8q+EgLIHkYfjbdMAq7
         NxvFwO39Mrwn1jaOLzvyOLqoBj2gK/kAbCQ9hNY0=
Message-ID: <1567602838.13841.1.camel@kernel.org>
Subject: Re: [PATCH v3] trace:Add "gfp_t" support in synthetic_events
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Zhengjun Xing <zhengjun.xing@linux.intel.com>, mingo@redhat.com,
        tom.zanussi@linux.intel.com, linux-kernel@vger.kernel.org
Date:   Wed, 04 Sep 2019 08:13:58 -0500
In-Reply-To: <20190904064327.28876d71@oasis.local.home>
References: <20190712015308.9908-1-zhengjun.xing@linux.intel.com>
         <1562947506.12920.0.camel@kernel.org>
         <20190904064327.28876d71@oasis.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, 2019-09-04 at 06:43 -0400, Steven Rostedt wrote:
> On Fri, 12 Jul 2019 11:05:06 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > Hi Zhengjun,
> > 
> > On Fri, 2019-07-12 at 09:53 +0800, Zhengjun Xing wrote:
> > > Add "gfp_t" support in synthetic_events, then the "gfp_t" type
> > > parameter in some functions can be traced.
> > > 
> > > Prints the gfp flags as hex in addition to the human-readable
> > > flag
> > > string.  Example output:
> > > 
> > >   whoopsie-630 [000] ...1 78.969452: testevent: bar=b20
> > > (GFP_ATOMIC|__GFP_ZERO)
> > >     rcuc/0-11  [000] ...1 81.097555: testevent: bar=a20
> > > (GFP_ATOMIC)
> > >     rcuc/0-11  [000] ...1 81.583123: testevent: bar=a20
> > > (GFP_ATOMIC)
> > > 
> > > Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> 
> Why is this Signed-off-by Tom? Tom, did you author part of this??
> 

Yeah, I added the part that prints the flag names.

Tom

> -- Steve
> 
> > > Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>  
> > 
> > Looks good to me, thanks!
> > 
> > Tom
> > 
> > > ---
> > >  kernel/trace/trace_events_hist.c | 19 +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > > 
> > > diff --git a/kernel/trace/trace_events_hist.c
> > > b/kernel/trace/trace_events_hist.c
> > > index ca6b0dff60c5..30f0f32aca62 100644
> > > --- a/kernel/trace/trace_events_hist.c
> > > +++ b/kernel/trace/trace_events_hist.c
> > > @@ -13,6 +13,10 @@
> > >  #include <linux/rculist.h>
> > >  #include <linux/tracefs.h>
> > >  
> > > +/* for gfp flag names */
> > > +#include <linux/trace_events.h>
> > > +#include <trace/events/mmflags.h>
> > > +
> > >  #include "tracing_map.h"
> > >  #include "trace.h"
> > >  #include "trace_dynevent.h"
> > > @@ -752,6 +756,8 @@ static int synth_field_size(char *type)
> > >  		size = sizeof(unsigned long);
> > >  	else if (strcmp(type, "pid_t") == 0)
> > >  		size = sizeof(pid_t);
> > > +	else if (strcmp(type, "gfp_t") == 0)
> > > +		size = sizeof(gfp_t);
> > >  	else if (synth_field_is_string(type))
> > >  		size = synth_field_string_size(type);
> > >  
> > > @@ -792,6 +798,8 @@ static const char *synth_field_fmt(char
> > > *type)
> > >  		fmt = "%lu";
> > >  	else if (strcmp(type, "pid_t") == 0)
> > >  		fmt = "%d";
> > > +	else if (strcmp(type, "gfp_t") == 0)
> > > +		fmt = "%x";
> > >  	else if (synth_field_is_string(type))
> > >  		fmt = "%s";
> > >  
> > > @@ -834,9 +842,20 @@ static enum print_line_t
> > > print_synth_event(struct trace_iterator *iter,
> > >  					 i == se->n_fields - 1 ?
> > > ""
> > > : " ");
> > >  			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
> > >  		} else {
> > > +			struct trace_print_flags __flags[] = {
> > > +			    __def_gfpflag_names, {-1, NULL} };
> > > +
> > >  			trace_seq_printf(s, print_fmt, se-  
> > > > fields[i]->name,  
> > > 
> > >  					 entry->fields[n_u64],
> > >  					 i == se->n_fields - 1 ?
> > > ""
> > > : " ");
> > > +
> > > +			if (strcmp(se->fields[i]->type, "gfp_t")
> > > ==
> > > 0) {
> > > +				trace_seq_puts(s, " (");
> > > +				trace_print_flags_seq(s, "|",
> > > +						      entry-  
> > > > fields[n_u64],  
> > > 
> > > +						      __flags);
> > > +				trace_seq_putc(s, ')');
> > > +			}
> > >  			n_u64++;
> > >  		}
> > >  	}  
> 
> 
