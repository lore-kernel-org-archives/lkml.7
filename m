Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D702C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB802070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FZsDoNRb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732399AbfCZULd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:11:33 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17868 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCZULc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 16:11:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9a876f0000>; Tue, 26 Mar 2019 13:11:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 Mar 2019 13:11:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 Mar 2019 13:11:31 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Mar
 2019 20:11:31 +0000
Subject: Re: CONFIG_DEBUG_VIRTUAL breaks boot on x86-32
To:     William Kucharski <william.kucharski@oracle.com>,
        Meelis Roos <mroos@linux.ee>
CC:     LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <4d5ee3b0-6d47-a8df-a6b3-54b0fba66ed7@linux.ee>
 <A1B7F481-4BF6-4441-8019-AE088F8A8939@oracle.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <f39477da-a1ef-e31e-a72d-8ea1d5755234@nvidia.com>
Date:   Tue, 26 Mar 2019 13:11:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <A1B7F481-4BF6-4441-8019-AE088F8A8939@oracle.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553631087; bh=culWY/Rk+vffcRaES9PIUDEE10WbDjvCzyyOH86GQbI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=FZsDoNRbAc/4HIAqnX+Vhp3z8GG7gJK9XpzbJ0o2AgUmo77iMdqmeGf4hsqJirXFz
         KD9YQx8cyDZO2zOa5KWXzLwhqJrh9hJBmbOral0aoQpkDeXzt0B4yZmiPBrBnFDpTp
         TnBXlS8XB16psg0eMYJrReNvKrHk6g9aM/ARYSLDwVek7HIhpN97BE635DArVyfjQp
         WFVjSAb0n+pK7VZWXuU0w31wIiDT1wdFIQNJDcS53JFHb9WI3LujqgV1CRBoqOM7Oq
         JzBMHcvXLsGogWedfKMpP8GzGvjLl6TmCN5uCvZ/aUTFacBwemf5G75ZNiWaQUxG5I
         5a14bPxDCOjPA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/26/19 6:52 AM, William Kucharski wrote:
> Does this still happen on 5.1-rc2?
> 
> Do you have idea as to what max_low_pfn() gets set to on your system at boot time?
> 
>  From the screen shot I'm guessing it MIGHT be 0x373fe, but it's hard to know for sure.
> 
> 
>> On Mar 21, 2019, at 2:22 PM, Meelis Roos <mroos@linux.ee> wrote:
>>
>> I tried to debug another problem and turned on most debug options for memory.
>> The resulting kernel failed to boot.
>>
>> Bisecting the configurations led to CONFIG_DEBUG_VIRTUAL - if I turned it on
>> in addition to some other debug options, the machine crashed with
>>
>> kernel BUG at arch/x86/mm/physaddr.c:79!
>>
>> Screenshot at http://kodu.ut.ee/~mroos/debug_virtual-boot-hang-1.jpg
>>
>> The machine was Athlon XP with VIA KT600 chipset and 2G RAM.
>>
>> -- 
>> Meelis Roos <mroos@linux.ee>
>>
> 

You might be hitting a bug I found.
Try applying this patch:
https://marc.info/?l=linux-kernel&m=155355953012985&w=2
