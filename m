Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65413C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4322073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="I5QEypMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLJUrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:47:45 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46027 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfLJUro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:47:44 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so17609384qkl.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 12:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=brfDeAvapVs1IWQAYvqzmBX7BVOnnV+rFYp3VtF2OSA=;
        b=I5QEypMiWNt3ukq/J3p83EeOyM1WrwFB6VFJj6VsPiz4PgM+VdvTJA6SgsjrzlJ1Yq
         JgFZT4iDSRXBKeSckqvePdZzu4QUiYtiKckF4bT2pzjrjk7gn6RqTXONfM1pN211RrXJ
         J4MjdhgEuEylmBSl3VUWNNZWyT152HhqsfEBylDYc7qJk2Fo27BmgPHtT4OS1A9P1Fyv
         l+Mr6EtqGhNAAitsTlgnZ83NzVhV7WHDSTWmlAQ4Pjt0b73Tz92q5t3t+db52qXM++aO
         oCg0ZnqEXDvkwomCM47pV4+pn9SK4Ak0JY8R6xM6kedPVicXd1e6E2q0CoHm48ONVegf
         iriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=brfDeAvapVs1IWQAYvqzmBX7BVOnnV+rFYp3VtF2OSA=;
        b=JecLq7HUuqB3KuRXf12fRxJlKnFHoO75Hgw/hBLwwSs5yA2zip5n3BuQGoMLvM2ffG
         saZNQvI0dSwa5KyySJKSFwPZeKZbWTMRF6WHB8Z/w64l0kRjXumivhZj8g1CXGpcH+Vj
         g3SX48zB3L1Bp1C6NSP7P0bVLjaxB6PPbtdZiQ877lIzl7YSbUjSBxCCVs6pEFANqhm/
         9OQgMY6Y4vsS2jVO8kFUkbY4kz1k13jMwECbiDebcdZOM5Px1bPMomONLquqzqaJ71ag
         fleMeG7gVCll91xJIUFxtwykGvsuVywLxNyI0dnbO2EMOZytN/I8gXugM6hmxDUfIrt+
         ce0w==
X-Gm-Message-State: APjAAAXmjvYG7sBa0EBKMbLtcdw11sHJXVaCa46ArkSalnJOeTTWNGVx
        pEGzv4pV5AcYnm0NL28U4rMhM0KnvTIHPg==
X-Google-Smtp-Source: APXvYqwuOeJY4G/7Ncu0F/iN/4LvvesywqyI7RFGsixjVMyTieOnTgWzsky/fnnkJV85WxRfXcfmXg==
X-Received: by 2002:ae9:f003:: with SMTP id l3mr3880877qkg.457.1576010863399;
        Tue, 10 Dec 2019 12:47:43 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h32sm346951qth.2.2019.12.10.12.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 12:47:42 -0800 (PST)
Subject: Re: [PATCH] btrfs: fix format string warning
To:     Arnd Bergmann <arnd@arndb.de>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191210204429.3383471-1-arnd@arndb.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <215ae20f-7528-6866-bddd-65ef3f73abe1@toxicpanda.com>
Date:   Tue, 10 Dec 2019 15:47:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191210204429.3383471-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/19 3:44 PM, Arnd Bergmann wrote:
> To print a size_t, the format string modifier %z should be used instead
> of %l:
> 
> fs/btrfs/tree-checker.c: In function 'check_extent_data_item':
> fs/btrfs/tree-checker.c:230:43: error: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'unsigned int' [-Werror=format=]
>       "invalid item size, have %u expect [%lu, %u)",
>                                           ~~^
>                                           %u
> 
> Fixes: 153a6d299956 ("btrfs: tree-checker: Check item size before reading file extent type")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
