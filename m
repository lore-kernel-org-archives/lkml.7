Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC18AC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5932084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="fG6szY4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfEOIgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 04:36:38 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:53876 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725871AbfEOIgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 04:36:37 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id BEA8F2E14C9;
        Wed, 15 May 2019 11:36:33 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id FiL44lb1Xj-aXwiN7Xh;
        Wed, 15 May 2019 11:36:33 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1557909393; bh=+V/qixzhLPwbC9jsVHGnQ96lDXhr7tMgZ+aRfAzVw2k=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=fG6szY4AI+sLKK0Ror9iZxVfH8KcIEIjDFDqPEpGgy5aw9sgoY4eXQrnKLKdMCUVp
         lkCjNFVFoGT6SsD+bCEIXfiPtyQuzbVhAGbwy2/3uAj0l8Gx4i7QqeF9OZsIcCqirl
         E6oaDZeudZXfcsdJP8n7pE7CsY9JkJr2vQ+sYzCM=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:ed19:3833:7ce1:2324])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id elKpxPcxty-aW8q7Dnp;
        Wed, 15 May 2019 11:36:33 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] mm: fix protection of mm_struct fields in get_cmdline()
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, mkoutny@suse.com
References: <155790813764.2995.13706842444028749629.stgit@buzz>
 <20190515082222.GA21259@linux>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <e86ce7c9-5093-816d-3141-1cc0d3ba8ad9@yandex-team.ru>
Date:   Wed, 15 May 2019 11:36:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515082222.GA21259@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.05.2019 11:22, Oscar Salvador wrote:
> On Wed, May 15, 2019 at 11:15:37AM +0300, Konstantin Khlebnikov wrote:
>> Since commit 88aa7cc688d4 ("mm: introduce arg_lock to protect arg_start|
>> end and env_start|end in mm_struct") related mm fields are protected with
>> separate spinlock and mmap_sem held for read is not enough for protection.
>>
>> Fixes: 88aa7cc688d4 ("mm: introduce arg_lock to protect arg_start|end and env_start|end in mm_struct")
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> 
> This was already addressed by [1]?

Yep.

> 
> [1] https://patchwork.kernel.org/patch/10923003/
> 
>> ---
>>   mm/util.c |    4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/util.c b/mm/util.c
>> index e2e4f8c3fa12..540e7c157cf2 100644
>> --- a/mm/util.c
>> +++ b/mm/util.c
>> @@ -717,12 +717,12 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
>>   	if (!mm->arg_end)
>>   		goto out_mm;	/* Shh! No looking before we're done */
>>   
>> -	down_read(&mm->mmap_sem);
>> +	spin_lock(&mm->arg_lock);
>>   	arg_start = mm->arg_start;
>>   	arg_end = mm->arg_end;
>>   	env_start = mm->env_start;
>>   	env_end = mm->env_end;
>> -	up_read(&mm->mmap_sem);
>> +	spin_unlock(&mm->arg_lock);
>>   
>>   	len = arg_end - arg_start;
>>   
>>
> 
