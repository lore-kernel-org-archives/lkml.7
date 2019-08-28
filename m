Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B901C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2957E2189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfH1OSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:18:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfH1OSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:18:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 15783308123B;
        Wed, 28 Aug 2019 14:18:46 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DC1335F2;
        Wed, 28 Aug 2019 14:18:42 +0000 (UTC)
Subject: Re: [PATCH v2] fs/proc/page: Skip uninitialized page when iterating
 page structures
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Dan Williams <dan.j.williams@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
References: <20190826124336.8742-1-longman@redhat.com>
 <20190827142238.GB10223@dhcp22.suse.cz>
 <20190828080006.GG7386@dhcp22.suse.cz>
 <8363a4ba-e26f-f88c-21fc-5dd1fe64f646@redhat.com>
 <20190828140938.GL28313@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <4367f507-97ba-a74e-6bf5-811cdd6ecdf9@redhat.com>
Date:   Wed, 28 Aug 2019 10:18:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190828140938.GL28313@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 28 Aug 2019 14:18:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/19 10:09 AM, Michal Hocko wrote:
> On Wed 28-08-19 09:46:21, Waiman Long wrote:
>> On 8/28/19 4:00 AM, Michal Hocko wrote:
>>> On Tue 27-08-19 16:22:38, Michal Hocko wrote:
>>>> Dan, isn't this something we have discussed recently?
>>> This was http://lkml.kernel.org/r/20190725023100.31141-3-t-fukasawa@vx.jp.nec.com
>>> and talked about /proc/kpageflags but this is essentially the same thing
>>> AFAIU. I hope we get a consistent solution for both issues.
>>>
>> Yes, it is the same problem. The uninitialized page structure problem
>> affects all the 3 /proc/kpage{cgroup,count,flags) files.
>>
>> Toshiki's patch seems to fix it just for /proc/kpageflags, though.
> Yup. I was arguing that whacking a mole kinda fix is far from good. Dan
> had some arguments on why initializing those struct pages is a problem.
> The discussion had a half open end though. I hoped that Dan would try
> out the initialization side but I migh have misunderstood.

If the page structures of the reserved PFNs are always initialized, that
will fix the problem too. I am not familiar with the zone device code.
So I didn't attempt to do that.

Cheers,
Longman

