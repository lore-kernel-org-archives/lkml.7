Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16AFC31E54
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 03:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26F2214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 03:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfFQD3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 23:29:38 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37302 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbfFQD3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 23:29:38 -0400
Received: by mail-ed1-f67.google.com with SMTP id w13so13917850eds.4;
        Sun, 16 Jun 2019 20:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sFjB0B2Yj7Wbf8qVffPV3cOdRNWRzp8gkqP8qHZXJ9A=;
        b=jsfzMfsdWloq/J6ATyzGIVoDvsFo1+bBHE5Pm7g/SGPHf+zgNs43kLRHMOT48zjXPp
         79Kybiiqp3XjABXzeBmBLwnFCeB8EN2cnl1S2gW0Vv+VAQmG9WGvDUEsRKMtO6tdhE1b
         9M+C8TGC4v98NeTTizYEx1DnxBMc8HHWAR2PhYdMO5s5HzTme5B1YzzvBfdZKsuoM1IN
         qq7i+Zu4aU6UWRihu/JPPF7XxS7Nmi5OfWH7vs1lAlQkykAAm5Dyd35pABclGJl6V9da
         DDQ0D8cfpzyA3zYWiGKYzOdMJpZZq8w5rds6tI9GF6H6W9CxGwqtuoC8CZOAPZlTbPi9
         tT3Q==
X-Gm-Message-State: APjAAAUi4e9kizKaltR9RziiF5Mu7Y/7Ld+53LbsnDsunPodcCrgMYhn
        SBRwk0QZK2/ZPDR5aKzlKx57/8A0AdI=
X-Google-Smtp-Source: APXvYqwUGmot489/eBfMiHVs4cEG70kRwdMiO5DKoYERtSSKZcjIURlTZgkHHPL2N0Rb1xiTQJeJhA==
X-Received: by 2002:a17:906:1c94:: with SMTP id g20mr9187614ejh.179.1560742175643;
        Sun, 16 Jun 2019 20:29:35 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id i5sm3349681edc.20.2019.06.16.20.29.35
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 20:29:35 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id p13so8197667wru.10;
        Sun, 16 Jun 2019 20:29:35 -0700 (PDT)
X-Received: by 2002:adf:fc85:: with SMTP id g5mr74039823wrr.324.1560742175356;
 Sun, 16 Jun 2019 20:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190614181040.67326-1-sboyd@kernel.org>
In-Reply-To: <20190614181040.67326-1-sboyd@kernel.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 17 Jun 2019 11:29:25 +0800
X-Gmail-Original-Message-ID: <CAGb2v67s0H2XWx09o=LTDb=9Pc01RZhnf=qxcmqGs7Vih4tRVA@mail.gmail.com>
Message-ID: <CAGb2v67s0H2XWx09o=LTDb=9Pc01RZhnf=qxcmqGs7Vih4tRVA@mail.gmail.com>
Subject: Re: [PATCH] clk: Do a DT parent lookup even when index < 0
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15, 2019 at 2:10 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> We want to allow the parent lookup to happen even if the index is some
> value less than 0. This may be the case if a clk provider only specifies
> the .name member to match a string in the "clock-names" DT property. We
> shouldn't require that the index be >= 0 to make this use case work.
>
> Fixes: 601b6e93304a ("clk: Allow parents to be specified via clkspec index")
> Reported-by: Alexandre Mergnat <amergnat@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

FWIW,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
