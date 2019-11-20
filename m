Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A3CC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D9222310
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbfKTLuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:50:44 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:45292 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727619AbfKTLun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:50:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=38;SR=0;TI=SMTPD_---0Tie.JMf_1574250633;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Tie.JMf_1574250633)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Nov 2019 19:50:35 +0800
Subject: Re: [PATCH v4 3/9] mm/lru: replace pgdat lru_lock with lruvec lock
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, shakeelb@google.com,
        Michal Hocko <mhocko@kernel.org>,
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
References: <1574166203-151975-1-git-send-email-alex.shi@linux.alibaba.com>
 <1574166203-151975-4-git-send-email-alex.shi@linux.alibaba.com>
 <20191119155704.GP20752@bombadil.infradead.org>
 <20191119164448.GA396644@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <ae58bcc4-cb47-7c66-d190-531299fb7b42@linux.alibaba.com>
Date:   Wed, 20 Nov 2019 19:50:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191119164448.GA396644@cmpxchg.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2019/11/20 ÉÏÎç12:44, Johannes Weiner Ð´µÀ:
> On Tue, Nov 19, 2019 at 07:57:04AM -0800, Matthew Wilcox wrote:
>> On Tue, Nov 19, 2019 at 08:23:17PM +0800, Alex Shi wrote:
>>> +static inline struct lruvec *lock_page_lruvec_irqsave(struct page *page,
>>> +				struct pglist_data *pgdat, unsigned long *flags)
>>> +{
>>> +	struct lruvec *lruvec = mem_cgroup_page_lruvec(page, pgdat);
>>> +
>>> +	spin_lock_irqsave(&lruvec->lru_lock, *flags);
>>> +
>>> +	return lruvec;
>>> +}
>>
>> This should be a macro, not a function.  You basically can't do this;
>> spin_lock_irqsave needs to write to a variable which can then be passed
>> to spin_unlock_irqrestore().  What you're doing here will dereference the
>> pointer in _this_ function, but won't propagate the modified value back to
>> the caller.  I suppose you could do something like this ...
> 
> This works because spin_lock_irqsave and local_irq_save() are
> macros. It boils down to '*flags = arch_local_irq_save()' in this
> function, and therefor does the right thing.
> 
> We exploit that in quite a few places:
> 
> $ git grep 'spin_lock_irqsave(.*\*flags' | wc -l
> 39
> 

Yes, thank you all for point this!
