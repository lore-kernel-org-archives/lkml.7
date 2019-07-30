Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65104C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26D37206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="WquyfmNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731099AbfG3CAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:00:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38240 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730929AbfG3CAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:00:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id az7so28206244plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 19:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsukata-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+CDQKEoJOQIhj1umhGJ0CzRFPA0QDeaVjkPHa4UOJKM=;
        b=WquyfmNw6WfYapV8car5sPOOJyDMSgxJYM8XVJOUzFKdrPTrkgG069YqbqaZetxhBg
         fDtxmRxnMa50wUusf1wvGHCme/fBgPCl35Fb6rIlYtNrKGS8AaT7MNZycGejvsp1DNBD
         zpdBv1pI9ownI+zIbyBMdupgY6VFfWrf3IEyyXi24KaJTjwOZjzvZ7aHJbsG6V4s+gzw
         r8yUq//6ciLof0gIA2m7mQKcJl5gKQ0nhWYfHMbKySTIBJmFbAjigOQ69eUs7Q9jYa7P
         QjDW6eT0LPlk6ki1adSAvNSTjWmyPVMwc8W0/zJ7yUs2yTUz7tHHGfy0gk65U32g6ZQE
         jfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+CDQKEoJOQIhj1umhGJ0CzRFPA0QDeaVjkPHa4UOJKM=;
        b=Uq1gQr7twXOCcHAIqgbdXFZ9RSmhGQiz97l3RDgfVzxocRZIwDzap1Vj4CukyOe7Vw
         ddAMpY70walFacawIRhq2V9O3d2zQCk7sLR9QHPCizQPAsS2djyLZRq/pU4o0lV8lJdJ
         tfCP6vckpt9yucYX3tbNYMcF4K2O5zEFjjIM71+BT6qfqChlgOw0KD3UTlkG+bOhJBfo
         0neFE3bfgH/cl0Zm606Ae6iqH5YWRNRRbdV5OvzskftGgFjZ9gYPEFOQNeKROE5SPoAD
         kriiG5lDNew10t0GQ7Jcf8hJXgDx4tXamJshBzVInrJjkVKJfhJvyR3ZIb0qzCNu+VTG
         o7yw==
X-Gm-Message-State: APjAAAV8o7kP8G/YAuE2HfPuPx4Ym4T90R0xKszy4GQ9o1gXwM2Q7JMe
        +5yQRJeEZPOc1uHhwRbxIekvF7yC
X-Google-Smtp-Source: APXvYqx6yg/z/CRl2zc2hnB6QNwoaIBbYgVGoBKKZSL89Hs5Ce+HLhbVWgC642xrRuIyMGwPzQS2PQ==
X-Received: by 2002:a17:902:4c88:: with SMTP id b8mr116727557ple.29.1564452046215;
        Mon, 29 Jul 2019 19:00:46 -0700 (PDT)
Received: from etsukata.local (fs76eecbcd.tkyc008.ap.nuro.jp. [118.238.203.205])
        by smtp.gmail.com with ESMTPSA id k3sm47769126pgq.92.2019.07.29.19.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 19:00:45 -0700 (PDT)
Subject: Re: [PATCH] tracing: Prevent RCU EQS breakage in preemptirq events
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     joel@joelfernandes.org, paulmck@linux.vnet.ibm.com,
        tglx@linutronix.de, peterz@infradead.org, mingo@redhat.com,
        fweisbec@gmail.com, luto@amacapital.net,
        linux-kernel@vger.kernel.org
References: <20190729010734.3352-1-devel@etsukata.com>
 <20190729112126.6554b141@gandalf.local.home>
From:   Eiichi Tsukata <devel@etsukata.com>
Openpgp: preference=signencrypt
Autocrypt: addr=devel@etsukata.com; keydata=
 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
Message-ID: <2ceec933-503e-5d58-60b4-85b491b017d4@etsukata.com>
Date:   Tue, 30 Jul 2019 11:00:42 +0900
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729112126.6554b141@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for comments.

On 2019/07/30 0:21, Steven Rostedt wrote:
> On Mon, 29 Jul 2019 10:07:34 +0900
> Eiichi Tsukata <devel@etsukata.com> wrote:
> 
>> If context tracking is enabled, causing page fault in preemptirq
>> irq_enable or irq_disable events triggers the following RCU EQS warning.
>>
>> Reproducer:
>>
>>   // CONFIG_PREEMPTIRQ_EVENTS=y
>>   // CONFIG_CONTEXT_TRACKING=y
>>   // CONFIG_RCU_EQS_DEBUG=y
>>   # echo 1 > events/preemptirq/irq_disable/enable
>>   # echo 1 > options/userstacktrace
> 
> So the problem is only with userstacktrace enabled?

It can happen when tracing code causes page fault in preemptirq events.
For example, the following perf command also hit the warning:

  # perf record -e 'preemptirq:irq_enable' -g ls


>>  
>>  __visible void trace_hardirqs_on_caller(unsigned long caller_addr)
>>  {
>> +	enum ctx_state prev_state;
>> +
>>  	if (this_cpu_read(tracing_irq_cpu)) {
>> -		if (!in_nmi())
>> +		if (!in_nmi()) {
> 
> This is a very high fast path (for tracing irqs off and such). Instead
> of adding a check here for a case that is seldom used (userstacktrace
> and tracing irqs on/off). Move this to surround the userstack trace
> code.
> 
> -- Steve

If the problem was only with userstacktrace, it will be reasonable to
surround only the userstack unwinder. But the situation is similar to
the previous "tracing vs CR2" case. As Peter taught me in
https://lore.kernel.org/lkml/20190708074823.GV3402@hirez.programming.kicks-ass.net/
there are some other codes likely to to user access.
So I surround preemptirq events earlier.
