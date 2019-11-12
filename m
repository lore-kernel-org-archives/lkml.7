Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC390C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8814221D7F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ni/jRc6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfKLPX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:23:28 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34665 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfKLPX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 10:23:28 -0500
Received: by mail-pg1-f194.google.com with SMTP id z188so6135497pgb.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 07:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ErfzrZR/5ryvUWJAJL1JzOPNG3JQELKeoUJmWdVzOHY=;
        b=ni/jRc6xyt6mTVHOl+knnLMXVa+vyCITLwdegkAjNX6LFfs+QC3+oXeYzoyxn2p46K
         mIV+CeRUlAqZc4RX8m8L/H+fiWQCYSde67Ia8C3BI5hwwPOePeRpecYwHXY2/sdi0Iwh
         m6GZPNb6Hkyp7G7lQoz6e4edML3+wE9uXNiVwrfoF9dFVToGANImTvSctV5JMSwkT/GL
         n6JOoUSfOW5+Z0DhYIPg/Ze/ZVN+PN9d8x5vRs5XVfgcd7OZU8Aluc4EZrnqOM+MxM1v
         paZrIMNcU+w92f5OEdABOTEv9l9u+W2M9wW1EeZq+ZWFmDCobjp8SFSR1o3SCGwCQxEy
         Eaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ErfzrZR/5ryvUWJAJL1JzOPNG3JQELKeoUJmWdVzOHY=;
        b=afEDexCFT4SK+M4ii+MhJWl2V3KXTgxP+lyz9K5kIwAC5ZE0gax+daGCELY6e2JHFI
         PXIzGiU4wpQ/Z+zRj3RK8TPwGi9NhpYlzOpL4DDWFmR3MkFWCy+EGQLk9MOg0zLfOYZV
         pQbIq0qGUMpmBH1HsdF8EOSPVOYh6W2uI5mqjZYOJcyCRV0sLVFY+ue1BKBylh83FC/0
         EWZOcO8GYY+SAf+q4M2rTcgIrgN9G61eJsCC7PP9M6IurHY3M4V/CTTQTylNhD1S8dsI
         CKN5i3dAqFAf/gi4PJXelpydeucl9M2cftzbveaySdc5LxWDiCyDtMmO18AGGo7e6zTJ
         tt/w==
X-Gm-Message-State: APjAAAUqQL76m8ZWNevRYm0TURao0ldU7SXt8T97EyHNurpKVeb5kv7N
        Go7TvxRI8f75C9sUmGwSz/aCxQ==
X-Google-Smtp-Source: APXvYqxlHkZ01oDRuL0uZnTPJwWbHJF3CWHUrXsIMQBPosRgzS3C9h1egzT6U+OdgoP6ZLrXQ5zzRA==
X-Received: by 2002:aa7:8edd:: with SMTP id b29mr37339092pfr.23.1573572206096;
        Tue, 12 Nov 2019 07:23:26 -0800 (PST)
Received: from [192.168.201.136] ([50.234.116.4])
        by smtp.gmail.com with ESMTPSA id e2sm17267011pgj.62.2019.11.12.07.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 07:23:25 -0800 (PST)
Subject: Re: [PATCH BUGFIX] block, bfq: deschedule empty bfq_queues not
 referred by any process
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Chris Evich <cevich@redhat.com>,
        Patrick Dung <patdung100@gmail.com>,
        Thorsten Schubert <tschubert@bafh.org>
References: <20191112074856.40433-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <83a56a54-3269-ecb9-f4ae-01c3f9717279@kernel.dk>
Date:   Tue, 12 Nov 2019 07:23:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191112074856.40433-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/19 11:48 PM, Paolo Valente wrote:
> Since commit 3726112ec731 ("block, bfq: re-schedule empty queues if
> they deserve I/O plugging"), to prevent the service guarantees of a
> bfq_queue from being violated, the bfq_queue may be left busy, i.e.,
> scheduled for service, even if empty (see comments in
> __bfq_bfqq_expire() for details). But, if no process will send
> requests to the bfq_queue any longer, then there is no point in
> keeping the bfq_queue scheduled for service.
> 
> In addition, keeping the bfq_queue scheduled for service, but with no
> process reference any longer, may cause the bfq_queue to be freed when
> descheduled from service. But this is assumed to never happen, and
> causes a UAF if it happens. This, in turn, caused crashes [1, 2].
> 
> This commit fixes this issue by descheduling an empty bfq_queue when
> it remains with not process reference.
> 
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1767539
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=205447

Applied, thanks.

-- 
Jens Axboe

