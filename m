Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2DDC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 21:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5B92080C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 21:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cl0rVA3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbfFIVwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 17:52:21 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:34189 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbfFIVwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 17:52:21 -0400
Received: by mail-lj1-f182.google.com with SMTP id p17so1240221ljg.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 14:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3u47NK04VLWnks2ECFn41iwvdVn3zhAxLH2OdU56Dmw=;
        b=Cl0rVA3z38e6L8+wW94OpWj72TSurDFbVXa3pn24DZWJJzrOrvC+fdcaUtFQndqIgP
         txxwbLiEo1JBtH/op3umTaxckv2djd/WaR5I5qa+EGNTpKe0HtK0Tq8lpu4RgQ+aidH1
         RQN+njo2AS3nHqvbBnl0jOecogbHfZyq2ZQoBr6Un7SjO9AiaCcnPinHmJPgJB5ysgy5
         i4n1mXa2crZfqK3FvymkbMZneKJ/uEnHKZlQ/hZb3BaKT89F9FiUvIiAc0qIjTvgsyHc
         GdMMVySRP+4084kUDTBoax7mRi1FuV0caKswGmr9183KWlYwKXnOIZg9Gxdz/EPAQTx5
         IU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3u47NK04VLWnks2ECFn41iwvdVn3zhAxLH2OdU56Dmw=;
        b=pj+cIWDeoumZ59zlTVa+5KlAkSyBC+EppwqCIWKpQ1UZClcG6c9267/sbiNuSU/iLS
         rZ72EM6AYvZQ58zp6lAHt7Kx7Erz/GKiaVNCp9hweEZuAy3KPneXtW7WIqTqCRb1EcsP
         1UXE6L8wjFPxHm4prmyeycu3tkZ05UTP/HDn8OIg+kSDX4FLzMz4G0Cc6VTpEB3TbDFS
         sPydDmPocdqdqzE7UMlwau/trvNLIeNw816mG6uGc2svs7Be1q+pmfC8BNDD4TR0Kumn
         tBs8aSVWcC7/His/h8iT8xURqjHMkvQ2HLBJoGS36dACYKMBr4HYSKrFzG8s9qtZFegE
         4u6Q==
X-Gm-Message-State: APjAAAU9dGSfUe11XlbYaBS/Modd5Ct2mXTkAJeY7o7KkaJF3p5Tt1Ee
        ImgVWZExmOsCoDt30AtsDh+CcBW33BjUSPpIgckeVCye
X-Google-Smtp-Source: APXvYqxxvAPH8DO2c0X0YBL0L2eBq2A1RkbOzyw6mq+phUKB0rDXYXygI1YbFcBf/zVxAnxBKN7lStrxUTnG75YtXlc=
X-Received: by 2002:a2e:9753:: with SMTP id f19mr10655574ljj.113.1560117139172;
 Sun, 09 Jun 2019 14:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190609180621.7607-1-martin.blumenstingl@googlemail.com> <20190609204510.GB8247@lunn.ch>
In-Reply-To: <20190609204510.GB8247@lunn.ch>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 9 Jun 2019 23:52:12 +0200
Message-ID: <CACRpkdbOnxZJZ=Lvv0mbnrCg8kPWyeRsBbOa2cUiwjcPnR=4RA@mail.gmail.com>
Subject: Re: [RFC next v1 0/5] stmmac: honor the GPIO flags for the PHY reset GPIO
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        netdev <netdev@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Giuseppe CAVALLARO <peppe.cavallaro@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 9, 2019 at 10:45 PM Andrew Lunn <andrew@lunn.ch> wrote:

> Linus can probably create a stable branch with the GPIO changes, which
> David can pull into net-next, and then apply the stmmac changes on
> top.

Sure thing, just tell me what to queue and I'll create an immutable
branch for this that David can pull.

Yours,
Linus Walleij
