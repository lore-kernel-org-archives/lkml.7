Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDBAC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 22:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709DA206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 22:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LvlBxGic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfKTW62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 17:58:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43431 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfKTW62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 17:58:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id n1so1943834wra.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 14:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nVPM4TZQkI/JB4AeVmniWVGFTK/0gIVwlxo9x63gXmw=;
        b=LvlBxGic4YZL1bPZ2CU3XsKlhQOSgLhVBhASz+JrHXHGHnMeyMWQH8tTZizzp3SHLC
         xJJ7tb8rpFtn1KSJtLJrvTX82fTy5zcZ4ZkL0gxVIWLvONwpR2FN6jHbOC+NOTKAMaua
         histlZ93rRBP426qEDAYUxKc+lv/l7OF4LbPy8+9A5vu/Ik5N6XoARJr8NfpxatW7u40
         0aJcdiP4WaAOBz4w07tYNEz1nozzyinxw+EVowBoQu9sDlaNoqH0dHTVmQx9HS7MDlT5
         Jp9sFmCRbQXhiAx+Xtpwmz0TTvganq8D19NM5oMbouqva1y1Rp2YRpt5jS6PFALu+iWE
         eXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nVPM4TZQkI/JB4AeVmniWVGFTK/0gIVwlxo9x63gXmw=;
        b=lB3Yj7USEcrEUk0dicDHApBx1IvUy8iFFiRuAWUDaH6MC19Xcc/PADJatOkXdDALfP
         CWb+OHN+zhkjTRVQnrxjSCvFNTmK4RNcQuO08vRCillOjwSz06YqAA3dSmXzUA7SW0mx
         WsvnR/YTaYG/e9f/K037zszffxQd1S5rc9vDQjTkuKwdVZHIkio8HN6ca12uSH5OwC0f
         Qbss29vZiwWgioECiBYtiYMkRQ282OJ9g1ZMJJn6RcQHtoO4eshvPBMB1ymRDLf/P4M2
         D6ma3rK0D/NDoz281e6U8mD8GceuxQ/TVSDjftL/R9Yba4lUC+WBL24R5rwVdXK/M1DZ
         a8nQ==
X-Gm-Message-State: APjAAAVK6At08bH54PTKHbzg1SrreL3DT+Kqt7jWw6Y6W2X4nvsg1VFm
        AXhKiTC2455aI570ZuvmRyIOLwQh/2w=
X-Google-Smtp-Source: APXvYqy2CRkhLPohzNHZJRLEJJWmbfQ7GFCu1v0se8Sjq8tiPLJmmqEkm7PU6tuYBWU945bP0EPQUQ==
X-Received: by 2002:adf:f688:: with SMTP id v8mr6764083wrp.147.1574290705776;
        Wed, 20 Nov 2019 14:58:25 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id y67sm863812wmy.31.2019.11.20.14.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2019 14:58:25 -0800 (PST)
Subject: Re: [Y2038] [PATCH 01/23] y2038: remove CONFIG_64BIT_TIME
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>
Cc:     linux-aio@kvack.org, Stephen Boyd <sboyd@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
References: <20191108210236.1296047-1-arnd@arndb.de>
 <20191108210824.1534248-1-arnd@arndb.de>
 <638f6bcc2f7ecf96eda85973457a8d69b0a7640e.camel@codethink.co.uk>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <892d8856-4d0a-2ef0-b8e6-0c94f39ea54d@arista.com>
Date:   Wed, 20 Nov 2019 22:58:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <638f6bcc2f7ecf96eda85973457a8d69b0a7640e.camel@codethink.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/19 10:28 PM, Ben Hutchings wrote:
> On Fri, 2019-11-08 at 22:07 +0100, Arnd Bergmann wrote:
> [...]
>> --- a/kernel/time/time.c
>> +++ b/kernel/time/time.c
>> @@ -267,7 +267,7 @@ COMPAT_SYSCALL_DEFINE2(settimeofday, struct old_timeval32 __user *, tv,
>>  }
>>  #endif
>>  
>> -#if !defined(CONFIG_64BIT_TIME) || defined(CONFIG_64BIT)
>> +#ifdef CONFIG_64BIT
>>  SYSCALL_DEFINE1(adjtimex, struct __kernel_timex __user *, txc_p)
>>  {
>>  	struct __kernel_timex txc;		/* Local copy of parameter */
>> @@ -884,7 +884,7 @@ int get_timespec64(struct timespec64 *ts,
>>  	ts->tv_sec = kts.tv_sec;
>>  
>>  	/* Zero out the padding for 32 bit systems or in compat mode */
>> -	if (IS_ENABLED(CONFIG_64BIT_TIME) && in_compat_syscall())
>> +	if (in_compat_syscall())
>>  		kts.tv_nsec &= 0xFFFFFFFFUL;
>>  
>>  	ts->tv_nsec = kts.tv_nsec;
> [...]
> 
> It's not a problem with this patch, but I noticed that this condition
> doesn't match what the comment says.  It looks like it was broken by:
> 
> commit 98f76206b33504b934209d16196477dfa519a807
> Author: Dmitry Safonov <dima@arista.com>
> Date:   Fri Oct 12 14:42:53 2018 +0100
> 
>     compat: Cleanup in_compat_syscall() callers
> 

Ugh, you right. I've failed to read the condition and thought it's
related to CONFIG_COMPAT :(
I'll send a fix shortly, thanks for spotting this!

-- 
          Dmitry
