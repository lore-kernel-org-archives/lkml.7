Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E285BC2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 23:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FE9206C3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 23:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BtXPVluI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfLUXrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 18:47:43 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34955 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfLUXrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 18:47:43 -0500
Received: by mail-pj1-f68.google.com with SMTP id s7so5794370pjc.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Dec 2019 15:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fXy9xPSzwrsW14AMvNrH3dau8w//YzJTAr3l1Saqoig=;
        b=BtXPVluI1WJZfcKt5Lud61D40VYwvpo6G9Kp/Zsin1sj39dw2Dx681RY9uOB4Vqs28
         JWjDIAY4lEvhH95dllicpVB7VvOZflG+nvB9i8ly9SVnTnh8T8+NDo+HmIZwRePTp1jS
         jmtmCvrpP5x12TX5TYu5W4Vk+6pEm5t36iekU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fXy9xPSzwrsW14AMvNrH3dau8w//YzJTAr3l1Saqoig=;
        b=UM1T2qYGuXFg/oc8ZJ3QeZcIammvIjUccmD6BCiFM9Rg0VLr4iqbw4jNNep7wmjEZ7
         jT6QHsS3T0vFDtduOoaYLlu9rJ63Ucf7zgeVmZyxAFcbRD5dMlS7upqQdForOy18fhOC
         3eEfANviaCyY6v85JC/PKuvjwC7+J4hLiNZgxkNUEOViZ8w00WQ9CNj8QL9OlB0SMuMi
         kijK55Ef64eej63TvJZEAjXvXy3Uga/FGN3Sk8/vaLPX9NNZ4WFgDrKqD90jm2Itn/ex
         ekllPi4TPlMPX6ZlyTpnvzR3HvpkyfMwfZ7xf5FH9UFNfOSD/r9ONojByGy46cPaMws2
         OugQ==
X-Gm-Message-State: APjAAAV8EOBB35yRtMReAPtDkn1IfZjO5TuqXlISRXyEi1MyUOu9MTsr
        IJCjCNOxe2ghI0Wo51rPj9kqEQ==
X-Google-Smtp-Source: APXvYqzqzkp+eh1lKWYNwRToIgvfbaM/icchIpqxyrT/W118lizYV6091XMmfU8VB14/yYGANC8/Ew==
X-Received: by 2002:a17:902:8bc9:: with SMTP id r9mr22866985plo.48.1576972062452;
        Sat, 21 Dec 2019 15:47:42 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 133sm18161268pfy.14.2019.12.21.15.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 15:47:42 -0800 (PST)
Date:   Sat, 21 Dec 2019 18:47:41 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Antonio Borneo <antonio.borneo@st.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] tracing: Fix printing ptrs in preempt/irq enable/disable
 events
Message-ID: <20191221234741.GA116648@google.com>
References: <20191127154428.191095-1-antonio.borneo@st.com>
 <20191204092115.30ef75c9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204092115.30ef75c9@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 09:21:15AM -0500, Steven Rostedt wrote:
> 
> Joel,
> 
> Any comments on this patch?

Steve, it looks like this issue happens with trace-cmd not knowing what
_stext is. If I do cat trace_pipe , then I don't see the issue as _stext is
looked up correctly but the reporter of the bug is using trace-cmd. Is there
a way to solve this within trace-cmd? Not knowing much about trace-cmd
internals, I will have to defer to you on this though..

Other than this, I need to make the offset to _stext as s32 instead of u32
type so that the problem of the symbol location being before _stext does not
cause overflow.

Lastly, I am not super convinced that we need to store the full pointer just
to handle a case where the offset of the symbol might be more than +-2G from
_stext. Once we see such issue, then we can handle it. But right now the size
of the trace buffer is utilized better by just storing the offset IMHO.

thanks,

 - Joel


> 
> -- Steve
> 
> On Wed, 27 Nov 2019 16:44:28 +0100
> Antonio Borneo <antonio.borneo@st.com> wrote:
> 
> > This tracing event class is the only instance in kernel that logs
> > in the trace buffer the instruction pointer as offset to _stext,
> > instead of logging the full pointer.
> > This looks like a nice optimization for 64 bits platforms, where a
> > 32 bit offset can take less space than a full 64 bits pointer. But
> > the symbol _stext is incorrectly resolved as zero in the expansion
> > of TP_printk(), which then prints only the hex offset instead of
> > the name of the caller function. Plus, on arm arch the kernel
> > modules are loaded at address lower than _stext, causing the u32
> > offset arithmetics to overflow and wrap at 32 bits.
> > I did not identified a 64 bit arch where the modules are loaded at
> > offset from _stext that exceed u32 range, but I also did not
> > identified any constraint to feel safe with a u32 offset.
> > 
> > Log directly the instruction pointer instead of the offset to
> > _stext.
> > 
> > Signed-off-by: Antonio Borneo <antonio.borneo@st.com>
> > Fixes: d59158162e03 ("tracing: Add support for preempt and irq enable/disable events")
> > ---
> >  include/trace/events/preemptirq.h | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/trace/events/preemptirq.h b/include/trace/events/preemptirq.h
> > index 95fba0471e5b..d548a6aafa18 100644
> > --- a/include/trace/events/preemptirq.h
> > +++ b/include/trace/events/preemptirq.h
> > @@ -18,18 +18,18 @@ DECLARE_EVENT_CLASS(preemptirq_template,
> >  	TP_ARGS(ip, parent_ip),
> >  
> >  	TP_STRUCT__entry(
> > -		__field(u32, caller_offs)
> > -		__field(u32, parent_offs)
> > +		__field(unsigned long, caller_ip)
> > +		__field(unsigned long, parent_ip)
> >  	),
> >  
> >  	TP_fast_assign(
> > -		__entry->caller_offs = (u32)(ip - (unsigned long)_stext);
> > -		__entry->parent_offs = (u32)(parent_ip - (unsigned long)_stext);
> > +		__entry->caller_ip = ip;
> > +		__entry->parent_ip = parent_ip;
> >  	),
> >  
> >  	TP_printk("caller=%pS parent=%pS",
> > -		  (void *)((unsigned long)(_stext) + __entry->caller_offs),
> > -		  (void *)((unsigned long)(_stext) + __entry->parent_offs))
> > +		  (void *)__entry->caller_ip,
> > +		  (void *)__entry->parent_ip)
> >  );
> >  
> >  #ifdef CONFIG_TRACE_IRQFLAGS
> 
