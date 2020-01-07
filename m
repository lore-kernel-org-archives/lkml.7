Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D42C32771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 02:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF4B20715
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 02:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgAGCd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 21:33:56 -0500
Received: from mga04.intel.com ([192.55.52.120]:11317 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbgAGCdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 21:33:55 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 18:33:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,404,1571727600"; 
   d="scan'208";a="217587426"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jan 2020 18:33:52 -0800
Date:   Tue, 7 Jan 2020 10:33:57 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, vdavydov.dev@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        cgroups@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [RFC PATCH] mm: thp: grab the lock before manipulation defer list
Message-ID: <20200107023357.GD15341@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200103143407.1089-1-richardw.yang@linux.intel.com>
 <CAKgT0Uf+EP8yGf93=R3XK0Y=0To0KQDys0O1BkG-Odej3Rwj5A@mail.gmail.com>
 <20200107012624.GB15341@richard>
 <alpine.DEB.2.21.2001061803200.55132@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2001061803200.55132@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 06:07:29PM -0800, David Rientjes wrote:
>On Tue, 7 Jan 2020, Wei Yang wrote:
>
>> >One thing you might want to do is pull the "if (compound)" check out
>> >and place it outside of the spinlock check. It would then simplify
>> >this signficantly so it is something like
>> >if (compound) {
>> >  spin_lock();
>> >  list = page_deferred_list(page);
>> >  if (!list_empty(list)) {
>> >    list_del_init(list);
>> >    from->..split_queue_len--;
>> >  }
>> >  spin_unlock();
>> >}
>> >
>> >Same for the block below. I would pull the check for compound outside
>> >of the spinlock call since it is a value that shouldn't change and
>> >would eliminate an unnecessary lock in the non-compound case.
>> 
>> This is reasonable, if no objection from others, I would change this in v2.
>
>Looks fine to me; I don't see it as a necessary improvement but there's 
>also no reason to object to it.  It's definitely a patch that is needed, 
>however, for the simple reason that with the existing code we can 
>manipulate the deferred split queue incorrectly so either way works for 
>me.  Feel free to keep my acked-by.

Ah, thanks David. You are so supportive.

-- 
Wei Yang
Help you, Help me
