Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E6EC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41A121872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555075626;
	bh=pZpdFE2n9SIrv6fRHGRkRbWq48qrQJG6z6V/4z4Mvyg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ERZUOOt3nsqERAWbJQ/WHI1lO45ErLSVtGTOPVt/PmMancfPxM4joR7bWiqBycCsL
	 xI9f+P+25qhYOtDCDSrA35UVcwbKoMxf/RBCHLg8EFiTB/WlZpzZXoEnNcrUeuxFUQ
	 KuwcibDsdxXbuK3/Z5OaGj/iJsC06qNkli5FH5ak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfDLN1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:27:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfDLN1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:27:04 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52BA9206BA;
        Fri, 12 Apr 2019 13:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555075623;
        bh=pZpdFE2n9SIrv6fRHGRkRbWq48qrQJG6z6V/4z4Mvyg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LrFvPgGDGc/EM49/+AwwlvwjOUBIJL/Bo6DA4Vni8alq00K19sd5kDyWO1yYYA++e
         FkrcZnU9wPe4oxYKiDpsiRRXglDz2ENiz++2UWeygJKPUfIwggaTvCcJFvALbEaZJ4
         6CXJRcqJvXvtIJDpn6FEzbVdHntS0L/Qn9jLlb64=
Subject: Re: [PATCH] selftests: livepatch use TEST_PROGS for test shell
 scripts
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com,
        joe.lawrence@redhat.com, live-patching@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190412011823.26884-1-shuah@kernel.org>
 <alpine.LSU.2.21.1904120901490.773@pobox.suse.cz>
From:   shuah <shuah@kernel.org>
Message-ID: <8967c9aa-7eb1-7e6d-a371-f29a2be24c84@kernel.org>
Date:   Fri, 12 Apr 2019 07:26:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.1904120901490.773@pobox.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/19 1:03 AM, Miroslav Benes wrote:
> On Thu, 11 Apr 2019, Shuah Khan wrote:
> 
>> TEST_PROGS variable is for test shell scripts and common clean target
>> in lib.mk doesn't touch them. TEST_GEN_PROGS are removed by it.
>>
>> Fix it to use TEST_PROGS for test shell scripts and TEST_PROGS_EXTENDED
>> for common functions.sh.
>>
>> Signed-off-by: Shuah Khan <shuah@kernel.org>
>> ---
>>   tools/testing/selftests/livepatch/Makefile | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
>> index af4aee79bebb..fd405402c3ff 100644
>> --- a/tools/testing/selftests/livepatch/Makefile
>> +++ b/tools/testing/selftests/livepatch/Makefile
>> @@ -1,6 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   
>> -TEST_GEN_PROGS := \
>> +TEST_PROGS_EXTENDED := functions.sh
>> +TEST_PROGS := \
>>   	test-livepatch.sh \
>>   	test-callbacks.sh \
>>   	test-shadow-vars.sh
> 
> Hi Shuah,
> 
> thanks for the patch. We have already something similar queued in our git
> tree. See
> https://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching.git/commit/?h=for-5.1/upstream-fixes&id=abfe3c4560684864f66641438fee3075de098e89
> 
> It is missing TEST_PROGS_EXTENDED though. Should we add it?
> 

Please do. What that does is when selftests are installed, functions.h
gets installed as well so the the test can run from installed location.

Did I miss reviewing the original? I maintain the framework and try to
catch these if patch gets sent to me.

thanks,
-- Shuah

