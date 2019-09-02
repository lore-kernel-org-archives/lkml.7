Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA50DC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E7F217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CmcNGkZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbfIBJou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:44:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37817 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730015AbfIBJou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:44:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id z11so13308972wrt.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 02:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qd++qlXo+afPltQBesGSfDh/78ykDbV4CflLE8Z4FBI=;
        b=CmcNGkZYbOXX56CkkyUQiEcj2V/JwCX/HPonVAuRIH/jfFxLuIXgB/AQ67mn1ufEGG
         kg2qfhRcSGATrqKjKdds6Tp3aqpt29i4pYMDp4zrA2C/2v1vDDR9SlkRMDr11o7EdUBb
         qCQ7gKVZ8awETYWQ8cpQ09UfE3qotA+q3rmDNURtCvoBXgBeS8/MYX3qbfgsnzRNatc7
         lO/hXSzdOPqYfFqBKmjzdTfF3D8nKgBHZWKIx3YXfG5WMLX+qb2icEeOW7r5XJjCs54C
         t+YvB/Ymr7JjDpaxktA9g5I+a7eHzMNHeJjNoE96/Ag9zpbphvfNXea4hrooRMzrSS7b
         uZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qd++qlXo+afPltQBesGSfDh/78ykDbV4CflLE8Z4FBI=;
        b=j5BFyg3Hgv5Ch6CWfA/Ukl7keSvfZ3Azmd2aybByomKPtjlfCNv76J5jcRabLUBeJf
         yo+ePkl/F4lYNEH7mATxO7oYbaKabxNF/FzYUq4HsWLie8g9JCuGgoaTXtnBR4pP7mLn
         hAau1gKp+yKiLLNzYSlHR1Mu9aI26A7AB+pxU57HXdrNEkbYuZR5Hj9NIizja7RiEeFi
         bKf2R1+BIgM577pMLpUxyb1C7ZGwqE3j7557WclinSkZQu+HF5Zc9LSgziwkSH1v+opd
         zs8ikaPzPs7QSoiADmgjRUY+FyJl23vdcwUH1tGhgp7F+ii+7x+XIpx6zRYbFWU/5SFY
         soIw==
X-Gm-Message-State: APjAAAV4JN3xVfFGF/U4JKynsQPIpHMak6iZ/VvKWgJiUHKHCbtoiBym
        2NH0F7Oj0o1ha1MNaA7ejmFeyQ==
X-Google-Smtp-Source: APXvYqzBC9wQvqJpV9XW7R3+58fb834Rs94m6nZbv917724zDE4pMNUIC8FJHqYHZ/5VOym469o4yA==
X-Received: by 2002:adf:e7c4:: with SMTP id e4mr31602370wrn.62.1567417487988;
        Mon, 02 Sep 2019 02:44:47 -0700 (PDT)
Received: from dell ([95.147.198.93])
        by smtp.gmail.com with ESMTPSA id y6sm4378512wmi.14.2019.09.02.02.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Sep 2019 02:44:47 -0700 (PDT)
Date:   Mon, 2 Sep 2019 10:44:45 +0100
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
Subject: Re: [PATCH v6 03/13] dt-bindings: mfd: mediatek: add mt6323
 power-controller
Message-ID: <20190902094445.GR32232@dell>
References: <20190818135611.7776-1-frank-w@public-files.de>
 <20190818135611.7776-4-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190818135611.7776-4-frank-w@public-files.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Aug 2019, Frank Wunderlich wrote:

> From: Josef Friedl <josef.friedl@speed.at>
> 
> - add powercontroller-section to existing binding-document
> - add mt6323-pwrc bindings-document with example
> 
> Suggested-by: Frank Wunderlich <frank-w@public-files.de>
> Signed-off-by: Josef Friedl <josef.friedl@speed.at>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> changes since v5: split out non-pwrc related changes
> changes since v4: none
> changes since v3: none
> changes since v2: none (=v2 part 7)
> ---
>  .../devicetree/bindings/mfd/mt6397.txt        |  6 ++++++
>  .../bindings/power/reset/mt6323-poweroff.txt  | 20 +++++++++++++++++++
>  2 files changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
