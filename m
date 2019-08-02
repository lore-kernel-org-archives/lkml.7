Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567EFC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AEB72086A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390987AbfHBKUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 06:20:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:54846 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389243AbfHBKUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:20:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4649EAE03;
        Fri,  2 Aug 2019 10:20:34 +0000 (UTC)
Subject: Re: [RFC PATCH 2/3] mm, compaction: use MIN_COMPACT_COSTLY_PRIORITY
 everywhere for costly orders
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Hillf Danton <hdanton@sina.com>, Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190724175014.9935-1-mike.kravetz@oracle.com>
 <20190724175014.9935-3-mike.kravetz@oracle.com>
 <278da9d8-6781-b2bc-8de6-6a71e879513c@suse.cz>
 <0942e0c2-ac06-948e-4a70-a29829cbcd9c@oracle.com>
 <89ba8e07-b0f8-4334-070e-02fbdfc361e3@suse.cz>
 <2f1d6779-2b87-4699-abf7-0aa59a2e74d9@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <a0f01341-a5d8-d015-c37e-4932eaafd868@suse.cz>
Date:   Fri, 2 Aug 2019 12:20:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2f1d6779-2b87-4699-abf7-0aa59a2e74d9@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/19 10:33 PM, Mike Kravetz wrote:
> On 8/1/19 6:01 AM, Vlastimil Babka wrote:
>> Could you try testing the patch below instead? It should hopefully
>> eliminate the stalls. If it makes hugepage allocation give up too early,
>> we'll know we have to involve __GFP_RETRY_MAYFAIL in allowing the
>> MIN_COMPACT_PRIORITY priority. Thanks!
> 
> Thanks.  This patch does eliminate the stalls I was seeing.

Great, thanks! I'll send a proper patch then.

> In my testing, there is little difference in how many hugetlb pages are
> allocated.  It does not appear to be giving up/failing too early.  But,
> this is only with __GFP_RETRY_MAYFAIL.  The real concern would with THP
> requests.  Any suggestions on how to test that?

AFAICS the default THP defrag mode is unaffected, as GFP_TRANSHUGE_LIGHT doesn't
include __GFP_DIRECT_RECLAIM, so it never reaches this code. Madvised THP
allocations will be affected, which should best be tested the same way as Andrea
and Mel did in the __GFP_THISNODE debate.

