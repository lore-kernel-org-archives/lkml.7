Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D748FC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CDC208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfEMLOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:14:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52610 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbfEMLOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:14:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6CFA374;
        Mon, 13 May 2019 04:14:31 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92C9B3F703;
        Mon, 13 May 2019 04:14:29 -0700 (PDT)
Date:   Mon, 13 May 2019 12:14:27 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     John Garry <john.garry@huawei.com>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "moderated list:ARM PMU PROFILING AND DEBUGGING" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] perf vendor events arm64: Add Cortex-A57 and
 Cortex-A72 events
Message-ID: <20190513111427.GC6711@fuggles.cambridge.arm.com>
References: <20190502234704.7663-1-f.fainelli@gmail.com>
 <5c04ebac-3e3c-fa53-d287-3a602a350091@huawei.com>
 <a8a3c429-307c-40fc-12b4-d62374bfda1d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8a3c429-307c-40fc-12b4-d62374bfda1d@gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 12:49:55PM -0700, Florian Fainelli wrote:
> On 5/6/19 12:25 AM, John Garry wrote:
> > On 03/05/2019 00:47, Florian Fainelli wrote:
> >> The Cortex-A57 and Cortex-A72 both support all ARMv8 recommended events
> >> up to the RC_ST_SPEC (0x91) event with the exception of:
> >>
> >> - L1D_CACHE_REFILL_INNER (0x44)
> >> - L1D_CACHE_REFILL_OUTER (0x45)
> >> - L1D_TLB_RD (0x4E)
> >> - L1D_TLB_WR (0x4F)
> >> - L2D_TLB_REFILL_RD (0x5C)
> >> - L2D_TLB_REFILL_WR (0x5D)
> >> - L2D_TLB_RD (0x5E)
> >> - L2D_TLB_WR (0x5F)
> >> - STREX_SPEC (0x6F)
> >>
> >> Create an appropriate JSON file for mapping those events and update the
> >> mapfile.csv for matching the Cortex-A57 and Cortex-A72 MIDR to that
> >> file.
> > 
> > I suppose you could have also created separate a72 and a57 folders, and
> > used a symbolic link for the json. That would have kept the folder
> > structure consistent and neat.
> 
> Will, Mark, any preference on that? Either way works fine.

I'd personally avoid committing symbolic links if possible, so I'm fine
with your patch as-is.

Will
