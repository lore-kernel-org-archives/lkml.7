Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D41BC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D8620848
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdmBOFP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgAGRgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:36:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28372 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728470AbgAGRgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578418602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VihdCZ5GwLlSJ5I8YuEgJBv1m9R/zhpqOr0AnZl/yZE=;
        b=YdmBOFP5CI7G2TIKS+HJjtSCf6qkbAVHrBPaq/ZKbFg9f5g3qsaRyhce/sWhyvz8zZ3pYq
        0iTL05Rd2JaQy/C4dDT06oc2gaTRxBeAVZ8TJt0U0CGWhcZ2ysTeE0TpitImAcf+MH5pk+
        CCIRuwiD1n/z7eTGn0KWZxsImYKodzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-rzrttXOJNdWyIMZZ1M4qZw-1; Tue, 07 Jan 2020 12:36:38 -0500
X-MC-Unique: rzrttXOJNdWyIMZZ1M4qZw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CEE3DB34;
        Tue,  7 Jan 2020 17:36:37 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EA4F6106B;
        Tue,  7 Jan 2020 17:36:36 +0000 (UTC)
Subject: Re: [PATCH v2] locking/qspinlock: Fix inaccessible URL of MCS lock
 paper
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <20200107151619.20802-1-longman@redhat.com>
 <20200107173443.GB32009@willie-the-truck>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <dd29ceda-cc8f-f418-9cce-1be4e33ae6f1@redhat.com>
Date:   Tue, 7 Jan 2020 12:36:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200107173443.GB32009@willie-the-truck>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/20 12:34 PM, Will Deacon wrote:
> On Tue, Jan 07, 2020 at 10:16:19AM -0500, Waiman Long wrote:
>> It turns out that the URL of the MCS lock paper listed in the source
>> code is no longer accessible. I did got question about where the paper
>> was. This patch updates the URL to BZ 206115 which contains a copy of
>> the paper from
>>
>>   https://www.cs.rochester.edu/u/scott/papers/1991_TOCS_synch.pdf
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  kernel/locking/qspinlock.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
>> index 2473f10c6956..ce75b2270b58 100644
>> --- a/kernel/locking/qspinlock.c
>> +++ b/kernel/locking/qspinlock.c
>> @@ -31,10 +31,9 @@
>>  /*
>>   * The basic principle of a queue-based spinlock can best be understood
>>   * by studying a classic queue-based spinlock implementation called the
>> - * MCS lock. The paper below provides a good description for this kind
>> - * of lock.
>> + * MCS lock. A copy of the original MCS lock papaer is available at
> s/papaer/paper/
>
> I think I reviewed the previous patch as you sent this version, but please
> could you reword as suggested here [1]?
>
> Cheers,
>
> Will
>
> [1] https://lore.kernel.org/lkml/20200107172343.GA32009@willie-the-truck/T/#m0f9eaf53e509b87d0f6378e35514c9b120d8edc2
>
Sure. I will send out v3 shortly.

Cheers,
Longman

