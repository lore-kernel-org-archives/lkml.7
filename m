Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B57C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD90421841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfDHN5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:57:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36959 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfDHN5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 09:57:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so16551158wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 06:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wsuW/A/A/2IZbYOm99nwKA0chJUmq1KGQa/aD2KSNeE=;
        b=nKw479GiLNNOhX3gcMdE94lb/AFLXAmfyfYxawMxIvI85LBAs9sDYcVJjxe2HnzJSG
         w31T9eYEzTFSjuvPiqffrVB0+o55Dt9joNa+63kKwJRGPm0+m0V04+q+Uq1IdATX4Os5
         sSi07OHQCLQ3gShrNWCOg9A+D+etZ0ZxrPACFLpg5k7myn+rwWchYPZhhkislQwIY37m
         3rk0KqvYnV23Zkzu3miX8pSYvMggG/+aNsUFpWl7/VFe3VEvWQhoz2CM5QYd5BfLh99T
         HRS4/wQjvB08pzGE3jfu+HfcZm9Y5KS6NXTeO+7tZL45Lo3xyxUSrKIm6Mv8PfAxsmon
         tqoQ==
X-Gm-Message-State: APjAAAWtjtWSqZIqRnkR2PfGFB86ZdXMsBwP8kO6mI/ks26kO6AeGYR6
        0tGJSvY6L0+1VylD2+74v4VIVg==
X-Google-Smtp-Source: APXvYqx5wsfcDx+IzJVWFibOMvbgB9E1q0b7vtZVVlLk4ucYSSSI5DrxSDgZ6RPgHoNnlq+gmRiulw==
X-Received: by 2002:a5d:6681:: with SMTP id l1mr19311262wru.186.1554731829302;
        Mon, 08 Apr 2019 06:57:09 -0700 (PDT)
Received: from t460s.bristot.redhat.com ([193.205.81.200])
        by smtp.gmail.com with ESMTPSA id z13sm46303628wrw.36.2019.04.08.06.57.08
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 06:57:08 -0700 (PDT)
Subject: Re: [PATCH V2 2/2] trace,x86: Add nmi to the irq_vectors class
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
References: <833f2a192b491649e4d46cec51028d07c96bbf5e.1554142415.git.bristot@redhat.com>
 <d9e0e9d14d2ef394cea974e2f47c0099b7d18839.1554142415.git.bristot@redhat.com>
 <alpine.DEB.2.21.1904052323200.1802@nanos.tec.linutronix.de>
 <9fc0399e-ab53-1074-623a-a826e2466277@redhat.com>
 <20190408094633.7ff8dbf4@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <1da7473c-a602-9a49-35a1-6de43bb744b9@redhat.com>
Date:   Mon, 8 Apr 2019 15:57:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190408094633.7ff8dbf4@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/19 3:46 PM, Steven Rostedt wrote:
> On Mon, 8 Apr 2019 14:24:47 +0200
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>> NMI starts:
>>   f-4447  [000] d.Z.  1487.689290: nmi_entry: vector=2
>>   f-4447  [000] d.Z.  1487.689291: default_do_nmi <-do_nmi
>>   f-4447  [000] d.Z.  1487.689291: nmi_handle <-default_do_nmi
>>   f-4447  [000] d.Z.  1487.689291: nmi_cpu_backtrace_handler <-nmi_handle
>>
>> It handles very fast:
>>   f-4447  [000] d.Z.  1487.689292: nmi_handler: nmi_cpu_backtrace_handler()
>> delta_ns: 780 handled: 0
>>
>> But some other functions continues running in the NMI context:
>> [Dazed and confused, but trying to continue message ]
>>   f-4447  [000] d.Z.  1487.689292: _raw_spin_trylock <-default_do_nmi
>>   f-4447  [000] d.Z.  1487.689566: unknown_nmi_error <-default_do_nmi
>>   f-4447  [000] d.Z.  1487.689566: nmi_handle <-unknown_nmi_error
>>   f-4447  [000] d.Z.  1487.689567: printk <-unknown_nmi_error
>>   f-4447  [000] d.Z.  1487.689567: vprintk_func <-printk
>>   f-4447  [000] d.Z.  1487.689567: printk_safe_log_store <-vprintk_func
>>   f-4447  [000] d.Z.  1487.689569: arch_irq_work_raise <-irq_work_queue
>>   f-4447  [000] d.Z.  1487.689569: default_send_IPI_self <-arch_irq_work_raise
>>   f-4447  [000] d.Z.  1487.689569: __default_send_IPI_shortcut
>> <-default_send_IPI_self
> 
> Just to remove confusion. Your example is to show that the new
> tracepoints would have shown that the NMI was long due to the printk? As
> running printk from NMI (even with the delayed output) isn't a normal
> path.

The example is "to show that the new tracepoints would have shown that the NMI
was longer than what the existing tracepoint pointed." The example was not the
best, I agree.. but... it serves to illustrate the idea.

-- Daniel
