Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA50BC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 06:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB80C20863
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 06:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="IXCdsXIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfFYGfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 02:35:11 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38099 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfFYGfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 02:35:11 -0400
Received: by mail-lf1-f66.google.com with SMTP id b11so11796312lfa.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 23:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=utV8ZhP3NyDwE/ppybdMg9/ZYt1ddSXYb4H1u9/9AeQ=;
        b=IXCdsXIuDA7PVMIKffFP9i14drrJdcR/x5HRTIluH4ZR7/S1iJi1nCKTq2mJ5wsQfC
         r3WPWPY+U7IGfgBnrCRERqNJZxxExJ7P9gmbxTTVIUGbfVFuZD5GUA5/IpnaCL4lVN/N
         QdmlT8U9DpwOE+WttPGQssQpj8JaMdUkowmPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=utV8ZhP3NyDwE/ppybdMg9/ZYt1ddSXYb4H1u9/9AeQ=;
        b=qSCMRQ7Cd7O3HdzvD6h5QKbAQ4nO7vl9ovkScqITECeSxmRK+euH+EpPNqDRNyIue3
         bxk9Woj4cM9GHqVJCxXrV4Je6FRmltnSDFtHgtWnBz6SczwIMeNdiSZs1FHuapLpslnM
         Qu3C1yScuDrAY6l+FnaA+Q5a6irqnxMS1SvrBJiE6AMIngFz2oyauNvq2iTfGgbNPREq
         WRPBw75XiIxdeB6Go1hklsnVpZlpLN3L6/pbIm5WcozV/CerWjhEkdl+RAIxl2EacS3J
         OsBs8tUq0Ho7vkf8NbTFisjk/sxBxC+az1B77eINsB4Z71+8bdwPrvOaH8IK7FjL6Tky
         BJyw==
X-Gm-Message-State: APjAAAWI3tLpLyreju9yXBwq26b/lF9ptoVa3XC8rcrYuygpCkqjBnGV
        KyZp0g/p98enH0UFLycV+PDL6r1pMLY8PsPL
X-Google-Smtp-Source: APXvYqyskyofo3t3dks0vsjiT/+oJFZzQQA0PzB3KqpfusckyB5Crdy52w55D668gYO0RY7DXZX2Iw==
X-Received: by 2002:a19:488e:: with SMTP id v136mr9212549lfa.192.1561444508612;
        Mon, 24 Jun 2019 23:35:08 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id i5sm1827416lfo.55.2019.06.24.23.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 23:35:07 -0700 (PDT)
Subject: Re: [PATCH v6 7/8] dynamic_debug: add asm-generic implementation for
 DYNAMIC_DEBUG_RELATIVE_POINTERS
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190617222034.10799-1-linux@rasmusvillemoes.dk>
 <20190617222034.10799-8-linux@rasmusvillemoes.dk>
 <CAKwvOdn5fhCTqtciKBwAj3vYQMhi06annzxcdC1GjKxri=dHnw@mail.gmail.com>
 <12bd1adc-2258-ad5d-f6c9-079fdf0821b8@rasmusvillemoes.dk>
 <CAKwvOdkqy8=V17qEM_SMDEAh=UX5Y2-nj9EUkC169nEiXc_JzA@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <70aa7b96-e19d-5f8b-1ff6-af15715623e5@rasmusvillemoes.dk>
Date:   Tue, 25 Jun 2019 08:35:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdkqy8=V17qEM_SMDEAh=UX5Y2-nj9EUkC169nEiXc_JzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/2019 23.53, Nick Desaulniers wrote:
> On Thu, Jun 20, 2019 at 1:46 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> I've pushed them to https://github.com/Villemoes/linux/tree/dyndebug_v6
>> . They rebase pretty cleanly to just about anything you might prefer
>> testing on. Enabling it for arm64 or ppc64 is a trivial two-liner
>> similar to the x86 patch (and similar to the previous patches for those
>> arches). Thanks for volunteering to test this :)
> 
> Compile tested x86_64 allyesconfig
> boot tested x86_64 defconfig+CONFIG_DYNAMIC_DEBUG
> 
> (just curious why the Kconfig changes for arm64 or ppc64 aren't
> included in this set?)

Partly because I can't boot test those and this has proven much more
delicate than I thought, partly because none of the maintainers for
those arches have weighed in. So I'd rather have the bare minimal land,
then send specific individual patches for arm64 and ppc64.

>>> Anything I should test at runtime besides a boot
>>> test?
>>
>> Well, apart from booting, I've mostly just tested that the debugfs
>> control file is identical before and after enabling relative pointers,
> 
> mainline x86_64 defconfig+CONFIG_DYNAMIC_DEBUG
> $ cat /dfs/dynamic_debug/control  | wc -l
> 2488
> 
> 
> mainline x86_64 defconfig+CONFIG_DYNAMIC_DEBUG+this patch series
> $ cat /dfs/dynamic_debug/control  | wc -l
> 2486
> 
> (seems like maybe 2 are missing?  Let me try to collect a diff. Maybe
> 2 were removed in this series?)

Hm, no pr_debugs should have been added or removed. Perhaps you have a
slightly different set of modules loaded? Otherwise there's something
odd going on, and a diff would be really nice. It's possible that the
order of the lines are different, so you may have to sort them to get a
meaningful diff. (A diff is nice extra sanity check even if the line
count matches, of course).

>> and that enabling/disabling various pr_debug()s by writing to the
>> control file takes effect. I should only be changing the format for
> 
> Can you suggest one that's easy to test?

The ones in lib/kobject.c are triggered fairly often I think.

Thanks,
Rasmus
