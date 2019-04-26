Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C066C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9D9206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="lqchdwa2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfDZJmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:42:33 -0400
Received: from smtp73.iad3a.emailsrvr.com ([173.203.187.73]:51406 "EHLO
        smtp73.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726926AbfDZJlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:41:24 -0400
Received: from smtp2.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp2.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 9765D4422;
        Fri, 26 Apr 2019 05:41:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1556271682;
        bh=AFFXNxnuayg/6yjC2puugNBjEVgWU3v1aBQDa5tiIww=;
        h=Subject:To:From:Date:From;
        b=lqchdwa2bn0nPA4fyF99hhA8m2MaG6ybtGvP6fwQr7YV5NDFHmmVzVr0miqloCAtC
         Ihzr5yq5RVn8w8e6RSrV6AWs0pm4zfv+8N7W6EmNd8eKRJmpRG0FHyCdViYUSkMIRL
         n+yZM6BhSqMKwJIMbCpoyZrPav1m1T3EPK8Kk5xo=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp2.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 1E6D72A6B;
        Fri, 26 Apr 2019 05:41:22 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.62] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Fri, 26 Apr 2019 05:41:22 -0400
Subject: Re: [PATCH] staging: comedi: comedi_isadma: Use a non-NULL device for
 DMA API
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20190425162644.21947-1-abbotti@mev.co.uk>
 <20190425171351.GB11105@kroah.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <e1322f35-af8b-8151-b560-0ba76775b237@mev.co.uk>
Date:   Fri, 26 Apr 2019 10:41:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425171351.GB11105@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2019 18:13, Greg Kroah-Hartman wrote:
> On Thu, Apr 25, 2019 at 05:26:44PM +0100, Ian Abbott wrote:
>> The "comedi_isadma" module calls `dma_alloc_coherent()` and
>> `dma_free_coherent()` with a NULL device pointer which is no longer
>> allowed.  If the `hw_dev` member of the `struct comedi_device` has been
>> set to a valid device, that can be used instead.  Unfortunately, all the
>> current users of the "comedi_isadma" module leave the `hw_dev` member
>> set to NULL.  In that case, use a static dummy fallback device structure
>> with the coherent DMA mask set to the ISA bus limit of 16MB.
>>
>> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
>> ---
>>   drivers/staging/comedi/drivers/comedi_isadma.c | 15 +++++++++++++--
>>   drivers/staging/comedi/drivers/comedi_isadma.h |  3 +++
>>   2 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/comedi/drivers/comedi_isadma.c b/drivers/staging/comedi/drivers/comedi_isadma.c
>> index b77dc8d5d3ff..8929952516a1 100644
>> --- a/drivers/staging/comedi/drivers/comedi_isadma.c
>> +++ b/drivers/staging/comedi/drivers/comedi_isadma.c
>> @@ -14,6 +14,16 @@
>>   
>>   #include "comedi_isadma.h"
>>   
>> +/*
>> + * Fallback device used when hardware device is NULL.
>> + * This can be removed after drivers have been converted to use isa_driver.
>> + */
>> +static struct device fallback_dev = {
>> +	.init_name = "comedi_isadma fallback device",
>> +	.coherent_dma_mask = DMA_BIT_MASK(24),
>> +	.dma_mask = &fallback_dev.coherent_dma_mask,
>> +};
> 
> Ick, no, static struct device are a very bad idea as this is a reference
> counted structure and making it static can cause odd problems.

This was based on the use of `struct device x86_dma_fallback_dev` in 
"arch/x86/kernel/pci-dma.c", and `static struct device isa_dma_dev` in 
"arch/arm/kernel/dma-isa.c", but perhaps it is not appropriate in 
non-arch code.

> Why not just create a "real" one?  Or better yet, use the real device
> for the comedi device as all of these drivers should have one now.

I suppose I could use the comedi class device pointed to by the 
`class_dev` member of `struct comedi_device` (although that could also 
be NULL because the comedi core does not currently treat 
`device_create()` failures as fatal).

> 
> thanks,
> 
> greg k-h

Thanks for the review,

Ian Abbott.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
