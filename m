Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A518BC2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FD521582
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfLPQYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 11:24:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:55930 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfLPQYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 11:24:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3B3D0B14A;
        Mon, 16 Dec 2019 16:24:18 +0000 (UTC)
Date:   Mon, 16 Dec 2019 08:17:48 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH v2] mm/hugetlb: defer free_huge_page() to a workqueue
Message-ID: <20191216161748.tgi2oictlfqy6azi@linux-p48b>
Mail-Followup-To: Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, aneesh.kumar@linux.ibm.com
References: <20191211194615.18502-1-longman@redhat.com>
 <4fbc39a9-2c9c-4c2c-2b13-a548afe6083c@oracle.com>
 <32d2d4f2-83b9-2e40-05e2-71cd07e01b80@redhat.com>
 <0fcce71f-bc20-0ea3-b075-46592c8d533d@oracle.com>
 <20191212060650.ftqq27ftutxpc5hq@linux-p48b>
 <20191212063050.ufrpij6s6jkv7g7j@linux-p48b>
 <20191212190427.ouyohviijf5inhur@linux-p48b>
 <20191216133711.GH30281@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191216133711.GH30281@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2019, Michal Hocko wrote:
>I am afraid that work_struct is too large to be stuffed into the struct
>page array (because of the lockdep part).

Yeah, this needs to be done without touching struct page.

Which is why I had done the stack allocated way in this patch, but we
cannot wait for it to complete in irq, so that's out the window. Andi
had suggested percpu allocated work items, but having played with the
idea over the weekend, I don't see how we can prevent another page being
freed on the same cpu before previous work on the same cpu is complete
(cpu0 wants to free pageA, schedules the work, in the mean time cpu0
wants to free pageB and workerfn for pageA still hasn't been called).

>I think that it would be just safer to make hugetlb_lock irq safe. Are
>there any other locks that would require the same?

It would be simpler. Any performance issues that arise would probably
be only seen in microbenchmarks, assuming we want to have full irq safety.
If we don't need to worry about hardirq, then even better.

The subpool lock would also need to be irq safe.

Thanks,
Davidlohr
