Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EEFCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC0121872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="PjQQPBto"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389642AbfJWS26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 14:28:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42107 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732810AbfJWS26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 14:28:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id r1so13389122wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 11:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FO1icP7++q1qCn8suzxihC3IELICMjjLnmnWE+fJqmU=;
        b=PjQQPBtoQxQl3GPqZTshvbiyW+woEGHqnpsjbQSUWAblEvf29P89Bxmv/GSr1kvoDV
         EiW+Z/zlBJdIKMgLHU5NBSTRv47eJCD7Usr+/jeSECvNmSCGvsg/wN3XWY6rbgw8POQ8
         HeWA09el0iZ8oBuDcwlA+c0hDypKGn3En2Nd6lVMEkGtidiW3iSKWwr0+7vHwakibLzW
         iM80EEeY7JrznpMdkIa7HZ6/4wP/PXOAP0Q/YJZyTXm+Y3rC2UZ7fshmBB4FQSFrcS8P
         vt80J80X2Mpw8g8w8XiYO8EkvJL8KBKqInhlucaeA941kzobper8AfmkAfAd3S6bl1p9
         Murw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FO1icP7++q1qCn8suzxihC3IELICMjjLnmnWE+fJqmU=;
        b=aae86ZKHnSICD/EeWw8SaxJ8XYLyQ3LNc2FaFsX5ua+j0PhTqUR6uRxYwYrWPNLckp
         fjD+hcUXFxFhT4mdXXuL5g9L4ko5LQmidD1yEoyQM0gNjgxh3xQgj2bNw6BRW4vgDu7Q
         TFINTFA4hQ/HeAAMt2dvkywf2NVkYNvqtgDbJm56VRmeeKeQmf4xVqPWRi+IT/Gz2zOq
         Gmj4z9B5nIZjpTJONgtZMYUgUv2jaDCU+pkZQZPSRspzVu5xijJ7GFI5ocDhltOJn/k+
         5k6cvzLjC0ODIqm/IwqB1A3LZozIeWqUuHNYx9raadvig/mAmGHmG0pRsnhNgDjuNdtw
         HnGQ==
X-Gm-Message-State: APjAAAURyzOsz+WyqE20wwF8rTgqOzqJvKUjYnkD6upi7OnJrdAmdguQ
        YQLmVAg1aKXnhaji5aKOpxvUWg==
X-Google-Smtp-Source: APXvYqwM/fNEQgVnYS6gVjEpLMpLYRZ1Tij0RXOubxkQe0HyV3h6C/7J9q7RIQ4qUoG9wD9Rn0Pl5w==
X-Received: by 2002:adf:c448:: with SMTP id a8mr92192wrg.233.1571855334570;
        Wed, 23 Oct 2019 11:28:54 -0700 (PDT)
Received: from linux.fritz.box (p200300D9970483001CF3BB0BE954CA02.dip0.t-ipconnect.de. [2003:d9:9704:8300:1cf3:bb0b:e954:ca02])
        by smtp.googlemail.com with ESMTPSA id r3sm38070268wre.29.2019.10.23.11.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 11:28:53 -0700 (PDT)
Subject: Re: [ipc/sem.c] 6394de3b86:
 BUG:kernel_NULL_pointer_dereference,address
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>, 1vier1@web.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, lkp@lists.01.org,
        ltp@lists.linux.it
References: <20191021083514.GE9296@shao2-debian>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <d49d1940-a704-d79e-b44f-79db9f096d5c@colorfullife.com>
Date:   Wed, 23 Oct 2019 20:28:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191021083514.GE9296@shao2-debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 10/21/19 10:35 AM, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
>
> commit: 6394de3b868537a90dd9128607192b0e97109f6b ("[PATCH 4/5] ipc/sem.c: Document and update memory barriers")
> url: https://github.com/0day-ci/linux/commits/Manfred-Spraul/wake_q-Cleanup-Documentation-update/20191014-055627

Yes, known issue:

> @@ -2148,9 +2176,11 @@ static long do_semtimedop(int semid, struct 
> sembuf __user *tsops,
>         }
>
>         do {
> -               WRITE_ONCE(queue.status, -EINTR);
> +               /* memory ordering ensured by the lock in sem_lock() */
> +               queue.status = EINTR;
>                 queue.sleeper = current;
>
> +               /* memory ordering is ensured by the lock in sem_lock() */
>                 __set_current_state(TASK_INTERRUPTIBLE);
>                 sem_unlock(sma, locknum);
>                 rcu_read_unlock();
It must be "-EINTR", not "EINTR".

If there is a timeout or a spurious wakeup, then the do_semtimedop() 
returns to user space without unlinking everything properly.

I was able to reproduce the issue: V1 of the series ends up with the 
shown error.

V3 as now merged doesn't fail.

--

     Manfred


