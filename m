Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20142C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4262085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388764AbfCAP0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:26:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:43378 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbfCAP0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:26:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 22603AB4D;
        Fri,  1 Mar 2019 15:26:17 +0000 (UTC)
Date:   Fri, 1 Mar 2019 16:25:48 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        hughd@google.com, kirill@shutemov.name, joel@joelfernandes.org,
        jglisse@redhat.com, yang.shi@linux.alibaba.com,
        mgorman@techsingularity.net
Subject: Re: [PATCH] mm,mremap: Bail out earlier in mremap_to under map
 pressure
Message-ID: <20190301152547.GA25732@rei>
References: <20190226091314.18446-1-osalvador@suse.de>
 <20190226140428.3e7c8188eda6a54f9da08c43@linux-foundation.org>
 <20190227213205.5wdjucqdgfqx33tr@d104.suse.de>
 <5edcfeb8-4f53-0fe6-1e5b-c1e485f91d0d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5edcfeb8-4f53-0fe6-1e5b-c1e485f91d0d@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> Hopefully the only program that would start failing would be a LTP test
> testing the current behavior near the limit (if such test exists). And
> that can be adjusted.

There does not seem to be a mremap() test that would do such a thing, so
we should be safe :-).

BTW there was a similar fix for mmap() with MAP_FIXED that caused a LTP
test to fail and was fixed in:

commit e8420a8ece80b3fe810415ecf061d54ca7fab266
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Mon Apr 29 15:08:33 2013 -0700

    mm/mmap: check for RLIMIT_AS before unmapping

And I haven't heard of any breakages so far so I guess that this very
similar situation and that the possibility of breaking real world
applications here is really low.

-- 
Cyril Hrubis
chrubis@suse.cz
