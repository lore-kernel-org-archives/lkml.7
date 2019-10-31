Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1437CCA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02E52086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfJaKTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 06:19:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:46124 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726864AbfJaKTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:19:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D9028B12E;
        Thu, 31 Oct 2019 10:19:08 +0000 (UTC)
Date:   Thu, 31 Oct 2019 10:19:04 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: Make sched-idle cpu selection consistent
 throughout
Message-ID: <20191031101904.GI28938@suse.de>
References: <5eba2fb4af9ebc7396101bb9bd6c8aa9c8af0710.1571899508.git.viresh.kumar@linaro.org>
 <20191030164714.GH28938@suse.de>
 <CAKohpo=hssu_uvb1J=0Od=KziAQVSMmbBt9zxa4mYttKhFJwFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKohpo=hssu_uvb1J=0Od=KziAQVSMmbBt9zxa4mYttKhFJwFw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 02:42:03PM +0530, Viresh Kumar wrote:
> On Wed, 30 Oct 2019 at 22:17, Mel Gorman <mgorman@suse.de> wrote:
> 
> > As the patch stands, I think a fork-intensive workload where each
> > process is doing small amounts of work will suffer from overloading
> > domains and have variable performance depending on how quickly the load
> > balancer reacts.
> 
> Just wanted to clarify this slightly in case it is confusing. Once a
> newly forked
> (non SCHED_IDLE) task gets placed on a sched-idle CPU, it won't remain
> sched-idle anymore and we will again start looking for a fully idle CPU. So,
> we won't put everything on a small set of CPUs, but just one SCHED_NORMAL
> task on a CPU unless we are out of idle CPUs.
> 
> Do you have some specific test in mind which I can run to test this ?
> 

Nothing in particular. git test suite for the basic fork-intensive case
(mmtests config workload-shellscripts), something fork-intensive but
relatively short-lived like a kernel build scaling the number of build
jobs (mmtests config config-workload-kerndevel), something fairly basic
that scales number of running jobs and relatively long-lived like tbench
(mmtests config config-network-tbench). The ideal of course is that you
wrote the patch based on an observed problem that you decided to fix.

-- 
Mel Gorman
SUSE Labs
