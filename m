Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4050C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DA42082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554934722;
	bh=UI7q17vQhvE2Etty/hhbeA139X5yjFMGcEdzOCyYvzo=;
	h=From:Subject:To:Cc:References:Date:In-Reply-To:List-ID:From;
	b=RnCL6xlyvI7+EppPQqPHu2MsRq0SQOJfX4S96hy4UPMqq6/zO4LPM268CyV0QWcVD
	 U+mDz+lPCqYN1tns4NMEJPhMLITirox48WCtpnrP7AcXwCcDKHzZ3o/N5MYoiAYG5T
	 AWU6JlKLSGjKGam9JeSV0TyLl7XUgi+jskqhtGXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfDJWSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:18:40 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36618 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfDJWSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:18:40 -0400
Received: by mail-qk1-f195.google.com with SMTP id k130so2286057qke.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MGSZQXDQcdOWwdlhCrxsVkTwl8GxYj97+vMhZgI1w9I=;
        b=YghhWebs518Q9Du8A28X4VKdN4x7kDepAZExP2acSuUghBeIZuyRk8p6gl+i2e3/51
         PA1q3Hg635V2pfqhG3nmvdxYV5e5LR0a7+AbEg8vru5SUy75A5PQTvxxhrR22NbKwNCP
         lA0+Oq+/ZDvN3ZLuBl4hiRrdW6N+9chbcd0a9nDsn75unUq/2w7/3WSYuogdDg89yWda
         NLx3y7juhgCAQk/1kSU18b50Q4vVKhznCG9fIrCMnwB6czqavJ+O8PcC4qCyjXev2Hr8
         zxm2udgZWBMtyXrVNwTLfCdDGG8DTJ9YRshf/KYhWStdXquq2VExy6REn8qe+avvoOJG
         qbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MGSZQXDQcdOWwdlhCrxsVkTwl8GxYj97+vMhZgI1w9I=;
        b=nH15Nc7o9238NDQmNGq9jt1O40r81iAl3CL234EY3xKLncXSimD8pjYDGOoGu6TQjJ
         04u3ueBsaE6ETNO7Pg46pNWmiuSs38eIe5vXcfF19eszEMNobktw8tCFEYYPY2z1cOZk
         zJuOZ0X2/jNMELWp74LMWYLFj5T+MECYCYlaESBwYJJ7PFiO3eUHHRzozFS9HDIeEMAZ
         lKHdQcKJ1+j5eWTKFzXasJAIPoESX4/zKbwv5/S0ETrKtgeSITFVr9GRCZ7250EjZGAa
         n73IVArdRu2RzlgWSeetQuRoEHgEsWiDqgP50bIKAqf5qZNYd/L5Bcg0j0CVvGTSsMBL
         ctyQ==
X-Gm-Message-State: APjAAAWv9XItIUWZRCmR/H/14sq4CLjS6A+iptUwtELfGwm1Pmcnt47r
        t1JCV+Am21w7HQYOqDtw8u5Tmzep
X-Google-Smtp-Source: APXvYqzOqxpzFrkqVpHfI4ObiAjfEnz8ZYok6Tec8N+nCkT8St9PAbXSEX25DYeKHfVQa3jP02KSqA==
X-Received: by 2002:ae9:e515:: with SMTP id w21mr36419931qkf.200.1554934719433;
        Wed, 10 Apr 2019 15:18:39 -0700 (PDT)
Received: from [10.84.150.60] ([167.220.148.60])
        by smtp.gmail.com with ESMTPSA id t35sm24855663qtc.10.2019.04.10.15.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 15:18:38 -0700 (PDT)
From:   Sinan Kaya <Okaya@kernel.org>
X-Google-Original-From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v1] init: Do not select DEBUG_KERNEL by default
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>
References: <20190410212627.29514-1-okaya@kernel.org>
 <CAGXu5j+uBuPjDc+gGcxW_QoJJi7sQZ8m=Zg-Q2wKDxyTt7yGvg@mail.gmail.com>
 <a9508cc3-3385-256e-2f27-c1e0a770ba69@kernel.org>
 <CAGXu5jLPxUESH9eMm6rvaTVue_9rNEdx+9dcxiV11kgi03jUmA@mail.gmail.com>
Message-ID: <ac8f52a9-30a4-41fd-50f6-65c8ae859675@kernel.org>
Date:   Wed, 10 Apr 2019 18:18:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLPxUESH9eMm6rvaTVue_9rNEdx+9dcxiV11kgi03jUmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/2019 6:04 PM, Kees Cook wrote:

>> I don't want any of the debug features in my kernel but still
>> need all the expert features. My kernel is considered a production
>> kernel. I don't really want to ship all the good debug enables.
> 
> Production kernels enable it. e.g. Ubuntu:
> $ grep '\bCONFIG_DEBUG_KERNEL\b' /boot/config-$(uname -r)
> CONFIG_DEBUG_KERNEL=y
> 

It makes sense for a general purpose operating system. It doesn't apply
to my limited case where I'm very concerned about image size.

>> I don't see the relationship between CONFIG_DEBUG and CONFIG_EXPERT
>> as none of the features except KALLSYMS depend on it. If there was
>> a compile time dependency, I'd say move it to the things that need
>> it as this patch suggests.
> 
> CONFIG_DEBUG_KERNEL mainly only enables the visibility of various
> other options. I can only find two instances of it controlling a
> "default", and one is overridden by CONFIG_SMP on alpha. :)
> 
> $ git grep -B2 'default.*DEBUG_KERNEL'
> arch/alpha/Kconfig.debug-config MATHEMU
> arch/alpha/Kconfig.debug-       tristate "Kernel FP software
> completion" if DEBUG_KERNEL && !SMP
> arch/alpha/Kconfig.debug:       default y if !DEBUG_KERNEL || SMP
> --
> kernel/trace/Kconfig-menuconfig FTRACE
> kernel/trace/Kconfig-   bool "Tracers"
> kernel/trace/Kconfig:   default y if DEBUG_KERNEL

If the idea is to just show, nothing should happen based on
DEBUG_KERNEL, right?

No default selection as in FTRACE, no c/S file changes in the code
path as Mathieu identified.

I can go after individual enables if you agree assuming Mathieu will
go after the changes in the other email. Let me know otherwise.

> 
> What do you see enabled that CONFIG_DEBUG_KERNEL enables that you don't want?
> 

