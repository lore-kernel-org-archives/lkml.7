Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2B5C00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460332070C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567786113;
	bh=MbBDXDeWJbAimTzaZRtY7p6RsilvG8i/em1kNMnLMMo=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=jVwzIHmEKv0sDIQNMbz8wEk3fRhl65OVeNBZ/SDoEL/+2UamPZ4ltwCgjTyAtSQfe
	 vMzvfb7eRLxgmqUWx5ZDlS/KefrS/8LoGtGtcDlLgtsoFR/a9mZnJct2eFUyM04+zZ
	 O6LDYXsRv8JjMPJtEOYYmUTdFJY+nbQiL9h7JZNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405881AbfIFQIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 12:08:32 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34474 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389039AbfIFQIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:08:32 -0400
Received: by mail-io1-f68.google.com with SMTP id s21so13958274ioa.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 09:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8J350dN8/M6cK0y+Ad2uk2NCojbGNvCKnyVt3HjFMFM=;
        b=Bp7xECazcgvuielhCk9NpeivTZ88aSRr3td1uSX/4ZYRvMsgz52UXNH+r8AzBGw5ri
         gbsWvYOirWDOPlapvKitQGzxuwlJ2CNGfftUmjUY1Mr963hhQhW1qRyfz/CCR3iapS9i
         G067oubFpJll5RIqNkLSbccj0Ri2JIfgu6Ik0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8J350dN8/M6cK0y+Ad2uk2NCojbGNvCKnyVt3HjFMFM=;
        b=Hm3kQN9Wbov4ekrc3RdavjsLo/VobIe3Gq8vp09wOyp/4ZypPbyGdGdnIuPUBqMxTA
         58FnhAcdRsN5y4Rs5vnRLfLnLxqRd+VwYhSWpxDyx7vRfH5F9ndkYkkde2hz332wzmFt
         eH8T+/k39UZVP1foPeOZ7ho0+xIvufPEzSc6avIbZBMY45iFEpOjBU73k6yEpzcda7T3
         QQrDEjih+JflDIfUuoCAeGwFrCVoBfyp0+KONSmUf73/7L3mgZ5owWDQll7f4gmUd7ZM
         4NH2pw5Rdp6ht7I3ZJPz3Ep3QZXCWGTEuqjUlh4maROD3IHZ5/caIOX2+BS8xi6p1CLs
         qB8g==
X-Gm-Message-State: APjAAAX24/Av+OOY5iHDQqyCJ30OEzO32pCjqNZM3qjWIe5ttr4iN9fI
        BR20lydCuhQvTbhoIMNDGfEBeg==
X-Google-Smtp-Source: APXvYqz0XnW7wcQLDNwsPZK+Sg5pamQWd1BBeXHmIYvXm+MFCbLgq97VuRuVQ+IHTATRY3wQ3JO+DQ==
X-Received: by 2002:a6b:761a:: with SMTP id g26mr11382863iom.71.1567786111002;
        Fri, 06 Sep 2019 09:08:31 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l186sm11163832ioa.54.2019.09.06.09.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 09:08:30 -0700 (PDT)
Subject: Re: [PATCH] kunit: add PRINTK dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        shuah <shuah@kernel.org>
References: <20190906152800.1662489-1-arnd@arndb.de>
 <5dfe1bfc-0236-25cf-756b-ce05f7110136@linuxfoundation.org>
 <CAK8P3a3ynubySZ3A5M7D__B6R+caMjys=v+GVjqA78rppOJQQQ@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <67f4fe26-7d6a-68f2-dc45-af358be590df@linuxfoundation.org>
Date:   Fri, 6 Sep 2019 10:08:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3ynubySZ3A5M7D__B6R+caMjys=v+GVjqA78rppOJQQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/19 10:02 AM, Arnd Bergmann wrote:
> On Fri, Sep 6, 2019 at 5:39 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>>>    config KUNIT
>>>        bool "Enable support for unit tests (KUnit)"
>>> +     depends on PRINTK
>>>        help
>>>          Enables support for kernel unit tests (KUnit), a lightweight unit
>>>          testing and mocking framework for the Linux kernel. These tests are
>>>
>>
>> Hi Arnd,
>>
>> This is found and fixed already. I am just about to apply Berndan's
>> patch that fixes this dependency. All of this vprintk_emit() stuff
>> is redone.
> 
> Ok, perfect. Unfortunately I only started testing the coming
> linux-next release after Stephen went on his break, so
> I'm missing some updates.
> 

No worries. I am pushing it now - should be there in 5-10 mins.

Please use linuxk-kselftest next.

Let me know if you see any issues. Thanks for testing it.

thanks,
-- Shuah

