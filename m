Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEFFC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 01:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070AC21835
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 01:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfLQBaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 20:30:23 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:49797 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726591AbfLQBaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 20:30:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=38;SR=0;TI=SMTPD_---0Tl9Rv9Q_1576546213;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Tl9Rv9Q_1576546213)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 Dec 2019 09:30:14 +0800
Subject: Re: [PATCH v6 02/10] mm/lru: replace pgdat lru_lock with lruvec lock
To:     Matthew Wilcox <willy@infradead.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, shakeelb@google.com,
        hannes@cmpxchg.org, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
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
References: <1576488386-32544-1-git-send-email-alex.shi@linux.alibaba.com>
 <1576488386-32544-3-git-send-email-alex.shi@linux.alibaba.com>
 <20191216121427.GZ32169@bombadil.infradead.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <286c11c2-480f-37d6-e9fe-91822f862cd6@linux.alibaba.com>
Date:   Tue, 17 Dec 2019 09:30:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191216121427.GZ32169@bombadil.infradead.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2019/12/16 ÏÂÎç8:14, Matthew Wilcox Ð´µÀ:
> On Mon, Dec 16, 2019 at 05:26:18PM +0800, Alex Shi wrote:
>> -static void lock_page_lru(struct page *page, int *isolated)
>> +static struct lruvec *lock_page_lru(struct page *page, int *isolated)
>>  {
>> -	pg_data_t *pgdat = page_pgdat(page);
>> +	struct lruvec *lruvec = lock_page_lruvec_irq(page);
>>  
>> -	spin_lock_irq(&pgdat->lru_lock);
>>  	if (PageLRU(page)) {
>> -		struct lruvec *lruvec;
>>  
>> -		lruvec = mem_cgroup_page_lruvec(page, pgdat);
>>  		ClearPageLRU(page);
>>  		del_page_from_lru_list(page, lruvec, page_lru(page));
>>  		*isolated = 1;
>>  	} else
>>  		*isolated = 0;
>> +
>> +	return lruvec;
>>  }
> 
> You still didn't fix this function.  Go back and look at my comment from
> the last time you sent this patch set.
> 

Sorry for the misunderstanding. I guess what your want is fold the patch 9th into this, is that right?
Any comments for the 9th patch?

Thanks
Alex
