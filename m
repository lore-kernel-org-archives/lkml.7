Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3AEC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A80206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MRC5GtQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfKUQH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:07:29 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:34792 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfKUQH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:07:29 -0500
Received: by mail-il1-f194.google.com with SMTP id p6so3830095ilp.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 08:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P4W4hyYZ6T+wL1O213mYLd96KdBzBHpg9/YQCjoVILM=;
        b=MRC5GtQYRbjWjFGZ/vJsaClUMDJ7hy8XeLThYplbe7u/VBoJyVDfOQRYNCc9WHf1+R
         YM8i3LUmqrCtDbaOPuE+/759ibNWitWsdr/1LB32m8NQp+rYS/R5MRMYP0SxrAH7pDW/
         yzbDF1xvKxuXI/4YwDImOAMRtkxOBtfLCZb7Rn0Rg5lGNiLHY69oLwDT8tQHHONCPyOL
         VRRMjJIF0O4osgapAp43czNPYKTjL442yIx7Ljhmy1ctls9w6UWWmnJ6QyM6DqVy3hqf
         4k0Yi51vruRfdY62Nc1rpQ3KoiUObEVajgdICck/bxmpkaj8MaFGqq96EHvYxa8LmC1u
         C7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P4W4hyYZ6T+wL1O213mYLd96KdBzBHpg9/YQCjoVILM=;
        b=a1H7ds2hSE8CgoaV6KRvr38hAn9M8erE0b4Q2tcQ3OqiHe88efMi/pEoDtJ+yajYy2
         v+xCuGxKdBwCq7BRDaVYDaLH14cYPJO+6+ntxQqIEypJ7p6u6mNs2Zs8U0LcKpeAAsP5
         GHvsXkFY8m7KpMjVW2R7MjUq9+7wpNFoxgQkQS4++MlSIJwyGqRrnsJH7gk+Fc7XimS4
         76SXS+irXvOXeiUuWQFjdvHnijMuuRRBbxfMOvGO1GGbtPXnKdLY/n35IVNxeuOwNgo/
         2YomFmrKNyVuelDCR3itP779THVBVEVJVxqhTgwwrwOP7ymbHEgqMz/C5Gsmo6+RXILR
         PH9A==
X-Gm-Message-State: APjAAAX52krZS4dfTwjvHR6pHbuN6T8gVyHFO1nlpo2P2ZiXUlCkZ+91
        9Z8aFMgH+xQw8n7n0MSyVBbS4Q==
X-Google-Smtp-Source: APXvYqwBuxR5GnmNrTTF+fDPqQ/m+MVGAFtj5D46hjZm7URBjIHtPwDjypsu1kC4QDIwCYtLqK4NhA==
X-Received: by 2002:a92:9ace:: with SMTP id c75mr11197162ill.296.1574352448192;
        Thu, 21 Nov 2019 08:07:28 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v15sm1379208ilk.8.2019.11.21.08.07.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 08:07:27 -0800 (PST)
Subject: Re: [PATCH] block: add iostat counters for flush requests
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
References: <157433282607.7928.5202409984272248322.stgit@buzz>
 <ff971ff6-9a10-c3f1-107d-4f7d378e8755@kernel.dk>
 <20191121160430.GJ6211@magnolia>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f542739c-7d43-1ea3-5235-c7809bb59f62@kernel.dk>
Date:   Thu, 21 Nov 2019 09:07:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191121160430.GJ6211@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/19 9:04 AM, Darrick J. Wong wrote:
> On Thu, Nov 21, 2019 at 08:56:14AM -0700, Jens Axboe wrote:
>> On 11/21/19 3:40 AM, Konstantin Khlebnikov wrote:
>>> Requests that triggers flushing volatile writeback cache to disk (barriers)
>>> have significant effect to overall performance.
>>>
>>> Block layer has sophisticated engine for combining several flush requests
>>> into one. But there is no statistics for actual flushes executed by disk.
>>> Requests which trigger flushes usually are barriers - zero-size writes.
>>>
>>> This patch adds two iostat counters into /sys/class/block/$dev/stat and
>>> /proc/diskstats - count of completed flush requests and their total time.
>>
>> This makes sense to me, and the "recent" discard addition already proved
>> that we're fine extending with more fields. Unless folks object, I'd be
>> happy to queue this up for 5.5.
> 
> Looks like a good addition to /me... :)

That's all the encouragement I needed, added :-)

-- 
Jens Axboe

