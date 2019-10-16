Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBA2FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C34821A49
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WSEnOnOc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406440AbfJPQnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 12:43:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36686 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405336AbfJPQny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:43:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id y22so15076011pfr.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 09:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=8zOXZspx/ff3Ozrug4tze/962ZrSUCYsoKHNkx0Z9Gk=;
        b=WSEnOnOcJXVEpXJumHL2VQXVBlhI9HQacG1QdM+77Aj8bQ5NPvpZhTdZDPY9Ek7EWp
         flv5GylfYkqyQH7SekWQHG+EJj7RF0TZ+e74t1KER1iTkzuS2zxNjWEj5/AsiGjjnghV
         qY5DtlA+sMcldJnGMHXjNNH2C8Oh2jrX2HwIWZvffOqssL4iCnpwZlvUCjMNk0zneCja
         oOcDWMmbUE4d1+aNC9WbovW3sMGiT0Cqo44sPrSwL+wAiX2LDoy1BhKWPQO8j4CNVTEL
         JEEWykgSymemea1O2KhYUd1ROH1aomJIsxQ95c/gGaSvYtwGaddkE2m1uAtQ5SuYMSmo
         xtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=8zOXZspx/ff3Ozrug4tze/962ZrSUCYsoKHNkx0Z9Gk=;
        b=kTE91EC9usnAVp/FNK5T4gP6vUvVeD1qAMLSssygOxKf2wcf/QhLBlwXw1rlcsiF2z
         oY2ctqWA2QWqVx9mBc/vCc5ltcsdqlBzzI3EdxmB7OOSQWDJRVz5glQQuLnIXcErq154
         vHexNvB9MRi1Kx3Ekk3myFXOKIuMkLz2sJU3+bEN5z54gSqbIz2VIa1kOV0+bHAbGpva
         IL4GBdFMLJ/usFjMcXFchT+eVmOxjsj7ceaLrWH/N46EEDlFoK4wCa6ZoQQopNE0EEMC
         Q4lqiExnHargG1HIldHIsWBTWmDXWmGjwMkGkvBUuDZSs8qhAaZbuyVBZo0EfuvKf7qS
         WcPw==
X-Gm-Message-State: APjAAAVPePHCOKHXa+lZKuWKqqljSDUnrmECpzBWM8kkknlSJBdfTVSW
        aY5QqJfrtor0hbsQU8rvz8KDgw==
X-Google-Smtp-Source: APXvYqxjPUoV//tePpS0gP9myPSBYo/ftLbM3UV+aV7H1zkRU9RAhAkUXS/U8RU5wMHB2AlbyXtKMg==
X-Received: by 2002:a62:5ec6:: with SMTP id s189mr46373405pfb.30.1571244234130;
        Wed, 16 Oct 2019 09:43:54 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id n66sm40776772pfn.90.2019.10.16.09.43.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 09:43:53 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: meson: sm1: add audio support
In-Reply-To: <7h7e54hdif.fsf@baylibre.com>
References: <20191009082708.6337-1-jbrunet@baylibre.com> <7h7e54hdif.fsf@baylibre.com>
Date:   Wed, 16 Oct 2019 09:43:52 -0700
Message-ID: <7ho8ygfxo7.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Hilman <khilman@baylibre.com> writes:

> Jerome Brunet <jbrunet@baylibre.com> writes:
>
>> This patchset adds audio support on the sm1 SoC family and the
>> sei610 platform
>
> Queued for v5.5.
>
>> Kevin, The patchset depends on:
>>  - The ARB binding merged by Philipp [0]
>>  - The audio clock controller bindings I just applied. A tag is
>>    available for you here [1]
>
> I've pulled both of those into v5.5/dt64 so that branch is buildable
> standlone.
>
> Thanks for details on the dependencies.

Just noticed that all of these had "meson" in the subject instead of
"amlogic".  Fixed up when applying.

Thanks,

Kevin
