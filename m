Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C4EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479F12086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EylqCyMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733125AbfHHNbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:31:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34573 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbfHHNbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:31:19 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so43585725plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 06:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BOGXkv2eq5LzpgbiQpijW+BYV+myujjXowu9Y8jZ1JU=;
        b=EylqCyMdUfJCaP+DGBkKQp3ZouA8/qzfrRCwdhcc3Pxzzq5HqbsJ1FBBtJzq6K7brl
         9yTwUCPKvhAuyZ8s1JswtB3P6V9oUx7vqE72lXBXTRSIFrWxBymddeGHyaO8b5xIocEU
         9hCqXmk7ENjL5aDEdxvpXVcn5owpRK6hThCzPXMJyfwzGoRuQaEVP35daFufVVvpasUr
         CFLB55yTwoa3Gq9RWoVw8VOjXiQ9yE3DEipTfS7V4de6xEq7BN5DTdQ/sfGkP3hRnJfr
         +EhqtvJbJqNabCSxp5meecDdQfRAZ/GMuWcCQcuC8VLB8wUG7gAzumLzeQ028WTrrxhe
         +x2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BOGXkv2eq5LzpgbiQpijW+BYV+myujjXowu9Y8jZ1JU=;
        b=W0ZZ6Z/f9aiEfwgqlwIjExj1AkLFtm2ojOVdVVA9l0cCTEbanx1sXMQ8GsvA7+v5Cs
         UywWWce8iAkhKqa/wNKEKFzQKMlrOneaZjTq6vUVDTDFMGG3/RgllsBlCTHGKUNJGEUS
         CxEtQUvyEfX9gFfvBfFS3OMg1/cwzE1BTv/a4Q1EJJ9sDmCGy1nrac4uQxGzT1p+mT4a
         RI6+ab0kcWV3oaJ+V8UMEdqdKBpFzpByTyj3sexXvRpidLg2PUgpdkpRLXnrumgFLQk+
         kI3xeoQtwZVL6nieHkK63K845/ZJn6d0VfbkpgDs7Ufndg3L7cnxM/VY94VvZkAhjti0
         KrcQ==
X-Gm-Message-State: APjAAAWV9XN9SQEtVaZsPQkENsn/pT+s+c1sLPubdQRRVpl/xbSG9fMd
        wkyotwrKpx+DODAdpnRmjUjXQg==
X-Google-Smtp-Source: APXvYqwzC8UH+BwTDNYOd9a8XdLsnp2ltbmnDTl1XWwJvQnwqtaNO8EdxMmTOpgrx05xp3m7rwRhmw==
X-Received: by 2002:a17:902:7202:: with SMTP id ba2mr14065245plb.266.1565271078780;
        Thu, 08 Aug 2019 06:31:18 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:186c:3a47:dc97:3ed1? ([2605:e000:100e:83a1:186c:3a47:dc97:3ed1])
        by smtp.gmail.com with ESMTPSA id x1sm2445502pjo.4.2019.08.08.06.31.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 06:31:17 -0700 (PDT)
Subject: Re: [PATCH BUGFIX 0/2] block, bfq: fix user after free
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        pavel@denx.de
References: <20190807141754.3567-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d081622d-0e0a-14d0-449b-27900ac94904@kernel.dk>
Date:   Thu, 8 Aug 2019 06:31:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807141754.3567-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/19 7:17 AM, Paolo Valente wrote:
> Hi Jens,
> this series contains a pair of fixes for the UAF reported in
> [1]. These patches are the result of the testing described in this
> Chrome OS issue [2] since Comment 57.

Applied, thanks.

-- 
Jens Axboe

