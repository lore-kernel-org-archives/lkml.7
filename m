Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7A0C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD4C208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7KjhDCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgAGOO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:14:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36793 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727658AbgAGOO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 09:14:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578406466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VtLAG7c6R8oB1H0MkTMBv/4vODwA64YlZ/IAZHtDS1c=;
        b=T7KjhDCmPqhJFSbWNfeOcfX8KOYq+M1T3x6e9e66ioJNy3xguq1PEFhwxstrz5blSaJMS7
        qo1UZnLJL8xWAtDL0XZz6KrrRuV0wAABvDNj4YyImMSOJ5193GbT5+5UYjJ6f+8BYUH9ns
        MlFv+m24oBZ7uXfXg7ty0i2HgfDuCww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-vQs1209_PJG_eHLgAvgb7g-1; Tue, 07 Jan 2020 09:14:23 -0500
X-MC-Unique: vQs1209_PJG_eHLgAvgb7g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2293F477;
        Tue,  7 Jan 2020 14:14:22 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 525A2271A5;
        Tue,  7 Jan 2020 14:14:21 +0000 (UTC)
Subject: Re: [PATCH] locking/qspinlock: Fix inaccessible URL of MCS lock paper
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>
References: <20191223022532.14864-1-longman@redhat.com>
 <20200107125824.GA2844@hirez.programming.kicks-ass.net>
 <20200107130939.GV2871@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <64bac471-11c6-41b7-c647-fa2c70b1bc32@redhat.com>
Date:   Tue, 7 Jan 2020 09:14:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200107130939.GV2871@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/20 8:09 AM, Peter Zijlstra wrote:
> On Tue, Jan 07, 2020 at 01:58:24PM +0100, Peter Zijlstra wrote:
>> On Sun, Dec 22, 2019 at 09:25:32PM -0500, Waiman Long wrote:
>>> It turns out that the URL of the MCS lock paper listed in the source
>>> code is no longer accessible. I did got question about where the paper
>>> was. This patch updates the URL to one that is still accessible.
>>>
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> ---
>>>  kernel/locking/qspinlock.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
>>> index 2473f10c6956..1d008d2333c0 100644
>>> --- a/kernel/locking/qspinlock.c
>>> +++ b/kernel/locking/qspinlock.c
>>> @@ -34,7 +34,7 @@
>>>   * MCS lock. The paper below provides a good description for this kind
>>>   * of lock.
>>>   *
>>> - * http://www.cise.ufl.edu/tr/DOC/REP-1992-71.pdf
>>> + * https://www.cs.rochester.edu/u/scott/papers/1991_TOCS_synch.pdf
>> Do we want to stick a copy of the paper in our bugzilla and link that
>> instead? ISTR we do something similar elsewhere, but I'm having trouble
>> finding it.
>>
>> Thomas, Konstantin?
> Boris provided an example from commit:
>
>   018ebca8bd70 ("x86/cpufeatures: Enable a new AVX512 CPU feature")
>
> That puts a copy of the relevant Intel document here:
>
>   https://bugzilla.kernel.org/show_bug.cgi?id=204215
>
OK, that sounds good. I will put a copy of the paper in the BZ and
linked it there.

Thanks,
Longman

