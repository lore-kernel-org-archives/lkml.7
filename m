Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A49C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 17:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98ABE214DB
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 17:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/5cez3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbfIHRFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 13:05:10 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:47049 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729734AbfIHRFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 13:05:09 -0400
Received: by mail-qt1-f193.google.com with SMTP id v11so13195921qto.13
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 10:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VCEjeAlF/R9OaASshTLZCJrV+Bz/CgD5dTbWg84yOkw=;
        b=s/5cez3JbjZidvVcC7Ce82LxJWpWG8js/u//v7iCPLDCLbT++KsCJl/XA6IL28o8/g
         Tv754QWlrlpFqzqE0NGL/2qOzLIxsLK+SptB+S8Zl2dNq0gCuI25+oxBsAek4QnbuMEV
         NKjH9xJMaSF00fZ/hGdWidi7dh4+R/fsXOF3SYe7TDD8Lnoi4Xlc8iMausuXUAFhqwn7
         1lNsd73RKCnZF4sMh1Uc/5bHTeeN4hAw9UMF/VtXaO9DLNc0BtVfMTmKglDGHrY+iULW
         vYyFmzw7on0t03WGVztnSTA6WYJ+jgXbKmaaD7R8y+HlGYrZAgCylVk3XUHWyZ3aa8fj
         dYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VCEjeAlF/R9OaASshTLZCJrV+Bz/CgD5dTbWg84yOkw=;
        b=bzp0EAYcZJGD1VGdQUE3V588E/0P3wD+39zD4VAJO2TTeSHq51TphNZ6/BwaLXvUpA
         13A5Ov516IG3qxHNijCZPc5rNMQvo2IVugAVHmjzvuNOxWTDaEJPQBVYLtTDdrIidxzU
         LzkYIKfbdp17pupWBNgny6B9QOUGsToqBmwwfQtY/pfhkyrepw5/K6REGzCxaS0FurT5
         91kcTecFkmxhojZcAMZOBdaFRXSSKDN/dIVeOviuxEzPsFOLzv0Hch4K1NxumzdRkEf8
         ysnG8neF4XUrgQQwe8rHjl+2M+tkfZLWCcwOnd1iWzLBWCMfgNKhfAeluQ6v8f3Y951B
         gNgA==
X-Gm-Message-State: APjAAAUX6RTAxvP/+anz3ZlHzAFh/ciR43shWNQA0fwL5H+PWtNlBELB
        MfhYXRt5VTXn9UNOWHM+U4PBTtY=
X-Google-Smtp-Source: APXvYqwCeFBBNjDYjjkV0i++kjj3X0zEMoSmqa0kMDVKneX79Dbubr9Shoz3CyfuWV6Jzz3oZJe74Q==
X-Received: by 2002:a0c:d084:: with SMTP id z4mr11810376qvg.63.1567962308181;
        Sun, 08 Sep 2019 10:05:08 -0700 (PDT)
Received: from [192.168.1.99] ([92.117.170.41])
        by smtp.googlemail.com with ESMTPSA id w73sm3310832qkb.111.2019.09.08.10.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Sep 2019 10:05:07 -0700 (PDT)
Subject: Re: [PATCH v6 1/4] ftrace: Implement fs notification for
 tracing_max_latency
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
References: <20190905132548.5116-1-viktor.rosendahl@gmail.com>
 <20190905132548.5116-2-viktor.rosendahl@gmail.com>
 <20190906141740.GA250796@google.com>
 <c35722db-bb79-7e09-ac02-e82ab827e1e3@gmail.com>
 <20190907233801.GA117656@google.com>
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
Message-ID: <955add6c-1465-df65-ddb1-f2b3a05df9d1@gmail.com>
Date:   Sun, 8 Sep 2019 19:05:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190907233801.GA117656@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/19 1:38 AM, Joel Fernandes wrote:> On Sat, Sep 07, 2019 at 
11:12:59PM +0200, Viktor Rosendahl wrote:
 >> On 9/6/19 4:17 PM, Joel Fernandes wrote:
 >>> On Thu, Sep 05, 2019 at 03:25:45PM +0200, Viktor Rosendahl wrote:
 >> <clip>
 >>>> +
 >>>> +__init static int latency_fsnotify_init(void)
 >>>> +{
 >>>> +	fsnotify_wq = alloc_workqueue("tr_max_lat_wq",
 >>>> +				      WQ_UNBOUND | WQ_HIGHPRI, 0);
 >>>> +	if (!fsnotify_wq) {
 >>>> +		pr_err("Unable to allocate tr_max_lat_wq\n");
 >>>> +		return -ENOMEM;
 >>>> +	}
 >>>
 >>> Why not just use the system workqueue instead of adding another 
workqueue?
 >>>
 >>
 >> For the the latency-collector to work properly in the worst case, when a
 >> new latency occurs immediately, the fsnotify must be received in less
 >> time than what the threshold is set to. If we always are slower we will
 >> always lose certain latencies.
 >>
 >> My intention was to minimize latency in some important cases, so that
 >> user space receives the notification sooner rather than later.
 >>
 >> There doesn't seem to be any system workqueue with WQ_UNBOUND and
 >> WQ_HIGHPRI. My thinking was that WQ_UNBOUND might help with the latency
 >> in some important cases.
 >>
 >> If we use:
 >>
 >> queue_work(system_highpri_wq, &tr->fsnotify_work);
 >>
 >> then the work will (almost) always execute on the same CPU but if we are
 >> unlucky that CPU could be too busy while there could be another CPU in
 >> the system that would be able to process the work soon enough.
 >>
 >> queue_work_on() could be used to queue the work on another CPU but it
 >> seems difficult to select the right CPU.
 >
 > Ok, a separate WQ is fine with me as such since the preempt/irq 
events are on
 > a debug kernel anyway.

Keep in mind that this feature is also enabled by the wakeup tracers and by
hwlat. These are often enabled by production kernels.

I guess it would be possible to add some ifdefs so that we create a new
workqueue only if preempt/irqsoff tracing is enabled in the kernel 
config and
use system_highpri_wq if we only have the wakeup and hwlat tracers in the
config.

However, I don't really like adding yet some more ifdefs to the code.

Since a new workqueue will not necessariy create a new worker thread 
nowadays,
I thought that it would be OK with a new unbound workqueue, which should not
add much to the tendency to create more worker threads.

 >
 > I'll keep reviewing your patches next few days, I am at the LPC 
conference so
 > might be a bit slow. Overall I think the series look like its 
maturing and
 > getting close.
 >

Ok, thanks. Could you let me know when you have looked through it all so 
that
I know when it makes sense to make another reroll of the series?

best regards,

Viktor
