Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA1FC4332F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 23:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D8E21744
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 23:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="aeYLQSYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395269AbfIGXiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 19:38:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36302 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfIGXiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 19:38:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id l21so5579325pgm.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 16:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O8KRr1lIqMqniA1MwlfijdRSpaSsSbMrc32dOS+yii0=;
        b=aeYLQSYqq1hi7dlyiv7kq2PH0uqNHpAVG2BBHub6DSIlUvT1Mti4f5OnYhV9Armd2t
         Q29qqYcmUTRkG3OdVfuyKRZSeeg7aaqSUkLThFqXs01tj24YYM8/gteq04P4bezynKPh
         NjmoNg8QYMkbE2XApsWshcVCJs+x22hH9+U0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O8KRr1lIqMqniA1MwlfijdRSpaSsSbMrc32dOS+yii0=;
        b=lPqe7U7kpq5kWM0+lWk/ps24oDhDnm1AQSDbA+FZDUnjcfwfdE4U5a50aSsO6GyHS7
         f7ohfq1x42IpTZ3zbHh2ouzzv1W+ibxf389JhPA+MQbPd6BdCq+jNQQszC+Zp/5WFnT5
         qNXl8YDOd5T34wJHBfyTQ9wp60S3jNeROcTGbozTkdep69cwwbHmhdaLMj/1r+8a/2p0
         Yc51907LtU+Xn6SBns8mxjibo2kCPP+q3x3TNMXOoLaeeP9v0dykTB898cy2/N30DYdo
         flMHkOnbr6sHtfA1ly93Wyv73RmD1koAtg6Rz1BYBacYq6/EOlZU81pYKeM/LMxK0rMa
         2Vsg==
X-Gm-Message-State: APjAAAVIKQQAtnkZJmZf4dd1w+JtwRqK3kS8pw2yoEcNxgvYP1AoRVq/
        Xoey8KsjXlz13Jr/YwhveLqUuQ==
X-Google-Smtp-Source: APXvYqy1/DrQJAPddhhSYSLAnm6bco9ZVAeKlhqYO9+qU0Tf/LXOeMbTXTiqX2GA3oq/Ckjis5/K+w==
X-Received: by 2002:a63:5550:: with SMTP id f16mr15262675pgm.426.1567899483709;
        Sat, 07 Sep 2019 16:38:03 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x8sm9870655pfm.35.2019.09.07.16.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 16:38:03 -0700 (PDT)
Date:   Sat, 7 Sep 2019 19:38:01 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Viktor Rosendahl <viktor.rosendahl@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/4] ftrace: Implement fs notification for
 tracing_max_latency
Message-ID: <20190907233801.GA117656@google.com>
References: <20190905132548.5116-1-viktor.rosendahl@gmail.com>
 <20190905132548.5116-2-viktor.rosendahl@gmail.com>
 <20190906141740.GA250796@google.com>
 <c35722db-bb79-7e09-ac02-e82ab827e1e3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c35722db-bb79-7e09-ac02-e82ab827e1e3@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 07, 2019 at 11:12:59PM +0200, Viktor Rosendahl wrote:
> On 9/6/19 4:17 PM, Joel Fernandes wrote:
> > On Thu, Sep 05, 2019 at 03:25:45PM +0200, Viktor Rosendahl wrote:
> <clip>
> > > +
> > > +__init static int latency_fsnotify_init(void)
> > > +{
> > > +	fsnotify_wq = alloc_workqueue("tr_max_lat_wq",
> > > +				      WQ_UNBOUND | WQ_HIGHPRI, 0);
> > > +	if (!fsnotify_wq) {
> > > +		pr_err("Unable to allocate tr_max_lat_wq\n");
> > > +		return -ENOMEM;
> > > +	}
> > 
> > Why not just use the system workqueue instead of adding another workqueue?
> > 
> 
> For the the latency-collector to work properly in the worst case, when a
> new latency occurs immediately, the fsnotify must be received in less
> time than what the threshold is set to. If we always are slower we will
> always lose certain latencies.
> 
> My intention was to minimize latency in some important cases, so that
> user space receives the notification sooner rather than later.
> 
> There doesn't seem to be any system workqueue with WQ_UNBOUND and
> WQ_HIGHPRI. My thinking was that WQ_UNBOUND might help with the latency
> in some important cases.
> 
> If we use:
> 
> queue_work(system_highpri_wq, &tr->fsnotify_work);
> 
> then the work will (almost) always execute on the same CPU but if we are
> unlucky that CPU could be too busy while there could be another CPU in
> the system that would be able to process the work soon enough.
> 
> queue_work_on() could be used to queue the work on another CPU but it
> seems difficult to select the right CPU.

Ok, a separate WQ is fine with me as such since the preempt/irq events are on
a debug kernel anyway.

I'll keep reviewing your patches next few days, I am at the LPC conference so
might be a bit slow. Overall I think the series look like its maturing and
getting close.

thanks,

 - Joel

