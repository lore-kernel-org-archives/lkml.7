Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C06FC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E07C20673
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ya0zg7pQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390690AbfEXKmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 06:42:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46572 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390497AbfEXKmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:42:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so9471158wrr.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 03:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sMgd9oZAKI1GrJ2O2mtgZuuxKr/03GN+V6GqnIamqiM=;
        b=Ya0zg7pQjg6VWbg1h/AAx+p19IUhVehVy7LguVr1othTF/poBx67vu9yEsTVyoYt7Y
         fsSheJV7cQFowfQ4dZrdxSJMq+6VSoDY3zNDeO1IQI4bbmd6T9mk3NRyOQN91cU8EXbm
         3o5xT0BlVYxu2rnyfFYKgxJXa1BBajc7cjZYaPiSB4x7nLmOVlyDbBnwCXgV4RLP1zgi
         GTe3D8kIMJE6TSf+sHcO8s8ZCO7NVyDoYwfgP+pAZJb4kfXtuThMmEA5w3How0R0pCRT
         4x0vKT7oh1ROoHsIbZ8+SbMaPmxG0PMdG/ZubnAj3OxeRMe/DMZSZLvln4MtCOz+2N+T
         5vMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sMgd9oZAKI1GrJ2O2mtgZuuxKr/03GN+V6GqnIamqiM=;
        b=F8SYd8s/grn/BRT8RH+7YwHUOgMRQqGfUmz0z9VNay9LTodDQyXufuLtNxIVVezqSA
         K60rZtGA3XjO3uffy5hcQEKlgDjugdh/oD82is68LEqMCUr1Y/Us26VWtaWKWQ2QcT2E
         9JZ/Gwk6N7hgq1h38ZqorGFaVDeIANkR3uU6qkqUfML2hQXmJ8PK4cHpXGphIWgCSwzP
         1wTUxVy7LXJOKK/jN03OVEFobYfAt+uLQD00TCf6VKkxY+UZZh4zeN4DG1kIqf8nk3hK
         PUTekoNQAenoj0QoE27/6PUPp1xkxnWDGu49+S9LjVinU7dtDDqN4t0BhXF2b3CRawbo
         MXQg==
X-Gm-Message-State: APjAAAUpP0KBTjXXYfTC6LFMl4fdfijBIkoloWUca09PZ6c8NwgmXQMh
        4qyUd4Xi4Lc+sicVGm7JwQbhRg==
X-Google-Smtp-Source: APXvYqyINA4RJcI3np98LtdVeR4axYizn55wIalMAZg4q6a2dh6IvmkWcd31cIgC6JlsO+XYc4CKvA==
X-Received: by 2002:a5d:54cc:: with SMTP id x12mr16916464wrv.303.1558694560785;
        Fri, 24 May 2019 03:42:40 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id 88sm5731506wrc.33.2019.05.24.03.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 03:42:40 -0700 (PDT)
Subject: Re: [PATCH] clocksource/arm_arch_timer: Don't trace count reader
 functions
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
References: <1558689025-50679-1-git-send-email-julien.thierry@arm.com>
 <9adf92c2-b7a5-00a3-ff09-58484d9bb9db@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a1af63f8-1b3e-a959-d309-7360679739a2@linaro.org>
Date:   Fri, 24 May 2019 12:42:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9adf92c2-b7a5-00a3-ff09-58484d9bb9db@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2019 11:53, Marc Zyngier wrote:
> On 24/05/2019 10:10, Julien Thierry wrote:
>> With v5.2-rc1, The ftrace functions_graph tracer locks up whenever it is
>> enabled on arm64.
>>
>> Since commit 0ea415390cd3 ("clocksource/arm_arch_timer: Use
>> arch_timer_read_counter to access stable counters") a function pointer
>> is consistently used to read the counter instead of potentially
>> referencing an inlinable function.
>>
>> The graph tacers relies on accessing the timer counters to compute the
> 
> nit: tracers
> 
>> time spent in functions which causes the lockup when attempting to trace
>> these code paths.
>>
>> Annontate the arm arch timer counter accessors as notrace.
> 
> nit: Annotate
> 
>>
>> Fixes: 0ea415390cd3 ("clocksource/arm_arch_timer: Use
>>        arch_timer_read_counter to access stable counters")
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> ---

[ ... ]

> Well spotted, thanks Julien.
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Daniel, can you please pick this up for the next batch of clocksource fixes?

Sure.

I will take care of fixing the comments, no need to resend.

Thanks

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

