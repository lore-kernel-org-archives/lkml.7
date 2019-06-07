Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA44C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACB2206E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NqnGfAJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbfFGW4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 18:56:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40418 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730547AbfFGW4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:56:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id d30so1880992pgm.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 15:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=M8kh7Dgz12YKrTZB/CDTuS2cguipR8YlgXyL4uu88Rk=;
        b=NqnGfAJwCu03tLbifhT0GvFm2QW9R9io9AMcdefvJFzJ7g5Vr8PmXoK2S/sS0EBCtH
         Fusk7Ssd1izPi4ZVcnBnUIZrYJgm2cJJofYjf12PPHOu7ZZQRvC6lU0/MhgweIGPyLeg
         E6/EwGWuLTjiqp09TGPSY2SCFTQsrN6Q1gyBuOEW5aINnxk+dmy7z5bJcCLEazyA8lbi
         VWQySNTO5RzIXQriYe54HK29THy5Z3raT0y6A4hFRm5CoOlH/IVwVyITcvGmjab4XIjl
         OGj96J+wDHrvBD5Bl803937Zwo9o/GU9QYKxuCxNaeVzWqwjMi90YBdkhNvlFjQpuFFm
         tqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=M8kh7Dgz12YKrTZB/CDTuS2cguipR8YlgXyL4uu88Rk=;
        b=pSnCpyidtLx/PXvFPiN0P8hoYVrrpcEjr+GRuHjy5ObF0zMrc/VmQ/nRgvKtRWWToP
         QWPNF8P65b6iSzNNPVE/DARTZXVOFHwJFSqTpl1z486VUaO8vpqZp+esrF6W7LA6TwIK
         84GH4ocK09fm1FK5Rxtd4azHsl+RQZVlcV3DiWd245QAXAHU2PskbXmKo7Y1eqqK20+6
         x95jJismYiMrs8bl7PnXJZliH/50dJ9x8/IIs5DsXqfWWEPuggP2LJZGhFf05RQEibWR
         s4Lt7eVUNP+SIAevdk8d3Ii/B0LczmCl5QwA35s17VPKRC+bxQji0nA2YNd8Md+ts/o8
         cmMw==
X-Gm-Message-State: APjAAAVe5aKikUlNRHw0oqEKSYDS7zq3zUrL8wOAFsmEglGwVyZ9z8rp
        Z5KVWQjNRPIRB8MLZqWmV1XRs1ZVaCo=
X-Google-Smtp-Source: APXvYqx8Ow2gN0FBBUIuNPbj3rAAjRbrUfUEtyHrw8/8rVx9mCf6X0IFniQr4nPekXIHjCWdFu3P7g==
X-Received: by 2002:a17:90a:5d15:: with SMTP id s21mr8054502pji.126.1559948212523;
        Fri, 07 Jun 2019 15:56:52 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id f13sm3439916pfa.182.2019.06.07.15.56.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 15:56:51 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, mchehab@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-media@vger.kernel.org, linux-media@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: platform: ao-cec-g12a: remove spin_lock_irqsave() locking in meson_ao_cec_g12a_read/write
In-Reply-To: <20190605122015.11439-1-narmstrong@baylibre.com>
References: <20190605122015.11439-1-narmstrong@baylibre.com>
Date:   Fri, 07 Jun 2019 15:56:51 -0700
Message-ID: <7hk1dxatsc.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Since locking is handled by regmap, the spin_lock_irqsave() in the
> meson_ao_cec_g12a_read/write() regmap callbacks is not needed.
>
> Fixes: b7778c46683c ("media: platform: meson: Add Amlogic Meson G12A AO CEC Controller driver")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Tested-by: Kevin Hilman <khilman@baylibre.com>
