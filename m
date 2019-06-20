Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E03C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD672083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 09:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="r/1yYnXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfFTJRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:17:48 -0400
Received: from mail-yw1-f42.google.com ([209.85.161.42]:36369 "EHLO
        mail-yw1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfFTJRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 05:17:47 -0400
Received: by mail-yw1-f42.google.com with SMTP id t126so886890ywf.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 02:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yjS6Q6+F6t5GdBFMmUlrcxYceoRTSp3oTZ0mJxc8DLc=;
        b=r/1yYnXXaFsNBbYms9dnUrTz6KSjQ9x6NFYgigUTCsUW9L5hQ6tiErceaIBDjMsgfU
         AOsief+Rc7h4OTKWcsbQJGVbeCHqFRzJNvVGhi9Q9dmCaOEIeX5dah/7R2dkgvBU7sCy
         dNl0vrS6PAGdT8iKGgKnibojs8LoX7GraPy+H8Yf2xMzSW8CQjKlxnKKA8uLLvdvdgJN
         BguPMakvZfbsIO0UUcodniWlnazBwy3uz4scQJl767NsZjIXiZnzNYlJjDCkH4GsVbbz
         VekLSHMgWBFM7dYJS4MzV4K0Jai51UHHA6lBvVl6mn/NEk4NOW/LsOCdPybgYjfNOZPX
         KMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yjS6Q6+F6t5GdBFMmUlrcxYceoRTSp3oTZ0mJxc8DLc=;
        b=j4dbz1BwxytMMCmXEksHawM20B09zZ2+GahlhZMmrPXErO/YRsbJhLSXxrCt9m3FfE
         6Z/8C+/LGRlhKEpbFfAGDmkIokTsyB0wasW+seXruzqRLfzehYvugD2y1SrGdt+WkdLz
         9YZHJ5X0h6xoHaKffwZC1zrAare0ePbvD+89438Qv4WnKdbGV8J+ss5u1ek2Z/zM8dHi
         iqVXToZfkIwTUzSNw+zyGEJIbJTW+PA9AynilhUsNoRah8A+kQUK09f8U3A7B/Cbb6Nn
         p7Yy1awUmG0uN/7WzIV8dH1NFL+E2USAI3BI7k+iFdrBKKTZbakSc9OuNXwtwdgHKSVR
         SEJg==
X-Gm-Message-State: APjAAAXOtJEYUyYti/sX3e033cBNDx56Yzfrbgfb/eDMaGI6R6f/GlLk
        sNIV/zH8iDXhjuLlGvhVOC8NAw==
X-Google-Smtp-Source: APXvYqw+luOP592XhcspSOMCAWKp60asbS1wP4Nkli3ErkUVNbmFVXmD1uG5Uvb9NR18THl//mPoug==
X-Received: by 2002:a0d:f144:: with SMTP id a65mr49343023ywf.42.1561022266304;
        Thu, 20 Jun 2019 02:17:46 -0700 (PDT)
Received: from ?IPv6:2600:380:5278:90d8:9c74:6b59:c9f5:5bd0? ([2600:380:5278:90d8:9c74:6b59:c9f5:5bd0])
        by smtp.gmail.com with ESMTPSA id i126sm2441339ywa.108.2019.06.20.02.17.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 02:17:45 -0700 (PDT)
Subject: Re: [RESEND PATCH] block: move tag field position in struct request
To:     Minwoo Im <minwoo.im.dev@gmail.com>, linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190608201551.4531-1-minwoo.im.dev@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <091ac608-071c-538f-4c43-eb8b40005b05@kernel.dk>
Date:   Thu, 20 Jun 2019 03:17:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190608201551.4531-1-minwoo.im.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/19 2:15 PM, Minwoo Im wrote:
> __data_len and __sector are internal fields which should not be accessed
> directly in driver-level like the comment above it. But, tag field can
> be accessed by driver level directly so that we need to make the comment
> right by moving it to some other place.

Applied, thanks.

-- 
Jens Axboe

