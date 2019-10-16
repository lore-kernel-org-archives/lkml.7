Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B19AECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5856721925
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390184AbfJPIe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:34:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728113AbfJPIey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:34:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B13CC8535C;
        Wed, 16 Oct 2019 08:34:54 +0000 (UTC)
Received: from [10.36.117.237] (ovpn-117-237.ams2.redhat.com [10.36.117.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78C195C1B5;
        Wed, 16 Oct 2019 08:34:53 +0000 (UTC)
Subject: Re: [PATCH] mm, soft-offline: convert parameter to pfn
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191016070924.GA10178@hori.linux.bs1.fc.nec.co.jp>
 <e931b14b-da27-2720-5344-b5c0b08b38ad@redhat.com>
 <20191016082735.GB13770@hori.linux.bs1.fc.nec.co.jp>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <c78962ba-ffa1-90e2-0116-6c94d082de2f@redhat.com>
Date:   Wed, 16 Oct 2019 10:34:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191016082735.GB13770@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 16 Oct 2019 08:34:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.19 10:27, Naoya Horiguchi wrote:
> On Wed, Oct 16, 2019 at 09:56:19AM +0200, David Hildenbrand wrote:
>> On 16.10.19 09:09, Naoya Horiguchi wrote:
>>> Hi,
>>>
>>> I wrote a simple cleanup for parameter of soft_offline_page(),
>>> based on thread https://lkml.org/lkml/2019/10/11/57.
>>>
>>> I know that we need more cleanup on hwpoison-inject, but I think
>>> that will be mentioned in re-write patchset Oscar is preparing now.
>>> So let me shared only this part as a separate one now.
> ...
>>
>> I think you should rebase that patch on linux-next (where the
>> pfn_to_online_page() check is in place). I assume you'll want to move the
>> pfn_to_online_page() check into soft_offline_page() then as well?
> 
> I rebased to next-20191016. And yes, we will move pfn_to_online_page()
> into soft offline code.  It seems that we can also move pfn_valid(),
> but is simply moving like below good enough for you?

At least I can't am the patch to current next/master (due to  
pfn_to_online_page()).

> 
>    @@ -1877,11 +1877,17 @@ static int soft_offline_free_page(struct page *page)
>      * This is not a 100% solution for all memory, but tries to be
>      * ``good enough'' for the majority of memory.
>      */
>    -int soft_offline_page(struct page *page, int flags)
>    +int soft_offline_page(unsigned long pfn, int flags)
>     {
>     	int ret;
>    -	unsigned long pfn = page_to_pfn(page);
>    +	struct page *page;
>     
>    +	if (!pfn_valid(pfn))
>    +		return -ENXIO;
>    +	/* Only online pages can be soft-offlined (esp., not ZONE_DEVICE). */
>    +	if (!pfn_to_online_page(pfn))
>    +		return -EIO;
>    +	page = pfn_to_page(pfn);
>     	if (is_zone_device_page(page)) {
>     		pr_debug_ratelimited("soft_offline: %#lx page is device page\n",
>     				pfn);
>    --
> 
> Or we might have an option to do as memory_failure() does like below:

In contrast to soft offlining, memory failure can deal with devmem. So I  
think the above makes sense.

-- 

Thanks,

David / dhildenb
