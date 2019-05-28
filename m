Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD766C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B586B206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfE1QHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 12:07:46 -0400
Received: from relay.sw.ru ([185.231.240.75]:38226 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbfE1QHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 12:07:45 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hVedY-0005la-Dm; Tue, 28 May 2019 19:07:40 +0300
Subject: Re: [PATCH REBASED 1/4] mm: Move recent_rotated pages calculation to
 shrink_inactive_list()
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, daniel.m.jordan@oracle.com,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <155290113594.31489.16711525148390601318.stgit@localhost.localdomain>
 <155290127956.31489.3393586616054413298.stgit@localhost.localdomain>
 <20190528155134.GA14663@cmpxchg.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <3c081218-0dc9-54f2-839e-00adca089831@virtuozzo.com>
Date:   Tue, 28 May 2019 19:07:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528155134.GA14663@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.05.2019 18:51, Johannes Weiner wrote:
> On Mon, Mar 18, 2019 at 12:27:59PM +0300, Kirill Tkhai wrote:
>> @@ -1945,6 +1942,8 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>>  		count_memcg_events(lruvec_memcg(lruvec), PGSTEAL_DIRECT,
>>  				   nr_reclaimed);
>>  	}
>> +	reclaim_stat->recent_rotated[0] = stat.nr_activate[0];
>> +	reclaim_stat->recent_rotated[1] = stat.nr_activate[1];
> 
> Surely this should be +=, right?
> 
> Otherwise we maintain essentially no history of page rotations and
> that wreaks havoc on the page cache vs. swapping reclaim balance.

Sure, thanks.

Kirill
