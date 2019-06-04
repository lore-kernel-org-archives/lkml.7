Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E053C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C2224A90
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfFDHSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:18:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbfFDHSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:18:13 -0400
Received: from [10.44.0.22] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 582FF24A8F;
        Tue,  4 Jun 2019 07:18:11 +0000 (UTC)
Subject: Re: [PATCH] m68k: io: Fix io{read,write}{16,32}be() for Coldfire
 peripherals
To:     Angelo Dureghello <angelo@sysam.it>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
References: <20190429081937.7544-1-geert@linux-m68k.org>
 <20190603122608.GA21347@jerusalem>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <d474e366-cf5f-bbf3-9521-c5ea29bb9c19@linux-m68k.org>
Date:   Tue, 4 Jun 2019 17:18:08 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603122608.GA21347@jerusalem>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On 3/6/19 10:26 pm, Angelo Dureghello wrote:
> couldn't seen any follow up on this patch. I tested it and at least
> for mcf5441x it works properly and solves all issues.
> 
> Do you think it may be accepted as an initial fix ?

I'll add it to the m68knommu git tree.
Seeing as you wrote it Geert I assume you have no problem with that?  :-)

Regards
Greg


> On Mon, Apr 29, 2019 at 10:19:37AM +0200, Geert Uytterhoeven wrote:
>> The generic definitions of mmio_{read,write}{16,32}be() in lib/iomap.c
>> assume that the {read,write}[wl]() I/O accessors always use little
>> endian accesses, and swap the result.
>>
>> However, the Coldfire versions of the {read,write}[wl]() I/O accessors are
>> special, in that they use native big endian instead of little endian for
>> accesses to the on-SoC peripheral block, thus violating the assumption.
>>
>> Fix this by providing our own variants, using the raw accessors,
>> reinstating the old behavior.  This is fine on m68k, as no special
>> barriers are needed, and also avoids swapping data twice.
>>
>> Reported-by: Angelo Dureghello <angelo@sysam.it>
>> Fixes: aecc787c06f4300f ("iomap: Use non-raw io functions for io{read|write}XXbe")
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> ---
>> This can be reverted later, after this oddity of the Coldfire I/O
>> support has been fixed, and drivers have been updated.
>> ---
>>   arch/m68k/include/asm/io.h | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/m68k/include/asm/io.h b/arch/m68k/include/asm/io.h
>> index aabe6420ead2a599..d47e7384681ab1cd 100644
>> --- a/arch/m68k/include/asm/io.h
>> +++ b/arch/m68k/include/asm/io.h
>> @@ -8,6 +8,12 @@
>>   #include <asm/io_mm.h>
>>   #endif
>>   
>> +#define mmio_read16be(addr)		__raw_readw(addr)
>> +#define mmio_read32be(addr)		__raw_readl(addr)
>> +
>> +#define mmio_write16be(val, port)	__raw_writew((val), (port))
>> +#define mmio_write32be(val, port)	__raw_writel((val), (port))
>> +
>>   #include <asm-generic/io.h>
>>   
>>   #endif /* _M68K_IO_H */
>> -- 
>> 2.17.1
>>
> 
