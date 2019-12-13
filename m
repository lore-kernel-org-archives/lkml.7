Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3831C7D61E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1938C247F4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576269603;
	bh=IYWjg5OJjaLG0qOo558PuVbcFfLi8MVBEBBwonLH1JY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=14qRIFWoB6bnNHQ4t1VvogAotsxjQxZpwuEImUBwGhSX+GGxYra99h/w8rw+9fXl0
	 61thmNAO01E23Wwe65ohQkdCIBZ5MyQ38yuxG5PtaN2H1tZ2CBd3n65JHtURYN9v4F
	 1rbPLhd8VveKry7j2Dlz179UzBj/Kyjcy4AzVqSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfLMRwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 12:52:36 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33861 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbfLMRwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 12:52:36 -0500
Received: by mail-io1-f67.google.com with SMTP id z193so291048iof.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 09:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hy3AvTAR2QUBOc1XPBas2+Hf+Bw6YdTXU1iNc4w7BkY=;
        b=XX9FmTbdib0UTqkkdp5EPcMPbKSwp7YMKPKZ8M4jjb5E2/uqp2w4DR2Azme9nLvfMD
         6f/I5757ws+Vdjsec3tpX25jwT/xzBlWN95JyvKyNgjvp6NbW3ShJ2oc+70z7OFwAhas
         t2G5quHQxu2NqGGaXeLQq9PpN43xqT7jAN+ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hy3AvTAR2QUBOc1XPBas2+Hf+Bw6YdTXU1iNc4w7BkY=;
        b=EM5ZATGyR4gtDXsj2ROFW95DhytXc++nYCZxUZOjQSh54pIBKmFXdQS2Bsn3zxnGVa
         XJcRgavt05PUdglDu2L89XvkmWmDrKaelLo6wZsZhiki3ua4Qs9LevFSLaXZweVzMhir
         nlyYoXQkmXcyE5xLHus+Hm+YylG3T19YoxeMa07+y/B+Mmdwro4U9DqhmJLxqf1bTHrP
         nHOSGkzmddPQS/JVGokyoe08aDAGjxjDbP0xEpqoAyoEkZT7u0l7fmKQFKRJagDJ5r+j
         eTFUpxAMBUVPrGCyeWWVec6sSJZE2HKT387SSMGDNi5hMjjBAFTyxCX7THgU1P/O1hrM
         +BLA==
X-Gm-Message-State: APjAAAVRuIzf+ZFf9qGjgqoS06QunzdlNOsl9LWWfq6F3mVxXsA12+n2
        EXCIfxLrr8prWEngwGNtWWGSvA==
X-Google-Smtp-Source: APXvYqwd6YvyW5t24xr0JsnXfhzy5gwTV7WZSLxG9nm2KVycM18TRx5QXNuBq3SwkTDbFbQh//mx0w==
X-Received: by 2002:a6b:fb0e:: with SMTP id h14mr7607851iog.222.1576259554554;
        Fri, 13 Dec 2019 09:52:34 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b22sm445789iot.74.2019.12.13.09.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 09:52:33 -0800 (PST)
Subject: Re: [PATCH] selftests: livepatch: Fix it to do root uid check and
 skip
To:     Petr Mladek <pmladek@suse.com>
Cc:     jpoimboe@redhat.com, jikos@kernel.org, mbenes@suse.cz,
        joe.lawrence@redhat.com, shuah@kernel.org,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20191213015617.23110-1-skhan@linuxfoundation.org>
 <20191213083411.delrxditrpcdm7az@pathway.suse.cz>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <bda9819d-a054-232b-e973-41d41dfffc5a@linuxfoundation.org>
Date:   Fri, 13 Dec 2019 10:52:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191213083411.delrxditrpcdm7az@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/19 1:34 AM, Petr Mladek wrote:
> On Thu 2019-12-12 18:56:17, Shuah Khan wrote:
>> livepatch test configures the system and debug environment to run
>> tests. Some of these actions fail without root access and test
>> dumps several permission denied messages before it exits.
>>
>> Fix it to check root uid and exit with skip code instead.
> 
> It works when I run the tests directly, e.g.
> 
> $> cd tools/testing/selftests/livepatch
> $> ./test-livepatch.sh
> 
> But I still get an error from the selftest framework when running
> make run_tests:
> 
> $> make run_tests
> TAP version 13
> 1..5
> # selftests: livepatch: test-livepatch.sh
> /mnt/kernel/linux/tools/testing/selftests/kselftest/runner.sh: line 43: /dev/stdout: Permission denied
> not ok 1 selftests: livepatch: test-livepatch.sh # exit=1
> # selftests: livepatch: test-callbacks.sh
> /mnt/kernel/linux/tools/testing/selftests/kselftest/runner.sh: line 43: /dev/stdout: Permission denied
> not ok 2 selftests: livepatch: test-callbacks.sh # exit=1
> # selftests: livepatch: test-shadow-vars.sh
> /mnt/kernel/linux/tools/testing/selftests/kselftest/runner.sh: line 43: /dev/stdout: Permission denied
> not ok 3 selftests: livepatch: test-shadow-vars.sh # exit=1
> # selftests: livepatch: test-state.sh
> /mnt/kernel/linux/tools/testing/selftests/kselftest/runner.sh: line 43: /dev/stdout: Permission denied
> not ok 4 selftests: livepatch: test-state.sh # exit=1
> # selftests: livepatch: test-ftrace.sh
> /mnt/kernel/linux/tools/testing/selftests/kselftest/runner.sh: line 43: /dev/stdout: Permission denied
> not ok 5 selftests: livepatch: test-ftrace.sh # exit=1
> 
> The same problem is also in linux-next. Is this a know problem, please?
> 
> 

This isn't a known issue.

I am not seeing this problem on 5.5-rc1 and on linux-next with top
commit 32b8acf85223448973ca0bf0ee8149a01410f3a0 (HEAD -> master, tag: 
next-20191213

I am curious what could be diffent in your env. that is causing it.

>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   tools/testing/selftests/livepatch/functions.sh | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
>> index 31eb09e38729..014b587692f0 100644
>> --- a/tools/testing/selftests/livepatch/functions.sh
>> +++ b/tools/testing/selftests/livepatch/functions.sh
>> @@ -45,6 +57,7 @@ function pop_config() {
>>   }
>>   
>>   function set_dynamic_debug() {
>> +	is_root
>>           cat <<-EOF > /sys/kernel/debug/dynamic_debug/control
>>   		file kernel/livepatch/* +p
>>   		func klp_try_switch_task -p
> 
> This test is superfluous.

> 
> I guess that it was added because of test-state.sh. But it calls
> set_dynamic_debug() instead of config_setup() by mistake.
> Please, use the patch below instead of the above hunk.
> 
> Otherwise, this patch looks good. Thanks for fixing this.
> Without the hunk above, and with the patch below, feel free to use:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> 
> Here is the fix of test-state.sh:
> 
>  From 01ca8fd71fc964b892e54aea198537d007d33b4f Mon Sep 17 00:00:00 2001
> From: Petr Mladek <pmladek@suse.com>
> Date: Fri, 13 Dec 2019 09:26:45 +0100
> Subject: [PATCH] selftests/livepatch: Use setup_config() also in test-state.sh
> 
> The commit 35c9e74cff4c798d0 ("selftests/livepatch: Make dynamic debug
> setup and restore generic") introduced setup_config() to prepare
> the testing environment. All selftests should call it instead
> of set_dynamic_debug().
> 
> test-state.sh has been developed in parallel and was not converted
> by mistake.
> 

Thanks for suggesting the right fix. I will send v2 with your
suggested -by tag.

thanks,
-- Shuah
