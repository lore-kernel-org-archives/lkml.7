Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681DDC2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F152206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v75PO5hR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfLPQbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 11:31:45 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55942 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfLPQbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 11:31:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so7427146wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 08:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tOdF2v2tnPw84XyFs+DLGKUeb/1Y9vVZVEyHczF+0yg=;
        b=v75PO5hRYI3xifwe8IjjxOk8gXJmuPeTk8r/sebv8k5VXvGx2syxR0H2BKR6+vXv2H
         tXer/YdwJlAMyR6zpiMe252PHatrAG2aKC/69EAn0ZDmqxbtiiKDtszJ1HIgL3DgkLRd
         Y71pqiVAxrAniWaaLJfzb0lXCjDqpPY6au4dWY3RakMG9IrCBjprhEWpW4oSTXYKR6o2
         mdt/kTckQyZGRZ8izFK+O2fSRgUC3kCpertIvQABHrTv22+fA88ER9ECqNDpFSkkqWlN
         vlL4nqfNXTN3xHkdXsyHbGlOzAyx7gQHwXYJX9pETi/63ceapo1lij7b17hsEHuP5nWb
         PQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tOdF2v2tnPw84XyFs+DLGKUeb/1Y9vVZVEyHczF+0yg=;
        b=UgTUgzkdcQMTJ18DMQCbzMslVD/LFzcI/9sUEexGyOIdGo5PC5UDKk5KjsVkfNk0VO
         zW/42f/UE3Wrgnh3lFQ0LZTtc8/VXcAc4pF7+41kGYq+cAJC8kf4oSZm/6wb1em17KeQ
         wnIgGyMVsDUd4iw0VIl0+AnOTJ4z3IqXiPeh4xelUgiiwNBF1LfOjXxPs89yMwZysw/f
         eHpqS/rqhGts6wpem8wZsj3L2bv3vSukvzmVLe9kG8+kRgWyA6Ae1ck9kLrpTllURou9
         bMtC6oePRILGK8fzM2ob0lNA2kCehOjGbS0IcbJooKqxNdWw7T5AMdvKRkILgB/TpktF
         g5IQ==
X-Gm-Message-State: APjAAAV2y+sKYm3b33BmU6HnMVKaU6zoHHUzrJ7i+h+7uiCavdTINqhU
        w6ibQ/2fYEdPjwNIyqRS43G/pg==
X-Google-Smtp-Source: APXvYqza4ODdROrK4+NXBOk9wQRDqm6YbdINa4RvvhiswJwObb7hlbCMFzyXEVki5DExzxaNMZShsg==
X-Received: by 2002:a05:600c:2218:: with SMTP id z24mr31321397wml.50.1576513902937;
        Mon, 16 Dec 2019 08:31:42 -0800 (PST)
Received: from dell ([185.17.149.202])
        by smtp.gmail.com with ESMTPSA id w20sm21142865wmk.34.2019.12.16.08.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 08:31:42 -0800 (PST)
Date:   Mon, 16 Dec 2019 16:31:41 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     support.opensource@diasemi.com, robh+dt@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        joel@jms.id.au, andrew@aj.id.au, lgirdwood@gmail.com,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 5/6] dt-bindings: mfd: da9062: add regulator gpio
 enable/disable documentation
Message-ID: <20191216163141.GS2369@dell>
References: <20191129172537.31410-1-m.felsch@pengutronix.de>
 <20191129172537.31410-6-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191129172537.31410-6-m.felsch@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Nov 2019, Marco Felsch wrote:

> At the gpio-based regulator enable/disable documentation. This property
> can be applied to each subnode within the 'regulators' node so each
> regulator can be configured differently.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> Changelog:
> v3:
> - adapt binding description
> 
>  Documentation/devicetree/bindings/mfd/da9062.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
