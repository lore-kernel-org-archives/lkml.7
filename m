Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BB2C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DDE208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbfFYMho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 08:37:44 -0400
Received: from foss.arm.com ([217.140.110.172]:40930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbfFYMhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:37:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC02B2B;
        Tue, 25 Jun 2019 05:37:42 -0700 (PDT)
Received: from [70.10.37.10] (unknown [10.37.10.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBE593F71E;
        Tue, 25 Jun 2019 05:37:39 -0700 (PDT)
Subject: Re: RISC-V nommu support v2
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <mhng-6f11ed95-e3f3-41dc-93c5-1576928b373b@palmer-si-x1e>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <4b2ce641-1412-0e71-82be-07e3f0a6328a@arm.com>
Date:   Tue, 25 Jun 2019 13:37:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <mhng-6f11ed95-e3f3-41dc-93c5-1576928b373b@palmer-si-x1e>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/19 8:31 AM, Palmer Dabbelt wrote:
> On Mon, 24 Jun 2019 06:08:50 PDT (-0700), vladimir.murzin@arm.com wrote:
>> On 6/24/19 12:54 PM, Christoph Hellwig wrote:
>>> On Mon, Jun 24, 2019 at 12:47:07PM +0100, Vladimir Murzin wrote:
>>>> Since you are using binfmt_flat which is kind of 32-bit only I was expecting to see
>>>> CONFIG_COMPAT (or something similar to that, like ILP32) enabled, yet I could not
>>>> find it.
>>>
>>> There is no such thing in RISC-V.  I don't know of any 64-bit RISC-V
>>> cpu that can actually run 32-bit RISC-V code, although in theory that
>>> is possible.  There also is nothing like the x86 x32 or mips n32 mode
>>> available either for now.
>>>
>>> But it turns out that with a few fixes to binfmt_flat it can run 64-bit
>>> binaries just fine.  I sent that series out a while ago, and IIRC you
>>> actually commented on it.
>>>
>>
>> True, yet my observation was that elf2flt utility assumes that address
>> space cannot exceed 32-bit (for header and absolute relocations). So,
>> from my limited point of view straightforward way to guarantee that would
>> be to build incoming elf in 32-bit mode (it is why I mentioned COMPAT/ILP32).
>>
>> Also one of your patches expressed somewhat related idea
>>
>> "binfmt_flat isn't the right binary format for huge executables to
>> start with"
>>
>> Since you said there is no support for compat/ilp32, probably I'm missing some
>> toolchain magic?
>>
>> Cheers
>> Vladimir
> To:          Christoph Hellwig <hch@lst.de>
> CC:          vladimir.murzin@arm.com
> CC:          Christoph Hellwig <hch@lst.de>
> CC:          Paul Walmsley <paul.walmsley@sifive.com>
> CC:          Damien Le Moal <Damien.LeMoal@wdc.com>
> CC:          linux-riscv@lists.infradead.org
> CC:          linux-mm@kvack.org
> CC:          linux-kernel@vger.kernel.org
> Subject:     Re: RISC-V nommu support v2
> In-Reply-To: <20190624131633.GB10746@lst.de>
> 
> On Mon, 24 Jun 2019 06:16:33 PDT (-0700), Christoph Hellwig wrote:
>> On Mon, Jun 24, 2019 at 02:08:50PM +0100, Vladimir Murzin wrote:
>>> True, yet my observation was that elf2flt utility assumes that address
>>> space cannot exceed 32-bit (for header and absolute relocations). So,
>>> from my limited point of view straightforward way to guarantee that would
>>> be to build incoming elf in 32-bit mode (it is why I mentioned COMPAT/ILP32).
>>>
>>> Also one of your patches expressed somewhat related idea
>>>
>>> "binfmt_flat isn't the right binary format for huge executables to
>>> start with"
>>>
>>> Since you said there is no support for compat/ilp32, probably I'm missing some
>>> toolchain magic?
>>
>> There is no magic except for the tiny elf2flt patch, which for
>> now is just in the buildroot repo pointed to in the cover letter
>> (and which I plan to upstream once the kernel support has landed
>> in Linus' tree).  We only support 32-bit code and data address spaces,
>> but we otherwise use the normal RISC-V ABI, that is 64-bit longs and
>> pointers.
> 
> The medlow code model on RISC-V essentially enforces this -- technically it
> enforces a 32-bit region centered around address 0, but it's not that hard to
> stay away from negative addresses.  That said, as long as elf2flt gives you an
> error it should be fine because all medlow is going to do is give you a
> different looking error message.
> 

Thanks for explanation!

Vladimir
