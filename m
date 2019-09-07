Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C19C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 21:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFC8208C3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 21:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVGWCL11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436693AbfIGVNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 17:13:05 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38227 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406264AbfIGVNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 17:13:05 -0400
Received: by mail-qk1-f193.google.com with SMTP id x5so9138053qkh.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 14:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WZ40lQLRZ9Qku3eSrX7Z1ZfXZh74jtidVt6YdPRI94A=;
        b=DVGWCL11t9HhKdvGMIS39j3Cx0wFP0iI/b1YY7TvHHbrpLSjFusy12jTARGG5Y0lcK
         2xOv5PTooPZpTuxcuzHszX5CigRZ14xFaCAyEXJrNQfr6aAgH9dcsKhDAn1mSJEHU7gY
         L0XnCQlN3riT2nbtGPOMaulYkpBzNLZLrnB9lgqzl9Os17U7mFLKUZ3Tj05488FZHSES
         3Urg71yfxLx8cWTPq7v6KXoWeqT5L1YjQ/Tv6ZTuz4hSiaxxsrbmKf2Oq49Bf5F2htOY
         Mf8ot7Pj6fFJRqFoVLKNQjMA9EAFwlPq4Ns9465haSx845wo4r5z4NDu+Wrb29A79Oft
         FNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WZ40lQLRZ9Qku3eSrX7Z1ZfXZh74jtidVt6YdPRI94A=;
        b=tgD4bFdJg/RclYIqZEFP7Ybf8X+ptoND3i6mmSKoL/wHfzkGxM8q85C6bSTzVu+HNL
         gxGtaAgBRqcpTCdEz+Pnio8OtKvf/XbCEkwvvXa3hJ9uUvDRY9v+2QjW+enlfuXkPTxZ
         kgbpHBtGi5YFUaaJ/skn9MspaFlfHRO7KvaPBza/ZyApoZZRr3tTIQP0QnzA4+quKaat
         uu3HwIRwqOUQ/MGXzI2mq5Y0JT0kix09OWefaV7JVWgCHHWr4lgI4aeh1OMFQ3762WDA
         AiKgsthb7RWqV5aPy5IPuB5sP2OtdyVGsw16hjz/FLyLmJNdhzLYKZ8zfZN3TaBJBMtE
         6aOQ==
X-Gm-Message-State: APjAAAVfYlGIU5uWJ4MB1iamHhv6S6tGqSyrw8SqW6aNQfaq/CqwgGtE
        tJfOuJ+FyAQNW6Y7CTtR9Ztk48s=
X-Google-Smtp-Source: APXvYqxWFMdVYFWxwuOVLAOfZrJlRePmiCgwwz+3EBRllub6N5d9x8F3XqBSm+6ziOpFShPFABJHVw==
X-Received: by 2002:a05:620a:1494:: with SMTP id w20mr16249585qkj.317.1567890783557;
        Sat, 07 Sep 2019 14:13:03 -0700 (PDT)
Received: from [192.168.1.99] ([92.117.172.145])
        by smtp.googlemail.com with ESMTPSA id 29sm5135881qkp.86.2019.09.07.14.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Sep 2019 14:13:02 -0700 (PDT)
Subject: Re: [PATCH v6 1/4] ftrace: Implement fs notification for
 tracing_max_latency
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
References: <20190905132548.5116-1-viktor.rosendahl@gmail.com>
 <20190905132548.5116-2-viktor.rosendahl@gmail.com>
 <20190906141740.GA250796@google.com>
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
Message-ID: <c35722db-bb79-7e09-ac02-e82ab827e1e3@gmail.com>
Date:   Sat, 7 Sep 2019 23:12:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906141740.GA250796@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/19 4:17 PM, Joel Fernandes wrote:
> On Thu, Sep 05, 2019 at 03:25:45PM +0200, Viktor Rosendahl wrote:
<clip>
>> +
>> +__init static int latency_fsnotify_init(void)
>> +{
>> +	fsnotify_wq = alloc_workqueue("tr_max_lat_wq",
>> +				      WQ_UNBOUND | WQ_HIGHPRI, 0);
>> +	if (!fsnotify_wq) {
>> +		pr_err("Unable to allocate tr_max_lat_wq\n");
>> +		return -ENOMEM;
>> +	}
> 
> Why not just use the system workqueue instead of adding another workqueue?
> 

For the the latency-collector to work properly in the worst case, when a
new latency occurs immediately, the fsnotify must be received in less
time than what the threshold is set to. If we always are slower we will
always lose certain latencies.

My intention was to minimize latency in some important cases, so that
user space receives the notification sooner rather than later.

There doesn't seem to be any system workqueue with WQ_UNBOUND and
WQ_HIGHPRI. My thinking was that WQ_UNBOUND might help with the latency
in some important cases.

If we use:

queue_work(system_highpri_wq, &tr->fsnotify_work);

then the work will (almost) always execute on the same CPU but if we are
unlucky that CPU could be too busy while there could be another CPU in
the system that would be able to process the work soon enough.

queue_work_on() could be used to queue the work on another CPU but it
seems difficult to select the right CPU.

best regards,

Viktor
