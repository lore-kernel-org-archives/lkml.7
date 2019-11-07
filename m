Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E6AC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F17E218AE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="zSzi0lmk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730903AbfKGR7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:59:33 -0500
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:38758 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727830AbfKGR7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:59:33 -0500
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id CB77A2E15E7;
        Thu,  7 Nov 2019 20:59:29 +0300 (MSK)
Received: from myt5-6212ef07a9ec.qloud-c.yandex.net (myt5-6212ef07a9ec.qloud-c.yandex.net [2a02:6b8:c12:3b2d:0:640:6212:ef07])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id iFvPSonkQi-xTL8QSb6;
        Thu, 07 Nov 2019 20:59:29 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1573149569; bh=UsTIMeG7xsDGua2wB4RGJCRGGAhXBbC4sAwyVZakSFM=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=zSzi0lmkJ4ng4EZjtCZJNHjGKtFkodF7uVs67LtyDETpYeiwdJS+vlaZsf1LIw/n8
         /l6aKMa2Yo+BfyCpcX5Wv6yJaGs6q9AkYKlsORM2pIAOKIExvnxB9lrncf9B8rt7FF
         BqXPRm0haiSnJq0THZ8NFsx3slDZBzwUdruDEXxo=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8554:53c0:3d75:2e8a])
        by myt5-6212ef07a9ec.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id kC45TC5435-xTWKke1e;
        Thu, 07 Nov 2019 20:59:29 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] fs/quota: use unsigned int helper for sysctl fs.quota.*
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
References: <157312129151.3890.6076128127053624123.stgit@buzz>
 <20191107115041.GC11400@quack2.suse.cz>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <2bc0f9c6-76a7-f683-d6a2-c62e93698f83@yandex-team.ru>
Date:   Thu, 7 Nov 2019 20:59:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191107115041.GC11400@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2019 14.50, Jan Kara wrote:
> On Thu 07-11-19 13:08:11, Konstantin Khlebnikov wrote:
>> Report counters as unsigned, otherwise they turn negative at overflow:
>>
>> # sysctl fs.quota
>> fs.quota.allocated_dquots = 22327
>> fs.quota.cache_hits = -489852115
>> fs.quota.drops = -487288718
>> fs.quota.free_dquots = 22083
>> fs.quota.lookups = -486883485
>> fs.quota.reads = 22327
>> fs.quota.syncs = 335064
>> fs.quota.writes = 3088689
>>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> 
> Fair enough but then 'stats' array in dqstats should be unsigned as well
> for consistency and why not actually make everything long when we are at
> it? percpu_counter we use is s64 anyway...

Ok. I'll patch this too.

> 
> 								Honza
> 
>> ---
>>   fs/quota/dquot.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
>> index 6e826b454082..606e1e39674b 100644
>> --- a/fs/quota/dquot.c
>> +++ b/fs/quota/dquot.c
>> @@ -2865,7 +2865,7 @@ static int do_proc_dqstats(struct ctl_table *table, int write,
>>   	/* Update global table */
>>   	dqstats.stat[type] =
>>   			percpu_counter_sum_positive(&dqstats.counter[type]);
>> -	return proc_dointvec(table, write, buffer, lenp, ppos);
>> +	return proc_douintvec(table, write, buffer, lenp, ppos);
>>   }
>>   
>>   static struct ctl_table fs_dqstats_table[] = {
>>
