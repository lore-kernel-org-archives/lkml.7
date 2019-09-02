Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07221C3A5A8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CC3217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mhtkERu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbfIBJnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:43:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52240 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729668AbfIBJnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:43:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id t17so13798938wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 02:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4d0l7N35iWoMyBbjAl4hMooElMfpWLjU+xP3/QM48gE=;
        b=mhtkERu8jUQkzHnNqRbpGC8pMP8PM9wc9YYdW3YJzfxC+5CivPw0eN4Mx0FCBqkZ1k
         MMpoWhfUGlcZ11BMUqW6LIGUqZ5vgXx8aarqN0fXE9js6Z524xGTXLKm6blIp1daoMKx
         0J5VxGMjhAiQxIeU+zuC6dUZUtFUveEcznHTq14si0umE8rRYGiDKfwK+5RFTa/d29GI
         /c/EdZUuoNeHEdVdE8Wk+3yh73Qi+0Ro5yqJlSh32RqsCQGOvjbi8PUiqBo7yQt4iXzn
         6FzeKLgh7cF2NZ50ISsMteEICGPzKmU/mdoKRiwjs/fdB+p7i+EJT9EKTZ0LTnRwsHd+
         Es7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4d0l7N35iWoMyBbjAl4hMooElMfpWLjU+xP3/QM48gE=;
        b=ItoWqVOJo24OqTYMBLOa9mLDfkCHqFC4UsHh+LQCRDUay8ac/6gxguPP1WiW8N6r0w
         DSHHsY431GEOoa0ykIkT66qoKF8oKmzDyDtcvMctO82qbbxVBsgSm+iNCWxOZh/ROEpS
         oLBZpff5KYZCSenOTDFiVxns01Dktg/526AICKrG7tOPbGN1ZIRE8AlbbWZSFIUxHD5G
         D7wdGituGfuqPY1vl4RBzy2UWQJ7723PddA0D1lygMzo6XGKzNThsQhT6mtSakl6H3X8
         mkgMxplmBDrkYhHByF8QAciTJoDWm9hEKSL2yw4oO3JVMJpgScVB9v1B1B6pgebcVg0M
         akCA==
X-Gm-Message-State: APjAAAUis48seo+yDMbonXHnIaO+w7CJSOBWL5+0xcrIjDUdl+7bclBh
        eXqoqK5UaRg40ZmVGXTJy0/VBg==
X-Google-Smtp-Source: APXvYqzm2jMdu+QtRADNIC1TnhWQKqVD1sQ/ZS7+PqSLNP6Rmxvz386etPsBfvjnR60QuMOGSfWyEg==
X-Received: by 2002:a7b:c935:: with SMTP id h21mr33247098wml.35.1567417396069;
        Mon, 02 Sep 2019 02:43:16 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id e4sm11403837wro.21.2019.09.02.02.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 02:43:15 -0700 (PDT)
Date:   Mon, 2 Sep 2019 10:43:13 +0100
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
Subject: Re: [PATCH v6 01/13] dt-bindings: mfd: mediatek: mt6397: change to
 relative paths
Message-ID: <20190902094313.GP32232@dell>
References: <20190818135611.7776-1-frank-w@public-files.de>
 <20190818135611.7776-2-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190818135611.7776-2-frank-w@public-files.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Aug 2019, Frank Wunderlich wrote:

> paths in dt-bindings should be relative as suggested by Lee Johnes
> 
> Suggested-By: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> changes since v5: splitted from dt-bindings: add powercontroller
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
