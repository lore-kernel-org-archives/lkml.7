Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2A1C00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636E1206F0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="tnVP3zsf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgACWhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 17:37:14 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39630 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbgACWhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 17:37:13 -0500
Received: by mail-pf1-f194.google.com with SMTP id q10so24104670pfs.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 14:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9z2Jrxz8B+NqLAfVzgb4mOFXsmumv7Pnna32uCgS49s=;
        b=tnVP3zsfQZQf9IWPzBds6IQBbwJHd5p9iz+Gd5cjZpF6689inCWlaBe62w13DNeDts
         ej4KRjVqOYZWa2LQT+cejZuDr+nfEP45lqqszvee0l3CRBTAE+l9TQ9hSaujLNxnVLY4
         yRsI7qYYntWPdQ8etEekh8I+a+JLY87H+cSFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9z2Jrxz8B+NqLAfVzgb4mOFXsmumv7Pnna32uCgS49s=;
        b=GmfjFNQuBYPKtAkKZcOgv9h+LrzqeCWzXzE3+phgLkdCHu4FLjnavC+I0jAr3N7I2V
         h4D6omz+UUVnB015FcG4vwgau4WiNIDToy86xaWYrRcuTPPG2g+iffoW71S1VIGdtA3p
         DsBnN4arD1nX6lBZdlHhbe2Em2cHlrgRxMn6TurT8VyhVdMwYYmXqwp1HWUzmTCZ13qZ
         /dQV7XkXqHwuGrvlO4FGJyp5mV9ujfA2lnKRBKtxJwjT9sRh8zr8m6XW3V+ulwy967/+
         Eq6wkDjLlTmyYJeM2TfCVJV0PvjJmNNoRKuEfYP3VS33fvPtK5Ano3bmvEHuNQirwYt3
         CNKw==
X-Gm-Message-State: APjAAAXfg8CttznrWeNjOac5Vl3gFVERNmTc+rj1v9os74Cslw024oqs
        f98RFj18vU91kFVjgD/tmiiVJg==
X-Google-Smtp-Source: APXvYqzpnbI/U+FXATVw6oepP5oCLfwSzNcTTRQEFKLasS2pqKhvrl+bnWY6k6IPH03t2uMqwxWP/A==
X-Received: by 2002:a63:de03:: with SMTP id f3mr100645112pgg.141.1578091033299;
        Fri, 03 Jan 2020 14:37:13 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z6sm54042858pfa.155.2020.01.03.14.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 14:37:12 -0800 (PST)
Date:   Fri, 3 Jan 2020 17:37:11 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        saiprakash.ranjan@codeaurora.org, nachukannan@gmail.com
Subject: Re: [PATCH] tracing: Resets the trace buffer after a snapshot
Message-ID: <20200103223711.GC189259@google.com>
References: <20191231085822.yxhph6wcguejb7al@frank-laptop>
 <20200103114001.2c118ab1@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103114001.2c118ab1@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 11:40:01AM -0500, Steven Rostedt wrote:
> On Tue, 31 Dec 2019 03:58:22 -0500
> "Frank A. Cancio Bello" <frank@generalsoftwareinc.com> wrote:
> 
> > Currently, when a snapshot is taken the trace_buffer and the
> > max_buffer are swapped. After this swap, the "new" trace_buffer is
> > not reset. This produces an odd behavior: after a snapshot is taken
> > the previous snapshot entries become available to the next reader of
> > the trace_buffer as far as the reading occurs before the buffer is
> > refilled with new entries by a writer.
> 
> I consider this a feature not a bug ;-)
> 
> Anyway, this behavior should be determined by an option. Care to create
> one? (reset_on_snapshot?) I would keep the default behavior the same,
> but document this a bit better.

I relate to what Steve said as well. It is not strictly a bug per-se. An
option to do this would be nice but I am doubting a user will really turn on
such option (or even know an option exists) ;-). I would say leave it in the
current state unless some usecase is disrupted by the current behavior..

thanks!

 - Joel


> 
> Thanks!
> 
> -- Steve
> 
> > 
> > This patch resets the trace buffer after a snapshot is taken.
> > 
> > Signed-off-by: Frank A. Cancio Bello <frank@generalsoftwareinc.com>
> > ---
> > 
> > The following commands illustrate this odd behavior:
> > 
> > # cd /sys/kernel/debug/tracing
> > # echo nop > current_tracer
> > # echo 1 > tracing_on
> > # echo m1 > trace_marker
> > # echo 1 > snapshot
> > # echo m2 > trace_marker
> > # echo 1 > snapshot
> > # cat trace
> > # tracer: nop
> > #
> > # entries-in-buffer/entries-written: 1/1   #P:2
> > #
> > #                              _-----=> irqs-off
> > #                             / _----=> need-resched
> > #                            | / _---=> hardirq/softirq
> > #                            || / _--=> preempt-depth
> > #                            ||| /     delay
> > #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> > #              | |       |   ||||       |         |
> >             bash-550   [000] ....    50.479755: tracing_mark_write: m1
> > 
> > 
> >  kernel/trace/trace.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index ddb7e7f5fe8d..58373b5ae0cf 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -6867,10 +6867,13 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
> >  			break;
> >  		local_irq_disable();
> >  		/* Now, we're going to swap */
> > -		if (iter->cpu_file == RING_BUFFER_ALL_CPUS)
> > +		if (iter->cpu_file == RING_BUFFER_ALL_CPUS) {
> >  			update_max_tr(tr, current, smp_processor_id(), NULL);
> > -		else
> > +			tracing_reset_online_cpus(&tr->trace_buffer);
> > +		} else {
> >  			update_max_tr_single(tr, current, iter->cpu_file);
> > +			tracing_reset_cpu(&tr->trace_buffer, iter->cpu_file);
> > +		}
> >  		local_irq_enable();
> >  		break;
> >  	default:
> 
