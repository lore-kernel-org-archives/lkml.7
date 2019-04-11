Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214AAC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED7E2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555006541;
	bh=CYpuz4kSFGt3ReVvAdShqeumca74RVzqor2qC337P/w=;
	h=From:Subject:To:Cc:References:Date:In-Reply-To:List-ID:From;
	b=Z8imuSKOImKHWU65tSfWX74kBI5oyZlSz6A/0qDPgUlInERhFUAU64X2FCkNJ/PCH
	 zwk4VnAM77My6k0siFYCyavkCLILTTaCsKebKqJbYx5o9ULOQaeIsIYPp4RezQzss+
	 vDd8B3Nn0ZYWAfuhQlgT2y1upmNJ3XPPkZyjl7KI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfDKSPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:15:39 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33414 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfDKSPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:15:39 -0400
Received: by mail-qt1-f193.google.com with SMTP id k14so8289841qtb.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 11:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TVgurs4GiZUYMCyRAOgHBG6ClH9hAVLK6w8uzS9DNis=;
        b=GEc2j/2xhzfpicBPi6SMEwiPnM45uwzCZqrp+AOKZ7AMieV+rFT5hinylJbaZFZOb8
         h9rCaGy4khD2r/4TbZ3vLJya5tY+hW6mxg8dYwyG+7ZRtk3LxaSyofZkXdguuTQlD793
         nj+yPRtAJc3RdSHLWh4i2cmw/jQHZEqHXhFEKyRZfwQ/kyAWPLkcWI4fJjIrrmOpelXF
         Cj0Wa6LvgfBM6Yg1ccXg09utXzNrqBAVgVf1yJJC34DyCW+vSAq6qvgEas9rPqkgS5X6
         FKVqULURWjRl8z9cnHDo9kkG+rqLPZ8zoZLLMJ/r71PawPghB/vW3QLNtcHNuij0acVb
         sEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TVgurs4GiZUYMCyRAOgHBG6ClH9hAVLK6w8uzS9DNis=;
        b=PL5ZK3bgx6aV01z2Cu6lbCA0erPUAT27LqGXjrm5Ct/tIEfDbGdSk6h2R97ZTB/Um/
         g8xx6nkSohj8U/pdjjmbu6DF0ElmZ+LSuhFWvwFkHmR+ANNwuEivu+S847Y5DYBoWHmd
         PU/NKmIoLwlUdLcDuIwoKPdiTI/vQOCYdG7GtkFo3LWy41ACUXB9KofPP0nxHKOWCvzs
         AjhChIRX9k4bgFuuwy4TqVGnsumiUlaBf5XFjcNp+0ofR+a3D8veSs3V1+nTHM46pLtW
         5GRm6n+gUWFhmrZ/rNnA4hmSXXASFmCL52S/l2F3LmMGaEbrTKCPX7jB3uHPMG+Xp4CR
         /DgQ==
X-Gm-Message-State: APjAAAWZv0pXe3ngtf3k0lTF2G7tWIIh/d2adwQevNHzQ737A1MuYL2G
        42JQfZcGZVZBegaerPcb5NM=
X-Google-Smtp-Source: APXvYqzv1rCPsXgrZWzmBNIPeGDVdFr+SIcu6khPUQQ/uF4OUThORkd6rdqfcP4l4a1aKNmfpWmjDQ==
X-Received: by 2002:ac8:2246:: with SMTP id p6mr42032186qtp.225.1555006538066;
        Thu, 11 Apr 2019 11:15:38 -0700 (PDT)
Received: from [10.84.150.23] ([167.220.149.23])
        by smtp.gmail.com with ESMTPSA id v58sm25999568qtv.66.2019.04.11.11.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 11:15:37 -0700 (PDT)
From:   Sinan Kaya <Okaya@kernel.org>
X-Google-Original-From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v3] init: Do not select DEBUG_KERNEL by default
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Changbin Du <changbin.du@intel.com>
References: <20190411005634.8495-1-okaya@kernel.org>
 <CAK7LNAS=G7-nXr=pT2EYExGNkCcOcd2NH1haaBMt+JsyhX2Z8Q@mail.gmail.com>
 <c8babeca-2d24-4265-0477-0634d87efa70@kernel.org>
 <CAK7LNARB54R5OfADaxzO=Mu8LucCd7wPVS4Yys8cfCKUpYc6Cg@mail.gmail.com>
Message-ID: <ac79dcfc-50cc-01d4-758c-8c0881ab0d2e@kernel.org>
Date:   Thu, 11 Apr 2019 14:15:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNARB54R5OfADaxzO=Mu8LucCd7wPVS4Yys8cfCKUpYc6Cg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/2019 1:48 AM, Masahiro Yamada wrote:
>> I was going by what Kconfig tells me
>>
>> Symbol: KALLSYMS_ALL [=n]
>>    Depends on: DEBUG_KERNEL [=n] && KALLSYMS [=y]
> Lots of features have 'depends on DEBUG_KERNEL'.
> What is special about KALLSYMS_ALL here?

I had to do some learning about KALLSYSM_ALL. Based on my limited
searching, KALLSYMS_ALL allows you to locate the symbol location
at runtime from the kernel.

Without KALLSYM_ALL, you can only locate the kernel code only. With
KALLSYMS_ALL, you can locate the symbols for any data structure
including kernel modules.

I'm not a KALLSYMS person but based on my search, I'd consider
KALLSYMS_ALL a debug feature as it is today.

kernel/kallsyms.c:              else if (IS_ENABLED(CONFIG_KALLSYMS_ALL))
kernel/livepatch/Kconfig:       depends on KALLSYMS_ALL
kernel/module.c:#ifdef CONFIG_KALLSYMS_ALL
kernel/module.c:#ifndef CONFIG_KALLSYMS_ALL

lib/Kconfig.debug:      select KALLSYMS_ALL
     config LOCKDEP
             bool
             depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
             select KALLSYMS
             select KALLSYMS_ALL

lib/Kconfig.debug:      select KALLSYMS_ALL
     config LATENCYTOP
             bool "Latency measuring infrastructure"
             select KALLSYMS
             select KALLSYMS_ALL

scripts/link-vmlinux.sh:        if [ -n "${CONFIG_KALLSYMS_ALL}" ]; then

