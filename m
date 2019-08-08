Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67EEC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 23:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861FA2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 23:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RQ1Ei+ek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404490AbfHHXau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 19:30:50 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17210 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733140AbfHHXat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 19:30:49 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4cb0aa0000>; Thu, 08 Aug 2019 16:30:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 08 Aug 2019 16:30:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 08 Aug 2019 16:30:49 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Aug
 2019 23:30:48 +0000
Subject: Re: [Linux-kernel-mentees][PATCH v4 1/1] sgi-gru: Remove *pte_lookup
 functions
From:   John Hubbard <jhubbard@nvidia.com>
To:     Bharath Vedartham <linux.bhar@gmail.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <sivanich@sgi.com>
CC:     <ira.weiny@intel.com>, <jglisse@redhat.com>,
        <william.kucharski@oracle.com>, <hch@lst.de>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel-mentees@lists.linuxfoundation.org>
References: <1565290555-14126-1-git-send-email-linux.bhar@gmail.com>
 <1565290555-14126-2-git-send-email-linux.bhar@gmail.com>
 <b659042a-f2c3-df3c-4182-bb7dd5156bc1@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <97a93739-783a-cf26-8384-a87c7d8bf75e@nvidia.com>
Date:   Thu, 8 Aug 2019 16:30:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b659042a-f2c3-df3c-4182-bb7dd5156bc1@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565307050; bh=JeEiCmZ1kkXlkjEvqYy9HdWxc7E1WmBQImLZC4SmHb4=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=RQ1Ei+ek/l7TS5OiIRwTFYtcyxSN9T9crP6QSv5UHXXIJAPAZC2aV4vTOVLtBo5Zs
         qH5R49FfIpBhuswLdJebx07f2s9YccCc3QuXdwYABh7ET1oOCDgc7ZXu5mwLTTstWb
         xOa02KE+GAVOGWGvFD0sVWCXxdmoLBJRwh+lJO60ITyZqc1MvDyNtE66gHpSkK1QWo
         YaJjFaXROyuyM1LFk09qlkvDpTRbR1gDXP8t/M4NtvKuJ9IIev7m9TTs+69QegZFTX
         52aYem6gWNo5FLgl6tSn7PXKLxcmYPTs5T34l56Pd9kudaY4yi6ni7k3DDa89tFCnx
         oXzCq5m5h4P9w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/19 4:21 PM, John Hubbard wrote:
> On 8/8/19 11:55 AM, Bharath Vedartham wrote:
> ...
>>  	if (is_gru_paddr(paddr))
>>  		goto inval;
>> -	paddr = paddr & ~((1UL << ps) - 1);
>> +	paddr = paddr & ~((1UL << *pageshift) - 1);
>>  	*gpa = uv_soc_phys_ram_to_gpa(paddr);
>> -	*pageshift = ps;
> 
> Why are you no longer setting *pageshift? There are a couple of callers
> that both use this variable.
> 
> 

...and once that's figured out, I can fix it up here and send it up with 
the next misc callsites series. I'm also inclined to make the commit
log read more like this:

sgi-gru: Remove *pte_lookup functions, convert to put_user_page*()

For pages that were retained via get_user_pages*(), release those pages
via the new put_user_page*() routines, instead of via put_page() or
release_pages().

This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
("mm: introduce put_user_page*(), placeholder versions").

As part of this conversion, the *pte_lookup functions can be removed and
be easily replaced with get_user_pages_fast() functions. In the case of
atomic lookup, __get_user_pages_fast() is used, because it does not fall
back to the slow path: get_user_pages(). get_user_pages_fast(), on the other
hand, first calls __get_user_pages_fast(), but then falls back to the
slow path if __get_user_pages_fast() fails.

Also: remove unnecessary CONFIG_HUGETLB ifdefs.


thanks,
-- 
John Hubbard
NVIDIA
