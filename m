Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5A7C31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 04:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C5C2087C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 04:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pU8/lDul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388875AbfHCESN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 00:18:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33128 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfHCESN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 00:18:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so36981413pfq.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 21:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zKeANEK6kwb2S9kHR576jpELFbbuT/gI7mLvYDstxwE=;
        b=pU8/lDulM8iSQPrAjU5DtefQ2mIw/LZFnBGddE91KmjOmHKwrNuWUZ/2Vk50txGhQK
         Ujcg+He8rFleQCPwytmVXhSKS97AWX3pIuQg17tigcsWDlGZgTPFEtz+t0KWnUnZG0UZ
         3khuTo2E5Yki6GKDEs9Q9KZmXxv5bxVba110fofYN/RnI8Pq+1yl/Dvv7zG7levNKsJi
         FnYUzbvghMUlpP2WIoPhi6kr7mf8NAjP/UAB5mpj3u/mo/ySjzS9UmNL3tnZqS/XsnEA
         p1VqQBeVoqj+dIbgIGl0TFOmnq4mM92daOw1ktPWKIXCSvB78ZUfrlucB2yhdIDKyxBO
         MP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zKeANEK6kwb2S9kHR576jpELFbbuT/gI7mLvYDstxwE=;
        b=EUZkzZgAZIY8hBtyodf5/8iK4ZGX/DL/Bke+qol5N0ZIaSFmNHNRZJva6q6hBbUa+1
         x5CAVQIc/RwYSZjP5i8TLUKMpvXY9aYRiySVR5d0qYXyM0NZq3ozSFOlgukJ5rxG73mD
         45Y0XNXFaHKUtJIFTYVmS2ppkRh98auDVdlxwdwlhfaM/9zpy7iXgImZHe00Uuz17OJz
         rvsTbICWHBbD1OAnIX8Il0Mu0JopJAiMz4tetQ4Mlmt/nLYbRhPyngtG4YH/xzLtCvxl
         y3UAZ62T5RPBx0ROLyIsndlAt5K2o/SlPxvxwHOwlKCgQOUwQyl6nNYQoDBXTeNvLDDE
         5odQ==
X-Gm-Message-State: APjAAAVsHdgvNoh+XR5k3lNECmuIL81GuQtIlD1qb+qyqC8bvEDCLbAh
        p1+n8YrgiqrcDb7ALWl/RZg/zvncDH4=
X-Google-Smtp-Source: APXvYqxJzcrHnxPcFtpDnZX41o71Cp0mTb86Tl9SxUJJArUP0wE47own42NZ6ZKd3+Y86tz0w3vl8Q==
X-Received: by 2002:a17:90a:d80b:: with SMTP id a11mr7105400pjv.53.1564805892582;
        Fri, 02 Aug 2019 21:18:12 -0700 (PDT)
Received: from [192.168.86.24] (cpe-75-85-219-51.dc.res.rr.com. [75.85.219.51])
        by smtp.gmail.com with ESMTPSA id z13sm8593480pjn.32.2019.08.02.21.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 21:18:11 -0700 (PDT)
Subject: Re: [PATCH 1/1] block: Use bits.h macros to improve readability
To:     Leonardo Bras <leonardo@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     Dennis Zhou <dennis@kernel.org>, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20190802000041.24513-1-leonardo@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a41b5530-f2e1-0932-1f39-0ce66ce902ae@kernel.dk>
Date:   Fri, 2 Aug 2019 21:18:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802000041.24513-1-leonardo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/19 6:00 PM, Leonardo Bras wrote:
> Applies some bits.h macros in order to improve readability of
> linux/blk_types.h.
> 
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> ---
>   include/linux/blk_types.h | 55 ++++++++++++++++++++-------------------
>   1 file changed, 28 insertions(+), 27 deletions(-)
> 
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 95202f80676c..31c8c6d274f6 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -9,6 +9,7 @@
>   #include <linux/types.h>
>   #include <linux/bvec.h>
>   #include <linux/ktime.h>
> +#include <linux/bits.h>
>   
>   struct bio_set;
>   struct bio;
> @@ -101,13 +102,13 @@ static inline bool blk_path_error(blk_status_t error)
>   #define BIO_ISSUE_SIZE_BITS     12
>   #define BIO_ISSUE_RES_SHIFT     (64 - BIO_ISSUE_RES_BITS)
>   #define BIO_ISSUE_SIZE_SHIFT    (BIO_ISSUE_RES_SHIFT - BIO_ISSUE_SIZE_BITS)
> -#define BIO_ISSUE_TIME_MASK     ((1ULL << BIO_ISSUE_SIZE_SHIFT) - 1)
> +#define BIO_ISSUE_TIME_MASK     GENMASK_ULL(BIO_ISSUE_SIZE_SHIFT - 1, 0)

Not sure why we even have these helpers, I'd argue that patches like
this HURT readability, not improve it. When I see

((1ULL << SOME_SHIFT) - 1)

I know precisely what that does, whereas I have to think about the other
one, maybe even look it up to be sure. For instance, without looking
now, I have no idea what the second argument is. Looking at the git log,
I see numerous instances of:

"xxx: Fix misuses of GENMASK macro

 Arguments are supposed to be ordered high then low."

Hence it seems GENMASK_ULL is easy to misuse or get wrong, the very
opposite of what you'd want in a helper. How is it helping readability
if the helper is easy to misuse?

Ditto with

(1ULL << SOME_SHIFT)

vs BIT_ULL. But at least that one doesn't have a mysterious 2nd
argument.

Hence I'm not inclined to apply this patch.

-- 
Jens Axboe

