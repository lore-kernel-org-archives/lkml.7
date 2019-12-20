Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493E3C2D0C8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 23:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB932072B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 23:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Oo62xS5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfLTXsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 18:48:52 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:44485 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfLTXsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 18:48:51 -0500
Received: by mail-pf1-f180.google.com with SMTP id 195so5198081pfw.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 15:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zworJJwQ8dOshFr0Q172KPILlQ/18z3PgpXzpXjduD4=;
        b=Oo62xS5QTd9Pi9wuU/wp1XxKZ9YnnqNbj39mTJiDIM7+rBbqPQ0thBrf10zljuAgRo
         s2KpYnSXwNExRfb26lB/tm2E6E9temQCKSTelu1+9MZtKUBVDZuJCmKRAq8PJh4Vxnsk
         me2XFBzA4RJEDnXjtke9v4Tco8mFJqGBDqDYaipnWKYfo889PZJGIAk//570rTBpnxHS
         B4ziulXhui4VYDp1R4rhQFqZ8Zxd5N15hhjIvg8O2pSEofXKsrFr5pNlwZ1ubIzEqXEE
         P3WStyWCcdPCayW57YQhVPTCI9S7V0rSUN+PRICyCJs0dUQKYUf1r938QKU9NKWda0g9
         D7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zworJJwQ8dOshFr0Q172KPILlQ/18z3PgpXzpXjduD4=;
        b=AnrUcm3JVXe3Za25zmH9AkJltOFRoyOPDBZ4Y4iM0iN9RsNMBSEOQZjCOQfOZzato4
         fBLkhXJveux1DvmkCOtvtOGeZjTPF+Dikd1B1kiCLjCYcbl7IX5Xn+euP6GcDS/Y0r7/
         jfoe1J4PnAnxmCQGQpiKIWoERAWHKplSlIyX/fopJRBVMpny0z47i/84gmFJIDAMx4oy
         52P3QYv+O+GGtDe9kOAFWPFlLNHNi+a+wd9CoUsoHEd0Uofv/ZCaZUi5rMrkmErnTEfo
         ecpX0fV/RZti/KVrkzqVuNUaPYwpXUlo31CZx+QUgJRO99lfi/a9KtRIlLlyeT+gyIoC
         mphA==
X-Gm-Message-State: APjAAAWrc5HyTg6uFd5kSJLSIHsEI/1BYHuo5IRilXIneYylONprQhBA
        i/nb+IsMezsyf0NObJ2hMw6PigTbCiyjEw==
X-Google-Smtp-Source: APXvYqz22Ej/ewFeEbkIC+4DB0DxQRk1L0hC5wwhrHpRJH3fc2VsKC/9Ng9yNeyTfu2IdxGyefEwcg==
X-Received: by 2002:a65:420d:: with SMTP id c13mr18172724pgq.101.1576885730034;
        Fri, 20 Dec 2019 15:48:50 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id g6sm11405366pjl.25.2019.12.20.15.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 15:48:49 -0800 (PST)
Subject: Re: [PATCH][next] io_uring: fix missing error return when
 percpu_ref_init fails
To:     Colin King <colin.king@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191220233322.13599-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <398f514a-e2ce-8b4f-16cf-4edeec5fa1e7@kernel.dk>
Date:   Fri, 20 Dec 2019 16:48:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220233322.13599-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/19 4:33 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently when the call to percpu_ref_init fails ctx->file_data is
> set to null and because there is a missing return statement the
> following statement dereferences this null pointer causing an oops.
> Fix this by adding the missing -ENOMEM return to avoid the oops.

Nice, thanks! I'm guessing I didn't have the necessary magic debug
options to allow failure injection for failing.


-- 
Jens Axboe

