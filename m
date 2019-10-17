Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EB1FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BDC20872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vLPVBc0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440443AbfJQQLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:11:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41726 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406402AbfJQQLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:11:50 -0400
Received: by mail-pl1-f196.google.com with SMTP id t10so1341608plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 09:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=wqUCKXUJo8X5AAnTpFmKsNohxpW+m6dhYvogWfd9F4U=;
        b=vLPVBc0jLKrHi5fVflv9YxU/hVeu/thLp/A8Y8zkskX6Ye5Dy5BmCgU3KC62KpH5UH
         51cd+d34DJAoNncm6/3zAa9GnGflQHLPvRvBm3tMsYg5p7bBWqWsyg+oDbz8kfaC1uJ0
         JYm8MiUvFwitfQfmeZmHcysj4jHd7g9nj9kDP66XDTCZybnLhlVKdSPQuuS6xmLmevIz
         dcphuhkju0GyADHd3MBg0wPM1M3B89A1FF+glmpcimwLNMBCm1CWAqk6+5IcSY63yzN2
         M7+f8NEN+zuoAvlR/dJRptbELXTr3PAx+hA2K9iHhVtMouQnQGdPTynkkPJ2r1DqKw5c
         vMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wqUCKXUJo8X5AAnTpFmKsNohxpW+m6dhYvogWfd9F4U=;
        b=K/fuZ47z3qMVD+zHWiUfMfRcm4NLoKL55f48Eb6M2xvpWQ8+6D5oncYYthOcE/kwjq
         JfH4PepYsQWOIGYic+08YnKeZCUxPFa2ll7tUPuTz2xB9kXUyFyVvHc5yYLce2swc499
         TsKPbAB4cFA6L8XSejkcpHjOffVnpIzjlzjE9HaURGl3x8RSaDG57MzCtt8B9sWW4yom
         fesTABMsl8FKc8HEXPCuF5DGSmNohERlTiPN5ocU/bL/4eDpNCjLUHjdwdzZkI5y8UYh
         Fzw9syNAGhS8CNlhXlVhE9E/Q9cymH7q6qSZEjd6k0zLp5s9o5uEqYkiPZIFWn5FVtMd
         umvg==
X-Gm-Message-State: APjAAAWRjCnI9mW0xjvEuAxHpOyPTXYQ7BQ/x0llLRfQaooDq7VwcTW5
        OTeN6AyqOrJco/mjTd3tUtWdjWEXj30=
X-Google-Smtp-Source: APXvYqw6QWneFJB+QPd5Fr8J5Si4FPeSBOTzKJY8p7VwP6wPLB9npxHWIpL+GLPUVWu+FaDir8cNQg==
X-Received: by 2002:a17:902:9a84:: with SMTP id w4mr4790832plp.186.1571328709262;
        Thu, 17 Oct 2019 09:11:49 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:d8f2:392e:5b44:157d])
        by smtp.gmail.com with ESMTPSA id e3sm2578093pjs.15.2019.10.17.09.11.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 09:11:48 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: meson: sm1: add audio support
In-Reply-To: <7ho8ygfxo7.fsf@baylibre.com>
References: <20191009082708.6337-1-jbrunet@baylibre.com> <7h7e54hdif.fsf@baylibre.com> <7ho8ygfxo7.fsf@baylibre.com>
Date:   Thu, 17 Oct 2019 09:11:48 -0700
Message-ID: <7hsgnrbbcr.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Hilman <khilman@baylibre.com> writes:

> Kevin Hilman <khilman@baylibre.com> writes:
>
>> Jerome Brunet <jbrunet@baylibre.com> writes:
>>
>>> This patchset adds audio support on the sm1 SoC family and the
>>> sei610 platform
>>
>> Queued for v5.5.
>>
>>> Kevin, The patchset depends on:
>>>  - The ARB binding merged by Philipp [0]
>>>  - The audio clock controller bindings I just applied. A tag is
>>>    available for you here [1]
>>
>> I've pulled both of those into v5.5/dt64 so that branch is buildable
>> standlone.
>>
>> Thanks for details on the dependencies.
>
> Just noticed that all of these had "meson" in the subject instead of
> "amlogic".  Fixed up when applying.

Ignore me, "meson" in the original is correct.

Kevin
