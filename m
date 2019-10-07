Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21526C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 09:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9057206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 09:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfJGJ5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 05:57:02 -0400
Received: from foss.arm.com ([217.140.110.172]:58848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbfJGJ5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 05:57:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7713315BE;
        Mon,  7 Oct 2019 02:57:01 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 724B13F68E;
        Mon,  7 Oct 2019 02:57:00 -0700 (PDT)
Date:   Mon, 7 Oct 2019 10:56:58 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v3 1/3] mm: kmemleak: Make the tool tolerant to struct
 scan_area allocation failures
Message-ID: <20191007095658.GF45043@arrakis.emea.arm.com>
References: <20190812160642.52134-1-catalin.marinas@arm.com>
 <20190812160642.52134-2-catalin.marinas@arm.com>
 <2ac37341-097e-17a2-fb6b-7912da9fa38e@ozlabs.ru>
 <20191003084135.GA21629@arrakis.emea.arm.com>
 <ba47fb68-f44c-04c9-7ea8-2705e799937b@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba47fb68-f44c-04c9-7ea8-2705e799937b@ozlabs.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2019 at 01:08:43PM +1000, Alexey Kardashevskiy wrote:
> On 03/10/2019 18:41, Catalin Marinas wrote:
> > On Thu, Oct 03, 2019 at 04:13:07PM +1000, Alexey Kardashevskiy wrote:
> >> On 13/08/2019 02:06, Catalin Marinas wrote:
> >>> Object scan areas are an optimisation aimed to decrease the false
> >>> positives and slightly improve the scanning time of large objects known
> >>> to only have a few specific pointers. If a struct scan_area fails to
> >>> allocate, kmemleak can still function normally by scanning the full
> >>> object.
> >>>
> >>> Introduce an OBJECT_FULL_SCAN flag and mark objects as such when
> >>> scan_area allocation fails.
> >>
> >> I came across this one while bisecting sudden drop in throughput of a
> >> 100Gbit Mellanox CX4 ethernet card in a PPC POWER9 system, the speed
> >> dropped from 100Gbit to about 40Gbit. Bisect pointed at dba82d943177,
> >> this are the relevant config options:
> >>
> >> [fstn1-p1 kernel]$ grep KMEMLEAK ~/pbuild/kernel-le-4g/.config
> >> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> >> CONFIG_DEBUG_KMEMLEAK=y
> >> CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=16000
> >> # CONFIG_DEBUG_KMEMLEAK_TEST is not set
> >> # CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
> >> CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
> > 
> > The throughput drop is probably caused caused by kmemleak slowing down
> > all memory allocations (including skb). So that's expected. You may get
> > similar drop with other debug options like lock proving, kasan.
> 
> I was not precise. I meant that before dba82d943177 kmemleak would
> work but would not slow network down (at least 100Gbit) and now it
> does which is downgrade so I was wondering if kmemleak just got so
> much better to justify this change or there is a bug somewhere, so
> which one is it? Or "LOG_SIZE=400" never really worked?

I suspect LOG_SIZE=400 never worked on your system (you can check the
log for any kmemleak disabled messages).

Thanks for testing the patch.

-- 
Catalin
