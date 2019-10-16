Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A924EFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4A52168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406392AbfJPQjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 12:39:13 -0400
Received: from foss.arm.com ([217.140.110.172]:45290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404348AbfJPQjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:39:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95ADC28;
        Wed, 16 Oct 2019 09:39:12 -0700 (PDT)
Received: from [192.168.1.103] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B24C73F68E;
        Wed, 16 Oct 2019 09:39:11 -0700 (PDT)
Subject: Re: [PATCH] hugetlb: Fix clang compilation warning
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20191016142324.52250-1-vincenzo.frascino@arm.com>
 <29fdadee-2e0c-0886-73b3-358f983fd1fd@oracle.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <cac7143d-fc2e-16c5-c422-42b06acf7039@arm.com>
Date:   Wed, 16 Oct 2019 17:41:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <29fdadee-2e0c-0886-73b3-358f983fd1fd@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 10/16/19 4:21 PM, Mike Kravetz wrote:
> On 10/16/19 7:23 AM, Vincenzo Frascino wrote:
>> Building the kernel with a recent version of clang I noticed the warning
>> below:
>>
>> mm/hugetlb.c:4055:40: warning: expression does not compute the number of
>> elements in this array; element type is 'unsigned long', not 'u32'
>> (aka 'unsigned int') [-Wsizeof-array-div]
>>         hash = jhash2((u32 *)&key, sizeof(key)/sizeof(u32), 0);
>>                                           ~~~ ^
>> mm/hugetlb.c:4049:16: note: array 'key' declared here
>>         unsigned long key[2];
>>                       ^
>> mm/hugetlb.c:4055:40: note: place parentheses around the 'sizeof(u32)'
>> expression to silence this warning
>>         hash = jhash2((u32 *)&key, sizeof(key)/sizeof(u32), 0);
>>                                               ^  CC      fs/ext4/ialloc.o
>>
>> Fix the warning adding parentheses around the sizeof(u32) expression.
>>
>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> Thanks,
> 
> However, this is already addressed in Andrew's tree.
> https://ozlabs.org/~akpm/mmotm/broken-out/hugetlbfs-hugetlb_fault_mutex_hash-cleanup.patch
> 

Thank you for pointing this out.

-- 
Regards,
Vincenzo
