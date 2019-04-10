Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81409C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E44C20820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXMzXKbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbfDJNh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:37:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36052 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732017AbfDJNhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:37:25 -0400
Received: by mail-pf1-f194.google.com with SMTP id z5so1514322pfn.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 06:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d2lj74hykPj00NZMz0Gb8iI/0M9PN6OvJ8AkEB2eG0s=;
        b=fXMzXKbtAbiRmnGWSTr4tQnlmnjhdweLKfJ9VkT+065ZkiU3vbsE9LITV9HPFHOTfQ
         W8SCj/GoJT7UeiXLXOdoKUxMSJTF+MglMS8CdxRMsK+nUNoF5ML5AsJB4Oqy/kerY7pF
         Ijtdfn5cs2gZIk4MgRxVFlShy2Rm4vYEglO4raSWzcE2j3MHD0iA+Mez2wnRC/btzCy3
         BQGAyGCKxLRw2oQexiKkspLCbIQo4XMm0m1Vi7LyBESlPxiLTm6l6VOG17pxzQnkvgGL
         9AqV2iL+XTCuF8g258CDpE7YGpZ7F6FMhOEep5+RIRUxvMY/UIQukla75o2gS0f7HAvQ
         nvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d2lj74hykPj00NZMz0Gb8iI/0M9PN6OvJ8AkEB2eG0s=;
        b=lGJLlCRnRQq6x9FSqtI+Q5x1Wx0ppWKFzptb6SF/k+N3dxf17in8SJBLulsk2d436P
         Cp/3l7JmgE0Z0+ZKMmdmuSWWQi1yQagvTUpacvJMEEEyRzWhqNtTv4CkpEVrSEF6/LyK
         S8F3fQQQzJrsovkDv4DV/vHeZu4538IvUSwHptuJJWp71NZua4mjx3nwX9LW9GO1zTgU
         eb42F5tVvcyfXzrtMQFjf7QaNvpF+6C6RgG7SjGKtfnGdrm4UFZGX4AOYOgOIhSd2pO7
         pldoU+mo/4Z9irLn7w62Yjb2xDkABKNKEHSDtTsUhXkIMZDJdCOaBPQZd9qpx7c/3YC6
         CV2A==
X-Gm-Message-State: APjAAAWeEeyV9YVuD6l4716lCNpoRt/D8i9mNQOEdp4MU2zsE8RQzkKz
        ZYSAN+VrTadYABqtdfImUAjBlwVl
X-Google-Smtp-Source: APXvYqwMLqGNEC2bnURSEFc0Ity1BJaWi/fLEmF7ybV7JiU48WfmO/chgaEvVjicIuqePlP29L+UxQ==
X-Received: by 2002:a62:47d0:: with SMTP id p77mr43492338pfi.95.1554903444612;
        Wed, 10 Apr 2019 06:37:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c3sm50109465pfo.2.2019.04.10.06.37.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 06:37:23 -0700 (PDT)
Subject: Re: [PATCH 23/23] watchdog: tangox_wdt: Convert to use device managed
 functions and other improvements
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mans Rullgard <mans@mansr.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <1554830641-9247-1-git-send-email-linux@roeck-us.net>
 <1554830641-9247-24-git-send-email-linux@roeck-us.net>
 <6ebee4d6-c650-c322-a966-4269d54da9be@free.fr>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c875ddd9-13f4-c6d4-4537-21b80000b9b5@roeck-us.net>
Date:   Wed, 10 Apr 2019 06:37:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6ebee4d6-c650-c322-a966-4269d54da9be@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 6:04 AM, Marc Gonzalez wrote:
> On 09/04/2019 19:24, Guenter Roeck wrote:
> 
>> Use device managed functions to simplify error handling, reduce
>> source code size, improve readability, and reduce the likelyhood of bugs.
>> Other improvements as listed below.
>>
>> The conversion was done automatically with coccinelle using the
>> following semantic patches. The semantic patches and the scripts
>> used to generate this commit log are available at
>> https://github.com/groeck/coccinelle-patches
>>
>> - Drop assignments to otherwise unused variables
>> - Drop unnecessary braces around conditional return statements
>> - Drop empty remove function
>> - Use devm_add_action_or_reset() for calls to clk_disable_unprepare
>> - Replace stop on remove with call to watchdog_stop_on_unregister()
>> - Use devm_watchdog_register_driver() to register watchdog device
> 
> No devm_clk_prepare() in mainline? :-(
> 
> https://lore.kernel.org/patchwork/patch/755487/
> 

We went through that several times and never succeeded. This was the major
reason why I didn't submit this series earlier since I was hoping for it
to appear at some point. Unfortunately, someone always objected, typically
with comments along the line that it could be misused, or citing individual
examples where the current code in some driver is wrong and should be fixed
instead.

This isn't really a technical argument: Everything can be misused, and all
code has bugs. Neither is a reason to reject a new useful API. As such, one
has to assume that after refuting such arguments, and even after fixing all
bugs in existing code, the opponents of the new API will come up with other
reasons to reject it.

At the end, I gave up trying. Feel free to try yourself; I most definitely
won't try it anymore. Using devm_add_action_or_reset() is a bit more clumsy,
but works just as well.

Guenter
