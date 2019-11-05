Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43190C1747C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC4721882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389476AbfKEOKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:10:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730671AbfKEOKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:10:45 -0500
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED18D8110A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2019 14:10:44 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id i1so21766321qtj.19
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 06:10:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+sinCEpD0bXZ2eNJLuorG8CS3BMWSnMyRoSnjLMp6SI=;
        b=Mx+9QyPjh5s63FwCUsRM7LG0f/UtGq/4O5xrfDDcxg8zgn0FyExQezFrmTMKlwS1ev
         BOty9s+/0JIKZDU2vJT4KN7l8P3QRNIa7GNzMmqBE+W0jdGrWyrOfZBJoh8qw6d19QSl
         GOR65ho/cwwhFPSTsfQITP+yJxHYtD6VtgJhS+GKBydD/77y3nX4ICFTA/Yae/vB4dp0
         ZXU8mNgP5nJOrpi1I/8+2rw0v+x8nIRrpIU85z2wyKsZQe85fvw3UmoARGmnVrpV8lxt
         Cr9kZCJ/t5ixVwpNVBWgu2l3pypZxMzY+dthBybee6FJRDjgjlXg/+Ip0Eb3WShReaaz
         uMNg==
X-Gm-Message-State: APjAAAXCnD4P3y5HMbC6MWF87tQoRj4TilN10HvNkZ0A4XU1oX5Aw8cI
        8vOKATHJeC3ddXLooH3iJUl66QWpiUHbtXKVqo1QTcxiUG4+uA62jRX5xjVB+9/9NPFqY+VLX+h
        S/5vdVUMMi8k8X6U5bzX/wbZn
X-Received: by 2002:ad4:5429:: with SMTP id g9mr27393796qvt.27.1572963044143;
        Tue, 05 Nov 2019 06:10:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqy1npPyoVI9zfJ5zk1Fy2jsPQm2jMlmyo4VKa5iOAaByDykcti/ZzqcXUIXanZpwy5kmu5/jw==
X-Received: by 2002:ad4:5429:: with SMTP id g9mr27393757qvt.27.1572963043824;
        Tue, 05 Nov 2019 06:10:43 -0800 (PST)
Received: from [192.168.1.4] (135-23-175-75.cpe.pppoe.ca. [135.23.175.75])
        by smtp.gmail.com with ESMTPSA id v54sm10010040qtc.77.2019.11.05.06.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 06:10:43 -0800 (PST)
Subject: Re: [RFC v2 PATCH] futex: extend set_robust_list to allow 2 locking
 ABIs at the same time.
To:     Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>
Cc:     Shawn Landden <shawn@git.icu>, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Keith Packard <keithp@keithp.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20191104002909.25783-1-shawn@git.icu>
 <87woceslfs.fsf@oldenburg2.str.redhat.com>
 <alpine.DEB.2.21.1911051053470.17054@nanos.tec.linutronix.de>
 <87sgn2skm6.fsf@oldenburg2.str.redhat.com>
 <alpine.DEB.2.21.1911051253430.17054@nanos.tec.linutronix.de>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <f11d82f1-1e81-e344-3ad2-76e4cb488a3d@redhat.com>
Date:   Tue, 5 Nov 2019 09:10:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911051253430.17054@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/19 6:56 AM, Thomas Gleixner wrote:
> On Tue, 5 Nov 2019, Florian Weimer wrote:
>> * Thomas Gleixner:
>>> On Tue, 5 Nov 2019, Florian Weimer wrote:
>>>> * Shawn Landden:
>>>>> If this new ABI is used, then bit 1 of the *next pointer of the
>>>>> user-space robust_list indicates that the futex_offset2 value should
>>>>> be used in place of the existing futex_offset.
>>>>
>>>> The futex interface currently has some races which can only be fixed by
>>>> API changes.  I'm concerned that we sacrifice the last bit for some
>>>> rather obscure feature.  What if we need that bit for fixing the
>>>> correctness issues?
>>>
>>> That current approach is going nowhere and if we change the ABI ever then
>>> this needs to happen with all *libc folks involved and agreeing.
>>>
>>> Out of curiosity, what's the race issue vs. robust list which you are
>>> trying to solve?
>>
>> Sadly I'm not trying to solve them.  Here's one of the issues:
>>
>>   <https://sourceware.org/bugzilla/show_bug.cgi?id=14485>
> 
> That one seems more a life time problem, i.e. the mutex is destroyed,
> memory freed and map address reused while another thread was not yet out of
> the mutex_unlock() call. Nasty.

It is difficult to fix.

The other issue is this:

"Robust mutexes do not take ROBUST_LIST_LIMIT into account"
https://sourceware.org/bugzilla/show_bug.cgi?id=19089

-- 
Cheers,
Carlos.
