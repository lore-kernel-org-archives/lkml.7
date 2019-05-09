Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249F6C04A6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 02:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2832173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 02:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfEIC4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 22:56:23 -0400
Received: from mail1.windriver.com ([147.11.146.13]:62113 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfEIC4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 22:56:23 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x492u8Vk004135
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 8 May 2019 19:56:08 -0700 (PDT)
Received: from [128.224.162.183] (128.224.162.183) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 8 May
 2019 19:56:07 -0700
Subject: Re: [PATCH] kdb: Fix bound check compiler warning
To:     Daniel Thompson <daniel.thompson@linaro.org>
CC:     <jason.wessel@windriver.com>, <prarit@redhat.com>,
        <kgdb-bugreport@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1557280359-202637-1-git-send-email-wenlin.kang@windriver.com>
 <20190508081640.tvtnazr4tf5jijh7@holly.lan>
From:   Wenlin Kang <wenlin.kang@windriver.com>
Message-ID: <ac8af42c-e69d-6fd0-1d76-73a37e8a672c@windriver.com>
Date:   Thu, 9 May 2019 10:56:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190508081640.tvtnazr4tf5jijh7@holly.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [128.224.162.183]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/19 4:16 PM, Daniel Thompson wrote:
> On Wed, May 08, 2019 at 09:52:39AM +0800, Wenlin Kang wrote:
>> The strncpy() function may leave the destination string buffer
>> unterminated, better use strlcpy() instead.
>>
>> This fixes the following warning with gcc 8.2:
>>
>> kernel/debug/kdb/kdb_io.c: In function 'kdb_getstr':
>> kernel/debug/kdb/kdb_io.c:449:3: warning: 'strncpy' specified bound 256 equals destination size [-Wstringop-truncation]
>>     strncpy(kdb_prompt_str, prompt, CMD_BUFLEN);
>>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
>> ---
>>   kernel/debug/kdb/kdb_io.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
>> index 6a4b414..7fd4513 100644
>> --- a/kernel/debug/kdb/kdb_io.c
>> +++ b/kernel/debug/kdb/kdb_io.c
>> @@ -446,7 +446,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
>>   char *kdb_getstr(char *buffer, size_t bufsize, const char *prompt)
>>   {
>>   	if (prompt && kdb_prompt_str != prompt)
>> -		strncpy(kdb_prompt_str, prompt, CMD_BUFLEN);
>> +		strlcpy(kdb_prompt_str, prompt, CMD_BUFLEN);
> Shouldn't that be strscpy?


Hi Daniel

I thought about strscpy, but I think strlcpy is better, because it only 
copy the real number of characters if src string less than that size.


>
>
> Daniel.
>
>>   	kdb_printf(kdb_prompt_str);
>>   	kdb_nextline = 1;	/* Prompt and input resets line number */
>>   	return kdb_read(buffer, bufsize);
>> -- 
>> 1.9.1
>>

-- 
Thanks,
Wenlin Kang

