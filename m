Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6DBC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 09:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEDA20645
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 09:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fPYe1Epp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390428AbfEXJiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 05:38:04 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:5182 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390229AbfEXJiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 05:38:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce7bb7b0001>; Fri, 24 May 2019 02:38:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 24 May 2019 02:38:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 24 May 2019 02:38:03 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 May
 2019 09:38:01 +0000
Subject: Re: [PATCH v2] consolemap: Fix a memory leaking bug in
 drivers/tty/vt/consolemap.c
To:     Kees Cook <keescook@chromium.org>,
        Gen Zhang <blackgod016574@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     <jslaby@suse.com>, <linux-kernel@vger.kernel.org>
References: <20190521092935.GA2297@zhanggen-UX430UQ>
 <201905211342.DE554F0D@keescook> <20190522015055.GC4093@zhanggen-UX430UQ>
 <201905221353.AD8E585E6D@keescook> <20190523003452.GB14060@zhanggen-UX430UQ>
 <201905230952.B47ADA17A@keescook>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b99d0da6-a1d6-1c04-66ff-b2937d21d346@nvidia.com>
Date:   Fri, 24 May 2019 10:37:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201905230952.B47ADA17A@keescook>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558690683; bh=7V/P3p3LlFI68QuDb/W98fvhbSImEJ1UyHdaU+Ah9a4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=fPYe1Epp0xpH1bMUz7lJaRo0/nXyZo8DVN/0p8Qe3V3QtdStpNyP4WFxrUTKwgCrj
         k/xgj+PnOICRijm29b0U6qEgtobSmW72rldIDNe+w3pn7J8XoGzupCSGfL5gU+NjS/
         22SbVjh6LUkeK4gpXZz8sxqTATpP8YKX4n9qtFKSZ7mtvV/mTZ9TxnPG+EbD5/i6G2
         Qk2ZLdgZOmu/pYkVuTjbz5lYD1GdqE9z6qNXnn1E1qi3Q3CbaNNPSEc7f3imo5WOTa
         xcHwYGSXVwYXabfbam+hHSw6b8nsfsF3xYkaWmaxrTpbDmwlMD7w5ingQTolxcWjMg
         gYrOTi/GNsOUg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees,

On 23/05/2019 17:54, Kees Cook wrote:
> On Thu, May 23, 2019 at 08:34:52AM +0800, Gen Zhang wrote:
>> In function con_insert_unipair(), when allocation for p2 and p1[n]
>> fails, ENOMEM is returned, but previously allocated p1 is not freed, 
>> remains as leaking memory. Thus we should free p1 as well when this
>> allocation fails.
>>
>> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> 
> As far as I can see this is correct, as it's just restoring the prior
> state before the p1 allocation.

Are you sure this is correct? It looks like p1 is only allocated if
p->uni_pgdir[n = unicode >> 11] == NULL.

I only mention this because I have seen a few patches from Gen today
regarding memory leaks and devm_kzalloc() that are not correct.

> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
>> ---
>> diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
>> index b28aa0d..79fcc96 100644
>> --- a/drivers/tty/vt/consolemap.c
>> +++ b/drivers/tty/vt/consolemap.c
>> @@ -489,7 +489,11 @@ con_insert_unipair(struct uni_pagedir *p, u_short unicode, u_short fontpos)
>>  	p2 = p1[n = (unicode >> 6) & 0x1f];
>>  	if (!p2) {
>>  		p2 = p1[n] = kmalloc_array(64, sizeof(u16), GFP_KERNEL);
>> -		if (!p2) return -ENOMEM;
>> +		if (!p2) {
>> +			kfree(p1);
>> +			p->uni_pgdir[n] = NULL;
>> +			return -ENOMEM;
>> +		}
>>  		memset(p2, 0xff, 64*sizeof(u16)); /* No glyphs for the characters (yet) */
>>  	}
>>  
>> ---

Cheers
Jon

-- 
nvpublic
