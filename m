Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8FFC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7363E214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LliSzz7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfEHLfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 07:35:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53782 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbfEHLfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:35:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id 198so2827254wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 04:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HXeOrT3youkkGlJIREGe1d+8JaSnzpTXLtcFxjjLlUY=;
        b=LliSzz7pVx0hjhCRfi+t9+LqV4Ah8haHdit5fv0NgcDm/ODp589aw2xPWnbKMLrekF
         Rv6P/MsoNN+69PGk+3WmM08UPq/pQbupbjOhSH56cJviz1J/IYisYdfZgkMc6FkxpD9G
         TldD+G8t2K7r6oq4TYB69Q4OZTkowf2l8R+dLOqWYpNZFWxUBb6YBkCayqd6M1qWtwgR
         wWp+/42MzAWZBBLPfzxvQdftRl3w6XIt8Wh6Zfo6aJ+Bhiwi3iZxhTorxcoR5OwrFZcp
         Jt8yia6x/rVZ6WihXYcNaL5dHTFSyfd7CdHOjy7B/yP5f3SdEPRkJGZsZbNnEiVh1OCR
         uYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HXeOrT3youkkGlJIREGe1d+8JaSnzpTXLtcFxjjLlUY=;
        b=J8iE+wRtvV5o5pH9TtPtRyLi9dw6OSDQw2FAkMb/CRLCG2HQtAB+nJRNK/4PTipN8D
         u1Jb+hY/aTIO5VhRl4C4ACnTblNbjL90bEO0ybVxy14IMUhBZ7U8YMQd2qDxxDT+bD04
         FGMtki5JqjIt6PJD8cgxwf0I3S3Dxu+/In7s0ASppyb5p1kLLsyqmA0KaGNU4sLf454I
         XLqEifoBb9r0YajfjLxiJXZvdO8fGD1H8g0sUuYXy1WHehywfEmRTd8sgkVdtnb3tJL+
         9c2/7u0o/mHyWFjMVkcbkLIa2QwY1irihZ/h8+NJFTV0tuSQ9WT2TYJT36juSavroF0a
         lBBA==
X-Gm-Message-State: APjAAAXW0kVwyk2G2zLCowkAjdXzIs65t+1OJd5wyb80w+y0ry7rz1f5
        EL+J4g2uqARuoIAj0D/x7Tx1pw==
X-Google-Smtp-Source: APXvYqwNFOAfUkxBrSyIDhXFkjVCnIQEKaQPvZER01gSPTdvNyQBaKHpBzlgxc/hpy319B6Un5JkPA==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr2669949wmc.137.1557315313220;
        Wed, 08 May 2019 04:35:13 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id v184sm2645597wma.6.2019.05.08.04.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 04:35:12 -0700 (PDT)
Date:   Wed, 8 May 2019 12:35:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, rdunlap@infradead.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/7] dt-bindings: mfd: LMU: Fix lm3632 dt binding
 example
Message-ID: <20190508113510.GA31645@dell>
References: <20190506191614.25051-1-dmurphy@ti.com>
 <20190506191614.25051-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190506191614.25051-2-dmurphy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 May 2019, Dan Murphy wrote:

> Fix the lm3632 dt binding examples as the LCM enable GPIOs
> are defined as enable GPIOs per the regulator/lm363x-regulator.txt
> bindings document.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
