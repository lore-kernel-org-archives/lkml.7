Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20B0C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 08:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECDA2083D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 08:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfCBI0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 03:26:36 -0500
Received: from mga02.intel.com ([134.134.136.20]:53693 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbfCBI0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 03:26:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2019 00:26:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,431,1544515200"; 
   d="scan'208";a="122046952"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.151])
  by orsmga008.jf.intel.com with ESMTP; 02 Mar 2019 00:26:33 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Chen\, Rong A" <rong.a.chen@intel.com>,
        "lkp\@01.org" <lkp@01.org>, LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tim C Chen <tim.c.chen@intel.com>
Subject: Re: [LKP] [page cache] eb797a8ee0: vm-scalability.throughput -16.5% regression
References: <20181114092242.GD18977@shao2-debian>
        <20181114141713.GA25731@bombadil.infradead.org>
        <875zt7t14h.fsf@yhuang-dev.intel.com>
        <CAHk-=whn+F+vFgCR0a04atTQuBmXhq0oU1Y1f0YqMiUFHj28JQ@mail.gmail.com>
        <1c33a91c-a436-a879-ca14-7eebcbf971c2@redhat.com>
        <87imx4pv5q.fsf@yhuang-dev.intel.com>
        <CAHk-=wiXgigVGwumT0y_N64LjCiB5tR0snjCAm3u4YyhDB+dwQ@mail.gmail.com>
Date:   Sat, 02 Mar 2019 16:26:33 +0800
In-Reply-To: <CAHk-=wiXgigVGwumT0y_N64LjCiB5tR0snjCAm3u4YyhDB+dwQ@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 27 Feb 2019 17:32:57 -0800")
Message-ID: <87a7idn0li.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Feb 27, 2019 at 5:19 PM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> So I think in the heavily contended situation, we should put the fields
>> accessed by rwsem holder in a different cache line of rwsem.  But in
>> un-contended situation, we should put the fields accessed in rwsem
>> holder and rwsem in the same cache line to reduce the cache footprint.
>> The requirement of un-contended and heavily contended situation is
>> contradicted.
>
> Generally, we should strive to optimize for the uncontended state.
>
> The performance profile of a contended state tends to be very
> different, and the actual solution tends to be to try really hard to
> just avoid contention to begin with.
>
> I think we've gotten to the point where we have very few real loads
> that show lock contention on a kernel level. And when people do find
> loads that cause contention, we should try really hard to fix the
> locking rather than try to then treat the symptom of contention.
>
> So on the whole, aim to make the uncontended case go fast, at least to
> a first approximation.

Sounds reasonable!  Thanks for clarification!

Best Regards,
Huang, Ying

>                Linus
