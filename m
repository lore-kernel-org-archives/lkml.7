Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AFEC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85A62070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfE2Jsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 05:48:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40078 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfE2Jsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:48:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id 15so1105900wmg.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 02:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vwTDW3GDxSfGJ2Nes8b8IkCVACpMJT3M2VlYKu8eRgU=;
        b=C36PMuWZZfx63dg7mXggxQrWn/+GMP6bXt8YPjfYvT2qHm5vv49Tson6IOPRv7ZmQX
         sjBX6IqEwa1dgz/5hFR0OTCDrgDfSq6XUXKpJDjkzRaF41qFQMsW/hIGBW+TP4h2kk6S
         pPYRyAZkUJbP0xsYpAm58QS8ludLQbIbWWexkY6SzEZOHLzXnpuPXil8VqM6D/0gXgfj
         bCnXaBeWyMIjJHP2FyeTuvXLMhRw/CyVsygycuvX0pfJ62IaUGMh6FkFW6a6gSM89edY
         EWN3XEkhss94kOqCmypqlXzEG76QOqP6JYF560/5sxBx/AeYOb9KF9K9V6wnT0jToILr
         y68A==
X-Gm-Message-State: APjAAAW8SANSxWCYXuIpI21O19Ia3o5EjVZRhva2MBKE1Lo2+U4wUw4F
        BxsrO+P0XX34AEucTGW6QhdkYQ==
X-Google-Smtp-Source: APXvYqwPpPnTUCV71Vn8aBzEQJbZtzUzzeFpbnjygQDsymUJAOHpHXY2cUhKhI/47w3qhZq4WzYc0g==
X-Received: by 2002:a7b:c7d7:: with SMTP id z23mr1684756wmk.127.1559123332502;
        Wed, 29 May 2019 02:48:52 -0700 (PDT)
Received: from t460s.bristot.redhat.com ([193.205.81.200])
        by smtp.gmail.com with ESMTPSA id f18sm1942745wrt.21.2019.05.29.02.48.51
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 02:48:51 -0700 (PDT)
Subject: Re: [RFC 3/3] preempt_tracer: Use a percpu variable to control
 traceble calls
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, williams@redhat.com,
        daniel@bristot.me, "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
References: <cover.1559051152.git.bristot@redhat.com>
 <9b0698774be3bb406e2b8b2c12dc1fb91532bff0.1559051152.git.bristot@redhat.com>
 <20190529084118.GG2623@hirez.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <e0671ce1-654e-8256-2226-cdbb950e5aed@redhat.com>
Date:   Wed, 29 May 2019 11:48:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529084118.GG2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2019 10:41, Peter Zijlstra wrote:
> On Tue, May 28, 2019 at 05:16:24PM +0200, Daniel Bristot de Oliveira wrote:
>>  #if defined(CONFIG_PREEMPT) && (defined(CONFIG_DEBUG_PREEMPT) || \
>>  				defined(CONFIG_TRACE_PREEMPT_TOGGLE))
>> +
>> +DEFINE_PER_CPU(int, __traced_preempt_count) = 0;
>>  /*
>>   * If the value passed in is equal to the current preempt count
>>   * then we just disabled preemption. Start timing the latency.
>>   */
>>  void preempt_latency_start(int val)
>>  {
>> -	if (preempt_count() == val) {
>> +	int curr = this_cpu_read(__traced_preempt_count);
> 
> We actually have this_cpu_add_return();
> 
>> +
>> +	if (!curr) {
>>  		unsigned long ip = get_lock_parent_ip();
>>  #ifdef CONFIG_DEBUG_PREEMPT
>>  		current->preempt_disable_ip = ip;
>>  #endif
>>  		trace_preempt_off(CALLER_ADDR0, ip);
>>  	}
>> +
>> +	this_cpu_write(__traced_preempt_count, curr + val);
>>  }
>>  
>>  static inline void preempt_add_start_latency(int val)
>> @@ -3200,8 +3206,12 @@ NOKPROBE_SYMBOL(preempt_count_add);
>>   */
>>  void preempt_latency_stop(int val)
>>  {
>> -	if (preempt_count() == val)
>> +	int curr = this_cpu_read(__traced_preempt_count) - val;
> 
> this_cpu_sub_return();
> 
>> +
>> +	if (!curr)
>>  		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
>> +
>> +	this_cpu_write(__traced_preempt_count, curr);
>>  }
> 
> Can't say I love this, but it is miles better than the last patch.
> 

ack! I will change the methods (and remove some blank lines here and there... :-))

Thanks Peter!

-- Daniel
