Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A51C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892D121874
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IPp3tcOW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731355AbfIBJoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:44:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33076 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730260AbfIBJoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:44:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id r17so11509965wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 02:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rzr6c6CJF4AO7OQdux81zJnqNsWs8fMapTnA/mWIH2k=;
        b=IPp3tcOWV67rZlX80/E5IFYzBXPjJMI6rryBXkLyrFUeBYFXwRV7zI4CLc+AKIFldP
         64rpcf21UoGVpp3I5Sn/ftpeEBMg8okKXbriPwbgXuMWaIXsWG+KJSfb5WopSyq4fHos
         uQJBobf4xSaIORYzXjGtKOXrwg/QH5ZWf8U93DWm8FG+0D40HQXWFoPdEDcjhxN7GEuq
         YuYWYj819EzbkE6cF0l3wpzBqKx3f7sf+kBfqHJolG0XfW1gf1S8uHsq6MzkbA5YRBuX
         9KqJHrA9L/utr0gH3zxbszxrh7VeiVd9PwOC4A9HNr+sGhBHb35gm0bNbLGuWj25EOHW
         CLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rzr6c6CJF4AO7OQdux81zJnqNsWs8fMapTnA/mWIH2k=;
        b=M58+2PNUHppZkIdLAdB2ysn8Nbcj3Ot8sBbN37jjVLJCn77jLxZYVXnP+i2EOPgnOy
         B+xv7WyjxtzLCHkNTXeQHpyTQCT/W6swigykbRRrIAId7oNcF+noe9rGJgCKONB1pB4d
         vrxj+BYS5C8m0szGZFyeLa2NirpgLpFjwj0J8i7y9fMaMJppiBXapvWJwV98J4Q5Scuv
         6m13mxrIVFoeqCwcjb7A2mzL5KeaoeU2/MYnmuojWfyFdSBptjKfFjrYkO2qAcV5HKcX
         uVp3aT17A/J7JJCy3KhLynVmCfeopklv3vBGyaRkUKyAbxNvrm5KGmJ4KPEDsqW3iW7r
         E28w==
X-Gm-Message-State: APjAAAU9aUnuS3qdwA/LCbAesk1Ml6iMFC9cOurkJQd/X01CvOXOpMLV
        bhSHtZZ2RfVUtDv+j+GeNC/EqA==
X-Google-Smtp-Source: APXvYqyiJ+KUkcFbJzvDtuCJ7zAHN4kxjezhQQTUAC0DDyiipTQ7w7uuuYjP+HBaNj3IQDM7tdGAWg==
X-Received: by 2002:a1c:c5c3:: with SMTP id v186mr20911229wmf.66.1567417453967;
        Mon, 02 Sep 2019 02:44:13 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id u68sm20849297wmu.12.2019.09.02.02.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 02:44:13 -0700 (PDT)
Date:   Mon, 2 Sep 2019 10:44:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        "linux-arm-kernel @ lists . infradead . org Alessandro Zummo" 
        <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Josef Friedl <josef.friedl@speed.at>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Tianping Fang <tianping.fang@mediatek.com>
Subject: Re: [PATCH v6 02/13] dt-bindings: mfd: mediatek: update rtc to
 include mt6323
Message-ID: <20190902094411.GQ32232@dell>
References: <20190818135611.7776-1-frank-w@public-files.de>
 <20190818135611.7776-3-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190818135611.7776-3-frank-w@public-files.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Aug 2019, Frank Wunderlich wrote:

> From: Josef Friedl <josef.friedl@speed.at>
> 
> add mt6323 to rtc-bindings
> 
> Signed-off-by: Josef Friedl <josef.friedl@speed.at>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> changes since v5: splitted from "dt-bindings: add powercontroller"
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
