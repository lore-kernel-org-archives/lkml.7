Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D421C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C9B20692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WQxEV3nJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgAHQrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:47:03 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33286 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbgAHQrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:47:02 -0500
Received: by mail-wm1-f65.google.com with SMTP id d139so71434wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 08:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Z2Dsc4udNbGFE/7eZpXylgFH1pZngr3dKxA7StmarZU=;
        b=WQxEV3nJmb5iLgusvKoiio0KSMTlqc34m8g/eqArcWJU6TDrJpMr9+BpJqiNfMu+Rz
         Dt6tIbC4J1cBEvZSxfLNW9A2t01+ILQMSWak6EX1mR23NXWfgqN3TDr7e0MVRWUgFH78
         yX1dnJo8yS0DVhIJ8SSRblClIHFrdIO2mXfAhvod/r9VPSW8rxDGHqiZNO6vwMO9y0ep
         xxSNaKcUCjRGpIzWtjagb9OMVn3gzK41bjmJXIdRqXHVXazLso3nyU1IHkdwc++Ojb8p
         Ob8iq2Kc7rd+zbR0zOBk9KogsRON+Y1LwbqNhsV8/G7Upm/yz4ToEaWv64EtcO2kbIxw
         /cgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Z2Dsc4udNbGFE/7eZpXylgFH1pZngr3dKxA7StmarZU=;
        b=b0ZuzS3yIppu5IzFcKAvqAUgoJrODL8vL4oIOgr0SyYw7GY/TC7gmwPnzWAP2eHtXM
         gnS2gjAet7wvbPVn71D8VpkJaluEDBYPPPgZU7E7/6raFFz5Fkav5L1OfXSx5fueQ1H4
         siBCOGXQdTc81G7xo8mgRADIiHJMAg9o55TYx8BmCea+/38/mWK1WobOd7SX1PwFlRQs
         n3VmkrgkVQ7eL1JAhCDRY5/UtSiXiAc5tfcmarx7lKNKcBZ5CBUhHtPStKPwPIcxPgs0
         NO4YWOn88Eiub7QaHBXa6/OZOEXL7NDUZ9NGS2cvCUOCweYlDRSEv2OdYlTk1KB/YhvI
         ddGQ==
X-Gm-Message-State: APjAAAVb6ANTeRXx0oJCGblQDV3ia4eJCds0u33ga72O3Yrkh5pupGpb
        xEtLz32gXE8ciOf8P/7NTEWFOocjJ3it8Q==
X-Google-Smtp-Source: APXvYqxCU0cpGHr2Xy1cUVSbSrSw8PAXPTUbouSksmKznU7NjJOrQdGsbcUB+whJPr1UNPdvxf/ztA==
X-Received: by 2002:a1c:6585:: with SMTP id z127mr4915741wmb.113.1578502020015;
        Wed, 08 Jan 2020 08:47:00 -0800 (PST)
Received: from linaro.org ([2a01:e0a:f:6020:1cab:f594:1e9b:59de])
        by smtp.gmail.com with ESMTPSA id q3sm4239553wmc.47.2020.01.08.08.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 08:46:58 -0800 (PST)
Date:   Wed, 8 Jan 2020 17:46:57 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains v2
Message-ID: <20200108164657.GA16425@linaro.org>
References: <CAKfTPtCGm7-mq3duxi=ugy+mn=Yutw6w9c35+cSHK8aZn7rzNQ@mail.gmail.com>
 <20200106145225.GB3466@techsingularity.net>
 <CAKfTPtBa74nd4VP3+7V51Jv=-UpqNyEocyTzMYwjopCgfWPSXg@mail.gmail.com>
 <20200107095655.GF3466@techsingularity.net>
 <CAKfTPtAtJSWGPC1t+0xj_Daid0fZaWnN+b53WQ_a1-Js5fJ6sg@mail.gmail.com>
 <20200107115646.GI3466@techsingularity.net>
 <CAKfTPtAacdmxniM9yZUrQPW39LAvhpBQt6ZiGiwk5qpEx7zicA@mail.gmail.com>
 <20200107202406.GJ3466@techsingularity.net>
 <20200108131858.GZ2827@hirez.programming.kicks-ass.net>
 <20200108140349.GL3466@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200108140349.GL3466@techsingularity.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wednesday 08 Jan 2020 à 14:03:49 (+0000), Mel Gorman a écrit :
> On Wed, Jan 08, 2020 at 02:18:58PM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 07, 2020 at 08:24:06PM +0000, Mel Gorman wrote:
> > > Now I get you, but unfortunately it also would not work out. The number
> > > of groups is not related to the LLC except in some specific cases.
> > > It's possible to use the first CPU to find the size of an LLC but now I
> > > worry that it would lead to unpredictable behaviour. AMD has different
> > > numbers of LLCs per node depending on the CPU family and while Intel
> > > generally has one LLC per node, I imagine there are counter examples.
> > 
> > Intel has the 'fun' case of an LLC spanning nodes :-), although Linux
> > pretends this isn't so and truncates the LLC topology information to be
> > the node again -- see arch/x86/kernel/smpboot.c:match_llc().
> > 
> 
> That's the Sub-NUMA Clustering, right? I thought that manifested as a
> separate NUMA node in Linux. Not exactly right from a topology point of
> view, but close enough. Still, you're right in that identifying the LLC
> specifically would not necessarily be the way to go. FWIW, I have one
> machine with SNC enabled and didn't notice anything problematic in the
> versions of the patch released to date.
> 
> > And of course, in the Core2 era we had the Core2Quad chips which was a
> > dual-die solution and therefore also had multiple LLCs, and I think the
> > Xeon variant of that would allow the multiple LLC per node situation
> > too, although this is of course ancient hardware nobody really cares
> > about anymore.
> > 
> 
> Ok, even though they're older, it's enough counter-examples to be concerned
> about. I'm definitely dropping the LLC considerations for the moment :)
> 
> > > This means that load balancing on different machines with similar core
> > > counts will behave differently due to the LLC size.
> > 
> > That sounds like perfectly fine/expected behaviour to me.
> > 
> 
> Even so, I think it should not be part of the initial patch. I would only
> be happy if I had enough different machine types to prove that specific
> special casing is required and we cannot simply rely on standard load
> balancing of the domains below SD_NUMA.
> 
> > > It might be possible
> > > to infer it if the intermediate domain was DIE instead of MC but I doubt
> > > that's guaranteed and it would still be unpredictable. It may be the type
> > > of complexity that should only be introduced with a separate patch with
> > > clear rationale as to why it's necessary and we are not at that threshold
> > > so I withdraw the suggestion.
> > 
> > So IIRC the initial patch(es) had the idea to allow for 1 extra task
> > imbalance to get 1-1 pairs on the same node, instead of across nodes. I
> > don't immediately see that in these later patches.
> > 
> 
> Not quite -- I had a minimum allowed imbalance of 2 tasks -- mostly for
> very small NUMA domains. By v3, it was not necessary because the value
> was hard-coded regardless of the number of CPUs. I think I'll leave it
> out because I don't think it's worth worrying about the imbalance between
> NUMA domains of less than 4 CPUs (do they even exist any more?)
> 
> > Would that be something to go back to? Would that not side-step much of
> > the issues under discussion here?
> 
> Allowing just 1 extra task would work for netperf in some cases except when
> softirq is involved. It would partially work for IO on ext4 as it's only
> communicating with one journal thread but a bit more borderline for XFS
> due to workqueue usage. XFS is not a massive concern in this context as
> the workqueue is close to the IO issuer and short-lived so I don't think
> it would crop up much for load balancing unlike ext4 where jbd2 could be
> very active.
> 
> If v4 of the patch fails to meet approval then I'll try a patch that

My main concern with v4 was the mismatch between the computed value and the goal to not overload the LLCs

> allows a hard-coded imbalance of 2 tasks (one communicating task and

If there is no good way to compute the allowed imbalance, a hard coded value of 2 is probably simple value to start with

> one kthread) regardless of NUMA domain span up to 50% of utilisation

Are you sure that it's necessary ? This degree of imbalance already applies only if the group has spare capacity

something like

+               /* Consider allowing a small imbalance between NUMA groups */
+               if (env->sd->flags & SD_NUMA) {
+
+                       /*
+                        * Until we found a good way to compute an acceptable
+						 * degree of imbalance linked to the system topology
+						 * and that will not impatc mem bandwith and latency,
+						 * let start with a fixed small value.
+						 */
+                       imbalance_adj = 2;
+
+                       /*
+                        * Ignore small imbalances when the busiest group has
+                        * low utilisation.
+                        */
+                        env->imbalance -= min(env->imbalance, imbalance_adj);
+               }

> and see what that gets. One way or the other, I would like to get basic
> NUMA balancing issue out of the way before even looking at NUMA balancing
> and whether it needs to be adjusted based on the load balancing rewrite.
> NUMA balancing already has some logic that fights load balancer decisions
> and I don't want to make that worse, I would be delighted if we could
> even delete that migration retry check that overrides the load balancer
> because it always was a bit nasty.
> 
> -- 
> Mel Gorman
> SUSE Labs
