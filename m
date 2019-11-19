Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E581C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 20:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249D222448
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 20:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574194703;
	bh=fCngud5e24l3m49KZf+3a6ZQ2F+yxF50s4pbJ9AdGW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LVygLtKNr3rAqFgvd9+IZ7KooKzMeoYlyrn19Y/Y3LRmZ3nqIBHtX7/yCt/uBKyU0
	 X1qtKPLokJQ/Jy6s+hkEGDZcGaZNNy7PCQ/I5K/PRn7DXoH5/FaH2mJ1AkqrehH7Pk
	 cfSVfKTg27K17Jtexz+OxnkG5rWOMZcbrzSXvX5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfKSUSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 15:18:22 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37989 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfKSUSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 15:18:21 -0500
Received: by mail-ot1-f67.google.com with SMTP id z25so19129057oti.5;
        Tue, 19 Nov 2019 12:18:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=onoq+Z2JcZ0wm7xV09BtvAAc615BtbBWD3mKE843QYY=;
        b=oyU8RUJ4BBLwQJJDFhZwnxdmGoehLys/5yWi8DY26zRexUNs2TJbRBYQ7lqSl/opn0
         3eexwqc2BgLqmRvfwjhlOeHiGDItWKanD6iU/65vonLv3q3k2jryKt59wqQc/PhW5+vn
         XCiKewsWvylk+qToje1uG458N4wrFn5HY2QzPNpcrmXpE7a/pgpVb8N225gNBQNb1UuK
         0yUrVDOReK2cv+ldJUsdLn1N8yj3ty1CCAlQCdOwQNnBQqAshP4VPn/kPV7Lbaaq3M9g
         5OXhvZPzlOklKX35zMO3nGQwkfcDe7u/lXBmo1g7ZTa855RgmjCY+v+vRRYvqoLHO7x0
         5axA==
X-Gm-Message-State: APjAAAUpTjO35UqLvyThySfYEMRswK3VnqW4HPXqF8Ep6UBlTemfi3SQ
        uxEEJCHORhHeRB47FB05hQ==
X-Google-Smtp-Source: APXvYqzk50DUwK44cVAQKNTxSjvx/DhWiu+LrLwLviaKJdBnE6+0GzA6D87C87M4wXVUnS//c5dHvg==
X-Received: by 2002:a05:6830:15a:: with SMTP id j26mr5085138otp.342.1574194699323;
        Tue, 19 Nov 2019 12:18:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u1sm7574771otk.33.2019.11.19.12.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 12:18:18 -0800 (PST)
Date:   Tue, 19 Nov 2019 14:18:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v4 1/2] dt-bindings: pwm: Convert PWM bindings to
 json-schema
Message-ID: <20191119201817.GA17082@bogus>
References: <20191021160207.18026-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021160207.18026-1-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 06:02:06PM +0200, Krzysztof Kozlowski wrote:
> Convert generic PWM controller bindings to DT schema format using
> json-schema.  The consumer bindings are provided by dt-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Acked-by: Paul Walmsley <paul.walmsley@sifive.com>

Looks like I missed this one somehow.

I've applied the series now.

Rob
