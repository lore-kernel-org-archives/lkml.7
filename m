Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0C9C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 10:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302E221881
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 10:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="lqyHqJ/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfIQKON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 06:14:13 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34901 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbfIQKON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 06:14:13 -0400
Received: by mail-lf1-f66.google.com with SMTP id w6so2432822lfl.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 03:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kjxnCGfbE9oG4rXA0UnyUIJoUg+5vOPeXFD1JNJ7Bxk=;
        b=lqyHqJ/6gSch6A2/7HyTmfxCiK9D0zeoHcv9Tj5I3x0qrpoZPRsfNfQzp/aXNC1l7Q
         Y06UseY2279S/LZ6lv6HUmgNl/5AxWVmSxiV6TtnRtUulOVSVYTZFw1r2o7qCxTqxgPb
         WpVlm5hsDSPKKEnSMr73cR9hAnU91GECatNFtO+6PGCPsbboLcSbvDu8mIY8t8mPX8mE
         rfxkpHrgjVpBmONgNMYYEu1RlnULSSG2Js7yFjyuv2wrO3hGdzXLBEOybIaL9NlN6rO/
         OI4cdWaMWlO2meZYkVWRQlurxnIkTKyzQqBUCV1JXvJ67cyds4D3ERR/yx9v5MwfWM/H
         NDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kjxnCGfbE9oG4rXA0UnyUIJoUg+5vOPeXFD1JNJ7Bxk=;
        b=rujThQMQDG/9DfQ9Yac02mUGEHFgH1Jbb8khjHsoSJsnQEWCof2/0U30X1fgqWD/YJ
         zC5VDLQHTC675RG6iX4ZJtPtGEKqolsREL/FeYzju1mzzJZNLAWaWq4/RB9zjWAxQZw2
         DQCTyn3chsEMMKT69RKEpjb8YSespPOOqva/inRkLdrbBlspjjnlcvk6k9SY5ZUFJWpC
         mDoukXMsmOWD1JKNP8tv/f39F9nW1mIqECxw9ONltT4OWEdCirNaNlpsBmry9sUqyiga
         x12PK2Ay6KDur3QBFWrYKYC7gAWTyt+N7LXSmJF1MaGsjJzTfnftfBvSk0IguAXQwzrt
         nzWQ==
X-Gm-Message-State: APjAAAXgRVJjliYlHpeCGYHNGeBqOMHmfV9x0QKj5fxyP21JLCUg1EEr
        wDNUf58/OIct5ELYfS+MdLUnuw==
X-Google-Smtp-Source: APXvYqxMulznp1P+TSTYERRDeow5/xshl3zawrDJQaWFw5QNipvGHHXAI/dtj9usHhJMT0GMjt5zeg==
X-Received: by 2002:a19:2207:: with SMTP id i7mr1644977lfi.185.1568715250889;
        Tue, 17 Sep 2019 03:14:10 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:6e6:a4e9:5101:fe11:ada5:769e? ([2a00:1fa0:6e6:a4e9:5101:fe11:ada5:769e])
        by smtp.gmail.com with ESMTPSA id g5sm221169ljk.22.2019.09.17.03.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 03:14:10 -0700 (PDT)
Subject: Re: [PATCH v3 bpf-next 09/14] samples: bpf: makefile: use own flags
 but not host when cross compile
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, ast@kernel.org,
        daniel@iogearbox.net, yhs@fb.com, davem@davemloft.net,
        jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
 <20190916105433.11404-10-ivan.khoronzhuk@linaro.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <b9b802b5-3d86-31ed-6929-209c50530b3b@cogentembedded.com>
Date:   Tue, 17 Sep 2019 13:14:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190916105433.11404-10-ivan.khoronzhuk@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 16.09.2019 13:54, Ivan Khoronzhuk wrote:

> While compile natively, the hosts cflags and ldflags are equal to ones

   Compiling. Host's.

> used from HOSTCFLAGS and HOSTLDFLAGS. When cross compiling it should
> have own, used for target arch. While verification, for arm, arm64 and
> x86_64 the following flags were used alsways:
> 
> -Wall
> -O2
> -fomit-frame-pointer
> -Wmissing-prototypes
> -Wstrict-prototypes
> 
> So, add them as they were verified and used before adding
> Makefile.target, but anyway limit it only for cross compile options as
> for host can be some configurations when another options can be used,
> So, for host arch samples left all as is, it allows to avoid potential
> option mistmatches for existent environments.

    Mismatches.

> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
[...]

MBR, Sergei
