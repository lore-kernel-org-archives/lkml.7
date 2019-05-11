Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF534C04A6B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 02:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6768F217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 02:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557543185;
	bh=kd//zpjVzQFal2fs0dl5xsA/Q+kM3MAXQkPAVzMaPik=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=A8AdkTgOOdas/H/te1IQ1pGUhKBtL18NffpvDZmk7XI+04IZ02fCzBvYjv25c+bAJ
	 Np0bB/MKntpsjxsOzpU6/GmlFdiikUPeFkI9PhxeplaoiD/bhUf7fLWcDVfikJpHi9
	 N7hXyQufNgCP1R5Dx3SGvMAzi4BTF//+HXwDrHxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfEKCxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 22:53:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43587 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbfEKCxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 22:53:02 -0400
Received: by mail-io1-f65.google.com with SMTP id v7so6007234iob.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 19:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QNZoChIf2lg8703PWLK0D4vhE3dgoghA+HjSLMHNtYc=;
        b=aM7BCxyUBYM95MqIGVpU2RewLKHldN5lkU0Fb48xw4JGT/s2zA6M2yZ35jAU1dyXyj
         qONocOLi+p5NvUTr9p4bz2tnECsRMsHMNTEcdidRor4E+dEG7Dff/NuK1NXd+AGevM3h
         7ybeoqD6/YVwWFmNwlHDSwdRxpBbtfYKU0Cmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QNZoChIf2lg8703PWLK0D4vhE3dgoghA+HjSLMHNtYc=;
        b=Es44MFs0IFdqqIeBqMDerAXw5R5owlQshkNNwYoCeKzj1csBsbDV9d+Aayu73TofCc
         tYZCwuOSv7KSvUWx9ld6RyCZ4IamtOf+YzJpgDIrewrUWYLeP8i8G8ATGraDW+wkQXMv
         0Y9SWjfK0YLowP4aEvXlw8dRsPGyc286QklBWLBmMEDSK+BumzvnWMLucimPRTvE/Uds
         IuVEaX4CoEVE1ki/ymDacdkxI4AFRLaCmvVFVmwWljkiwzspJQr/WuJMp41tXXV1v6XW
         kV5tVmB3tYaCgowWmB2Ooinslge/sFA9ApmaFh/cJbyLlSwLtPhsvEGpOvs9xX0F7v4M
         pZSw==
X-Gm-Message-State: APjAAAXWieN+g6SMR0QJuFTHgs/woN7qnOGcpMn9pBN5ovwa0km3ocP/
        Qehr2KGW9VZQUw54KmWnYK5dWg==
X-Google-Smtp-Source: APXvYqxe4QgzEQeuJSwnU5rTv1AAsOgXkua44aeiqHQt+sJIUfj6qnNliRkc7znEWLRMNiwf94S/Og==
X-Received: by 2002:a05:6602:1d6:: with SMTP id w22mr154210iot.215.1557543181638;
        Fri, 10 May 2019 19:53:01 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c3sm2206061iob.80.2019.05.10.19.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 19:53:00 -0700 (PDT)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.2-rc1
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, skhan@linuxfoundation.org
References: <9b434125-44b6-0e83-4f70-d1fd28752407@linuxfoundation.org>
 <20190509222043.b4zn32kuohduzzzr@ast-mbp>
 <dd983d42-d148-372d-3e57-b97c313d58b9@linuxfoundation.org>
 <28072ca5-f7c8-f16d-6881-aec3e8b61ae8@linuxfoundation.org>
 <20190510021750.bxjda2wbuj3hdml7@ast-mbp>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6da7fa0f-5da8-9274-3781-edd31a4c3043@linuxfoundation.org>
Date:   Fri, 10 May 2019 20:53:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510021750.bxjda2wbuj3hdml7@ast-mbp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/19 8:17 PM, Alexei Starovoitov wrote:
> On Thu, May 09, 2019 at 07:42:09PM -0600, Shuah Khan wrote:
>> On 5/9/19 4:40 PM, Shuah Khan wrote:
>>> On 5/9/19 4:20 PM, Alexei Starovoitov wrote:
>>>> On Mon, May 06, 2019 at 10:56:56AM -0600, Shuah Khan wrote:
>>>>> Hi Linus,
>>>>>
>>>>> Please pull the following Kselftest update for Linux 5.2-rc1
>>>>>
>>>>> This Kselftest update for Linux 5.2-rc1 consists of
>>>>>
>>>>> - fixes to seccomp test, and kselftest framework
>>>>> - cleanups to remove duplicate header defines
>>>>> - fixes to efivarfs "make clean" target
>>>>> - cgroup cleanup path
>>>>> - Moving the IMA kexec_load selftest to selftests/kexec work from
>>>>>     Mimi Johar and Petr Vorel
>>>>> - A framework to kselftest for writing kernel test modules addition
>>>>>     from Tobin C. Harding
>>>>>
>>>>> diff is attached.
>>>>>
>>>>> thanks,
>>>>> -- Shuah
>>>>>
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> The following changes since commit
>>>>> 15ade5d2e7775667cf191cf2f94327a4889f8b9d:
>>>>>
>>>>>     Linux 5.1-rc4 (2019-04-07 14:09:59 -1000)
>>>>>
>>>>> are available in the Git repository at:
>>>>>
>>>>>     git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
>>>>> tags/linux-kselftest-5.2-rc1
>>>>>
>>>>> for you to fetch changes up to d917fb876f6eaeeea8a2b620d2a266ce26372f4d:
>>>>>
>>>>>     selftests: build and run gpio when output directory is the src dir
>>>>> (2019-04-22 17:02:26 -0600)
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> linux-kselftest-5.2-rc1
>>>>>
>>>>> This Kselftest update for Linux 5.2-rc1 consists of
>>>>>
>>>>> - fixes to seccomp test, and kselftest framework
>>>>> - cleanups to remove duplicate header defines
>>>>> - fixes to efivarfs "make clean" target
>>>>> - cgroup cleanup path
>>>>> - Moving the IMA kexec_load selftest to selftests/kexec work from
>>>>>     Mimi Johar and Petr Vorel
>>>>> - A framework to kselftest for writing kernel test modules addition
>>>>>     from Tobin C. Harding
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> Kees Cook (3):
>>>>>         selftests/seccomp: Handle namespace failures gracefully
>>>>>         selftests/harness: Add 30 second timeout per test
>>>>>         selftests/ipc: Fix msgque compiler warnings
>>>>>
>>>>> Mathieu Desnoyers (1):
>>>>>         rseq/selftests: Adapt number of threads to the number of
>>>>> detected cpus
>>>>>
>>>>> Mimi Zohar (9):
>>>>>         selftests/kexec: move the IMA kexec_load selftest to
>>>>> selftests/kexec
>>>>>         selftests/kexec: cleanup the kexec selftest
>>>>>         selftests/kexec: define a set of common functions
>>>>>         selftests/kexec: define common logging functions
>>>>>         selftests/kexec: define "require_root_privileges"
>>>>>         selftests/kexec: kexec_file_load syscall test
>>>>>         selftests/kexec: check kexec_load and kexec_file_load are enabled
>>>>>         selftests/kexec: make kexec_load test independent of IMA
>>>>> being enabled
>>>>>         selftests/kexec: update get_secureboot_mode
>>>>>
>>>>> Petr Vorel (1):
>>>>>         selftests/kexec: Add missing '=y' to config options
>>>>>
>>>>> Po-Hsu Lin (1):
>>>>>         selftests/efivarfs: clean up test files from test_create*()
>>>>>
>>>>> Roman Gushchin (1):
>>>>>         selftests: cgroup: fix cleanup path in
>>>>> test_memcg_subtree_control()
>>>>>
>>>>> Sabyasachi Gupta (4):
>>>>>         selftest/x86/mpx-dig.c: Remove duplicate header
>>>>>         selftest/timers: Remove duplicate header
>>>>>         selftest/rseq: Remove duplicate header
>>>>>         selftest/gpio: Remove duplicate header
>>>>>
>>>>> Shuah Khan (2):
>>>>>         selftests: fix headers_install circular dependency
>>>>
>>>> Shuah,
>>>>
>>>> the commit 8ce72dc32578 ("selftests: fix headers_install circular
>>>> dependency")
>>>> broke our build/test workflow, since it added:
>>>>     ifneq ($(KBUILD_OUTPUT),)
>>>>             OUTPUT := $(KBUILD_OUTPUT)
>>>>     else
>>>>
>>>> which means that all of selftests/bpf artifacts are now going into
>>>> main build directory cluttering it with all sorts of .o, generated files
>>>> and executables.
>>>> The end result is humans and scripts can no longer find tests.
>>
>> bpf build fails with the above commit. However, even without it, I am
>> seeing bpf objects going to tools/testing/selftests/bpf
>>
>> I reverted the commit and ran your use-case:
>>
>> export KBUILD_OUTPUT=/tmp/kselftest_bpf
>> cd tools/testing/selftests/bpf/
>> make
>> ./test_verifier
>>
>> I see bpf objects in tools/testing/selftests/bpf/ and I can run the
>> test.
>>
>> What am I missing? The only way ./test_verifier would work is if
>> test_verifier is in tools/testing/selftests/bpf/
> 
> That's the point. All artifacts should be in tools/testing/selftests/bpf/
> if 'make' was done there regardless of KBUILD_OUTPUT.
> 

Alexei,

Thanks for reporting the problem. Fix is on the way. Please test and let
me know if it works for you. I verified bpf build/test workflow with
and without KBUILD_OUTPUT set.

thanks,
-- Shuah
