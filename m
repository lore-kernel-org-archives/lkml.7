Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F37BC5B578
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 00:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7F12187F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 00:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfGDAcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 20:32:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:17261 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727326AbfGDAcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 20:32:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 17:32:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,449,1557212400"; 
   d="scan'208";a="164499846"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by fmsmga008.fm.intel.com with ESMTP; 03 Jul 2019 17:32:07 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     huang ying <huang.ying.caritas@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>, <jhladky@redhat.com>,
        <lvenanci@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH -mm] autonuma: Fix scan period updating
References: <20190624025604.30896-1-ying.huang@intel.com>
        <20190624140950.GF2947@suse.de>
        <CAC=cRTNYUxGUcSUvXa-g9hia49TgrjkzE-b06JbBtwSn2zWYsw@mail.gmail.com>
        <20190703091747.GA13484@suse.de>
Date:   Thu, 04 Jul 2019 08:32:06 +0800
In-Reply-To: <20190703091747.GA13484@suse.de> (Mel Gorman's message of "Wed, 3
        Jul 2019 10:17:47 +0100")
Message-ID: <87ef3663nd.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mgorman@suse.de> writes:

> On Tue, Jun 25, 2019 at 09:23:22PM +0800, huang ying wrote:
>> On Mon, Jun 24, 2019 at 10:25 PM Mel Gorman <mgorman@suse.de> wrote:
>> >
>> > On Mon, Jun 24, 2019 at 10:56:04AM +0800, Huang Ying wrote:
>> > > The autonuma scan period should be increased (scanning is slowed down)
>> > > if the majority of the page accesses are shared with other processes.
>> > > But in current code, the scan period will be decreased (scanning is
>> > > speeded up) in that situation.
>> > >
>> > > This patch fixes the code.  And this has been tested via tracing the
>> > > scan period changing and /proc/vmstat numa_pte_updates counter when
>> > > running a multi-threaded memory accessing program (most memory
>> > > areas are accessed by multiple threads).
>> > >
>> >
>> > The patch somewhat flips the logic on whether shared or private is
>> > considered and it's not immediately obvious why that was required. That
>> > aside, other than the impact on numa_pte_updates, what actual
>> > performance difference was measured and on on what workloads?
>> 
>> The original scanning period updating logic doesn't match the original
>> patch description and comments.  I think the original patch
>> description and comments make more sense.  So I fix the code logic to
>> make it match the original patch description and comments.
>> 
>> If my understanding to the original code logic and the original patch
>> description and comments were correct, do you think the original patch
>> description and comments are wrong so we need to fix the comments
>> instead?  Or you think we should prove whether the original patch
>> description and comments are correct?
>> 
>
> I'm about to get knocked offline so cannot answer properly. The code may
> indeed be wrong and I have observed higher than expected NUMA scanning
> behaviour than expected although not enough to cause problems. A comment
> fix is fine but if you're changing the scanning behaviour, it should be
> backed up with data justifying that the change both reduces the observed
> scanning and that it has no adverse performance implications.

Got it!  Thanks for comments!  As for performance testing, do you have
some candidate workloads?

Best Regards,
Huang, Ying
