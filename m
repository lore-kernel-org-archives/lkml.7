Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715AEC79DB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E982470A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sgIfRKUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfLMQxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 11:53:31 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40593 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbfLMQxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 11:53:31 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so1460618plp.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 08:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=jZARGI2ljyaZUUzftM9FBJPmm5n1/FlWF5GqHksaDjI=;
        b=sgIfRKUhqdV6BDX8b6Kkhb8TzuupxC2yg76LGod3zYtqCfQ76L3DdNFNDiqlh9WLKE
         9dXGb4UmaQ8anwQHzY8aW4mJ/JTFQ1A2+Wiuf7DzNT3BN14t9RiR0KyPVztQRoaMoEA2
         I4n3IPzgUzElgqn4XqboDq4TwfFrfRlagOp59iq7mlIx7/pP//A7AZjbVfNEZwv1D8kc
         3p5wP4AmYPgcjL4ty3DlDOpiLvqFzQYolTT1qhp1PFI356oUi8LCyrHkkK4kjV7fBoPe
         +ewZOJ5RhrkySNjyqYEljIXs7JvW8wYj2XlZ/37DNMn2XLJKSmwntpP6ZtpTr0mXAzQx
         4MVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=jZARGI2ljyaZUUzftM9FBJPmm5n1/FlWF5GqHksaDjI=;
        b=o2qAIamFGIyCCw7MUqkSDm4AUT5xMLAzpqY2SAlGUf17nvPMgCR0v7uNJQl4QQMtrZ
         cZMaQA5JRyCKE4E4JH5jxjAiUksyQc+LCsM2pgzIvSAy+iYo9atmECqWIr7DGs9qyXpX
         5C5mJvqQT+JJkcc5HfzEiBB/H6WmHFDgdyh+TzbhiIplArq0iq9QWx7o2OIYdCgW/FPx
         UTRVrG2ipzVOpeiPIBjH6F8ZiocTrv5Zdug+D01z4OCPGks9t/dWA+jINxXsCCIJmCcQ
         lPqJ5LROpRz61OkJjOtHnB7JCk6Rh+X48uzHsuc2nTwNSs5JJdWbkDFaUYNqGZbC5upZ
         s5HA==
X-Gm-Message-State: APjAAAVBnhtm1RIXlpGXtXuHZF5+qsHw3JfX9bIzP9TtmeywX8O6mRRU
        IVABmOEKnedOw7j0okd3qYim/A==
X-Google-Smtp-Source: APXvYqwOTIE7mAAvzbQljivGwT1lZknrS5gskCeChmKf5NoyTIKMXUPpvw2+ULP/zm43ECQeQEQD2w==
X-Received: by 2002:a17:90a:c697:: with SMTP id n23mr302398pjt.37.1576256010397;
        Fri, 13 Dec 2019 08:53:30 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id z1sm12336131pfk.61.2019.12.13.08.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Dec 2019 08:53:29 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, mjourdan@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: meson-sm1: add video decoder compatible
In-Reply-To: <20191121101429.23831-4-narmstrong@baylibre.com>
References: <20191121101429.23831-1-narmstrong@baylibre.com> <20191121101429.23831-4-narmstrong@baylibre.com>
Date:   Fri, 13 Dec 2019 08:53:29 -0800
Message-ID: <7htv6488vq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Add the video decoder specific compatible for Amlogic SM1 SoC.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Queued for v5.6,

Kevin
