Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF00C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FCE2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lXrxUu2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfHNOui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:50:38 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40725 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfHNOug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:50:36 -0400
Received: by mail-ot1-f65.google.com with SMTP id c34so42951031otb.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 07:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cWx0cFqnOpCViIJ4tMHIiuLTvCAxlz9fs3eE3H38dRE=;
        b=lXrxUu2GbQ/3WBKNQg6bGoE9vwtRUCP4SFYSH0scEDD89DaRziNNmLBjE0vttmjUe/
         O4oi/JbfzfFG5Xw+9gyej9xa8Hxo6VT5l/5Uhu6Ny65juAt0JRUAzvszKia3iSP6nh2r
         cE0Ny9xPzGSah2fDAN6DN8EjpM8B6mh5i7nhJfiWPFDueWS5tsen90BhvNf8os6QfOaB
         R9wxOqDAIO9Yz9t6d1bMDRQ3gDdzZeohh4mmfilwhiOUUe/mDlQ6e3WFeK9AEwQGx/YF
         rY1tFBsimehN69v0SOIHFcLiMcb9eRNPzSfZvNrcyjLsWDG+3r2rJKdeGRUyQs6JW23U
         vFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cWx0cFqnOpCViIJ4tMHIiuLTvCAxlz9fs3eE3H38dRE=;
        b=oyMgPcYYQf4HXaD3XbNcoo5mH3pe2hhusF0YlEJIWmq7gBNKAxnWetzVzrXmgFNNNU
         /aUIGX0E5qwQpuH77KmMd8pv3JXJGirII0jAQi76jzmuqa5ecn2tDWV1p0gOyr8UkA5s
         amPoNu8+P8qrm7pnPcywcnN1/GJUtGYnqqTTUAPZI3Qj8ItzEUjnFr27s00+CuQrW3JW
         MI+esELhh7+jVAAPHtBiAXjS0QjFF5hdMTFWIvcKpcQ9UaC4N2d3jyufL+r1ya/6ohd3
         NBJeTtkcmPEjqc8qbS1h6nKwQYuvegyUTlNij5F5xRsDWZjDclf+O64W2MysjFfD5WtB
         ILeg==
X-Gm-Message-State: APjAAAX+EWYuKc5EcmSAZoXR6USBslyVqznTOJP1u4qy+Y291GD1OmIj
        x9KrQVFe74DEFTYjxeIy5KQdiEtdeWW7Nw==
X-Google-Smtp-Source: APXvYqzQoRGPHjcNHC/V15omIqsc2Ze631e9qimSe/1ZAhI9YzS7mHKxHhdIL75MIuw/sd9unwIaTQ==
X-Received: by 2002:a5e:834d:: with SMTP id y13mr288968iom.79.1565794234700;
        Wed, 14 Aug 2019 07:50:34 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e22sm101663iog.2.2019.08.14.07.50.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 07:50:33 -0700 (PDT)
Subject: Re: [PATCH RESEND] block: annotate refault stalls from IO submission
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190808190300.GA9067@cmpxchg.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4ad47b61-e917-16cc-95a0-18e070b6b4e0@kernel.dk>
Date:   Wed, 14 Aug 2019 08:50:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808190300.GA9067@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/19 1:03 PM, Johannes Weiner wrote:
> psi tracks the time tasks wait for refaulting pages to become
> uptodate, but it does not track the time spent submitting the IO. The
> submission part can be significant if backing storage is contended or
> when cgroup throttling (io.latency) is in effect - a lot of time is
> spent in submit_bio(). In that case, we underreport memory pressure.
> 
> Annotate submit_bio() to account submission time as memory stall when
> the bio is reading userspace workingset pages.

Applied for 5.4.

-- 
Jens Axboe

