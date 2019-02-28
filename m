Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133B8C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C8F218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1IPKi3Le"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfB1VJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:09:23 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:56293 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbfB1VJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 16:09:23 -0500
Received: by mail-it1-f193.google.com with SMTP id z131so16907267itf.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 13:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OIt7kYvScC96C0scNE9LZkWMweIM8jE2ceiyHg5PAeE=;
        b=1IPKi3LeK9fBVfEN6GC45STvIHl+8KOiWvOry9ghREWe8WRrwKkzuRmv5UpC+gBw4T
         oWuVd/aifBGLcCiwSREwpia4DCLezsFJi/4auoOhRY8LA8+X4TwlH+Dq/6wNsmkIgvlO
         pO8bk9AXyIdPHG+OHJ5aFEX2z8017LSIcsrk4GCzm5c1lKa+Jh/QhHayd02YpZ6wo+K9
         /jxu3p/2XfQ1HAvVkd8I7zArasW2M5us6Y/SRXecU2YKjNcUebuYvBVGB4Apq4kxF1mr
         wHRutFNjHF3VPdTzp/siqanvPq8omEHt1+9mu8IwWQVEEglEVnr0EkGfGObbC79P8D3c
         nNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OIt7kYvScC96C0scNE9LZkWMweIM8jE2ceiyHg5PAeE=;
        b=cX+u7wl+7VUX58fTbokFBr+UByAdHzersEQ+VMjIc0ubbOdopNQmWV2Pa6zsWz50ey
         +cNVQCngduZW94rovm5qQbEdrI2xtGXGYJLScTBgPxbfLDVxd2hMUkobVWqYFteE+QBB
         uqNWK5/qGMBWV4PaLqKtrnFQ8QQz4nkT2x1NTXc532nzYzzUg+gGtjeiqET4DW0FfkAA
         R72qt7Lef0Pw9EZeqZygi1yeK1s34mJ/ISBByUB0Z8gthucTf855uHcA/DPwgxg7d9wh
         BthRCjqk84I1dvaZAzdN0ehMLmGoQM0SKbRpHCz3W+3UhZvDy4OGVdKXpa0MumeBr//l
         H+/g==
X-Gm-Message-State: APjAAAVLOoy8rxYuBOo3kM3wmQFYyeOIxGiWRwhYzhQoCS9kjvLIIPlJ
        XiyKYGlUhti1snFpZpdYBikIbIfXK7PYMw==
X-Google-Smtp-Source: AHgI3IYRZGTvRgdGEIgb3WRMAhRgNiMoNsuqlM53xOuQxm9kTmY22VFlc8k722iMyFU7d42SDlxcbQ==
X-Received: by 2002:a24:7690:: with SMTP id z138mr1197499itb.119.1551388161904;
        Thu, 28 Feb 2019 13:09:21 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 24sm7566187iog.25.2019.02.28.13.09.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 13:09:20 -0800 (PST)
Subject: Re: [PATCH] block: Replace function name in string with __func__
To:     iamkeyur96@gmail.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190217152156.14438-1-iamkeyur96@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1bfc6477-5c82-1999-c022-d8e8e10be1ef@kernel.dk>
Date:   Thu, 28 Feb 2019 14:09:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190217152156.14438-1-iamkeyur96@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/19 8:21 AM, iamkeyur96@gmail.com wrote:
> From: Keyur Patel <iamkeyur96@gmail.com>
> 
> Replace hard coded function name register_blkdev with __func__, to
> improve robustness and to conform to the Linux kernel coding
> style. Issue found using checkpatch.

Applied, thanks.

-- 
Jens Axboe

