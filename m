Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A22C4CEC5
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 00:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B46C20830
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 00:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="K548ZTJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390724AbfINAbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 20:31:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35755 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388296AbfINAbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 20:31:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id n4so16128538pgv.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 17:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=GZS0eMO5E5zSRugyeXgeD/cE6Edijnu4rZNFSWVvyE8=;
        b=K548ZTJEQ6iFC5z3YdwevITK1iNbgK/vue1InwebFMKHAUjYrEnTWfspcXJ6hGnwaS
         EGC8rQNV84p6P01VsYPZfaJyg3QJvjbVyfpJCuZCeoCgnOPlnKOU9A6IHwvthZbYJeib
         A/gg6kOGvOCoKuo+Zrk3B4GaU0DeB2d0PBZK3UwB1hgYW2XlUf4U5uYM4W75bYpGZzdE
         s02D4+6c6XwU8bbIR0bINDp6B0JMKQFWqoYF57rKupI2gT4Co+PdQubLPAtXFzsdhKe4
         jMB8/5Bjr24fZOn1D8eQ7VP0SvulhIki2bR1ugBynhWwx4nO9b0OoU6x5OOCoHX7pnWa
         ztJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GZS0eMO5E5zSRugyeXgeD/cE6Edijnu4rZNFSWVvyE8=;
        b=W0u5B3ApOyQ0WwxCl6Hiq/fGYYcIU5mY35HbFN+rJkqYGHZ23hPCZkS+I6KNFIC8dN
         /1Aw9rrAh2uXazM2FA4QbL80tBLSYUxg/Wzx7+7NoP9u4fhQNDJ9F7iIbOWL2hP1UWKQ
         BKZlqRGI3dZMxOLgRz5aXBgDRfLkimDu06GMdcWu5E3iy2fBwnWiWPaFtsoENjn1MALu
         c64WDbvPhyu44nSgF4zvF6spC2CBdwX5qqiqWyR2DPayxEg0SeMAoffq5iqmNtY8zHGc
         PZnJWvXenxpc3bAQgfsCTQ2C1iAzVihcAoOyiYesJIveC22YVoYmOYhf+x7S+Px4K9QP
         CECQ==
X-Gm-Message-State: APjAAAU9ZpiZXLm+wrNFYuKW+HSbqyg30TbS7DLtfp/MBnT6sxP/IGY+
        tjvD1wxN7YiIC/gRAPB59NFXspXgD7gOAQ==
X-Google-Smtp-Source: APXvYqyBRXdUrqfuDtkgroCENQHx7jGh5ioqxn1eRQ/mEpAduszh5yTIrIY4U8/ZsJ3pp2gZczHbvA==
X-Received: by 2002:a17:90a:be13:: with SMTP id a19mr189147pjs.55.1568421074785;
        Fri, 13 Sep 2019 17:31:14 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:4d1e:aad2:f066:c964? ([2605:e000:100e:83a1:4d1e:aad2:f066:c964])
        by smtp.gmail.com with ESMTPSA id m16sm2222389pgb.84.2019.09.13.17.31.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 17:31:13 -0700 (PDT)
Subject: Re: [RFC PATCH 0/2] Optimise io_uring completion waiting
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1568413210.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <af5ba045-2ea8-b213-3625-354c10334540@kernel.dk>
Date:   Fri, 13 Sep 2019 18:31:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1568413210.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/19 4:28 PM, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> There could be a lot of overhead within generic wait_event_*() used for
> waiting for large number of completions. The patchset removes much of
> it by using custom wait event (wait_threshold).
> 
> Synthetic test showed ~40% performance boost. (see patch 2)

Nifty, from an io_uring perspective, I like this a lot.

The core changes needed to support it look fine as well. I'll await
Peter/Ingo's comments on it.

-- 
Jens Axboe

