Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD51C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8DE20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfCGJnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:43:10 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42970 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfCGJnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:43:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B456480D;
        Thu,  7 Mar 2019 01:43:09 -0800 (PST)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98AD33F706;
        Thu,  7 Mar 2019 01:43:07 -0800 (PST)
Subject: Re: [PATCH] [v2] dma-mapping: work around clang bug
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Paul Burton <paul.burton@mips.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190307085246.1477426-1-arnd@arndb.de>
 <86b7f396-c525-ae7e-b51c-cb2442d8d507@arm.com>
 <CAK8P3a19dyTxE2o9KAw3G1qH8p4qXO-dhhc885Z2_w9BDSoFHQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <295485e0-a43e-874e-2314-7c501c56ba71@arm.com>
Date:   Thu, 7 Mar 2019 09:43:06 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <CAK8P3a19dyTxE2o9KAw3G1qH8p4qXO-dhhc885Z2_w9BDSoFHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-07 9:28 am, Arnd Bergmann wrote:
> On Thu, Mar 7, 2019 at 10:17 AM Robin Murphy <robin.murphy@arm.com> wrote:
>> On 2019-03-07 8:52 am, Arnd Bergmann wrote:
>>>
>>> -#define DMA_BIT_MASK(n)      (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
>>> +/* double shift to work around https://bugs.llvm.org/show_bug.cgi?id=38789 */
>>> +#define DMA_BIT_MASK(n)      (((n) == 64) ? ~0ULL : ((1ULL<<((n)-1))<<1)-1)
>>
>> I think that now makes DMA_BIT_MASK(0) undefined - that shouldn't matter
>> in most cases, but it could potentially happen at runtime where callers
>> use a non-constant argument. However, it also means we don't need to
>> special-case 64 any more (since that's there to avoid the same thing
>> anyway), so we could simply flip that to handle 0 instead.
> 
> Yes, good idea.
> 
>> FWIW I'd be very tempted to fold in the second shift as "2ULL<<((n)-1)",
>> but that may not be to everyone's taste.
> 
> I like that. So shall we do this?
> 
> /*
>   * Shifting '2' instead of '1' because of
>   * https://bugs.llvm.org/show_bug.cgi?id=38789
>   */
> #define DMA_BIT_MASK(n)    (((n) == 0) ? 0ULL : ((2ULL<<((n)-1)))-1)

Neat - it was too early in the morning for me to think of a succinct way 
to comment it, but that's great. I suspect there may be a redundant set 
of parentheses around the shift still, but other than that,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Cheers,
Robin.
