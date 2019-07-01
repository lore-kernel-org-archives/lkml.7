Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD7AC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0FA21473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfGAQhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 12:37:16 -0400
Received: from foss.arm.com ([217.140.110.172]:37476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727782AbfGAQhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 12:37:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3E6F2B;
        Mon,  1 Jul 2019 09:37:15 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53E523F703;
        Mon,  1 Jul 2019 09:37:15 -0700 (PDT)
Date:   Mon, 1 Jul 2019 17:37:13 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     lkml <linux-kernel@vger.kernel.org>
Subject: Re: Perf framework : Cluster based counter support
Message-ID: <20190701163712.GC31063@lakrids.cambridge.arm.com>
References: <7ce0c077-06ef-676f-1f7b-61f3ba8589d1@codeaurora.org>
 <20190628165915.GB5143@lakrids.cambridge.arm.com>
 <aca3b787-af8d-79fb-c23f-38accdd5d4e0@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aca3b787-af8d-79fb-c23f-38accdd5d4e0@codeaurora.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 09:09:33PM +0530, Mukesh Ojha wrote:
> 
> On 6/28/2019 10:29 PM, Mark Rutland wrote:
> > On Fri, Jun 28, 2019 at 10:23:10PM +0530, Mukesh Ojha wrote:
> > > Hi All,
> > Hi Mukesh,
> > 
> > > Is it looks considerable to add cluster based event support to add in
> > > current perf event framework and later in userspace perf to support
> > > such events ?
> > Could you elaborate on what you mean by "cluster based event"?
> > 
> > I assume you mean something like events for a cluster-affine shared
> > resource like some level of cache?
> > 
> > If so, there's a standard pattern for supporting such system/uncore
> > PMUs, see drivers/perf/qcom_l2_pmu.c and friends for examples.
> 
> Thanks Mark for pointing it out.
> Also What is stopping us in adding cluster based event e.g L2 cache hit/miss
> or some other type raw events  in core framework ?

That depends on how the event is exposed.

If it's exposed via the architectural PMU, then it's already accessible
as a raw (cpu-affine) event, regardless of whether that makes sense.

If it's a separate PMU (as I suspect is the case), then it simply has to
be a separate PMU driver.

Thanks,
Mark.
