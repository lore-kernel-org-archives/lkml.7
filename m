Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE7EC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 18:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB3C2086D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 18:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551551527;
	bh=LWJFIa5iJ0G75fjn537mMbuXZnuU15cwL1uRXhrPJhY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=OF4PRbqW4Trz6tFm3yZHqAJNjgtBhG+z4f4BIoI1d6XwmeBaBdI+6AEXZzCFK6GJ3
	 5sKbzV6p+GHihHwNfIlhlos9BdHtVTFY5XxAZaNhcCBhtkEpPZvrf/dnl5mZQMZYac
	 TTVfkQgDUa7Qq9nj5D5FNv6H347RHsbC5MDaLF44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfCBScF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 13:32:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfCBScE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 13:32:04 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9800920838;
        Sat,  2 Mar 2019 18:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551551524;
        bh=LWJFIa5iJ0G75fjn537mMbuXZnuU15cwL1uRXhrPJhY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TFtTc2c8JslryZZnmC2O3iLQEgBRJwwON4sqvFNqpRc5dqfdhYU6XQ285C+UuoIL6
         Ov4HkSRaJsjQvhPS1PgZ/p8BvdUf4fv8c2SF8VJ/dtNhJdDVwulA3//XV9X9AGNUlV
         dIctCnoBvO4tlPIbRu4qWDUFcyysyD3ZfoHab8UE=
Subject: Re: [PATCH] selftests: x86: add version check in test_syscall_vdso
To:     Greg KH <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Steve Muckle <smuckle@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        shuah <shuah@kernel.org>
References: <20190301001806.154271-1-smuckle@google.com>
 <CALCETrUcH9R62gDdiG-EGTfSt2kQktv-0+bYmPcLn4PWNMrHSQ@mail.gmail.com>
 <20190302091047.GA14963@kroah.com>
From:   shuah <shuah@kernel.org>
Message-ID: <b9805f57-5fc8-454e-c1c8-c06dab86e863@kernel.org>
Date:   Sat, 2 Mar 2019 11:31:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190302091047.GA14963@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/19 2:10 AM, Greg KH wrote:
> On Fri, Mar 01, 2019 at 11:59:24AM -0800, Andy Lutomirski wrote:
>>> On Feb 28, 2019, at 4:18 PM, Steve Muckle <smuckle@google.com> wrote:
>>>
>>> Since 4.17 registers r8-r11 are not clobbered/zeroed by a 64-bit kernel
>>> handling a 32-bit syscall and this behavior is enforced by the
>>> test_syscall_vdso testcase. See commit 8bb2610bc496
>>> ("x86/entry/64/compat: Preserve r8-r11 in int $0x80").
>>>
>>> Permit the old behavior in the testcase for kernels prior to 4.17.
>>
>> NAK.  If you want an old buggy kernel to pass a test, please either
>> patch the kernel or run an old test.
> 
> Yeah, this isn't ok, especially as you might have 4.14 or 4.9 kernels
> that can pass the test if the needed patches were backported.  Checking
> kernel version numbers should never be used for anything.
> 

Also, this test failure can tell us if we should backport important
fixes. I have had requests to add kernel version checking in tests
before and the recommendation is "don't check kernel versions and
reply on feature type checks". In the case of fixes like this one,
it is better for the test to fail than make us feel warm and fuzzy
by making it pass.

thanks,
-- Shuah


