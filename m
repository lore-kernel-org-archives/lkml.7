Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D99C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B4C205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UFXgx9Hu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfEFQVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 12:21:51 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52553 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfEFQVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 12:21:50 -0400
Received: by mail-it1-f194.google.com with SMTP id q65so19784246itg.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 09:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JM/WZfijWawO0dM75sC9wd0xm0O1e7k2DME12T/WG/Q=;
        b=UFXgx9HuMJqBVirFEYXePbVMPL7ifubbChBpKxZBsozZhVZdUX8Ot96uTiSw/V7CNk
         fSLYzzNvhbUb5hAYmI5Zl6SEyQ2jdbAKtEms3Ypy2pQmMDDum4DOht2B4MltviwdHnoq
         pXa0AIgIt5dGhunS5vhMZ92AiF53tkkXPDPv+0pTedFeqkTRhFOKBfgyTCqxB/Bi1xP2
         dPQnaN2VrGkDeGBjsgm960JmoMz207/11+prKIuW9Ru/8earF5aZf93UhtGUWdlB18Eq
         8yfQOtssex78N19DTIEBJQMWZ9atH8CaNx3iNa+PeisifL3Ff8LW9WaSlUw/DyuxyxS9
         5Phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JM/WZfijWawO0dM75sC9wd0xm0O1e7k2DME12T/WG/Q=;
        b=ARgdBkBMmtWky/5xrQMKt/FsRFe9sdEGM8InDV+e5lAji6gOVZBCgEgzCbexGuVaPd
         KVF6+1hPtJy7mGkLeGQ9S0i4kx8D1oEe+tzVyPhjuAfa557iF9v5Mdn6ov+PglbNRyQb
         dNlVLqyiLtkelIZvXJPU2aUN4G1l4Ls/GTlKymJaK8+D3OQrCRk/J/tCYx9HK7pwiGmM
         ul25aoPYgq2W0ElGY5vwmAZK4VSmYlIuM3ZP2BWbyN8QekHg00/PkcpgagR3PbzcPKvy
         pvRfd59VklXIAR1yoPctGdDt7vBz/eucXfTHrDQRl7fvdNvy0N59DW6o7g+n4FFbFLC4
         Qt8Q==
X-Gm-Message-State: APjAAAWVqzJmD0Ev3LG2hKQwpiteCZqLqksUlKI+scP4NlkpJ2YJ+a8y
        6vTAKISEMh38sa4HVxSGBvI7tdttHWaogQ==
X-Google-Smtp-Source: APXvYqx5RyQ8KTZzVdgGtPBddYXhbpfXTeY6xfZ5bVFKqngkFqVvd5/hfJWmx5YQugDGs5G6H8rXIA==
X-Received: by 2002:a24:6987:: with SMTP id e129mr18889644itc.28.1557159709220;
        Mon, 06 May 2019 09:21:49 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id d10sm3880686ios.72.2019.05.06.09.21.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 09:21:48 -0700 (PDT)
Subject: Re: [PATCH] io_uring: fix shadowed variable ret return code being not
 checked
To:     Colin King <colin.king@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190505220122.5024-1-colin.king@canonical.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5ccacedd-41d9-f33c-25de-ae16bcdb7b08@kernel.dk>
Date:   Mon, 6 May 2019 10:21:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190505220122.5024-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/19 4:01 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently variable ret is declared in a while-loop code block that
> shadows another variable ret. When an error occurs in the while-loop
> the error return in ret is not being set in the outer code block and
> so the error check on ret is always going to be checking on the wrong
> ret variable resulting in check that is always going to be true and
> a premature return occurs.
> 
> Fix this by removing the declaration of the inner while-loop variable
> ret so that shadowing does not occur.

Thanks, applied.

-- 
Jens Axboe

