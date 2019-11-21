Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582B9C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F89E206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfKUO6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:58:14 -0500
Received: from foss.arm.com ([217.140.110.172]:57658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfKUO6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:58:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26340DA7;
        Thu, 21 Nov 2019 06:58:13 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E80D3F703;
        Thu, 21 Nov 2019 06:58:11 -0800 (PST)
Date:   Thu, 21 Nov 2019 14:58:09 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>, mark.rutland@arm.com
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v4 11/11] sched/fair: rework find_idlest_group
Message-ID: <20191121145808.vlixdy3ilxfaswyr@e107158-lin.cambridge.arm.com>
References: <20191120115844.scli3gprgd5vvlt4@e107158-lin.cambridge.arm.com>
 <CAKfTPtDh7HAv2Krx9cRKcA+Zy=erYkykyZZj4=nkRoTEdY=oFw@mail.gmail.com>
 <CAKfTPtCFP3_U_YxwR8+Gs+HYJPmqSWJg6B6nBdgccNru8Gh5QA@mail.gmail.com>
 <20191120173431.b7e4jbq44mjletfe@e107158-lin.cambridge.arm.com>
 <CAKfTPtCSc+ym8FTFtSeF4foUqTbsDSr1fJ1j_+j+Zmo=XOUcLA@mail.gmail.com>
 <20191120181002.lh7vukjm2ifhysbc@e107158-lin.cambridge.arm.com>
 <CAKfTPtDCv4jWxODGf8FOefmP6qyWRdfi2QVRT=wZqwYgUKg9HA@mail.gmail.com>
 <20191120182731.z2sh5ju7uir5s3cp@e107158-lin.cambridge.arm.com>
 <CAKfTPtDzVHZpE0XmyPF8AVsmtVMCmKgYERjdW4euj-H6kNu2Rw@mail.gmail.com>
 <20191120195521.nvhzvd3x7l7jdxsr@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191120195521.nvhzvd3x7l7jdxsr@e107158-lin.cambridge.arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/19 19:55, Qais Yousef wrote:
> On 11/20/19 20:28, Vincent Guittot wrote:
> > I run few more tests and i can get either hw counter with 0 or not.
> > The main difference is on which CPU it runs: either big or little
> > little return always 0 and big always non-zero value
> > 
> > on v5.4-rc7 and tip/sched/core, cpu0-3 return 0 and other non zeroa
> > but on next, it's the opposite cpu0-3 return non zero ratio
> > 
> > Could you try to run the test with taskset to run it on big or little ?
> 
> Nice catch!
> 
> Yes indeed using taskset and forcing it to run on the big cpus it passes even
> on linux-next/next-20191119.
> 
> So the relation to your patch is that it just biased where this test is likely
> to run in my case and highlighted the breakage in the counters, probably?
> 
> FWIW, if I use taskset to force always big it passes. Always small, the counters
> are always 0 and it passes too. But if I have mixed I see what I pasted before,
> the counters have valid value but nhw is 0.
> 
> So the questions are, why little counters aren't working. And whether we should
> run the test with taskset generally as it can't handle the asymmetry correctly.
> 
> Let me first try to find out why the little counters aren't working.

So it turns out there's a caveat on usage of perf counters on big.LITTLE
systems.

Mark on CC can explain this better than me so I'll leave the details to him.

Sorry about the noise Vincent - it seems your patch was shifting things
slightly to cause migrating the task to another CPU, hence trigger the failure
on reading the perf counters, and the test in return.

Thanks

--
Qais Yousef
