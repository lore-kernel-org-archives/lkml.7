Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE805C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFE02067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfG2Pht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:37:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60733 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725209AbfG2Pht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:37:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE805300CA4D;
        Mon, 29 Jul 2019 15:37:48 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11B105C1A1;
        Mon, 29 Jul 2019 15:37:47 +0000 (UTC)
Subject: Re: [PATCH v2] sched/core: Don't use dying mm as active_mm of
 kthreads
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Phil Auld <pauld@redhat.com>, Rik van Riel <riel@surriel.com>,
        Andy Lutomirski <luto@kernel.org>
References: <20190727171047.31610-1-longman@redhat.com>
 <20190729085235.GT31381@hirez.programming.kicks-ass.net>
 <4cd17c3a-428c-37a0-b3a2-04e6195a61d5@redhat.com>
 <20190729150338.GF31398@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <c2dfc884-b3e1-6fb3-b05f-2b1f299853f4@redhat.com>
Date:   Mon, 29 Jul 2019 11:37:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190729150338.GF31398@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 29 Jul 2019 15:37:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/19 11:03 AM, Peter Zijlstra wrote:
> On Mon, Jul 29, 2019 at 10:51:51AM -0400, Waiman Long wrote:
>> On 7/29/19 4:52 AM, Peter Zijlstra wrote:
>>> On Sat, Jul 27, 2019 at 01:10:47PM -0400, Waiman Long wrote:
>>>> It was found that a dying mm_struct where the owning task has exited
>>>> can stay on as active_mm of kernel threads as long as no other user
>>>> tasks run on those CPUs that use it as active_mm. This prolongs the
>>>> life time of dying mm holding up memory and other resources like swap
>>>> space that cannot be freed.
>>> Sure, but this has been so 'forever', why is it a problem now?
>> I ran into this probem when running a test program that keeps on
>> allocating and touch memory and it eventually fails as the swap space is
>> full. After the failure, I could not rerun the test program again
>> because the swap space remained full. I finally track it down to the
>> fact that the mm stayed on as active_mm of kernel threads. I have to
>> make sure that all the idle cpus get a user task to run to bump the
>> dying mm off the active_mm of those cpus, but this is just a workaround,
>> not a solution to this problem.
> The 'sad' part is that x86 already switches to init_mm on idle and we
> only keep the active_mm around for 'stupid'.
>
> Rik and Andy were working on getting that 'fixed' a while ago, not sure
> where that went.

Good, perhaps the right thing to do is for the idle->kernel case to keep
init_mm as the active_mm instead of reuse whatever left behind the last
time around.

Cheers,
Longman

