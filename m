Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C11C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A45E2075A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BS4tfVw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfKUB7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 20:59:31 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39702 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKUB7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 20:59:30 -0500
Received: by mail-pj1-f68.google.com with SMTP id t103so704844pjb.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 17:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=78FX/0eBvEiR/EpkRd0Cqr1DZXWBnvT4u3YgaZ7Oe6E=;
        b=BS4tfVw9kFQOU0gCyzrqOoDB36MzXmvaLWOsqdA1hvDkhExi8oz/7H0r6SNGz1e5l7
         wtrqaYR2dHzd6/OCTrZCjMYnBRzoRq1JycKNzSyFo04QROnfIqAx9yJX8OM/t2XVZZ4O
         pHZZeUWTLiKiOH6gt8pjJUY44UPObPZDG/QHBgZkuEWo9qrpHnusMlwdJsuXymVbpFAJ
         6VNIY+EeP7w4AqAkh/+eFDnlbGYQ7sPGQizh9kv455VB6MCDiqEC4xDG312GeRIJ3ipA
         IlBOQ0t2KgUR2qV2feFMHxdVIw6yYp4rr9lx6mLv9NDco2Wnduw1xeO44xOlMxYcm41q
         su7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=78FX/0eBvEiR/EpkRd0Cqr1DZXWBnvT4u3YgaZ7Oe6E=;
        b=NayIg2oOa6x8ab0OobKgnN3Co2BhBzeo3SRzv6axAwzvWylcZQORapdUExbh9Ts+6C
         e04485dSEgVwyqcyno5XPiPl3PD+v0Sp9qT4Z7HanAfcIjp42YtfnnV4mMqu7YFlWwsB
         pBNIiLFe89Zsv9YKquQM9jQKgJaL7xJ0lnOPxdfx1oJ9m6b/7cyi32fK8fg4Bs8bl14T
         v/Wd7VrxsIGUf6znXd2rzdHjlOXGZ7GGa6FXDeyTlWwIOvDKyi9pdq+1kov8+T9cFNhz
         49eYC2GpJNo+fAMUgTGIlAL2PyGNqfRV2io63ED0/NHiKs+iUwvWaq5pYKXvDZ7lfQ2d
         JWHQ==
X-Gm-Message-State: APjAAAXMtgdfq4vd/37LLLQXBrsjzS6i+RbqSnfCLcwl+wvyygSepSRk
        DlDe7h938j1tTMZl8OH2hcBdJQ==
X-Google-Smtp-Source: APXvYqycAOiIHHP7Pql6Om3/mMUNgejRyqTx+PEO73XjED/jtnR31NppOw9Ye6HCWtba/40lYDrK9w==
X-Received: by 2002:a17:902:b101:: with SMTP id q1mr6247437plr.154.1574301570208;
        Wed, 20 Nov 2019 17:59:30 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id z2sm510274pgo.13.2019.11.20.17.59.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 17:59:29 -0800 (PST)
Subject: Re: [PATCH] block,bfq: Skip tracing hooks if possible
To:     Dmitry Monakhov <dmonakhov@gmail.com>, linux-kernel@vger.kernel.org
Cc:     paolo.valente@linaro.org
References: <20191101131110.18356-1-dmonakhov@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c1f10727-fc7a-7ac8-545b-a3a98b06c01f@kernel.dk>
Date:   Wed, 20 Nov 2019 16:11:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191101131110.18356-1-dmonakhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/19 7:11 AM, Dmitry Monakhov wrote:
> In most cases blk_tracing is not active, but  bfq_log_bfqq macro
> generate pid_str unconditionally, which result in significant overhead.
> 
> ## Test
> modprobe null_blk
> echo bfq > /sys/block/nullb0/queue/scheduler
> fio --name=t --ioengine=libaio --direct=1 --filename=/dev/nullb0 \
>     --runtime=30 --time_based=1 --rw=write --iodepth=128 --bs=4k
> 
> # Results
> |        | baseline | w/ patch | gain |
> | iops   | 113.19K  | 126.42K  | +11% |

Applied, thanks.

-- 
Jens Axboe

