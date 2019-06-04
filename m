Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA646C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D1D248CF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfFDKjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 06:39:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33593 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbfFDKjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 06:39:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so2828895wru.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 03:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PA1Zzos5/GV4W8WBqLWjw97Q+q76gYiUhMTLzyflnfQ=;
        b=iT7PYlIp3xNQotnXSiWvla3mpqSIUwm3rqgCjf5lRoTwQL065LdOy3hyRnP1QBnOqF
         F/8Atv/w9NWDXxZYqVBRpjjxuRRr+jMkIJhLMxuPnkvzlYZiAJXyubbzN0nNtuXF+TJ5
         EC1Q5MSduM9HGHnu/GqP02usgCwg8jFIy9fa3ZFtSeGg3aWQePzZDM0XO322au0hWfHK
         xKtl3f8Po595NUNSC8FLk249UkpIA614tOL/ClYOlrPFOFnLLrUcc0HKZAJSDlVwBpBw
         vQPVLUS/r8UYHWusmI6OfAM88lwvAZUQmRqd2PvLiRrZPFGEV2WdlDfHdlss5rk1zWzd
         +6FA==
X-Gm-Message-State: APjAAAXhOaD823Haidyo/A5JvJnfBp8OtylXE5q/sUt8VQx9lQLw5kRH
        fDd74zFMskXPISqtbXVV38041A==
X-Google-Smtp-Source: APXvYqz6IFhBQECP7usz4I6wTPlderjBZlyhpO1cG19aL7hXuEHA4YNvk8qOuDkcH4uOLL3TQLEiew==
X-Received: by 2002:adf:e583:: with SMTP id l3mr788137wrm.1.1559644770035;
        Tue, 04 Jun 2019 03:39:30 -0700 (PDT)
Received: from t460s.bristot.redhat.com ([5.170.68.106])
        by smtp.gmail.com with ESMTPSA id u13sm2979265wrq.62.2019.06.04.03.39.28
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 03:39:29 -0700 (PDT)
Subject: Re: [RFC 1/3] softirq: Use preempt_latency_stop/start to trace
 preemption
To:     Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, williams@redhat.com,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
References: <cover.1559051152.git.bristot@redhat.com>
 <b6bb4705efb0c01c11008ae3c46bc74555245303.1559051152.git.bristot@redhat.com>
 <20190529093056.GA146079@google.com>
 <20190529082248.76bb7a6c@oasis.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <835664be-a8ef-d164-4bf9-e0918413796c@redhat.com>
Date:   Tue, 4 Jun 2019 12:39:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529082248.76bb7a6c@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/05/2019 14:22, Steven Rostedt wrote:
> On Wed, 29 May 2019 05:30:56 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
>> Yes, I think so. Also this patch changes CALLER_ADDR0 passed to the
>> tracepoint because there's one more level of a non-inlined function call
>> in the call chain right?  Very least the changelog should document this
>> change in functional behavior, IMO.

In practice I am seeing no change in the values printed, but there is another
problem with this regard: there are cases in which both caller and parent have
the same address.

I am quite sure it has to do with the in_lock_function() behavior. Anyway, I was
already planing to propose a cleanup in the in_lock_function/in_sched_function.
I will investigate it more.

> This sounds more like a break in behavior not a functional change. I
> guess moving it to a header and making it a static __always_inline
> should be fine though.

Steve, which header should I use?

Thanks!

-- Daniel

> -- Steve
> 
