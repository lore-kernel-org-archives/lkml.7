Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB694C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFCE224676
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GehBVaBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgAGVBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:01:11 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38004 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbgAGVA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:00:58 -0500
Received: by mail-io1-f68.google.com with SMTP id v3so839108ioj.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 13:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TUCMvAlrozTSswUZRaX/kk/b3mxYfUe4t6CXtrf2o+s=;
        b=GehBVaBAx2yLw8xmK6L9yXpZmniP/2JyAJ3/e8p9FE6da8ZcO/BGm8rhirJ906imzR
         MyMS2cxd096Pcka3v1dxK5QOY76n81+jkNNzm92Fu1BLm12o33wIh8PuqUyvqB5JgEAT
         kg2l9mn1owXVwnaEwiAe9SxaV14zDbe3aXQoIoZMkigADe2qBr1ShfEmJPt4DmnIkFdM
         Nl7O3XfkSkhCda0b1Hkp1OlbetxllC5f4OMGIaWe96kCUf2NJ3z2UgdQ3Uskep4pyBmT
         i7Kg9HyftPWed+j0nbeSEVmQxWqgcolE4dTvs6xIG2mvTDxwga0AhX4w/wDYcgT/lrhn
         TfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TUCMvAlrozTSswUZRaX/kk/b3mxYfUe4t6CXtrf2o+s=;
        b=mOR2aKMVVgVDNg44QqBzBXKZMwS9IlOhgSta+NdoWY3Jsl6rpZ6wI2OAx9Vc8A5rLS
         KYubTzwgoTjCClQRva3snUd58joBKrA4J2OhOBo9Xsnr65WFrI4XTgOuTVffVtmsKWAh
         LEIvPcVH2Ns/TJ1Cl068B5/VNOaM87aQsrk+3sXBT8AA+VE62TwgsmPFm9mRuLLCIJVA
         5wY7fz7td1m6vGZbNhfiD39w+uABfnIlVwtk9UJ2uza0elrANx1OSJmW5p0VcXJ5ta1E
         kJJiOu1sQ5If4Aexw7zzTs9AEPoVIPKr9+cEfiJL6rk2aZsmlu839Ww+Ja6cjfm7TQRt
         SdLg==
X-Gm-Message-State: APjAAAUg7wdLT1ATde704mU+SNuahY1IFUgOzPS1/3ZHaZ5dDeof+T6J
        wfUaumrBT60u/BC6g1TQmZHTyg==
X-Google-Smtp-Source: APXvYqzgUwxMWRW1F7AdWKU490fmEMlII4xM/XzIv7jxVALemJiPaRzlelnhtwr2Yi1XbXw+xwNUuw==
X-Received: by 2002:a6b:7f47:: with SMTP id m7mr789897ioq.82.1578430857516;
        Tue, 07 Jan 2020 13:00:57 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g62sm230208ile.39.2020.01.07.13.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 13:00:57 -0800 (PST)
Subject: Re: [PATCH 5.4 100/191] block: fix splitting segments on boundary
 masks
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Chris Mason <clm@fb.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20200107205332.984228665@linuxfoundation.org>
 <20200107205338.341621494@linuxfoundation.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1fc351dd-a213-3310-7611-6b8c60c209cf@kernel.dk>
Date:   Tue, 7 Jan 2020 14:00:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107205338.341621494@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/20 1:53 PM, Greg Kroah-Hartman wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> commit 429120f3df2dba2bf3a4a19f4212a53ecefc7102 upstream.
> 
> We ran into a problem with a mpt3sas based controller, where we would
> see random (and hard to reproduce) file corruption). The issue seemed
> specific to this controller, but wasn't specific to the file system.
> After a lot of debugging, we find out that it's caused by segments
> spanning a 4G memory boundary. This shouldn't happen, as the default
> setting for segment boundary masks is 4G.
> 
> Turns out there are two issues in get_max_segment_size():
> 
> 1) The default segment boundary mask is bypassed
> 
> 2) The segment start address isn't taken into account when checking
>    segment boundary limit
> 
> Fix these two issues by removing the bypass of the segment boundary
> check even if the mask is set to the default value, and taking into
> account the actual start address of the request when checking if a
> segment needs splitting.

Greg, there's a problem with this one on ARM. Should be resolved
shortly, but probably best to defer this one until the next 5.4
stable release.

I'll ping you with both patches once the dust has settled.

-- 
Jens Axboe

