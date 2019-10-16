Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BD7C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC23C217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bfs.de header.i=@bfs.de header.b="hZjHEAoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389734AbfJPHUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:20:35 -0400
Received: from mx01-fr.bfs.de ([193.174.231.67]:64402 "EHLO mx01-fr.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732565AbfJPHUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:20:14 -0400
Received: from mail-fr.bfs.de (mail-fr.bfs.de [10.177.18.200])
        by mx01-fr.bfs.de (Postfix) with ESMTPS id 5DD7A20384;
        Wed, 16 Oct 2019 09:20:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1571210407; h=from:from:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NC6uNoV+Bbox7Ddnhu9UcPLyFj4/7LcgIIqejJJhFBI=;
        b=hZjHEAoZCY0OUi7JeJII3wlzMjAVqp5cxIAM9Gj/3fYJuVGSZcBhGKry/Cs3zb/JgaaG+4
        9uhhgCX9QpZ//DKvgOieJIx9xcMMuAf9WePe7gASulVMY6KOTRGMEgNj3050gdh2l6lXs/
        25+BG/CKvklnMkk81PIPsSpm3QCeJ3H+HZyc5dDFE3K2ciXFKPP8FpB+EGSk7/IOrbp1bx
        TZc42v9/rZJvl24RrUQHhbj6eq6lPghh//6RMr/N5UrkGLA5Y4Fh2O+lz/CmPlDzmrP0F8
        X2Q8i5TeYzeWxAcsYN4O39k2XlCKzzuUT/p1WR11Al5oIkeWwzLFs0JzyZy9Yw==
Received: from [134.92.181.33] (unknown [134.92.181.33])
        by mail-fr.bfs.de (Postfix) with ESMTPS id 214EBBEEBD;
        Wed, 16 Oct 2019 09:20:06 +0200 (CEST)
Message-ID: <5DA6C4A6.6090207@bfs.de>
Date:   Wed, 16 Oct 2019 09:20:06 +0200
From:   walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
MIME-Version: 1.0
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC:     Colin King <colin.king@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PNP: fix unintended sign extension on left shifts
References: <20191014131608.31335-1-colin.king@canonical.com> <cda044bf-4aec-4423-007c-1d6cf6f0eecf@intel.com>
In-Reply-To: <cda044bf-4aec-4423-007c-1d6cf6f0eecf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: mx01-fr.bfs.de
X-Spamd-Result: default: False [-2.96 / 7.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.00)[wharms@bfs.de];
         BAYES_HAM(-2.86)[99.39%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         RCPT_COUNT_FIVE(0.00)[5];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM(-0.00)[-0.999,0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         RCVD_TLS_ALL(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 15.10.2019 18:29, schrieb Rafael J. Wysocki:
> On 10/14/2019 3:16 PM, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Shifting a u8 left will cause the value to be promoted to an integer. If
>> the top bit of the u8 is set then the following conversion to a 64 bit
>> resource_size_t will sign extend the value causing the upper 32 bits
>> to be set in the result.
>>
>> Fix this by casting the u8 value to a resource_size_t before the shift.
>> Original commit is pre-git history.
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Please resend this with a Cc to linux-acpi@vger.kernel.org for easier
> handling.
> 
> 
>> ---
>>   drivers/pnp/isapnp/core.c | 18 ++++++++++++------
>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
>> index 179b737280e1..c947b1673041 100644
>> --- a/drivers/pnp/isapnp/core.c
>> +++ b/drivers/pnp/isapnp/core.c
>> @@ -511,10 +511,14 @@ static void __init
>> isapnp_parse_mem32_resource(struct pnp_dev *dev,
>>       unsigned char flags;
>>         isapnp_peek(tmp, size);
>> -    min = (tmp[4] << 24) | (tmp[3] << 16) | (tmp[2] << 8) | tmp[1];
>> -    max = (tmp[8] << 24) | (tmp[7] << 16) | (tmp[6] << 8) | tmp[5];
>> -    align = (tmp[12] << 24) | (tmp[11] << 16) | (tmp[10] << 8) | tmp[9];
>> -    len = (tmp[16] << 24) | (tmp[15] << 16) | (tmp[14] << 8) | tmp[13];
>> +    min = ((resource_size_t)tmp[4] << 24) | (tmp[3] << 16) |
>> +              (tmp[2] << 8) | tmp[1];
>> +    max = ((resource_size_t)tmp[8] << 24) | (tmp[7] << 16) |
>> +              (tmp[6] << 8) | tmp[5];
>> +    align = ((resource_size_t)tmp[12] << 24) | (tmp[11] << 16) |
>> +              (tmp[10] << 8) | tmp[9];
>> +    len = ((resource_size_t)tmp[16] << 24) | (tmp[15] << 16) |
>> +              (tmp[14] << 8) | tmp[13];
>>       flags = tmp[0];
>>       pnp_register_mem_resource(dev, option_flags,
>>                     min, max, align, len, flags);
>> @@ -532,8 +536,10 @@ static void __init
>> isapnp_parse_fixed_mem32_resource(struct pnp_dev *dev,
>>       unsigned char flags;
>>         isapnp_peek(tmp, size);
>> -    base = (tmp[4] << 24) | (tmp[3] << 16) | (tmp[2] << 8) | tmp[1];
>> -    len = (tmp[8] << 24) | (tmp[7] << 16) | (tmp[6] << 8) | tmp[5];
>> +    base = ((resource_size_t)tmp[4] << 24) | (tmp[3] << 16) |
>> +           (tmp[2] << 8) | tmp[1];
>> +    len = ((resource_size_t)tmp[8] << 24) | (tmp[7] << 16) |
>> +              (tmp[6] << 8) | tmp[5];
>>       flags = tmp[0];
>>       pnp_register_mem_resource(dev, option_flags, base, base, 0, len,
>> flags);
>>   }
> 
> 

there was a hint to use get/put_unaligned_be*() maybe that is here also possible ?

re,
 wh

(ps: see: [PATCH] scsi: fix unintended sign extension on left shifts)
> 
