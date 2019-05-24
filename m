Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CDFC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 19:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0415321848
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 19:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732081AbfEXTFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 15:05:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbfEXTFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 15:05:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ABBE559441;
        Fri, 24 May 2019 19:05:22 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 430261001DD5;
        Fri, 24 May 2019 19:05:19 +0000 (UTC)
Subject: Re: [PATCH v3] locking/lock_events: Use this_cpu_add() when necessary
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
References: <20190524185343.4137-1-longman@redhat.com>
 <CAHk-=wgmB8BVrOZEqDysvC21MNmWcWXh1-DYzctsZYmZomkkog@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <0f8883ee-6e31-a1dd-a749-6d2ba07e758d@redhat.com>
Date:   Fri, 24 May 2019 15:05:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgmB8BVrOZEqDysvC21MNmWcWXh1-DYzctsZYmZomkkog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 24 May 2019 19:05:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/19 3:00 PM, Linus Torvalds wrote:
> On Fri, May 24, 2019 at 11:54 AM Waiman Long <longman@redhat.com> wrote:
>>  v2: Simplify the condition to just preempt or !preempt.
>>  v3: Document the imprecise nature of the percpu count.
> My point was that if they are imprecise., then you shouldn't use CONFIG_PREEMPT.
>
> Because CONFIG_PREEMPT doesn't matter, and the count is imprecise with
> it or without it.
>
> So if they are imprecise, then what matters isn't whether the
> operation is atomic or not, and the real issue is avout whether it
> causes that "BUG: using __this_cpu_add() in preemptible" message.
>
> IOW, you should use the config option that matters and is relevant,
> namely CONFIG_DEBUG_PREEMPT.

Yes, that makes sense. I will update the patch again.

Thanks,
Longman

