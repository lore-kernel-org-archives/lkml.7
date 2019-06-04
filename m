Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2A0C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31A6206E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQ0vTsaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfFDPEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 11:04:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39236 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbfFDPEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:04:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so413680wma.4;
        Tue, 04 Jun 2019 08:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gR43S3Tc0yL04b0cnwqrNUq/7DMln80yTYJs6XCbVPM=;
        b=VQ0vTsaQmBYYRWyS+kDb4NIsLY1Sye8Wrn5ZLvk3CePx/8pB/gD2/Rn15gUfbYuU7S
         yl2eL7rqiOP1Gd+jgLVjqDZhQ0gLiDKpAT1omQ4yPAEOZjsyjfUpH4AGQPl2uc5HJmng
         h+iXAj+nuGwfcOFC7aRAy2ipIvMaHyQyMZBYTgj0iq+EW2yrYMxbv/hQAoNzM+3JtvTB
         4VgyS5CQE2nhbeNQfMwX9AyqCMmUoWuUid1v2HdtNbOxzGC/BREwuRR3RU1oDtg3XKLI
         1jFyGCc6ySbkxHUjhGMTYYvFleX9dPpyXNcQGEwQr4VP4nLasPymk03/GCqLqa+3mndM
         yUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gR43S3Tc0yL04b0cnwqrNUq/7DMln80yTYJs6XCbVPM=;
        b=j4QlcxjOBKIxpeseyVQulOYIzsZARvx0M8t46B9M21oruso1xbTThqbHm4xvEX35KA
         6vAvUuT9LH36TM9vM4UjXkVO9BSOt32s1CjM9uKS+Dk6qIT7GcwxpNKzhEhigGhVIj13
         mFbutWlCZ9p6Q3n8WrxOhZ7dcOy5sk7hRBcrVhh8jI5XtklyQ+Nr0Uy3o+LA29S02NvE
         i/77dQQxMz2UYOvcxqAKlVPg/kgCsHrIz96gDm0M/g3MUfkd1SroupfdvZIQ7dpvbfoD
         9DZD3BAlDvRb+d+Wv9dc8Yc/NlHavCbL1SupUiugtq0btvdU52yd3XxZUHnek6Ah3M89
         JTDg==
X-Gm-Message-State: APjAAAUhlAw7j063QaF83sL9SERCGtHv6ez2uN3x7X6T/7aQsDbiVHKq
        evBgeYpK7cwFfzMlQotuwak=
X-Google-Smtp-Source: APXvYqyYaNUpg4UwKb7n+gECGgoqY1H3Pelsi0JYsuIaQ1SgWvX6Fh61fd3YNYQTZkDkifjwlvourA==
X-Received: by 2002:a1c:eb01:: with SMTP id j1mr13535645wmh.60.1559660638995;
        Tue, 04 Jun 2019 08:03:58 -0700 (PDT)
Received: from jernej-laptop.localnet (cpe-86-58-52-202.static.triera.net. [86.58.52.202])
        by smtp.gmail.com with ESMTPSA id c18sm18063396wrm.7.2019.06.04.08.03.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 08:03:57 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com, megous@megous.com
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-sunxi] [PATCH] clk: sunxi-ng: sun50i-h6-r: Fix incorrect W1 clock gate register
Date:   Tue, 04 Jun 2019 17:03:55 +0200
Message-ID: <20522585.shqbOC0eQD@jernej-laptop>
In-Reply-To: <20190604150054.17683-1-megous@megous.com>
References: <20190604150054.17683-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 04. junij 2019 ob 17:00:54 CEST je megous via linux-sunxi 
napisal(a):
> From: Ondrej Jirman <megous@megous.com>
> 
> The current code defines W1 clock gate to be at 0x1cc, overlaying it
> with the IR gate.
> 
> Clock gate for r-apb1-w1 is at 0x1ec. This fixes issues with IR receiver
> causing interrupt floods on H6 (because interrupt flags can't be cleared,
> due to IR module's bus being disabled).
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>

You should add Fixes tag and CC stable with this.

Best regards,
Jernej


