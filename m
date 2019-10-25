Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B0DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E06E21D7F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0dJBpJic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409455AbfJYPBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 11:01:39 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:45523 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407863AbfJYPBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 11:01:38 -0400
Received: by mail-il1-f195.google.com with SMTP id b12so201676ilf.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 08:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7GmtzZy7croPEQDptRcTsxKybbnF94HZTydxe9zCc/k=;
        b=0dJBpJic3MXgTSdJXNYetPcb4q4ONYJKfPNQJoRzstIdGh4T9JwqtSh69qPj8r1Ubx
         gZRwFpyritBdDGVxrYI/jhtkM4PkUXE3vq6P8GhebJnJpWTtf6bWXOMGB1wJKj1D3d13
         XeuWZPfJGgQq8l3dH9OdfzIiet35lkNULVAYJL/OoXZX1DcBaINdR+wgTxMvjWdrVST2
         Mth2O2/Rz2W7OiW2siRZrqhaZYbmVtfSYaD1//OJJma1IGs6qO+Thpc0XSE/Pg6cfti7
         pGY0HlW93NGC+qBm30QJmW4ZFOVNvGQLpHbYUG5XuvoOMH8JRzO51kBERmObgyy0nfLF
         mSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7GmtzZy7croPEQDptRcTsxKybbnF94HZTydxe9zCc/k=;
        b=iI9b9X1H12oTTaA9NnPrBgLJ6yakLrtI6Cnev6vqAS7+mGY5SuQYG9FvsRzTNJOMOh
         by4pkGr8O59rh3pTPeWb7+eGh1bTxl1IHdXzDimoK5ZMFrjGxxEJPGxHDbVYkxWiG2q8
         UQsqbdqwYep7WJ00wNN6QgX+AqeCxderHV43oPgjV7CYH2XKIFYET+uuLNEYWaHY/E4e
         ivcD+98f2G1OuJxAJZD+4GG+xZM7V25sm+DQp4pLLMPb/PkPnyTGSrcjnwATT2UN9OlQ
         hT4KmupKNPGO5DeiW8ZrNbdDcSvrR8hUYFlx3NY4rX+Q+BNa5Fh+Z8JHp2yrif1fmYV7
         tXRA==
X-Gm-Message-State: APjAAAUOFZqBYLE1egzYRXzJwB8dRLj2vPJrKyK/zj2oeVqpsEbvZmJv
        5dL5sQ4jaJoNe2J02QSYyRlIaU9X6XnMXw==
X-Google-Smtp-Source: APXvYqzlQ4CvNTlup/i4cwSXZVQKIgsf3HZXSuj/3e5HVWCQfg/08jMlWPGiL0FlU64xPBCkwfEk+A==
X-Received: by 2002:a92:8dd9:: with SMTP id w86mr4360524ill.277.1572015697073;
        Fri, 25 Oct 2019 08:01:37 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q17sm265612iob.20.2019.10.25.08.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 08:01:35 -0700 (PDT)
Subject: Re: [PATCH 0/3][for-linus] Fix bunch of bugs in io_uring
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1571991701.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b095f79a-9699-fcc2-83d3-434febcaaf14@kernel.dk>
Date:   Fri, 25 Oct 2019 09:01:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cover.1571991701.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/19 3:31 AM, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> The issues are mostly unrelated. The fixes are done with simplicity
> and easiness to merge in mind. It may introduce a slight performance
> regression, which I intend to address in following patches for-next.
> 
> Pavel Begunkov (3):
>    io_uring: Fix corrupted user_data
>    io_uring: Fix broken links with offloading
>    io_uring: Fix race for sqes with userspace
> 
>   fs/io_uring.c | 67 ++++++++++++++++++++++++++++-----------------------
>   1 file changed, 37 insertions(+), 30 deletions(-)

These all look good, I'll apply them for 5.4. Thanks!

-- 
Jens Axboe

