Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35592C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CFB2168B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fwzbb2OS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfIXThZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 15:37:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43651 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730848AbfIXThY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 15:37:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id v27so1840287pgk.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 12:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QW+249ial7QzHQHqlUgktYZHv/cyg56Wf/nsHq4ceaQ=;
        b=Fwzbb2OSAetj8lqkxX5sf57e6bXzvjjYE68BFDR2tYXtKVGODpEl1+w1WUyJvsQBW4
         OSWWmIV0NhQFMoSMTWBIB4AV24YwrmbScmOBCkgVjit0+TNa9POMFKvXxH1hguF7qMTT
         zBiqDZH+McM18Aw4+QLySAcRjr43P3oEVcui8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QW+249ial7QzHQHqlUgktYZHv/cyg56Wf/nsHq4ceaQ=;
        b=C4yD9U6Ll1vfyajNpg+D40bd26ja8a+IvZ9/8hpeFWqDJdb0WWBjagj6ZlZ204w9xa
         qB2iY3ADfeR4EWV1fUj3YfMojoa0745MZei4J4IsPin0xyK5KA0HcOBTLabrf0y7j/ap
         JSJO3Bjot6Efk1/cwW1v/NNAUKj+qIrLL5vGjRurlJ2JQFfLfJSJ3bz6irjsYfR3ON96
         O+949cntASvit6/NCT2fSs9zZtWsT/6nEX/9E5tCEGG5zPQsScgd9pc89ivbbvC6cJJU
         hyS4FU6JrLw/gfnmY4WWCEeS0seg0CEeJOCkxVDbmzwKIVd4P1+s4ZsOS9fllXyNHLDl
         ocEw==
X-Gm-Message-State: APjAAAWweWUV1IrJ5/MiuIa1JDEhBEcvgYvHVJRwkdYcu+z+pAdLIb91
        QCxrkegeafLVbmsYjo2JSQ1szuRtsTQ=
X-Google-Smtp-Source: APXvYqwjrnnx+fSxwpBpsvp+uJBagX1I5OMNA2jwz4ZDbaee7VMqZhC9t+TGv9VXP6P/amMFIupW5Q==
X-Received: by 2002:a17:90a:3301:: with SMTP id m1mr1855164pjb.27.1569353843983;
        Tue, 24 Sep 2019 12:37:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id c14sm3403030pfm.179.2019.09.24.12.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 12:37:23 -0700 (PDT)
Date:   Tue, 24 Sep 2019 12:37:21 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] devfreq: Add tracepoint for frequency changes
Message-ID: <20190924193721.GK133864@google.com>
References: <CGME20190919174436epcas4p17bf0528950813d3326237fcc56fd9b21@epcas4p1.samsung.com>
 <20190919174423.105030-1-mka@chromium.org>
 <62b2228b-e198-2558-2afc-e5687935742b@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62b2228b-e198-2558-2afc-e5687935742b@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 10:15:57AM +0900, Chanwoo Choi wrote:
> Hi,

sorry for the delayed response, you message got buried in my
mailbox.

> On 19. 9. 20. 오전 2:44, Matthias Kaehlcke wrote:
> > Add a tracepoint for frequency changes of devfreq devices and
> > use it.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > (sending v2 without much delay wrt v1, since the change in devfreq
> >  probably isn't controversial, and I'll be offline a few days)
> > 
> > Changes in v2:
> > - included trace_devfreq_frequency_enabled() in the condition
> >   to avoid unnecessary evaluation when the trace point is
> >   disabled
> > ---
> >  drivers/devfreq/devfreq.c      |  3 +++
> >  include/trace/events/devfreq.h | 18 ++++++++++++++++++
> >  2 files changed, 21 insertions(+)
> > 
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index ab22bf8a12d6..e9f04dcafb01 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -317,6 +317,9 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
> >  
> >  	devfreq->previous_freq = new_freq;
> >  
> > +	if (trace_devfreq_frequency_enabled() && new_freq != cur_freq)
> > +		trace_devfreq_frequency(devfreq, new_freq);
> 
> You can change as following without 'new_freq' variable
> because devfreq->previous_freq is the new frequency.	
> 	trace_devfreq_frequency(devfreq);

In general that sounds good.

devfreq essentially uses df->previous_freq as df->cur_freq, I think
most code using it would be clearer if we renamed it accordingly.
I'll send a separate patch for this.

> > +
> >  	if (devfreq->suspend_freq)
> >  		devfreq->resume_freq = cur_freq;
> >  
> > diff --git a/include/trace/events/devfreq.h b/include/trace/events/devfreq.h
> > index cf5b8772175d..a62d32fe3c33 100644
> > --- a/include/trace/events/devfreq.h
> > +++ b/include/trace/events/devfreq.h
> > @@ -8,6 +8,24 @@
> >  #include <linux/devfreq.h>
> >  #include <linux/tracepoint.h>
> >  
> > +TRACE_EVENT(devfreq_frequency,
> > +	TP_PROTO(struct devfreq *devfreq, unsigned long freq),
> 
> 'unsigned long freq' parameter is not necessary.
> 
> > +
> > +	TP_ARGS(devfreq, freq),
> > +
> > +	TP_STRUCT__entry(
> > +		__string(dev_name, dev_name(&devfreq->dev))
> > +		__field(unsigned long, freq)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__assign_str(dev_name, dev_name(&devfreq->dev));
> > +		__entry->freq = freq;
> 
> Initialize the new frequency with 'devfreq->previous_freq' as following:
> 
> 		__entry->freq = devfreq->previous_freq;
> 
> > +	),
> > +
> > +	TP_printk("dev_name=%s freq=%lu", __get_str(dev_name), __entry->freq)
> > +);
> > +
> >  TRACE_EVENT(devfreq_monitor,
> >  	TP_PROTO(struct devfreq *devfreq),
> >  
> > 
> 
> 
> -- 
> Best Regards,
> Chanwoo Choi
> Samsung Electronics
