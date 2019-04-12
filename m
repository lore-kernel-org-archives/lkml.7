Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C45C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBC420869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfDLSwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:52:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfDLSv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 14:51:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 26346C04FF86;
        Fri, 12 Apr 2019 18:51:59 +0000 (UTC)
Received: from [10.18.17.208] (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EE955D6A9;
        Fri, 12 Apr 2019 18:51:58 +0000 (UTC)
Subject: Re: [PATCH] selftests: livepatch use TEST_PROGS for test shell
 scripts
To:     shuah <shuah@kernel.org>, Miroslav Benes <mbenes@suse.cz>
Cc:     jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190412011823.26884-1-shuah@kernel.org>
 <alpine.LSU.2.21.1904120901490.773@pobox.suse.cz>
 <8967c9aa-7eb1-7e6d-a371-f29a2be24c84@kernel.org>
 <alpine.LSU.2.21.1904121535100.773@pobox.suse.cz>
 <ad936df6-ab14-6bff-322a-c9d34d23c1f5@kernel.org>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <6f97800f-e78f-7d16-32b2-96ee5260321c@redhat.com>
Date:   Fri, 12 Apr 2019 14:51:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ad936df6-ab14-6bff-322a-c9d34d23c1f5@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 12 Apr 2019 18:51:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/19 1:05 PM, shuah wrote:
> On 4/12/19 7:37 AM, Miroslav Benes wrote:
>> On Fri, 12 Apr 2019, shuah wrote:
>>
>>> On 4/12/19 1:03 AM, Miroslav Benes wrote:
>>>> On Thu, 11 Apr 2019, Shuah Khan wrote:
>>>>
>>>>> TEST_PROGS variable is for test shell scripts and common clean target
>>>>> in lib.mk doesn't touch them. TEST_GEN_PROGS are removed by it.
>>>>>
>>>>> Fix it to use TEST_PROGS for test shell scripts and TEST_PROGS_EXTENDED
>>>>> for common functions.sh.
>>>>>
>>>>> Signed-off-by: Shuah Khan <shuah@kernel.org>
>>>>> ---
>>>>>     tools/testing/selftests/livepatch/Makefile | 3 ++-
>>>>>     1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/tools/testing/selftests/livepatch/Makefile
>>>>> b/tools/testing/selftests/livepatch/Makefile
>>>>> index af4aee79bebb..fd405402c3ff 100644
>>>>> --- a/tools/testing/selftests/livepatch/Makefile
>>>>> +++ b/tools/testing/selftests/livepatch/Makefile
>>>>> @@ -1,6 +1,7 @@
>>>>>     # SPDX-License-Identifier: GPL-2.0
>>>>>     
>>>>> -TEST_GEN_PROGS := \
>>>>> +TEST_PROGS_EXTENDED := functions.sh
>>>>> +TEST_PROGS := \
>>>>>      test-livepatch.sh \
>>>>>      test-callbacks.sh \
>>>>>      test-shadow-vars.sh
>>>>
>>>> Hi Shuah,
>>>>
>>>> thanks for the patch. We have already something similar queued in our git
>>>> tree. See
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git/commit/?h=for-5.1/upstream-fixes&id=abfe3c4560684864f66641438fee3075de098e89
>>>>
>>>> It is missing TEST_PROGS_EXTENDED though. Should we add it?
>>>>
>>>
>>> Please do. What that does is when selftests are installed, functions.h
>>> gets installed as well so the the test can run from installed location.
>>>
>>> Did I miss reviewing the original? I maintain the framework and try to
>>> catch these if patch gets sent to me.
>>
>> Unfortunately you did and it was our fault. You were not CCed, no one
>> noticed and we were a bit trigger happy. Sorry about that. It should not
>> have happened.
>>
>> Would this work for you?
> 
> Looks good to me.
> 

Hi Shuah,

Thanks for spotting this and apologies for missing your CC on my earlier 
patch post.  For future reference, do you prefer a direct CC, 
linux-kselftest, or both?

And for Miroslav, you can add my ack if needed.

-- Joe

>>
>> -->8--
>>
>> >From c158f5595286dba46f096cc7cc4bcef5ad8b6c16 Mon Sep 17 00:00:00 2001
>> From: Miroslav Benes <mbenes@suse.cz>
>> Date: Fri, 12 Apr 2019 15:31:42 +0200
>> Subject: [PATCH] selftests/livepatch: Add functions.sh to TEST_PROGS_EXTENDED
>>
>> Add functions.sh to TEST_PROGS_EXTENDED so that it is installed along
>> with the rest of the selftests and they can be run.
>>
>> Originally-by: Shuah Khan <shuah@kernel.org>
>> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
>> ---
>>    tools/testing/selftests/livepatch/Makefile | 1 +
>>    1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
>> index 114f43e2081a..fd405402c3ff 100644
>> --- a/tools/testing/selftests/livepatch/Makefile
>> +++ b/tools/testing/selftests/livepatch/Makefile
>> @@ -1,5 +1,6 @@
>>    # SPDX-License-Identifier: GPL-2.0
>>    
>> +TEST_PROGS_EXTENDED := functions.sh
>>    TEST_PROGS := \
>>    	test-livepatch.sh \
>>    	test-callbacks.sh \
>>
> 
> thanks,
> -- Shuah
>
