Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37CCC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787AF2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfEOKEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 06:04:21 -0400
Received: from mga14.intel.com ([192.55.52.115]:64924 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfEOKEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 06:04:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 03:04:20 -0700
X-ExtLoop1: 1
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.63])
  by orsmga008.jf.intel.com with ESMTP; 15 May 2019 03:04:17 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yabin Cui <yabinc@google.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH] perf/ring_buffer: Fix exposing a temporarily decreased data_head.
In-Reply-To: <20190515094352.GC2623@hirez.programming.kicks-ass.net>
References: <20190515003059.23920-1-yabinc@google.com> <87ef50xlb8.fsf@ashishki-desk.ger.corp.intel.com> <20190515094352.GC2623@hirez.programming.kicks-ass.net>
Date:   Wed, 15 May 2019 13:04:16 +0300
Message-ID: <87bm04xcdb.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Wed, May 15, 2019 at 09:51:07AM +0300, Alexander Shishkin wrote:
>> Yabin Cui <yabinc@google.com> writes:
>> 
>> > diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
>> > index 674b35383491..0b9aefe13b04 100644
>> > --- a/kernel/events/ring_buffer.c
>> > +++ b/kernel/events/ring_buffer.c
>> > @@ -54,8 +54,10 @@ static void perf_output_put_handle(struct perf_output_handle *handle)
>> >  	 * IRQ/NMI can happen here, which means we can miss a head update.
>> >  	 */
>> >  
>> > -	if (!local_dec_and_test(&rb->nest))
>> > +	if (local_read(&rb->nest) > 1) {
>> > +		local_dec(&rb->nest);
>> 
>> What stops rb->nest changing between local_read() and local_dec()?
>
> Nothing, however it must remain the same :-)
>
> That is the cryptic way of saying that since these buffers are strictly
> per-cpu, the only change can come from interrupts, and they must have a
> net 0 change. Or rather, an equal amount of decrements to increments.
>
> So if it changes, it must also change back to where it was.

Ah that's true. So the whole ->nest thing can be done with
READ_ONCE()/WRITE_ONCE() instead?
Because the use of local_dec_and_test() creates an impression that we
rely on atomicity of it, which in actuality we don't.

Regards,
--
Alex
