Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C027FC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944A42146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="S2234Y6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfLRQiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:38:23 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43349 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbfLRQiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 11:38:22 -0500
Received: by mail-qk1-f196.google.com with SMTP id t129so2058324qke.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 08:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sbHXKAlGtJ4WoF+Wk5BJ7Ni9B2+fY69RTFn/n1ttSO4=;
        b=S2234Y6PzoYiAKpG5kfvgExKO7U4AEEPbmh0zbW+1C8PjTfHk/M7SihyDv5d7vq+Ru
         NArec1JjWWgRz8TRt7gvAmwkrhVxatpifjGd6KEal21z6iBnXvuaJpa8p2rgdska4HR8
         Vn1IWYv7095dx+9vEd1cUadyqjeeepD8aTciCzCnaWuF+oAzgmeS5QjeNn5Lmn37yzYh
         fx8cbejQT9OMRW+IDdq/E8ZiCAOt/V/VrtYz1g2GV3t5tROmmRq6/XCUz1KiqHH2I6V6
         egDx+E2dG2bhwjzHMvecHlewS40PCe32Ce/P5nAKGuyQaOZt6MhqmyR/N26znSJNXPBS
         zLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sbHXKAlGtJ4WoF+Wk5BJ7Ni9B2+fY69RTFn/n1ttSO4=;
        b=Re3zPObak62ySgg++1+NdlpHAaFv5iJErFWjiNdYQDe62BnVgi6HMcf1fPR2Tu4hMd
         fa1KhgieVg31BRz6eVtsdLpxZndXnhOpRupG3YYMdU+LKc3cizVlv1Axbwtw/Wj0K2Pd
         YzlGTdp74gC1ED6buXsCILRCmpnecoyO+00hkBpyuzn8QPBgcMaUDmyC27rrmqpxrYnV
         YZK7c359j8sYYacc5YpoDCvd8/itf6wAbxpOvgCzgeDZ9g/tCKE1AcNxycxm7r7IIyf5
         PEmy/D3THfUei7b1zLho6LceDh2gtE6VH8YQzfHEOQMS4KR1yYqhzBgR372QvZ9BdcZh
         6dTQ==
X-Gm-Message-State: APjAAAXofXZQeeOi9Ah/oWFjVfXUf6cMdKWQS/rQm8UiX1ARiOZBdalB
        SIOM7Upe+woDufWzBg/b63PZQm7UncocYQ==
X-Google-Smtp-Source: APXvYqyi2DFONj1cNsqdqMvZd0EqSNs+bKVIC10ca2hMoPkHA/RPLR03EXtJv64Xk3ZmkgCRZBu+Tg==
X-Received: by 2002:a37:644:: with SMTP id 65mr3542626qkg.309.1576687100662;
        Wed, 18 Dec 2019 08:38:20 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::65a1])
        by smtp.gmail.com with ESMTPSA id q126sm812880qkd.21.2019.12.18.08.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 08:38:19 -0800 (PST)
Subject: Re: [PATCH] btrfs: remove BUG_ON used as assertions
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191215171237.27482-1-pakki001@umn.edu>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2f9d6549-47cf-fb71-3bff-50b51093e757@toxicpanda.com>
Date:   Wed, 18 Dec 2019 11:38:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191215171237.27482-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/19 12:12 PM, Aditya Pakki wrote:
> alloc_extent_state_atomic() allocates extents via GFP_ATOMIC flag
> and cannot fail. There are multiple invocations of BUG_ON on the
> return value to check for failure. The patch replaces certain
> invocations of BUG_ON by returning the error upstream.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

I already tried this a few months ago and gave up.  There are a few things if 
you want to tackle something like this

1) use bpf's error injection thing to make sure you handle every path that can 
error out.  This is the script I wrote to do just that

https://github.com/josefbacik/debug-scripts/blob/master/error-injection-stress.py

2) We actually can't fail here.  We would need to go back and make _all_ callers 
of lock_extent_bits() handle the allocation error.  This is theoretically 
possible, but a giant pain in the ass.  In general we can make allocations here 
and we need to be able to make them.

3) We should probably mark this path with __GFP_NOFAIL because again, this is 
locking and we need locking to succeed.

Thanks,

Josef
