Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FF5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55CF8218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Eb5dQL4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbfC2SIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:08:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729746AbfC2SIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 14:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=H/PoRPC1lktHX4182NbmlBZcudeaZE+Xbszx/F65dUQ=; b=Eb5dQL4JNedsk9Xw6+iVOelqg
        eAnX8G1j+knYyrWzdWqSBa0WC7UkL62NxgXrXRCxezJ/XVF3WBGkj2Jm3aBy1/siPPi4ODJXvNHtn
        H0XArkbXYD3erwTNkhmzqMx2Huh+w+Vs94UjwrkEUjLqSH/+ievYFVSx6sqQll8gADaj+u4tM3LjY
        +FWXe8Z8iz1iJC6a/lBciM8KlvebP1i2LuXY0wisohrUVNkVUn3TjT3yFKNzduTuwSUpuNxUae7QM
        wH7evI68tOlFuqDsktUVB1Ewf/1en7L33J+jkvA39/cBhBhy/zsShGUqDQVFxKG9jN5ogl2zMF/NP
        QYTWg9yFg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9vvA-0001Nd-FU; Fri, 29 Mar 2019 18:08:04 +0000
Subject: Re: [PATCH] gcov: include linux/module.h for within_module
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>, oberpar@linux.ibm.com,
        akpm@linux-foundation.org
Cc:     Greg Hackmann <ghackmann@android.com>, Tri Vo <trong@android.com>,
        linux-mm@kvack.org, kbuild-all@01.org,
        kbuild test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
References: <201903291603.7podsjD7%lkp@intel.com>
 <20190329174541.79972-1-ndesaulniers@google.com>
 <9f1ad3e1-fad7-2fb4-31c0-d31832468143@infradead.org>
Message-ID: <16a9f1b8-f937-7350-968e-36c5b3f838a5@infradead.org>
Date:   Fri, 29 Mar 2019 11:08:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <9f1ad3e1-fad7-2fb4-31c0-d31832468143@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/19 11:01 AM, Randy Dunlap wrote:
> On 3/29/19 10:45 AM, Nick Desaulniers wrote:
>> Fixes commit 8c3d220cb6b5 ("gcov: clang support")
>>
>> Cc: Greg Hackmann <ghackmann@android.com>
>> Cc: Tri Vo <trong@android.com>
>> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
>> Cc: linux-mm@kvack.org
>> Cc: kbuild-all@01.org
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Link: https://marc.info/?l=linux-mm&m=155384681109231&w=2
>> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> see https://lore.kernel.org/linux-mm/20190328225107.ULwYw%25akpm@linux-foundation.org/T/#mee26c00158574326e807480fc39dfcbd7bebd5fd
> 
> Did you test this?  kernel/gcov/gcc_4_7.c includes local "gcov.h",
> which includes <linux/module.h>, so why didn't that work or why
> does this patch work?

No, this patch does not fix the build error for me.

> thanks.
> 
>> ---
>>  kernel/gcov/gcc_3_4.c | 1 +
>>  kernel/gcov/gcc_4_7.c | 1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/kernel/gcov/gcc_3_4.c b/kernel/gcov/gcc_3_4.c
>> index 801ee4b0b969..0eda59ef57df 100644
>> --- a/kernel/gcov/gcc_3_4.c
>> +++ b/kernel/gcov/gcc_3_4.c
>> @@ -16,6 +16,7 @@
>>   */
>>  
>>  #include <linux/errno.h>
>> +#include <linux/module.h>
>>  #include <linux/slab.h>
>>  #include <linux/string.h>
>>  #include <linux/seq_file.h>
>> diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
>> index ec37563674d6..677851284fe2 100644
>> --- a/kernel/gcov/gcc_4_7.c
>> +++ b/kernel/gcov/gcc_4_7.c
>> @@ -13,6 +13,7 @@
>>   */
>>  
>>  #include <linux/errno.h>
>> +#include <linux/module.h>
>>  #include <linux/slab.h>
>>  #include <linux/string.h>
>>  #include <linux/seq_file.h>
>>
> 
> 


-- 
~Randy
