Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80790C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518FF2178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="VSOaZA+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732186AbfKFQAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:00:23 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34275 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732111AbfKFQAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:00:22 -0500
Received: by mail-pf1-f196.google.com with SMTP id n13so7522328pff.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 08:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1GV3/Jdxkg8ik6S7OWfdp2ifwH1Q7AbghamYNHcPHOc=;
        b=VSOaZA+jblM9AJLZwqdcCQod+zmpe8jHwojVTlpMraDgX4jrwb/4WIL5cqdd1d0kTR
         lMt1fPwOvxB8EgRvMAmZx9dl9lR19yeXgQaPeRwnKDGcRJNcgdaf4YHNnOTgrn0j86MI
         MNscn9U2vaU+IAabqYj8T73H0KzZYfjFiAi52EJKJPnYBVg1T5ugyzJOLAkKWUNG2KCQ
         lfWtYITopl9ZQ3QZbf2F9iaSD9E7Wavw5O3tfO200GF2et+Vpp6Gc+yBr2lfCFFMrmqf
         b74UkHIYuLdcSkrb16h1f9jTB4iSTNUREUywfP3jg1NWBvSco9f+BcQ97E2bQin3a33Q
         RU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1GV3/Jdxkg8ik6S7OWfdp2ifwH1Q7AbghamYNHcPHOc=;
        b=mXJiwxJvQKOZoEKdzhLaJkXxStEOaTkQkZpUpJMKfcUxR+zgRKMWq/upnPq3lyqqHW
         wpkGIHhD1HqVK4OpDwOrx54AYmUHWWpNwE21MRXob3Wq/6+y3lrSInxNaZnU7MfTzlLE
         xzbLFf9E84t29OSwEb2H9TyMyPHc/2X5ugoOxeHM6YtKhVo59LCM+ADeD0tGn6nM0Bge
         pLJ4ipDN2cjZawOdxGZeHhm8h+YkLv7A5py7dP7iT9blCkz5IQcWcNyj/k2Z9QRf8Uku
         Fjz+YOLt/emTiMyk8vwPnFrYscwk7/4D3QlqSLW6mUsATcLx/r9QSxKgeRvmJeHOJFEp
         0tMw==
X-Gm-Message-State: APjAAAUL/S7G4jI8atUYE0iSzja7eGpzydd0W4ovUBR16tbUYq5HFeJ5
        XNQlWeIq8cPQZ89DXE0fDuihHg==
X-Google-Smtp-Source: APXvYqxL9k+5TcfM9wckN3H0edDZs1LX2me43REHosrAo9CIFZgKkMe3XaA4FVlF2GlOyeGrmyTDyg==
X-Received: by 2002:a17:90a:280e:: with SMTP id e14mr4724404pjd.135.1573056021910;
        Wed, 06 Nov 2019 08:00:21 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id h6sm3082451pji.21.2019.11.06.08.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 08:00:20 -0800 (PST)
Subject: Re: [PATCH 09/50] arm64: Add loglvl to dump_backtrace()
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
References: <20191106030542.868541-1-dima@arista.com>
 <20191106030542.868541-10-dima@arista.com>
 <20191106132516.GC5808@willie-the-truck>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <8750aff1-036b-4604-27ab-5e04c7f9eeb4@arista.com>
Date:   Wed, 6 Nov 2019 16:00:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191106132516.GC5808@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/19 1:25 PM, Will Deacon wrote:
> On Wed, Nov 06, 2019 at 03:05:00AM +0000, Dmitry Safonov wrote:
[..]
>> @@ -82,12 +82,13 @@ static void dump_kernel_instr(const char *lvl, struct pt_regs *regs)
>>  	printk("%sCode: %s\n", lvl, str);
>>  }
>>  
>> -void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
>> +void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
>> +		    const char *loglvl)
>>  {
>>  	struct stackframe frame;
>>  	int skip = 0;
>>  
>> -	pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
>> +	printk("%s%s(regs = %p tsk = %p)\n", loglvl, __func__, regs, tsk);
> 
> This one needs to stay as pr_debug().

Makes sense, it's debug rather part of backtrace, will fix.

Thanks,
          Dmitry
