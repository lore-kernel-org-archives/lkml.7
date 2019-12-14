Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39DFC43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 14:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A898A214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 14:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GE3mP84b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfLNOjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 09:39:18 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38662 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfLNOjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 09:39:17 -0500
Received: by mail-pl1-f194.google.com with SMTP id f20so718794plj.5
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 06:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=IoBeQA2HlCS9XPEARFkefgYwffEfLh2rpYLRA+Zxnps=;
        b=GE3mP84bz9qJ1PbcGkHSWzDJUvu1LnnOmh0qGPofwkkHMu6viBA7LKUy7ZircRs1ua
         gHYE/tXgDv4mwdGVSAovrT5UzAB1jIa6GmlDc2YovUB8g1GzZ/l0MtXNedMXxhBaRA8r
         /+y6sd9VNaknBBBDU3yhwQYSi1wcyw/T9GyWzrjthejCngdqfY7eXKu55kWCW6mkMhYz
         z0anFk/j3KXsrozEvoWJvlACAxCXErhwQraqSkJ/jEvgtGk4TXkbYVdxXwiHG2LJBvsl
         cy6WXWHbDlygkWDYyoDmBXxR+ggzTzUXCYhkkNfKaJvZZAolWthExZjHRECamC1LqQoX
         Itdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IoBeQA2HlCS9XPEARFkefgYwffEfLh2rpYLRA+Zxnps=;
        b=VuRXo3s6f5nx3e8ZFTk2tDS0eLg9zQlo7BRH6sBVORsCqyDwpiY7aj23F9Kh94v9dZ
         bjBV6CJCUail+FoKyDN+axTZv7m69L+FswraJMUyG147jyXcXJf9guMFlzCsdfsJVXVJ
         15VnsvzUFMOcpJDPKpZovD+2rrFNo0YskcAXhvCr4RVygWnpW4kgTvrUzcn2xU5Fo24l
         ByngNbQfUI0ByUQLOy23iMslDsLJl5KB4H3nIC7Dft9AchNbjdhXCWeOUT1xUZV/j9hx
         +GGBvJvGjIz5RookYCNf9aYHbSMRMsghZMjAZ6+n20xPT5OqfEcLjENxFoaCEsrc5P36
         UhTg==
X-Gm-Message-State: APjAAAWq8nRQkEWaDII4vO8lmH1ky1npvZ9cmo2CkmQRQ8OnpvFlnkqb
        wfyWfxb122nwU3KPpNp6V1a1rCZkx3/oTg==
X-Google-Smtp-Source: APXvYqxGx5rkFXq/E1fSuSmmI1/Qmuwn5UJ1p91vjxHKdMebmKLf0SeawkfgmEDLlX184JTBsPtGeQ==
X-Received: by 2002:a17:902:830b:: with SMTP id bd11mr5185121plb.317.1576334356517;
        Sat, 14 Dec 2019 06:39:16 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id q6sm16416468pfq.27.2019.12.14.06.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2019 06:39:15 -0800 (PST)
Subject: Re: [PATCH v2] io_uring: don't wait when under-submitting
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <5caa38be87f069eb4cc921d58ee1a98ff5d53978.1576223348.git.asml.silence@gmail.com>
 <6256169d519f72fe592e70be47a04aa0e9c3b9a1.1576333754.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <55f01a72-fcbc-a3e4-d9db-7dd2a7ef1acd@kernel.dk>
Date:   Sat, 14 Dec 2019 07:39:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <6256169d519f72fe592e70be47a04aa0e9c3b9a1.1576333754.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/19 7:31 AM, Pavel Begunkov wrote:
> There is no reliable way to submit and wait in a single syscall, as
> io_submit_sqes() may under-consume sqes (in case of an early error).
> Then it will wait for not-yet-submitted requests, deadlocking the user
> in most cases.
> 
> Don't wait/poll if can't submit all sqes, and return -EAGAIN
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
> 
> v2: cap min_complete if submitted partially (Jens Axboe)

Can you update the commit message as well, doesn't really reflect the
current state of it... Apart from that, looks good to me!

-- 
Jens Axboe

