Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B366DC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9585D214C6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732811AbfHHR5G convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 13:57:06 -0400
Received: from 68.66.241.172.static.a2webhosting.com ([68.66.241.172]:50292
        "EHLO vps.redhazel.co.uk" rhost-flags-OK-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1729780AbfHHR5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 13:57:06 -0400
Received: from [100.121.56.177] (unknown [213.205.240.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by vps.redhazel.co.uk (Postfix) with ESMTPSA id AEFC31C02182;
        Thu,  8 Aug 2019 18:57:03 +0100 (BST)
Date:   Thu, 08 Aug 2019 18:57:02 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20190808163228.GE18351@dhcp22.suse.cz>
References: <CAJuCfpHhR+9ybt9ENzxMbdVUd_8rJN+zFbDm+5CeE2Desu82Gg@mail.gmail.com> <398f31f3-0353-da0c-fc54-643687bb4774@suse.cz> <20190806142728.GA12107@cmpxchg.org> <20190806143608.GE11812@dhcp22.suse.cz> <CAJuCfpFmOzj-gU1NwoQFmS_pbDKKd2XN=CS1vUV4gKhYCJOUtw@mail.gmail.com> <20190806220150.GA22516@cmpxchg.org> <20190807075927.GO11812@dhcp22.suse.cz> <20190807205138.GA24222@cmpxchg.org> <20190808114826.GC18351@dhcp22.suse.cz> <806F5696-A8D6-481D-A82F-49DEC1F2B035@redhazel.co.uk> <20190808163228.GE18351@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's inability to gracefully handle low memory pressure
To:     Michal Hocko <mhocko@kernel.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
From:   ndrw.xf@redhazel.co.uk
Message-ID: <5FBB0A26-0CFE-4B88-A4F2-6A42E3377EDB@redhazel.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8 August 2019 17:32:28 BST, Michal Hocko <mhocko@kernel.org> wrote:
>
>> Would it be possible to reserve a fixed (configurable) amount of RAM
>for caches,
>
>I am afraid there is nothing like that available and I would even argue
>it doesn't make much sense either. What would you consider to be a
>cache? A kernel/userspace reclaimable memory? What about any other in
>kernel memory users? How would you setup such a limit and make it
>reasonably maintainable over different kernel releases when the memory
>footprint changes over time?

Frankly, I don't know. The earlyoom userspace tool works well enough for me so I assumed this functionality could be implemented in kernel. Default thresholds would have to be tested but it is unlikely zero is the optimum value. 

>Besides that how does that differ from the existing reclaim mechanism?
>Once your cache hits the limit, there would have to be some sort of the
>reclaim to happen and then we are back to square one when the reclaim
>is
>making progress but you are effectively treshing over the hot working
>set (e.g. code pages)

By forcing OOM killer. Reclaiming memory when system becomes unresponsive is precisely what I want to avoid.

>> and trigger OOM killer earlier, before most UI code is evicted from
>memory?
>
>How does the kernel knows that important memory is evicted?

I assume current memory management policy (LRU?) is sufficient to keep most frequently used pages in memory.

>If you know which task is that then you can put it into a memory cgroup
>with a stricter memory limit and have it killed before the overal
>system
>starts suffering.

This is what I intended to use. But I don't know how to bypass SystemD or configure such policies via SystemD. 

>PSI is giving you a matric that tells you how much time you
>spend on the memory reclaim. So you can start watching the system from
>lower utilization already.

This is a fantastic news. Really. I didn't know this is how it works. Two potential issues, though:
1. PSI (if possible) should be normalised wrt the memory reclaiming cost (SSDs have lower cost than HDDs). If not automatically then perhaps via a user configurable option. That's somewhat similar to having configurable PSI thresholds. 
2. It seems PSI measures the _rate_ pages are evicted from memory. While this may correlate with the _absolute_ amount of of memory left, it is not the same. Perhaps weighting PSI with absolute amount of memory used for caches would improve this metric.

Best regards,
ndrw
