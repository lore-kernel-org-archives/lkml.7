Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A9DC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 20:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7BE20657
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 20:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YHnEBL7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbfHEU5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 16:57:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32796 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730055AbfHEU5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 16:57:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so36846825plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 13:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=YaR8Byqy3SpzGxyS+dW1jFl5yiqSZd1BZKYnowLKjXM=;
        b=YHnEBL7vrtqUmXkWhk8q3lmtIqZgpSSndy+j+cUAT2IUEeFFW38jrX0baqWR/25w7o
         W7/iVZSuy6q9OXAmGuC9PeAiBPBqB4I62qfyBNVhkqLkvPpPglNwUO9p+L3wovTPDjL6
         wvYxU5ov0Tv2kIqhszUrFDdGC8rHAOBTLtD8S2buDWgOVB0l79GDKUNO7WzuVDBLimL2
         93gZbuBPSaJhOQfHFErIBJ1eOuqEjJbC8uXtODGNCeN37OO4w8EDBbyxbBuCajkD2nfa
         gSwis1tWBS8gI8Nwd8HNY9DkGH5nljQFD2P5xoXKUk1zhCEpgTeP+kTmDVtocCpCCs2D
         BAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=YaR8Byqy3SpzGxyS+dW1jFl5yiqSZd1BZKYnowLKjXM=;
        b=Q6gZwoax4tlmkGzSqihBPGSNfNAJHvgMNXLHimyIOunDIMvvIew0KXiNKaKvlqgVki
         uidN6edLCEEOu4fWiYh6luyK6Rq6y1x1OCuMtTNUr1+ASJBzNG5Q8o1zfuRsAnSYwCja
         6N3QhyvyABcjub/oikMc3SENC0YeU/l1wMomwznUkhPyhY0LR289el+gvJHFm9Wg6pu6
         h08OmCUHPSol9fhG1B5Ixw7np5R4sDpAJtxmENgZLgFWzoVJp0oO2Dri+V2l7V1XIK1a
         IZvAGs5rA3vC7Kskp2SbhjV+vx6tDvjgG+04To0UOtBw84jVx5N0vkmXz/ecwsyjBmVh
         p96A==
X-Gm-Message-State: APjAAAU1ByA1qvus/rFTVdhxGb8qYWAU1FghUS9yQggnkRr/kIInUW+Z
        hwks4F+IfjIg9DW5eS2dJIFjpw==
X-Google-Smtp-Source: APXvYqwMUE/9GA/GfS1NI70alw8wCHXV860ABZdV3Ni0axotPGtKGeSCMzjIaJY8TspAAiDtuR8fBA==
X-Received: by 2002:a17:902:2baa:: with SMTP id l39mr147534530plb.280.1565038632142;
        Mon, 05 Aug 2019 13:57:12 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:7483:80d6:7f67:2672])
        by smtp.googlemail.com with ESMTPSA id s24sm85446319pfh.133.2019.08.05.13.57.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Aug 2019 13:57:11 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: add ethernet fifo sizes
In-Reply-To: <20190718090301.19283-1-jbrunet@baylibre.com>
References: <20190718090301.19283-1-jbrunet@baylibre.com>
Date:   Mon, 05 Aug 2019 13:57:10 -0700
Message-ID: <7htvavgwk9.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> If unspecified in DT, the fifo sizes are not automatically detected by
> the dwmac1000 dma driver and the reported fifo sizes default to 0.
> Because of this, flow control will be turned off on the device.
>
> Add the fifo sizes provided by the datasheets in the SoC in DT so
> flow control may be enabled if necessary.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Queued for v5.4,

Thanks,

Kevin
