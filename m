Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FF5C17440
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F6F21D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbfKMC0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:26:32 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:33815 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727419AbfKMC0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 21:26:30 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01451;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=29;SR=0;TI=SMTPD_---0ThwxTq0_1573611984;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ThwxTq0_1573611984)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Nov 2019 10:26:25 +0800
Subject: Re: [PATCH v2 4/8] mm/lru: only change the lru_lock iff page's lruvec
 is different
To:     Matthew Wilcox <willy@infradead.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        swkhack <swkhack@gmail.com>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <1573567588-47048-1-git-send-email-alex.shi@linux.alibaba.com>
 <1573567588-47048-5-git-send-email-alex.shi@linux.alibaba.com>
 <20191112143624.GA7934@bombadil.infradead.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <297ad71c-081c-f7e1-d640-8720a0eeeeba@linux.alibaba.com>
Date:   Wed, 13 Nov 2019 10:26:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191112143624.GA7934@bombadil.infradead.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Matthew,

Thanks a lot for comments!

ÔÚ 2019/11/12 ÏÂÎç10:36, Matthew Wilcox Ð´µÀ:
> On Tue, Nov 12, 2019 at 10:06:24PM +0800, Alex Shi wrote:
>> +/* Don't lock again iff page's lruvec locked */
>> +static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
>> +					struct lruvec *locked_lruvec)
>> +{
>> +	struct pglist_data *pgdat = page_pgdat(page);
>> +	struct lruvec *lruvec;
>> +
>> +	rcu_read_lock();
>> +	lruvec = mem_cgroup_page_lruvec(page, pgdat);
>> +
>> +	if (locked_lruvec == lruvec) {
>> +		rcu_read_unlock();
>> +		return lruvec;
>> +	}
>> +	rcu_read_unlock();
> 
> Why not simply:
> 
> 	rcu_read_lock();
> 	lruvec = mem_cgroup_page_lruvec(page, pgdat);
> 	rcu_read_unlock();
> 
> 	if (locked_lruvec == lruvec)

The rcu_read_unlock here is for guarding the locked_lruvec/lruvec comparsion.
Otherwise memcg/lruvec maybe changed, like, from memcg migration etc. I guess.
 
> 		return lruvec;
> 
> Also, why are you bothering to re-enable interrupts here?  Surely if
> you're holding lock A with interrupts disabled , you can just drop lock A,
> acquire lock B and leave the interrupts alone.  That way you only need
> one of this variety of function, and not the separate irq/irqsave variants.
> 

Thanks for the suggestion! Yes, if only do re-lock, it's better to leave the irq unchanging. but, when the locked_lruvec is NULL, it become a first time lock which irq or irqsave are different. Thus, in combined function we need a nother parameter to indicate if it do irqsaving. So comparing to a extra/indistinct parameter, I guess 2 inline functions would be a bit more simple/cleary? 

Thanks a lot!
Alex
