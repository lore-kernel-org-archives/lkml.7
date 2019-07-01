Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE5FC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D020206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="gGlJum1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfGATWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 15:22:38 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46198 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGATWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 15:22:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id h21so15857173qtn.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 12:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yZ128WO663Ik5oD84Bk7AccG0DwVr7HZGjA2cTGIof4=;
        b=gGlJum1orbFjNw7XSMFceisk1OAWlNqzg0Q81g86Sm5LAboahLBev7YHwe2S27W9D6
         CNv1gj6MMQgnkVwzSpwSGy/Wr4h5/fMyEJl9JiPAjvFrHEXqjf4R94ybzy7UnCGTXWKk
         X25nyMn67FssftNzFoDfBKOg/7rmTB5CPqNW4duXfvVxJSTAdlFsX4xscMX5b7XmwjYq
         jYLkqzwKCfSoOet5Gsvw6y3IjzDapnVwvXA4xChB6PUP7zz+waKHQApcR0D0KoUjk/38
         dia25mH6v9krZnIcj0g/sZpK33Mqx/fd/FQt2V036OsFcuAA4prMwD2exUSaU2Ua/Zez
         OBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yZ128WO663Ik5oD84Bk7AccG0DwVr7HZGjA2cTGIof4=;
        b=ZollHP6YM+RtoIBoPaEzNPJJWhgAq+JKc+4y7FkkogoBgKK3wTpoW20SOY5TripFY6
         TydjSHhW2s16EXlmKI1gPy5oVdSJQslaBybQo4dt0lN8xCAdECuUL4gOAJbM62/PbsTl
         FZ8I2HWXNKpSuhhj+h7LTwSiaKS/ZP0KqtxzO5E1qg+4Q1PONleXEH70RNzu7mwYu5Yi
         sVxClOGvnDvyWYiNrArzlbRQHWI1e2GUQxqG6TFvoZ4u+Lv5llzepaltTbZ7WPdYpifm
         ltiDplkH/afsPdaVeWtilE8rpHU67JHP+IM8i1nl9505mqo8gcpH08a1ZBmSy812YaIF
         /b9Q==
X-Gm-Message-State: APjAAAXuIToGR450jlN1w5mR32z2bnbDUI4Dy3tKFemoIGAMRwZ/JtGL
        PZKFNWQBPBQCeV23fIcITdvGew==
X-Google-Smtp-Source: APXvYqz+EP2osOJz8CJOfob8S2V6I7JigRIfgYSTygw2JekcTopfRP88Rfh+gzUqH08qo4i+kfZGoQ==
X-Received: by 2002:ad4:42c6:: with SMTP id f6mr11002390qvr.196.1562008957552;
        Mon, 01 Jul 2019 12:22:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::2ce6])
        by smtp.gmail.com with ESMTPSA id p23sm4788911qkm.55.2019.07.01.12.22.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 12:22:36 -0700 (PDT)
Date:   Mon, 1 Jul 2019 15:22:35 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, dietmar.eggemann@arm.com,
        peterz@infradead.org, mingo@redhat.com, morten.rasmussen@arm.com,
        tglx@linutronix.de, mgorman@techsingularity.net,
        vincent.guittot@linaro.org
Subject: Re: [PATCH 03/10] sched,fair: redefine runnable_load_avg as the sum
 of task_h_load
Message-ID: <20190701192234.5oxkuysimi437utz@macbook-pro-91.dhcp.thefacebook.com>
References: <20190628204913.10287-1-riel@surriel.com>
 <20190628204913.10287-4-riel@surriel.com>
 <20190701162949.vhxjndychoamhkbq@MacBook-Pro-91.local.dhcp.thefacebook.com>
 <757e0af14b714b596417b31c45098fc314ed7c8a.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <757e0af14b714b596417b31c45098fc314ed7c8a.camel@surriel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 12:47:35PM -0400, Rik van Riel wrote:
> On Mon, 2019-07-01 at 12:29 -0400, Josef Bacik wrote:
> > On Fri, Jun 28, 2019 at 04:49:06PM -0400, Rik van Riel wrote:
> > > The runnable_load magic is used to quickly propagate information
> > > about
> > > runnable tasks up the hierarchy of runqueues. The runnable_load_avg
> > > is
> > > mostly used for the load balancing code, which only examines the
> > > value at
> > > the root cfs_rq.
> > > 
> > > Redefine the root cfs_rq runnable_load_avg to be the sum of
> > > task_h_loads
> > > of the runnable tasks. This works because the hierarchical
> > > runnable_load of
> > > a task is already equal to the task_se_h_load today. This provides
> > > enough
> > > information to the load balancer.
> > > 
> > > The runnable_load_avg of the cgroup cfs_rqs does not appear to be
> > > used for anything, so don't bother calculating those.
> > > 
> > > This removes one of the things that the code currently traverses
> > > the
> > > cgroup hierarchy for, and getting rid of it brings us one step
> > > closer
> > > to a flat runqueue for the CPU controller.
> > > 
> > 
> > My memory on this stuff is very hazy, but IIRC we had the
> > runnable_sum and the
> > runnable_avg separated out because you could have the avg lag behind
> > the sum.
> > So like you enqueue a bunch of new entities who's avg may have
> > decayed a bunch
> > and so their overall load is not felt on the CPU until they start
> > running, and
> > now you've overloaded that CPU.  The sum was there to make sure new
> > things
> > coming onto the CPU added actual load to the queue instead of looking
> > like there
> > was no load.
> > 
> > Is this going to be a problem now with this new code?
> 
> That is a good question!
> 
> On the one hand, you may well be right.
> 
> On the other hand, while I see the old code calculating
> runnable_sum, I don't really see it _using_ it to drive
> scheduling decisions.
> 
> It would be easy to define the CPU cfs_rq->runnable_load_sum
> as being the sum of task_se_h_weight() of each runnable task
> on the CPU (for example), but what would we use it for?
> 
> What am I missing?

It's suuuuuper sublte, but you're right in that we don't really need the
runnable_avg per-se, but what you do is you kill calc_group_runnable, which used
to do this

load_avg = max(cfs_rq->avg.load_avg,
               scale_load_down(cfs_rq->load.weight));

runnable = max(cfs_rq->avg.runnable_load_avg,
               scale_load_down(cfs_rq->runnable_weight));

so we'd account for this weirdness of adding a previously idle process to a new
CPU and overloading the CPU because we'd add a bunch of these 0 weight looking
tasks that suddenly all wake up and are on the same CPU.  So we used the
runnable_weight to account for what was actually happening, and the max of
load_avg and the weight to figure out what the potential load would be.

What you've done here is change the weighting stuff to be completely based on
load avg, which is problematic for the reasons above.  Did you fix this later on
in your patches?  If so then just tell me to keep reading and I'll do that ;).
Thanks,

Josef
