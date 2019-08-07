Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7F8C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE07A2229C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCTR9djq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388840AbfHGP5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 11:57:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42622 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387985AbfHGP5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 11:57:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id x1so42005127wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 08:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gfZpuj45Ev+OU5FnhTdkXFsKqS1/cYJCjuIEw4WcKDA=;
        b=vCTR9djqvjSIKY69pRkJ45/cgQX6ysZIL6c3dcecj0jumYyiVFpvH1eGpW52fGto1E
         JdKQIFLVZ8BKwg9Ony1km0mqhY63BZ7N9ElCag2avsTol+suwhd5Y+e00CVfAxVKA9fx
         5ERoB5nJEivq7LtFOPBOjvmOy75b7qC5lAEPCRxDF7bVzzluH6yj9no2/Os+d9qsCf/3
         uVWpbvulF57QmwxvOCKkVuHjKavZHaHDdp3IlrSy0WWSxi0aIJR8xvBUvPd0LSvBb0ni
         T/vWepdZNKyhjNIkXIESH/wLgEbkKeUd1CViVM/cRXeZqsoGjr/3WG4FFzgsP8ozNjR+
         e0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gfZpuj45Ev+OU5FnhTdkXFsKqS1/cYJCjuIEw4WcKDA=;
        b=JvwnYzfYc5vQeF0EFTH8OPX5FuHiW8ExpfpLeucUfhKrKmnJDdJSpGw3WiHYnU9p1c
         XRwiEGqUmGIyQoANX9fIVE5/QcCM8778itv5C6uJsDuBWJrHcDOp3QmPEhvxsx+EnsPj
         xglVMkWvNuMvhI9YxDRGljhulLs8dEEgftnE6XArWi1neT4iMu6M5fid5Sruka1aA972
         ly4SCV5rXPXniK+sL90UdTEKsEdrnUG5mqajexSrgH5raCIuaHmimk5/IOi+vHuyD+rA
         NEXav+IfhKPz1Ry5EhsMTomZdevMU3tFQtMK6zh/SdFAEbIzpXfAZcy1hm1ARzX77hLE
         589A==
X-Gm-Message-State: APjAAAXeH0tSZ1lcrVpS+sfySshVxseZugwAZEhcZ9tSOvGKXis+0y+k
        leUYrmJMN7u5Yz8ykFaw31U=
X-Google-Smtp-Source: APXvYqwMZ0tQEhYRkNBrGjbUAW0Ati9aR766NXfYuR6lEULv4n5kC6QyXEvVhlKkQ/GcTcIdpQ9C3A==
X-Received: by 2002:adf:fc0c:: with SMTP id i12mr10837869wrr.86.1565193430378;
        Wed, 07 Aug 2019 08:57:10 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m6sm2778610wrq.95.2019.08.07.08.57.09
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 08:57:09 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] fork: extend clone3() to support CLONE_SET_TID
To:     Oleg Nesterov <oleg@redhat.com>, Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
References: <20190806191551.22192-1-areber@redhat.com>
 <20190807154828.GD24112@redhat.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <b57e809d-e5fa-bda2-ee81-e86116bb2856@gmail.com>
Date:   Wed, 7 Aug 2019 16:57:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190807154828.GD24112@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/7/19 4:48 PM, Oleg Nesterov wrote:
> On 08/06, Adrian Reber wrote:
>>
>> @@ -2530,12 +2530,14 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
>>  					      struct clone_args __user *uargs,
>>  					      size_t size)
>>  {
>> +	struct pid_namespace *pid_ns = task_active_pid_ns(current);
>>  	struct clone_args args;
>>  
>>  	if (unlikely(size > PAGE_SIZE))
>>  		return -E2BIG;
>>  
>> -	if (unlikely(size < sizeof(struct clone_args)))
>> +	/* The struct needs to be at least the size of the original struct. */
>> +	if (size < (sizeof(struct clone_args) - sizeof(__aligned_u64)))
>>  		return -EINVAL;
> 
> slightly off-topic, but with or without this patch I do not understand
> -EINVAL. Can't we replace this check with
> 
> 	if (size < sizeof(struct clone_args))
> 		memset((void*)&args + size, sizeof(struct clone_args) - size, 0);
> 
> ?
> 
> this way we can new members at the end of clone_args and this matches
> the "if (size > sizeof(struct clone_args))" block below which promises
> that whatever we add into clone_args a zero value should work.

What if the size is lesser than offsetof(struct clone_args, stack_size)?
Probably, there should be still a check that it's not lesser than what's
the required minimum..

Also note, that (kargs) and (args) are a bit different beasts in this
context..
kargs lies on the stack and might want to be with zero-initializer
:	struct kernel_clone_args kargs = {};

-- 
          Dmitry
