Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA036C2D0C2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 19:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50E321655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 19:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OGi5G4e0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgABTxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 14:53:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46448 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbgABTxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 14:53:17 -0500
Received: by mail-pl1-f193.google.com with SMTP id y8so18183671pll.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 11:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nNE7nxiMOHhNQ2zWJXigqMAR0pKRSawVm+iGS8N5/rk=;
        b=OGi5G4e0MGP5zSP7OHdg0uZJ+Yg1uGgbvrWTDBCiSvXn4IjvXPBs+0p4HBQrMYFJ9p
         6QAfy1sZbtxDKZXmOO/R4xkdzb+rHkKUDMLV1h0VoiU89v+V3JUDxVsnn896dturiyrg
         KJeWFgQ7BYoUVm6OLSUapiwVsHG6d7Cl0igPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nNE7nxiMOHhNQ2zWJXigqMAR0pKRSawVm+iGS8N5/rk=;
        b=Sn4PNA4U41s3xPwHjjCmEk4Ifz7Qa9W4VJUv6rxmZgRsfmktf/l0qz2ayQnG2yQiq/
         BcG+2JuicAuADJ790G3r87xMZDD1ZZOJBMD+TbBuR4Htet4x9LjR/AvapaxolSy1yqVi
         5y5DokY4lPq972IoW7QJtt1Hu10bzhOif/APToq1lx9AQyt9oq8e2OwtZZ7DhFNkVxFx
         CHQcrDaISgdB6Rv9EgAijQVB3oA+58sivUKZuWVjQYz3kbAh5okPi5dubtb3+BAmHny9
         nG+Bctt4h31kQImDX+MO03GT7CxRmTDuo8csBW2Ef0hS+TANCVUnQ2VjQm2DhspgH0ZG
         iepg==
X-Gm-Message-State: APjAAAWTeSmQESTX1ZWTc72wZp1uz4YqUHVl+0vigyECUVgcnudt2+g8
        Kl+5ZNVXX+lZN/TnxWUvzi+RtNJTavw=
X-Google-Smtp-Source: APXvYqy/R+36CiqUMUAf+/qlTm7lPsQwgVHBfcUlFHRAAY+sRLqjXug+95ypeJnMlNd+If7cQ8egVA==
X-Received: by 2002:a17:90a:f84:: with SMTP id 4mr22094454pjz.74.1577994796375;
        Thu, 02 Jan 2020 11:53:16 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z13sm12100871pjz.15.2020.01.02.11.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 11:53:15 -0800 (PST)
Date:   Thu, 2 Jan 2020 14:53:14 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Antonio Borneo <antonio.borneo@st.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] tracing: Fix printing ptrs in preempt/irq enable/disable
 events
Message-ID: <20200102195314.GA227154@google.com>
References: <20191127154428.191095-1-antonio.borneo@st.com>
 <20191204092115.30ef75c9@gandalf.local.home>
 <20191221234741.GA116648@google.com>
 <20191223151301.20be63f7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223151301.20be63f7@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 03:13:01PM -0500, Steven Rostedt wrote:
> On Sat, 21 Dec 2019 18:47:41 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > On Wed, Dec 04, 2019 at 09:21:15AM -0500, Steven Rostedt wrote:
> > > 
> > > Joel,
> > > 
> > > Any comments on this patch?  
> > 
> > Steve, it looks like this issue happens with trace-cmd not knowing what
> > _stext is. If I do cat trace_pipe , then I don't see the issue as _stext is
> > looked up correctly but the reporter of the bug is using trace-cmd. Is there
> > a way to solve this within trace-cmd? Not knowing much about trace-cmd
> > internals, I will have to defer to you on this though..
> > 
> > Other than this, I need to make the offset to _stext as s32 instead of u32
> > type so that the problem of the symbol location being before _stext does not
> > cause overflow.
> > 
> > Lastly, I am not super convinced that we need to store the full pointer just
> > to handle a case where the offset of the symbol might be more than +-2G from
> > _stext. Once we see such issue, then we can handle it. But right now the size
> > of the trace buffer is utilized better by just storing the offset IMHO.
> >
> 
> Does this fix it for you?

I am guessing this question is for Antonio to try Steve's patch with trace-cmd.
Meanwhile I posted a patch to fix the offset issue by changing the u32 to s32.

thanks,

 - Joel

> 
> -- Steve
> 
> diff --git a/lib/traceevent/event-parse.c b/lib/traceevent/event-parse.c
> index 4fd3907e..dc705dd2 100644
> --- a/lib/traceevent/event-parse.c
> +++ b/lib/traceevent/event-parse.c
> @@ -3595,6 +3595,45 @@ tep_find_event_by_name(struct tep_handle *tep,
>  	return event;
>  }
>  
> +static unsigned long long test_for_symbol(struct tep_handle *tep,
> +					  struct tep_print_arg *arg)
> +{
> +	unsigned long long val = 0;
> +	struct func_list *item = tep->funclist;
> +	char *func;
> +	int i;
> +
> +	if (isdigit(arg->atom.atom[0]))
> +		return 0;
> +
> +	for (i = 0; i < (int)tep->func_count; i++) {
> +		unsigned long long addr;
> +		const char *name;
> +
> +		if (tep->func_map) {
> +			addr = tep->func_map[i].addr;
> +			name = tep->func_map[i].func;
> +		} else if (item) {
> +			addr = item->addr;
> +			name = item->func;
> +			item = item->next;
> +		} else
> +			break;
> +
> +		if (strcmp(arg->atom.atom, name) == 0) {
> +			val = addr;
> +			break;
> +		}
> +	}
> +
> +	func = realloc(arg->atom.atom, 32);
> +	if (func) {
> +		snprintf(func, 32, "%lld", val);
> +		arg->atom.atom = func;
> +	}
> +	return val;
> +}
> +
>  static unsigned long long
>  eval_num_arg(void *data, int size, struct tep_event *event, struct tep_print_arg *arg)
>  {
> @@ -3611,7 +3650,10 @@ eval_num_arg(void *data, int size, struct tep_event *event, struct tep_print_arg
>  		/* ?? */
>  		return 0;
>  	case TEP_PRINT_ATOM:
> -		return strtoull(arg->atom.atom, NULL, 0);
> +		val = strtoull(arg->atom.atom, NULL, 0);
> +		if (!val)
> +			val = test_for_symbol(tep, arg);
> +		return val;
>  	case TEP_PRINT_FIELD:
>  		if (!arg->field.field) {
>  			arg->field.field = tep_find_any_field(event, arg->field.name);
