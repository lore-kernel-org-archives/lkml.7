Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2321CC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A062085A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 16:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mFi6QfPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfEAQAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 12:00:44 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39159 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfEAQAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 12:00:44 -0400
Received: by mail-it1-f193.google.com with SMTP id t200so10461957itf.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 09:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UucgAJ6vzQAJLUd8MejiceLufM+Rh+s5b6O4bHFTuzI=;
        b=mFi6QfPYyieJqHPZQXRfHHQ3WBm3B47xy+U1F43tfa/c8xD/oCRdQPCyQLse59bH6u
         rwFxaZRlvWgrLjxkbzjWZCnOnkEig0rDmc3Ay6+aAluhblZIeD73A/psLZIWKxAe5SHb
         +QvghO18x5taI/6ZuClbSwGl9KeXfvSeT5BzMJc1FLpIKnHL9AvPC7We5WNkzFXj4djD
         sp0c1Fgni/+VNaUU47LWahauEpxwRgHOnbWR0eKuAg+/+Xp08ftFkikjjuTdr7lpxbOT
         nJ/8JPgYI2gtW0rfJ4umEbRIB1KMVsUA9QZxIviKsXyaaNc4SyLzhZK6+CpRji18Xt+H
         ir0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UucgAJ6vzQAJLUd8MejiceLufM+Rh+s5b6O4bHFTuzI=;
        b=bYlVNbkduTX8jB5SJfaQOciMqzFVp1nwEwOPtLe0FQl/blvEuXTGrQLL7q59DsOj/s
         bFkdrbpOPP/gxfGRCsOOV5iSqKFYSJWsHkJCnpuE8GAseCoiE7fDxaACATSvXtEg/uM6
         Nl9qEH6Jfe537B7KlSyrKxv//k8hjmNr7tO7Z+F0Y9OQghrbdrbW3B3thb3sKG8MAdxO
         J9cERzv/Td4uzy+nQADXiyYWfNysbiJ5S2UvRhBAIj8L6ELZnaMlkqLYKXMpX32EmjZv
         yvWhW6MfKf/nQHnPAC7kkMsOk5z6IJznGxmXmk5B5Q+Rs8r7CZ9n35j+S0namo6o5OS8
         59dA==
X-Gm-Message-State: APjAAAWM40BLmL8+mYHp3TFDPC0HXLT17SUup1NurumMokh4HVxJtHGm
        ITGRGT5PEdXIE4siha0tyMfTVhWMtxjHRA==
X-Google-Smtp-Source: APXvYqyngemqaTJRtwt7edU3xJc85kB0kSghkkjs8I9dP2T+jLH2ib7wQ2eYqYgvb4dDcNdLhVepBw==
X-Received: by 2002:a24:4290:: with SMTP id i138mr8362892itb.129.1556726443331;
        Wed, 01 May 2019 09:00:43 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 15sm3275504itm.6.2019.05.01.09.00.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 09:00:42 -0700 (PDT)
Subject: Re: [PATCHv2] io_uring: avoid page allocation warnings
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
References: <20190501155916.34008-1-mark.rutland@arm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7c75a9bf-204f-1159-a2db-4679158652a2@kernel.dk>
Date:   Wed, 1 May 2019 10:00:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501155916.34008-1-mark.rutland@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/19 9:59 AM, Mark Rutland wrote:
> In io_sqe_buffer_register() we allocate a number of arrays based on the
> iov_len from the user-provided iov. While we limit iov_len to SZ_1G,
> we can still attempt to allocate arrays exceeding MAX_ORDER.
> 
> On a 64-bit system with 4KiB pages, for an iov where iov_base = 0x10 and
> iov_len = SZ_1G, we'll calculate that nr_pages = 262145. When we try to
> allocate a corresponding array of (16-byte) bio_vecs, requiring 4194320
> bytes, which is greater than 4MiB. This results in SLUB warning that
> we're trying to allocate greater than MAX_ORDER, and failing the
> allocation.
> 
> Avoid this by using kvmalloc() for allocations dependent on the
> user-provided iov_len. At the same time, fix a leak of imu->bvec when
> registration fails.

Applied, thanks.

-- 
Jens Axboe

