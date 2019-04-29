Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4A8C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E752087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfD2Q4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 12:56:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33836 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728520AbfD2Q4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 12:56:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9B3880D;
        Mon, 29 Apr 2019 09:56:38 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D8BD3F5AF;
        Mon, 29 Apr 2019 09:56:37 -0700 (PDT)
Date:   Mon, 29 Apr 2019 17:56:34 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com, tj@kernel.org,
        ak@linux.intel.com
Subject: Re: [PATCH 2/4] perf: Add filter_match() as a parameter for
 pinned/flexible_sched_in()
Message-ID: <20190429165634.GD2182@lakrids.cambridge.arm.com>
References: <1556549045-71814-1-git-send-email-kan.liang@linux.intel.com>
 <1556549045-71814-3-git-send-email-kan.liang@linux.intel.com>
 <20190429151225.GC2182@lakrids.cambridge.arm.com>
 <b00952cd-9af1-3e4f-45cb-11a692e9b722@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b00952cd-9af1-3e4f-45cb-11a692e9b722@linux.intel.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 11:31:26AM -0400, Liang, Kan wrote:
> 
> 
> On 4/29/2019 11:12 AM, Mark Rutland wrote:
> > On Mon, Apr 29, 2019 at 07:44:03AM -0700, kan.liang@linux.intel.com wrote:
> > > From: Kan Liang <kan.liang@linux.intel.com>
> > > 
> > > A fast path will be introduced in the following patches to speed up the
> > > cgroup events sched in, which only needs a simpler filter_match().
> > > 
> > > Add filter_match() as a parameter for pinned/flexible_sched_in().
> > > 
> > > No functional change.
> > 
> > I suspect that the cost you're trying to avoid is pmu_filter_match()
> > iterating over the entire group, which arm systems rely upon for correct
> > behaviour on big.LITTLE systems.
> > 
> > Is that the case?
> 
> No. In X86, we don't use pmu_filter_match(). The fast path still keeps this
> filter.
> perf_cgroup_match() is the one I want to avoid.

Understood; sorry for the silly question, and thanks for confirming! :)

Thanks,
Mark.
