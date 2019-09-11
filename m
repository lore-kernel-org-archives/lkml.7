Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EF4C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 20:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7992053B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 20:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfIKUvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 16:51:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729327AbfIKUvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 16:51:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6274930821BF;
        Wed, 11 Sep 2019 20:51:04 +0000 (UTC)
Received: from llong.remote.csb (ovpn-121-77.rdu2.redhat.com [10.10.121.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D11845D6A5;
        Wed, 11 Sep 2019 20:51:01 +0000 (UTC)
Subject: Re: [PATCH 5/5] hugetlbfs: Limit wait time when trying to share huge
 PMD
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Davidlohr Bueso <dave@stgolabs.net>
References: <20190911150537.19527-1-longman@redhat.com>
 <20190911150537.19527-6-longman@redhat.com>
 <20190911195745.GI29434@bombadil.infradead.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <11361434-ca3d-78ae-e825-8521ee3bfbe6@redhat.com>
Date:   Wed, 11 Sep 2019 21:51:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190911195745.GI29434@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 11 Sep 2019 20:51:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/19 8:57 PM, Matthew Wilcox wrote:
> On Wed, Sep 11, 2019 at 04:05:37PM +0100, Waiman Long wrote:
>> To remove the unacceptable delays, we have to limit the amount of wait
>> time on the mmap_sem. So the new down_write_timedlock() function is
>> used to acquire the write lock on the mmap_sem with a timeout value of
>> 10ms which should not cause a perceivable delay. If timeout happens,
>> the task will abandon its effort to share the PMD and allocate its own
>> copy instead.
> If you do a v2, this is *NOT* the mmap_sem.  It's the i_mmap_rwsem
> which protects a very different data structure from the mmap_sem.
>
Thanks for reminder. I should have read the code more carefully.

Cheers,
Longman

