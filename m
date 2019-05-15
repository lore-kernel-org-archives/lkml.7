Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C960C04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5902084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WI2iBDiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfEOAXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 20:23:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39110 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfEOAXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 20:23:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id z26so363357pfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 17:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=5HIeuVO94mCpx5lSheXh4TT/joqVZJDMNco4TU6ruo0=;
        b=WI2iBDiNQBQYnNO8zIf1I5Cm93vNfBc8DLM274EeENzYQh6HyU5OIOcXUCu5v7VUHi
         Vvowjub2/clMpmjpbJBkcBCD0H8Palt9XiSiwR+yvLteqXdm5BEgPGYEsl73Al6E5Pbj
         bkN/7YVJLeOtj5ztBW2Io8PYznr01N7l7/NMo0Ss7CyI+/l9k1XxGYZb37udI7eI2anU
         snyKGL9azRAt8t++XZOmsCo/sKojkZgUV+fRf+F6IAR0usXs+jgcpVFHZpoZnIxz4XJ1
         ZYl5FSwEYXMjolOzksFmT/UwnthtY9PGLBwlPdHRUeq6fMGTqUkEvLNa10kWRAdsudvf
         wsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5HIeuVO94mCpx5lSheXh4TT/joqVZJDMNco4TU6ruo0=;
        b=lqQITa0YBm4Qz2XEy907yGH3+DEjO+1qsSR2D4yfrkODoBTLb+XhxhJwr8qEMp0Z5G
         cVp8dMZo66MlidKdC4vIK/Q2K5SE3tH6PyZSrNHGSCLvwp+X7GermooucMLi99DimvAR
         XPvsQzgcpF8rVIv29pmXJV4kuNIrtErocooCIerKOk+aeYzwcqYCicTp4BujowBeucdn
         hD6UeSl+J7mol6ysVxoXy3d+0FiKYzIK8uxSbQpxNujvEwp4Ln8YQrtrw5gn2cdvve64
         rbBoaAIzSsUs3ghMx5g/B0iFSRafGLRP7XDgPQ16RxqHHT2CZrH9rC6cOfFJJRVZdqrJ
         1QpQ==
X-Gm-Message-State: APjAAAWemPlpDhGp5fkiJzkisiqaJNG4wGm1COVd5aaqqRFOHiIoB3cR
        SJL6AU2YxvFAIwjXwn/nqpqe+Q==
X-Google-Smtp-Source: APXvYqySDg667KIADa9m0x4Cb9pE3/e91sP9wsror2TboloDaKWl0tgT6z8dIix7C8Y3j2/LfrDD2Q==
X-Received: by 2002:a63:1e5b:: with SMTP id p27mr39817338pgm.213.1557879795688;
        Tue, 14 May 2019 17:23:15 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:fd66:a9bc:7c2c:636a])
        by smtp.googlemail.com with ESMTPSA id q75sm333952pfa.175.2019.05.14.17.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 17:23:14 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: g12a: set uart_ao clocks
In-Reply-To: <20190514094537.8765-1-jbrunet@baylibre.com>
References: <20190514094537.8765-1-jbrunet@baylibre.com>
Date:   Tue, 14 May 2019 17:23:13 -0700
Message-ID: <7hh89wd0r2.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Now that the AO clock controller is available, make the uarts of the
> always-on domain claim the appropriate peripheral clock.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Queued for v5.3 with tags from Neil and Martin,

Thanks,

Kevin
