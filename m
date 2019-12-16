Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3CDC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1BF206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hIqxrVZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfLPKmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:42:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37973 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfLPKmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:42:51 -0500
Received: by mail-wm1-f67.google.com with SMTP id u2so6132159wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 02:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=++Lt5Fr+RwIy1Ndr73jFO/gA9fjeqgMoPVWGoy6+iBA=;
        b=hIqxrVZIYiC6WKAtC1ImBqJ2ksj72SS90RjWVGpzSu+WVWxOxXjy5t8owPEiX8d9F/
         fRxEgPEdq1nGU5o228ROMHVcnbwXhyqghCoiNMO8dfnatxvmBl2WHHL2JZrvrg8QOizZ
         9yc+T6QudxtwpsoQ1O5EwLFzh8UumMtaAGar/nq8jwvagrSqVrCbaOa8mV5WrWSvltPB
         whlx7Qr1zRqf+wzhGbNSgnrBbjQza9N4zXxkPfca068hdfr4zH1Ddao77q0x6KInu4ml
         W9TsGVbyEFMTOPf2Q9TJAVwyXEoI+nSdJkEl3It2ulu+t5aLcfjp13dB1vipbXSxTVpo
         pQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=++Lt5Fr+RwIy1Ndr73jFO/gA9fjeqgMoPVWGoy6+iBA=;
        b=enEjPUb21f1iQkddx71mrFmLlHqaZgNSFmYtZytM5RKt1R89udeSurRb635FREx7In
         4hW43cY3Xcv3CTugmljpBThntC1UTi+rFmY5Up+3QDH2SdMs/GLwv3mAFzxbn1YZOprw
         IoK+rF7N+F7fI3clWFyq6M9gHdyRxGe6gouBOK33l9S5F9DDlk/dyvFeKHufQrubwXtg
         tezuOssbjICY1tj0yvaliZlbi2/Fyqrr+UhVjHkblWPePFFooY8I6rza9uJcbO5adj8j
         /SQlNkm+Y9OO3TG6TdM7OlFFZAoos8MvInH+Q3M6gQigRj3sAt6CfiMmG/437AQXKhLg
         v6Yw==
X-Gm-Message-State: APjAAAVMtY+WsHntqeguhQ8zHr8IiBJlOJ1rGyZ/zxg67q6y+iLUXlfo
        JxQ4iyR3xXNwbKExr6a7DkSDRJ/jwIA=
X-Google-Smtp-Source: APXvYqzzwkX1ps0/zgn1aMQHOpmA2TSJ2eZ63E3HwGB4lr0SQVll7z6EkkJ2AHAdRx3f+aHoIWg9TQ==
X-Received: by 2002:a1c:407:: with SMTP id 7mr28746768wme.29.1576492968976;
        Mon, 16 Dec 2019 02:42:48 -0800 (PST)
Received: from dell ([2.27.35.132])
        by smtp.gmail.com with ESMTPSA id y20sm19628749wmi.25.2019.12.16.02.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 02:42:48 -0800 (PST)
Date:   Mon, 16 Dec 2019 10:42:48 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: mfd: ab8500: Document AB8505 bindings
Message-ID: <20191216104248.GE3601@dell>
References: <20191117221053.278415-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191117221053.278415-1-stephan@gerhold.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Nov 2019, Stephan Gerhold wrote:

> AB8505 can now be configured from the device tree.
> The configuration is almost identical to AB8500, so just add a note
> for the nodes/compatibles that differ between the two revisions.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  Documentation/devicetree/bindings/mfd/ab8500.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
