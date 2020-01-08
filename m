Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73DBC33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 00:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4EC6206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 00:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgAHAfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:35:42 -0500
Received: from mga17.intel.com ([192.55.52.151]:52887 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgAHAfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 19:35:42 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 16:35:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,407,1571727600"; 
   d="scan'208";a="211367315"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga007.jf.intel.com with ESMTP; 07 Jan 2020 16:35:40 -0800
Date:   Wed, 8 Jan 2020 08:35:43 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yang.shi@linux.alibaba.com
Subject: Re: [RFC PATCH] mm: thp: grab the lock before manipulation defer list
Message-ID: <20200108003543.GA13943@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200103143407.1089-1-richardw.yang@linux.intel.com>
 <20200106102345.GE12699@dhcp22.suse.cz>
 <20200107012241.GA15341@richard>
 <20200107083808.GC32178@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107083808.GC32178@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 09:38:08AM +0100, Michal Hocko wrote:
>On Tue 07-01-20 09:22:41, Wei Yang wrote:
>> On Mon, Jan 06, 2020 at 11:23:45AM +0100, Michal Hocko wrote:
>> >On Fri 03-01-20 22:34:07, Wei Yang wrote:
>> >> As all the other places, we grab the lock before manipulate the defer list.
>> >> Current implementation may face a race condition.
>> >
>> >Please always make sure to describe the effect of the change. Why a racy
>> >list_empty check matters?
>> >
>> 
>> Hmm... access the list without proper lock leads to many bad behaviors.
>
>My point is that the changelog should describe that bad behavior.
>
>> For example, if we grab the lock after checking list_empty, the page may
>> already be removed from list in split_huge_page_list. And then list_del_init
>> would trigger bug.
>
>And how does list_empty check under the lock guarantee that the page is
>on the deferred list?

Just one confusion, is this kind of description basic concept of concurrent
programming? How detail level we need to describe the effect?

To me, grab the lock before accessing the critical section is obvious.
list_empty and list_del should be the critical section. And the
lock should protect the whole critical section instead of part of it.

>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
