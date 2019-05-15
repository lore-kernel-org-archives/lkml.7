Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB2EC04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 01:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9A52084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 01:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWFDE4os"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfEOBFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 21:05:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41722 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfEOBFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 21:05:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id f12so438025plt.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 18:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OigDY7C0dmgiXTDGvrusCma83AIE7G7GBT96nHD0zbM=;
        b=GWFDE4osS2bEzj1o7ShUnbslcK1xslARZnhZzfRZh7jSVI7phnABFz9jFlBejziQS6
         o1ObcqmOoNtPB3LuKJuSHwFsxPuab+LpwhgRN7oU/aw+v6NJo9YAIkc7K5OZfF1tA8KF
         BqcVnYQ8aBHxMSgTTQ0w+v9aGmWe05ZSVmocLTL33t5UfrDnmZulDE8cz6LY3qcldYQ1
         GuaCxx6A//0qbApOxaeRSTE93tA7qlxxVwEqYUKP0xlwEtecAi2BXe003LwZl2iZZNia
         rjckM/fvGbwjONwU7S2s3XlGSUzim51CRjyIN/6jdXPZaYJBBluwscH3pxhM1aaYX8+m
         i2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OigDY7C0dmgiXTDGvrusCma83AIE7G7GBT96nHD0zbM=;
        b=N9UkHROmlKVuk/RmGascCifsbsDMpcZ8zYoZKB86P1ELAik932jH22M+Pl9slLL1uN
         XSaooL+kaGUy7OGbO+23ELEUr7ju0FNUeQXPrUL9rda/12zTsY70gmmq9mnLo/e1nat0
         lvv8GIHRxyRX+cG+9Qp+vvvpWyAQZDUFepgmc65n7vU9vzP/LO1EInY4sKkzQrLxUhUA
         jj00nYdDg87WrJifqZ5VktH5t2swkM0sRxoBxH2QTfKEZIR+sz+qUyX8yZKUAWZSp/CX
         TOj4hk/V6ByGGe7YpeUbRvg2fLtSck4uJVRqKJd/fv1MThFIPmdhN1NBC2dOJHEbgBNu
         GlFg==
X-Gm-Message-State: APjAAAUAbt+lAm7jouGM/zYKAttw44rnWB6uMdtmijhSun2q5dKngN3Z
        pvmPTED9llpRePxJr8MKuhD8UZQo
X-Google-Smtp-Source: APXvYqzyXdx1JAKc9EQBG8NQoamrnNm65978YnQJMX+DqpSV+jegTFpztDsoZNa4XUv/kmajV5xtmA==
X-Received: by 2002:a17:902:5e1:: with SMTP id f88mr39973784plf.226.1557882332614;
        Tue, 14 May 2019 18:05:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r64sm450148pfa.25.2019.05.14.18.05.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 18:05:31 -0700 (PDT)
Subject: Re: [PATCH] drm/pl111: Initialize clock spinlock early
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1557758781-23586-1-git-send-email-linux@roeck-us.net>
 <CACRpkdb6EEchXBSnO5SckGq7MY0z26Fq-=y+uJR=2_SCMC0q+Q@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <9d4fde45-be92-f2e2-0571-f2316d036853@roeck-us.net>
Date:   Tue, 14 May 2019 18:05:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdb6EEchXBSnO5SckGq7MY0z26Fq-=y+uJR=2_SCMC0q+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/19 3:20 PM, Linus Walleij wrote:
> On Mon, May 13, 2019 at 4:46 PM Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> The following warning is seen on systems with broken clock divider.
>>
>> INFO: trying to register non-static key.
>> the code is fine but needs lockdep annotation.
>> turning off the locking correctness validator.
>> CPU: 0 PID: 1 Comm: swapper Not tainted 5.1.0-09698-g1fb3b52 #1
>> Hardware name: ARM Integrator/CP (Device Tree)
>> [<c0011be8>] (unwind_backtrace) from [<c000ebb8>] (show_stack+0x10/0x18)
>> [<c000ebb8>] (show_stack) from [<c07d3fd0>] (dump_stack+0x18/0x24)
>> [<c07d3fd0>] (dump_stack) from [<c0060d48>] (register_lock_class+0x674/0x6f8)
>> [<c0060d48>] (register_lock_class) from [<c005de2c>]
>>          (__lock_acquire+0x68/0x2128)
>> [<c005de2c>] (__lock_acquire) from [<c0060408>] (lock_acquire+0x110/0x21c)
>> [<c0060408>] (lock_acquire) from [<c07f755c>] (_raw_spin_lock+0x34/0x48)
>> [<c07f755c>] (_raw_spin_lock) from [<c0536c8c>]
>>          (pl111_display_enable+0xf8/0x5fc)
>> [<c0536c8c>] (pl111_display_enable) from [<c0502f54>]
>>          (drm_atomic_helper_commit_modeset_enables+0x1ec/0x244)
>>
>> Since commit eedd6033b4c8 ("drm/pl111: Support variants with broken clock
>> divider"), the spinlock is not initialized if the clock divider is broken.
>> Initialize it earlier to fix the problem.
>>
>> Fixes: eedd6033b4c8 ("drm/pl111: Support variants with broken clock divider")
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Applied to drm-misc-next-fixes and pushed.
> 
> Out of curiosity: do you have a "real" Integrator/CP or is this
> QEMU?
> 

This is with qemu.

Guenter
