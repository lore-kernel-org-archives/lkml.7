Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB29C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 13:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AFED206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 13:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUCECYPG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfLTNek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 08:34:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27526 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727369AbfLTNej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 08:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576848878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A4pL4OODD+dNtOJL84eETWJb22soRNmjqRpR6jv+Yl0=;
        b=IUCECYPGy5vO52jtRHsXFPPKXz3PQVnso0QtQWLDLALdGA8b4qmso8IaBxEnpmGQeElOXi
        nYFhEs/ftQT/o8MlikfuLl5o7+FC7P8G6FtwAhRTKQWSHXuqh8cs1BJDlr4+HS3KziplUm
        Jfq7CNwiJ/5yIkHhQ3lqZidK2EB5DhI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-6Pew3VxsOK2ji34xTTd9YQ-1; Fri, 20 Dec 2019 08:34:33 -0500
X-MC-Unique: 6Pew3VxsOK2ji34xTTd9YQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87B49800D48;
        Fri, 20 Dec 2019 13:34:32 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D55945C28F;
        Fri, 20 Dec 2019 13:34:31 +0000 (UTC)
Subject: Re: [PATCH] locking/lockdep: Fix potential buffer overrun problem in
 stack_trace[]
To:     Bart Van Assche <bvanassche@acm.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org
References: <20191219182812.20191-1-longman@redhat.com>
 <0cdfb26d-7faa-9da0-05b9-79bb21703283@acm.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <3ed5735a-2f42-682b-4319-6cb4633c240b@redhat.com>
Date:   Fri, 20 Dec 2019 08:34:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <0cdfb26d-7faa-9da0-05b9-79bb21703283@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/19 9:57 PM, Bart Van Assche wrote:
> On 2019-12-19 10:28, Waiman Long wrote:
>> If the lockdep code is really running out of the stack_trace entries,
>> there is a possiblity that buffer overrun can happen and corrupt the
>              ^^^^^^^^^^
>              possibility?
>> data immediately after stack_trace[].
>>
>> If there is less than LOCK_TRACE_SIZE_IN_LONGS entries left before
>> the call to save_trace(), the max_entries computation will leave it
>> with a very large positive number because of its unsigned nature. The
>> subsequent call to stack_trace_save() will then corrupt the data after
>> stack_trace[]. Fix that by changing max_entries to a signed integer
>> and check for negative value before calling stack_trace_save().
>>
>> Fixes: 12593b7467f9 ("locking/lockdep: Reduce space occupied by stack traces")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  kernel/locking/lockdep.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
>> index 32282e7112d3..56e260a7582f 100644
>> --- a/kernel/locking/lockdep.c
>> +++ b/kernel/locking/lockdep.c
>> @@ -482,7 +482,7 @@ static struct lock_trace *save_trace(void)
>>  	struct lock_trace *trace, *t2;
>>  	struct hlist_head *hash_head;
>>  	u32 hash;
>> -	unsigned int max_entries;
>> +	int max_entries;
>>  
>>  	BUILD_BUG_ON_NOT_POWER_OF_2(STACK_TRACE_HASH_SIZE);
>>  	BUILD_BUG_ON(LOCK_TRACE_SIZE_IN_LONGS >= MAX_STACK_TRACE_ENTRIES);
>> @@ -490,10 +490,8 @@ static struct lock_trace *save_trace(void)
>>  	trace = (struct lock_trace *)(stack_trace + nr_stack_trace_entries);
>>  	max_entries = MAX_STACK_TRACE_ENTRIES - nr_stack_trace_entries -
>>  		LOCK_TRACE_SIZE_IN_LONGS;
>> -	trace->nr_entries = stack_trace_save(trace->entries, max_entries, 3);
>>  
>> -	if (nr_stack_trace_entries >= MAX_STACK_TRACE_ENTRIES -
>> -	    LOCK_TRACE_SIZE_IN_LONGS - 1) {
>> +	if (max_entries < 0) {
>>  		if (!debug_locks_off_graph_unlock())
>>  			return NULL;
>>  
>> @@ -502,6 +500,7 @@ static struct lock_trace *save_trace(void)
>>  
>>  		return NULL;
>>  	}
>> +	trace->nr_entries = stack_trace_save(trace->entries, max_entries, 3);
>>  
>>  	hash = jhash(trace->entries, trace->nr_entries *
>>  		     sizeof(trace->entries[0]), 0);
> I'm not sure whether it is useful to call stack_trace_save() if
> max_entries == 0. How about changing the "max_entries < 0" test into
> "max_entries <= 0"?

I have actually added some instrumentation code to check the
distribution of stack trace lengths. I did get hits (about 40) on
zero-length stack traces after system bootup. But I am fine changing it
to <= 0.

Cheers,
Longman


