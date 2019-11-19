Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD51C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD05A20857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 10:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfKSKEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 05:04:50 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:58337 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725280AbfKSKEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 05:04:49 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=38;SR=0;TI=SMTPD_---0TiY4-eE_1574157875;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TiY4-eE_1574157875)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Nov 2019 18:04:36 +0800
Subject: Re: [PATCH v3 3/7] mm/lru: replace pgdat lru_lock with lruvec lock
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        swkhack <swkhack@gmail.com>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Colin Ian King <colin.king@canonical.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <1573874106-23802-1-git-send-email-alex.shi@linux.alibaba.com>
 <1573874106-23802-4-git-send-email-alex.shi@linux.alibaba.com>
 <20191118161126.GB365174@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <85702d50-daf0-ece8-9a5d-e4b860ef2f99@linux.alibaba.com>
Date:   Tue, 19 Nov 2019 18:04:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191118161126.GB365174@cmpxchg.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2019/11/19 ÉÏÎç12:11, Johannes Weiner Ð´µÀ:
> On Sat, Nov 16, 2019 at 11:15:02AM +0800, Alex Shi wrote:
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 62470325f9bc..cf274739e619 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -1246,6 +1246,42 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
>>  	return lruvec;
>>  }
>>  
>> +struct lruvec *lock_page_lruvec_irq(struct page *page,
>> +					struct pglist_data *pgdat)
>> +{
>> +	struct lruvec *lruvec;
>> +
>> +again:
>> +	lruvec = mem_cgroup_page_lruvec(page, pgdat);
>> +	spin_lock_irq(&lruvec->lru_lock);
> 
> This isn't safe. Nothing prevents the page from being moved to a
> different memcg in between these two operations, and the lruvec having
> been freed by the time you try to acquire the spinlock.
> 
> You need to use the rcu lock to dereference page->mem_cgroup and its
> lruvec when coming from the page like this.

Hi Johannes,

Yes, you are right. Thank a lot to point out this!
Could we use rcu lock to guard the lruvec till lruvec->lru_lock getten?

+struct lruvec *lock_page_lruvec_irq(struct page *page,
+                                       struct pglist_data *pgdat)
+{
+       struct lruvec *lruvec;
+
+again:
+       rcu_read_lock();
+       lruvec = mem_cgroup_page_lruvec(page, pgdat);
+       spin_lock_irq(&lruvec->lru_lock);
+       rcu_read_unlock();
+
+       /* lruvec may changed in commit_charge() */
+       if (lruvec != mem_cgroup_page_lruvec(page, pgdat)) {
+               spin_unlock_irq(&lruvec->lru_lock);
+               goto again;
+       }
+
+       return lruvec;
+}
> 
> You also need to use page_memcg_rcu() to insert the appropriate
> lockless access barriers, which mem_cgroup_page_lruvec() does not do
> since it's designed for use with pgdat->lru_lock.
> 

Since the page_memcg_rcu can not know it under a spin_lock, guess the following enhance is fine:
@@ -1225,7 +1224,7 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
                goto out;
        }

-       memcg = page->mem_cgroup;
+       memcg = READ_ONCE(page->mem_cgroup);
        /*


Millions thanks!
Alex
