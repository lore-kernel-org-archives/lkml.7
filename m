Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAF2C33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C9320866
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 10:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=generalsoftwareinc-com.20150623.gappssmtp.com header.i=@generalsoftwareinc-com.20150623.gappssmtp.com header.b="fUDxvGN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgAEKbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 05:31:16 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33943 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgAEKbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 05:31:16 -0500
Received: by mail-ua1-f68.google.com with SMTP id 1so16140544uao.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 02:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=generalsoftwareinc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EOMcHHzYktjweX7GWu8Qxhd5Ztkc/MhTgej/iqpn8mQ=;
        b=fUDxvGN7vi8s6r5QSwK0BZAPOw9uBb7ETHGS02FCWJnCkGfILsiy1bsf7WDx2UDbzj
         FgHCJlYCis3kHj2vGU1JKRAKKe9xO0P0haJsiyogM2xndiI+BS+F8M9Z5DXaP7okJoJH
         sF0fxNxPDEPSN09WWSugZctBCDcqPMSkpp85gLmHh6QFPAhKHAoTgwvdME81iG++U2hK
         tS7ROJXYJy69upI4l50ZYRTyK0k06LPJh3mvNjj55scMj/7HBnVbs/Zp7+82MgRTqUnn
         URKZPoYjaAYrqvWvRd575ey/g+qlxdnX4vrH0osC1N45KH2dhjWOJ+kDai0xrl1Dam60
         eF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EOMcHHzYktjweX7GWu8Qxhd5Ztkc/MhTgej/iqpn8mQ=;
        b=UQ9Y+Xn5jZFQ91Ko8F7lBNtBp5SEIxt2vf9fwjEI4VOX4A0Th1AuSAot7mCAnw+6iR
         /30bDyxlaa9iB5YslBC7QAldH1aqtUJIiP0hjfk/mUoKac5YcYkDc0T9WZJ89ciHgjmc
         6b2RhJYCjP7dzy8uXHB52PLhE+25udj7NSl8Ii6CYXbCwTdlbehdk1WRIzc8VItcH5Kl
         obef4ytCJxFnVVdi9HpLm1V+6F1d3GSZLPIZUCP4U0pEmAlGyUK9qhgvchbD9zPrIWYo
         c2h4pPZVHVxHWe5Qt1oCgxgRiIHQEnp6VuANvPPP6lBqStdYQTRXkcyf4eV17BGb3ILp
         ieQw==
X-Gm-Message-State: APjAAAVSVTFK193ZF1mL1zsId1a217r/xdSHk5ZhKTTYC06coD/1atof
        ovE089vTJMA+7l7DpasCv6X/0g==
X-Google-Smtp-Source: APXvYqwVo0JGbdODTzWZ7E8NaCLGnQCccEvBb8rbukOcYnVtr5PxVRpikRHxm7wCOifB2liifpRBtA==
X-Received: by 2002:ab0:65c1:: with SMTP id n1mr11904746uaq.28.1578220274302;
        Sun, 05 Jan 2020 02:31:14 -0800 (PST)
Received: from frank-laptop ([204.28.111.43])
        by smtp.gmail.com with ESMTPSA id s21sm8471910uao.11.2020.01.05.02.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 02:31:13 -0800 (PST)
Date:   Sun, 5 Jan 2020 05:31:13 -0500
From:   "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        saiprakash.ranjan@codeaurora.org, nachukannan@gmail.com
Subject: Re: [PATCH] tracing: Resets the trace buffer after a snapshot
Message-ID: <20200105103113.flhx26366zoqcgak@frank-laptop>
References: <20191231085822.yxhph6wcguejb7al@frank-laptop>
 <20200103114001.2c118ab1@gandalf.local.home>
 <20200103223711.GC189259@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103223711.GC189259@google.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 05:37:11PM -0500, Joel Fernandes wrote:
> On Fri, Jan 03, 2020 at 11:40:01AM -0500, Steven Rostedt wrote:
> > On Tue, 31 Dec 2019 03:58:22 -0500
> > "Frank A. Cancio Bello" <frank@generalsoftwareinc.com> wrote:
> > 
> > > Currently, when a snapshot is taken the trace_buffer and the
> > > max_buffer are swapped. After this swap, the "new" trace_buffer is
> > > not reset. This produces an odd behavior: after a snapshot is taken
> > > the previous snapshot entries become available to the next reader of
> > > the trace_buffer as far as the reading occurs before the buffer is
> > > refilled with new entries by a writer.
> > 
> > I consider this a feature not a bug ;-)
> > 
> > Anyway, this behavior should be determined by an option. Care to create
> > one? (reset_on_snapshot?) I would keep the default behavior the same,
> > but document this a bit better.
> 
> I relate to what Steve said as well. It is not strictly a bug per-se. An
> option to do this would be nice but I am doubting a user will really turn on
> such option (or even know an option exists) ;-). I would say leave it in the
> current state unless some usecase is disrupted by the current behavior..
> 

Thank you both for your answers. I'm wondering what would be the reason
for not resetting the trace buffer after it gets swapped with the snapshot
buffer. Given that resetting it's not expensive, I would say that is not
performance, so I'm intrigued ;)

If it's OK, I will send two patches then, one documenting explicitly
that the trace buffer it will not be reset after be swapped and the
implications of this, and the second one changing the documentation of
the field trace_array->max_buffer that I now realized that say:

"
/*
...
* The buffers for the max_buffer are set up the same as the trace_buffer
* When a snapshot is taken, the buffer of the max_buffer is swapped
* with the buffer of the trace_buffer and the buffers are reset for
* the trace_buffer so the tracing can continue.
*/

thanks
frank a.

> thanks!
> 
>  - Joel
> 
> 
> > 
> > Thanks!
> > 
> > -- Steve
> > 
> > > 
> > > This patch resets the trace buffer after a snapshot is taken.
> > > 
> > > Signed-off-by: Frank A. Cancio Bello <frank@generalsoftwareinc.com>
> > > ---
> > > 
> > > The following commands illustrate this odd behavior:
> > > 
> > > # cd /sys/kernel/debug/tracing
> > > # echo nop > current_tracer
> > > # echo 1 > tracing_on
> > > # echo m1 > trace_marker
> > > # echo 1 > snapshot
> > > # echo m2 > trace_marker
> > > # echo 1 > snapshot
> > > # cat trace
> > > # tracer: nop
> > > #
> > > # entries-in-buffer/entries-written: 1/1   #P:2
> > > #
> > > #                              _-----=> irqs-off
> > > #                             / _----=> need-resched
> > > #                            | / _---=> hardirq/softirq
> > > #                            || / _--=> preempt-depth
> > > #                            ||| /     delay
> > > #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> > > #              | |       |   ||||       |         |
> > >             bash-550   [000] ....    50.479755: tracing_mark_write: m1
> > > 
> > > 
> > >  kernel/trace/trace.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > > index ddb7e7f5fe8d..58373b5ae0cf 100644
> > > --- a/kernel/trace/trace.c
> > > +++ b/kernel/trace/trace.c
> > > @@ -6867,10 +6867,13 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
> > >  			break;
> > >  		local_irq_disable();
> > >  		/* Now, we're going to swap */
> > > -		if (iter->cpu_file == RING_BUFFER_ALL_CPUS)
> > > +		if (iter->cpu_file == RING_BUFFER_ALL_CPUS) {
> > >  			update_max_tr(tr, current, smp_processor_id(), NULL);
> > > -		else
> > > +			tracing_reset_online_cpus(&tr->trace_buffer);
> > > +		} else {
> > >  			update_max_tr_single(tr, current, iter->cpu_file);
> > > +			tracing_reset_cpu(&tr->trace_buffer, iter->cpu_file);
> > > +		}
> > >  		local_irq_enable();
> > >  		break;
> > >  	default:
> > 
