Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900C6C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 12:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6AD21743
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 12:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfHJMeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 08:34:12 -0400
Received: from 68.66.241.172.static.a2webhosting.com ([68.66.241.172]:49384
        "EHLO vps.redhazel.co.uk" rhost-flags-OK-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1726024AbfHJMeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 08:34:09 -0400
Received: from [192.168.1.66] (unknown [212.159.68.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by vps.redhazel.co.uk (Postfix) with ESMTPSA id 063771C000AA;
        Sat, 10 Aug 2019 13:34:07 +0100 (BST)
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <20190807075927.GO11812@dhcp22.suse.cz>
 <20190807205138.GA24222@cmpxchg.org> <20190808114826.GC18351@dhcp22.suse.cz>
 <806F5696-A8D6-481D-A82F-49DEC1F2B035@redhazel.co.uk>
 <20190808163228.GE18351@dhcp22.suse.cz>
 <5FBB0A26-0CFE-4B88-A4F2-6A42E3377EDB@redhazel.co.uk>
 <20190808185925.GH18351@dhcp22.suse.cz>
 <08e5d007-a41a-e322-5631-b89978b9cc20@redhazel.co.uk>
 <20190809085748.GN18351@dhcp22.suse.cz>
 <cdb392ee-e192-c136-41cb-48d9e4e4bf47@redhazel.co.uk>
 <20190809105016.GP18351@dhcp22.suse.cz>
From:   ndrw <ndrw.xf@redhazel.co.uk>
Message-ID: <33407eca-3c05-5900-0353-761db62feeea@redhazel.co.uk>
Date:   Sat, 10 Aug 2019 13:34:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809105016.GP18351@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2019 11:50, Michal Hocko wrote:
> We try to protect low amount of cache. Have a look at get_scan_count
> function. But the exact amount of the cache to be protected is really
> hard to know wihtout a crystal ball or understanding of the workload.
> The kernel doesn't have neither of the two.

Thank you. I'm familiarizing myself with the code. Is there anyone I 
could discuss some details with? I don't want to create too much noise here.

For example, are file pages created by mmaping files and are anon page 
exclusively allocated on heap (RW data)? If so, where do "streaming IO" 
pages belong to?

> We have been thinking about this problem for a long time and couldn't
> come up with anything much better than we have now. PSI is the most recent
> improvement in that area. If you have better ideas then patches are
> always welcome.

In general, I found there are very few user accessible knobs for 
adjusting caching, especially in the pre-OOM phase. On the other hand, 
swapping, dirty page caching, have many options or can even be disabled 
completely.

For example, I would like to try disabling/limiting eviction of some/all 
file pages (for example exec pages) akin to disabling swapping, but 
there is no such mechanism. Yes, there would likely be problems with 
large RO mmapped files that would need to be addressed, but in many 
applications users would be interested in having such options.

Adjusting how aggressive/conservative the system should be with the OOM 
killer also falls into this category.

>> [OOM killer accuracy]
> That is a completely orthogonal problem, I am afraid. So far we have
> been discussing _when_ to trigger OOM killer. This is _who_ to kill. I
> haven't heard any recent examples that the victim selection would be way
> off and killing something obviously incorrect.

You are right. I've assumed earlyoom is more accurate because of OOM 
killer performing better on a system that isn't stalled yet (perhaps it 
does). But actually, earlyoom doesn't trigger OOM killer at all:

https://github.com/rfjakob/earlyoom#why-not-trigger-the-kernel-oom-killer

Apparently some applications (chrome and electron-based tools) set their 
oom_score_adj incorrectly - this matches my observations of OOM killer 
behavior:

https://bugs.chromium.org/p/chromium/issues/detail?id=333617

> Something that other people can play with to reproduce the issue would
> be more than welcome.

This is the script I used. It reliably reproduces the issue: 
https://github.com/ndrw6/import_postcodes/blob/master/import_postcodes.py 
but it has quite a few dependencies, needs some input data and, in 
general, does a lot more than just fill up the memory. I will try to 
come up with something simpler.

Best regards,

ndrw


