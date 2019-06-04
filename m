Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0365BC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D95208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfFDR2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 13:28:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38834 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfFDR2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:28:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A1E2330860B5;
        Tue,  4 Jun 2019 17:28:37 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41CB15D9CC;
        Tue,  4 Jun 2019 17:28:36 +0000 (UTC)
Subject: Re: [PATCH v8 15/19] locking/rwsem: Adaptive disabling of reader
 optimistic spinning
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
References: <20190520205918.22251-1-longman@redhat.com>
 <20190520205918.22251-16-longman@redhat.com>
 <20190604091000.GH3402@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <cb524fd4-0c74-4fc0-6ddd-96f37a83fe64@redhat.com>
Date:   Tue, 4 Jun 2019 13:28:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604091000.GH3402@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 04 Jun 2019 17:28:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/19 5:10 AM, Peter Zijlstra wrote:
> On Mon, May 20, 2019 at 04:59:14PM -0400, Waiman Long wrote:
>> Reader optimistic spinning is helpful when the reader critical section
>> is short and there aren't that many readers around. It makes readers
>> relatively more preferred than writers. When a writer times out spinning
>> on a reader-owned lock and set the nospinnable bits, there are two main
>> reasons for that.
>>
>>  1) The reader critical section is long, perhaps the task sleeps after
>>     acquiring the read lock.
>>  2) There are just too many readers contending the lock causing it to
>>     take a while to service all of them.
>>
>> In the former case, long reader critical section will impede the progress
>> of writers which is usually more important for system performance.
>> In the later case, reader optimistic spinning tends to make the reader
>> groups that contain readers that acquire the lock together smaller
>> leading to more of them. That may hurt performance in some cases. In
>> other words, the setting of nonspinnable bits indicates that reader
>> optimistic spinning may not be helpful for those workloads that cause it.
>>
>> Therefore, any writers that have observed the setting of the writer
>> nonspinnable bit for a given rwsem after they fail to acquire the lock
>> via optimistic spinning will set the reader nonspinnable bit once they
>> acquire the write lock. Similarly, readers that observe the setting
>> of reader nonspinnable bit at slowpath entry will also set the reader
>> nonspinnable bit when they acquire the read lock via the wakeup path.
> So both cases set the _reader_ nonspinnable bit?

Yes.

-Longman

