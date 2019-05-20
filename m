Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D5AC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6196921773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 21:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rW1xFXB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfETVO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 17:14:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42634 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfETVO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 17:14:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id x15so7282729pln.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 14:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=e9DHapnp+Qtf77YR6olJPsTc8cKNqjeLv8Q9DilZXqg=;
        b=rW1xFXB/h+J/6RxYeiTn+/Q6pKGTEUVgsyJgniYwvDoIGXrx0B91WocP0iGbPkT3CO
         SxRBw2F4+HmqMrYzKl+Q6iHvx1CgT/sl/Gw2emNF/WpioKaJFb6o2G2tVwAIMUMcPZKs
         +gesDMpmDiigfgs2Ay3imhvQBB2T3M6d3Ge+5U30mvTx07z6EaPYwYoQ55uqv0q/wVi4
         C++USRuxnvy3BhcpZSOcByFVb5CJyJeNYFLymZ5IfbTT26fmKeHv4MTX+7aJwjlqteYu
         GSyWa/dPpb7+GhrHZkvRCqFA1oJMu9ymiumxDyopFuYUQpkQLnhYVBWOP0MzQpBY2fSf
         wtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=e9DHapnp+Qtf77YR6olJPsTc8cKNqjeLv8Q9DilZXqg=;
        b=SmEXUcwpsJGgHAb0xR7PXEwF3cUQBi4hsm6ZB/VsSBY1AlKRJQD5jyb9htqj0+utvb
         C1YpWAYEFtFzgqoedjPvlMR1t47ue+xdLcCTJEJipfhYXmqupc71bqM7/l8/ohVj6vPO
         +7mbhcl7WloJobWHG/gyviSd735yXh5AdCILuhb4eQRxzHhD9Ds8Ons6IgPepwaGiVDt
         trhub8FjMePEI12yxZgu7eyyCbYyNq1vD2PxOSjYRlH+XttKQxVz7/lPEw3j6+xMG9UP
         ITydXHFkVg2hZarxxSeFw5bx12S3qI2C5OE0Dc/xrm7q5GxI1qD1YRODAe+i2a9IBjW+
         SE/A==
X-Gm-Message-State: APjAAAVipaPAvMSsWdWYcMbhAGqgCB0IErtWJjrwmr/e0TiAR7LSiigY
        ZoRWogFcYxUDIm/prdO7TwCm3g==
X-Google-Smtp-Source: APXvYqyHMN/K1s6B7b8p3IGNVlLCHVQU7SaaC8OyYAZAD0EsLuxuKwtszvPEIFa0iiSPXHKYTdOj5g==
X-Received: by 2002:a17:902:46a:: with SMTP id 97mr50159186ple.66.1558386867639;
        Mon, 20 May 2019 14:14:27 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:e483:1cc0:e2c2:140d])
        by smtp.googlemail.com with ESMTPSA id y10sm15075030pfm.68.2019.05.20.14.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 14:14:26 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: dts: meson: g12a: add i2c
In-Reply-To: <20190514101237.13969-1-jbrunet@baylibre.com>
References: <20190514101237.13969-1-jbrunet@baylibre.com>
Date:   Mon, 20 May 2019 14:14:25 -0700
Message-ID: <7h7eak96by.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> Add the i2c controllers and pinctrl definitions to the g12a DT then
> the busses present on the u200 and sei510.
>
> Notice the use of the pinconf DT property 'drive-strength-microamp'.
> Support for this property is not yet merged in meson pinctrl driver but
> the DT part as been acked by the DT maintainer [0] so it should be safe
> to use.

Queued for v5.3,

Thanks,

Kevin
