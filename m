Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E19C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FDB20865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LcL/9uRR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388091AbfJCRfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:35:25 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38668 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731848AbfJCRfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 13:35:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id w8so1840744plq.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 10:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=fXED1acjUYEy8AfTXY9uzTTHkmVKjak7JTmjU0uqyWA=;
        b=LcL/9uRRNdFh8s3yJ34zvuzwmAlYXY+5NtkUJo19unLkx0Vd/qr8WqTEZBan/qftZr
         P1bDgtC07qIqLSSGqeYoL0rj7rNRyavq3OPtZDp6QIfTcfUnqZ+qT1ZIDz5oFqaOGbrS
         bddhgK6RC6JawtQgHzHSJ7Dfcme+1rlZvKUh4SWJKBwzlcEPHfrq1RqtyYZSNIc7wZF6
         k7Duu2DYf/TEpibED84bxJD7NVZ2H2gVwF7PoM7jleGKOPhQ6d24sdBI+M2QemqnvXWn
         En+88TQN7gWRurqwAw27hQo3eVf/lu+2dWPwg7zvpOquykRuQTYhtNH9Wpud+t2sW8qy
         zMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=fXED1acjUYEy8AfTXY9uzTTHkmVKjak7JTmjU0uqyWA=;
        b=CAZnnbj53tO6yj2OJ0N0qZRTLXvdL+AdfKSxP95QcAh1uc+OcKKT5NKtX7CjKZMvqz
         uwr2OJLSteaJZIxi9mFhwNCulf6MOR2zKZbeFE+5NU/vEVJW24DLLFgKJQG5ebgbfpGY
         y+etpb9BLcfMDC6Q4pUKLBw8JSAgwY0QGVzHD/mwi7JBg9SDbEcRDvGBGggYJM/5d5DJ
         50rBBNQw/nNt1yCatNBEALW2joLGpaPXH4Ko7JwuJzOrlu5YWePw4EFP7qRoO2EfL2+L
         fuqxcr7cwhQOjPqsOAMmin1jYWWsCRgMqkAUAi9SFJp674tJ9vOLYwLHeY4F1B4iYA0y
         Ty+w==
X-Gm-Message-State: APjAAAX3ZxWvEbXXkqQIeT3ltrR8RIt1Kso9+8ZUsYYLBTntCPAslTZf
        TJFZykLMKE7tqSps38jt/4F03A==
X-Google-Smtp-Source: APXvYqy05X9Caox3UXihsMlUZMERys06g8z7Vx5e9Y0f2nZLZLrsuuT/5m6q6Rg/jEuE7VX9C6qJXw==
X-Received: by 2002:a17:902:b7ca:: with SMTP id v10mr10149938plz.54.1570124122276;
        Thu, 03 Oct 2019 10:35:22 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:a084:116f:9da0:2d6c])
        by smtp.gmail.com with ESMTPSA id l21sm2835389pgm.55.2019.10.03.10.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Oct 2019 10:35:21 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Xingyu Chen <xingyu.chen@amlogic.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Xingyu Chen <xingyu.chen@amlogic.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Qianggui Song <qianggui.song@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-watchdog@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: meson: Fix the wrong value of left time
In-Reply-To: <1569754429-17287-1-git-send-email-xingyu.chen@amlogic.com>
References: <1569754429-17287-1-git-send-email-xingyu.chen@amlogic.com>
Date:   Thu, 03 Oct 2019 10:35:20 -0700
Message-ID: <7hy2y1vijr.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xingyu Chen <xingyu.chen@amlogic.com> writes:

> The left time value is wrong when we get it by sysfs. The left time value
> should be equal to preset timeout value minus elapsed time value. According
> to the Meson-GXB/GXL datasheets which can be found at [0], the timeout value
> is saved to BIT[0-15] of the WATCHDOG_TCNT, and elapsed time value is saved
> to BIT[16-31] of the WATCHDOG_TCNT.
>
> [0]: http://linux-meson.com
>
> Fixes: 683fa50f0e18 ("watchdog: Add Meson GXBB Watchdog Driver")
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
