Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE96BC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C06208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfFZHXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:23:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:32970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfFZHXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:23:16 -0400
Received: from [10.44.0.22] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1008020665;
        Wed, 26 Jun 2019 07:23:13 +0000 (UTC)
Subject: Re: [PATCH 08/17] binfmt_flat: consolidate two version of
 flat_v2_reloc_t
To:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>
Cc:     Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
References: <20190613070903.17214-1-hch@lst.de>
 <20190613070903.17214-9-hch@lst.de>
 <20190625222941.GA1343@ZenIV.linux.org.uk>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <f8a61a8e-0469-a9d6-e0a1-01a4619d7363@linux-m68k.org>
Date:   Wed, 26 Jun 2019 17:23:11 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190625222941.GA1343@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/6/19 8:29 am, Al Viro wrote:
> On Thu, Jun 13, 2019 at 09:08:54AM +0200, Christoph Hellwig wrote:
>> Two branches of the ifdef maze actually have the same content, so merge
>> them.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   include/linux/flat.h | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/flat.h b/include/linux/flat.h
>> index 2b7cda6e9c1b..19c586b74b99 100644
>> --- a/include/linux/flat.h
>> +++ b/include/linux/flat.h
>> @@ -69,15 +69,13 @@ struct flat_hdr {
>>   typedef union {
>>   	unsigned long	value;
>>   	struct {
>> -# if defined(mc68000) && !defined(CONFIG_COLDFIRE)
>> +#if defined(__LITTLE_ENDIAN_BITFIELD) || \
>> +    (defined(mc68000) && !defined(CONFIG_COLDFIRE))
>>   		signed long offset : 30;
>>   		unsigned long type : 2;
>>   # elif defined(__BIG_ENDIAN_BITFIELD)
>>   		unsigned long type : 2;
>>   		signed long offset : 30;
>> -# elif defined(__LITTLE_ENDIAN_BITFIELD)
>> -		signed long offset : 30;
>> -		unsigned long type : 2;
>>   # else
>>   #   	error "Unknown bitfield order for flat files."
>>   # endif
>> -- 
>> 2.20.1
>>
> 
> FWIW, I wonder if keeping that type is worth bothering.
> Something like
> old_reloc(__be32 reloc)
> {
> 	u32 v = be32_to_cpu(reloc);
> 	int offset, type;
> 
> #if (defined(mc68000) && !defined(CONFIG_COLDFIRE))
> 	/* old m68k uses unusual format - type is in lower bits of octet 3 */
> 	type = v % 4;
> 	offset = (int)v / 4;
> #else
> 	/* everything else (including coldfire) has it in upper bits of octet 0 */
> 	type = v >> 30;
> 	offset = (int)(v << 2) >> 2; /* or (v & 0x1fffffff) - (v & 0x20000000) * 4 */
> #endif
> 	...
> 
> and to hell with bitfields, aliasing unions, etc.  Unless I'm misreading
> the whole thing, that is...  Greg?

I think you are right. This is much better.
The old mc6800 is the odd one out, the rest have it in network order,
and this makes that much clearer.

Regards
Greg


