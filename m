Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01168C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51C32073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576079153;
	bh=rpndR5fnjjfB3qof/sRHMHDN7MnUMyylW7DnDTj7krE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=IE7KfhJFz+ugbjKyMIRhhtTc+gAc6KJx5JcJa7ic8812Ji5xqk9rAq+1LX9Id4yF0
	 PhJYRpA5331AKXgFsNY47vEXdLAfBdwDQWMqRnBB4r+KdCinpX85IJBtuRfFN2Dgoh
	 LkMxLseZiT1fwwKIMUkUuDDiCcYcbkKWjNCrmItQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388700AbfLKPpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:45:52 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:45577 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733217AbfLKPps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:45:48 -0500
Received: by mail-il1-f195.google.com with SMTP id p8so19791512iln.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 07:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wanFKaczLMfU3OqUb1JjxMoDgH35GgWk6HMwR/6djLs=;
        b=Hboi8tbgl13q5vXUiMA/tDWO1s3G8Dq3gtiHOGlv4UapdWcbWC0azlmd5VpIMEZ7a0
         dX02VAzyiD35CB4N0/L4fDo8Tx1jojLrV1nn8pm77iKJlTBN/YVNVVftSJnOnC2ViMVT
         OKFJ6dmmynQpt5Nvf2dkTutchpxyv7w0cPr+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wanFKaczLMfU3OqUb1JjxMoDgH35GgWk6HMwR/6djLs=;
        b=FjF9blbBWmufCVv83dkKtGK/QZRT1w8KROsUcKP2UAmji/wP/wx5leoGHbxurOxBnG
         qLtY/jsVZBVih7Dx6cG7WxMFrd9JOIpxr6q6aeDzB4GCeb9eackDlMqnamoDZN5Xcv2Z
         TVgwa8tlygqyA4+VoanrBWVyHIY1CEEzYXVE845FH2z7T4qxT1u3EE+8ZM9JSmCAFygl
         F4SNDn7Y+Mw5fOMmUkQWUADYwO/sZFRvv8Pww3XAsEe0DTlOZCpS2e5ww7cbMw56JoqX
         AU2jwuGV1VsrUi8p/ZWplohtLKTxE85LYrlw9/HenIWnVv8IlPPg7zYsDq80HA1R0yZ9
         /l3g==
X-Gm-Message-State: APjAAAX549HxlUszSnVYAerRhNr4YRmcYPaYCM9PBoVLOGx+Gay3L3rC
        DS3RWLAuneJqdzm/VhCVABhlZA==
X-Google-Smtp-Source: APXvYqwWxzDOaxYOxAqGjbjnSVqOCnFFvbbl+B7Ipdp0CLZzaOiNlZCqCL98ytaVistSY/tSdVlAGQ==
X-Received: by 2002:a92:3591:: with SMTP id c17mr3771724ilf.264.1576079147826;
        Wed, 11 Dec 2019 07:45:47 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x25sm586120iob.76.2019.12.11.07.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 07:45:47 -0800 (PST)
Subject: Re: Linux 5.5=rc1 kselftest rseq test build failure
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <2d53b409-31e0-2245-e163-1ab26f52c841@linuxfoundation.org>
 <1871753014.2121.1576077544796.JavaMail.zimbra@efficios.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c6b703ef-8481-23bc-0b4c-dfb8d48da74f@linuxfoundation.org>
Date:   Wed, 11 Dec 2019 08:45:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1871753014.2121.1576077544796.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/19 8:19 AM, Mathieu Desnoyers wrote:
> ----- On Dec 10, 2019, at 7:27 PM, Shuah Khan skhan@linuxfoundation.org wrote:
> 
>> Hi Mathieu,
>>
>> I am seeing rseq test build failure on Linux 5.5-rc1.
>>
>> gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./
>> param_test.c -lpthread -lrseq -o ...tools/testing/selftests/rseq/param_test
>> param_test.c:18:21: error: static declaration of ‘gettid’ follows
>> non-static declaration
>>     18 | static inline pid_t gettid(void)
>>        |                     ^~~~~~
>> In file included from /usr/include/unistd.h:1170,
>>                   from param_test.c:11:
>> /usr/include/x86_64-linux-gnu/bits/unistd_ext.h:34:16: note: previous
>> declaration of ‘gettid’ was here
>>     34 | extern __pid_t gettid (void) __THROW;
>>        |                ^~~~~~
>> make: *** [Makefile:28: ...tools/testing/selftests/rseq/param_test] Error 1
>>
>>
>> The following obvious change fixes it. However, there could be reason
>> why this was defined here. If you think this is the right fix, I can
>> send the patch. I started seeing this with gcc version 9.2.1 20191008
> 
> This issue is caused by introduction of "gettid()" in glibc 2.30. I don't
> think we want to introduce a build dependency on glibc 2.30 for kernel
> selftests. Removing the gettid() symbol as you propose here will break
> build environments with glibc < 2.30.
> 
> We could eventually try to figure out whether the glibc headers implement
> gettid() at build time (not sure how), or we could simply rename our own
> "gettid()" to "rseq_gettid()", thus removing the namespace clash with
> glibc.
> 
> I can propose a patch renaming gettid() to rseq_gettid() is that approach
> is OK with you.
> 

Looks like you already have a patch to do this. I see it in my Inbox.
I could take that.

thanks,
-- Shuah
