Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28BEC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7678A222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="IoXl9BAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388491AbfJDNcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:32:46 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:38830 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387917AbfJDNco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:32:44 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 115812E1603;
        Fri,  4 Oct 2019 16:32:41 +0300 (MSK)
Received: from iva8-b53eb3f76dc7.qloud-c.yandex.net (iva8-b53eb3f76dc7.qloud-c.yandex.net [2a02:6b8:c0c:2ca1:0:640:b53e:b3f7])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id lA1Eng3ZMU-WeVmLqu0;
        Fri, 04 Oct 2019 16:32:40 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1570195960; bh=Z5Lj5w0e5VEPUp7eDxDq0gCc1MTHSS9n5NKJDlcPteA=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=IoXl9BAYPNFG0mV20SXf2A9jyMQdQ0eS5N6qXx3lgSXKU0Z33MLBUGIRhYMZaee38
         FcsOqpTqUQu7DnT5LsYH51WUh68s3NRP9GdEKfFNp3N73XZGXQReFztYYC65rhFfMZ
         jNdv32kcPzBRgYrTlvtzt49AFbQdASXzqIQ9tEi4=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d4d:a9cb:ef29:4bb1])
        by iva8-b53eb3f76dc7.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id 0W78oI6gZV-WdHqNx9Z;
        Fri, 04 Oct 2019 16:32:40 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH v2] mm/swap: piggyback lru_add_drain_all() calls
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
References: <157019456205.3142.3369423180908482020.stgit@buzz>
 <20191004131230.GL9578@dhcp22.suse.cz>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <c1617cff-847f-4cbf-d314-0382a3e9233d@yandex-team.ru>
Date:   Fri, 4 Oct 2019 16:32:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004131230.GL9578@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2019 16.12, Michal Hocko wrote:
> On Fri 04-10-19 16:09:22, Konstantin Khlebnikov wrote:
>> This is very slow operation. There is no reason to do it again if somebody
>> else already drained all per-cpu vectors while we waited for lock.
>>
>> Piggyback on drain started and finished while we waited for lock:
>> all pages pended at the time of our enter were drained from vectors.
>>
>> Callers like POSIX_FADV_DONTNEED retry their operations once after
>> draining per-cpu vectors when pages have unexpected references.
> 
> This describes why we need to wait for preexisted pages on the pvecs but
> the changelog doesn't say anything about improvements this leads to.
> In other words what kind of workloads benefit from it?

Right now POSIX_FADV_DONTNEED is top user because it have to freeze page
reference when removes it from cache. invalidate_bdev calls it for same reason.
Both are triggered from userspace, so it's easy to generate storm.

mlock/mlockall no longer calls lru_add_drain_all - I've seen here
serious slowdown on older kernel.

There are some less obvious paths in memory migration/CMA/offlining
which shouldn't be called frequently.

> 
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> ---
>>   mm/swap.c |   16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/swap.c b/mm/swap.c
>> index 38c3fa4308e2..5ba948a9d82a 100644
>> --- a/mm/swap.c
>> +++ b/mm/swap.c
>> @@ -708,9 +708,10 @@ static void lru_add_drain_per_cpu(struct work_struct *dummy)
>>    */
>>   void lru_add_drain_all(void)
>>   {
>> +	static seqcount_t seqcount = SEQCNT_ZERO(seqcount);
>>   	static DEFINE_MUTEX(lock);
>>   	static struct cpumask has_work;
>> -	int cpu;
>> +	int cpu, seq;
>>   
>>   	/*
>>   	 * Make sure nobody triggers this path before mm_percpu_wq is fully
>> @@ -719,7 +720,19 @@ void lru_add_drain_all(void)
>>   	if (WARN_ON(!mm_percpu_wq))
>>   		return;
>>   
>> +	seq = raw_read_seqcount_latch(&seqcount);
>> +
>>   	mutex_lock(&lock);
>> +
>> +	/*
>> +	 * Piggyback on drain started and finished while we waited for lock:
>> +	 * all pages pended at the time of our enter were drained from vectors.
>> +	 */
>> +	if (__read_seqcount_retry(&seqcount, seq))
>> +		goto done;
>> +
>> +	raw_write_seqcount_latch(&seqcount);
>> +
>>   	cpumask_clear(&has_work);
>>   
>>   	for_each_online_cpu(cpu) {
>> @@ -740,6 +753,7 @@ void lru_add_drain_all(void)
>>   	for_each_cpu(cpu, &has_work)
>>   		flush_work(&per_cpu(lru_add_drain_work, cpu));
>>   
>> +done:
>>   	mutex_unlock(&lock);
>>   }
>>   #else
>>
> 
