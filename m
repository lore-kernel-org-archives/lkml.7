Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E467C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A7721773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553779128;
	bh=4/YwXwTMHzFUzuM78vsUxfC1Aq5VyGnNUXQ0rWeffIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EwrDwOXPVSOEr7QwTyPej3nspxGYLqoGp3S1jwdKOhIITk+G11wykh0z13+knyxfI
	 JJtUV4EZsERDQeSSRlY8hJd8VB2MVR+SgXk4CUY2owy8oKlZJwZNyUHtGUmAaM638y
	 6USByWLlznwv9eVvM68XAOdqclPnQemOi8gsNuKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfC1NSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:18:47 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35747 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfC1NSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:18:46 -0400
Received: by mail-ot1-f66.google.com with SMTP id m10so10644688otp.2;
        Thu, 28 Mar 2019 06:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5d2lRqa+a7/fX6CpKJ87Bae8PMCaBCPpXzoplQctylA=;
        b=tIk1BVaM8EH4AzNc49kDzWHPyD59jAzs72U7szhYD/iHU0OhJkx/Xwj31aE1UxiyGF
         ZzLQPPIdpi2enc590yiUFrKk62g0z8P2JjblwLfpuZR3vMeSdoJ/dd8gXdQ+FM0e8pSR
         5zZqcQ1hURSjgim/lo+JnMvXvX3+/KcPnWAWYtv/1bnwKdgfgHZBoE8a0O+oqf3Jy7S1
         nGFuZ7BAWIrY2gMGygUBSJwvRtBWe4KN9Fntdic73u0jTryKODPVX23Ynk6zYCn3OkST
         nFpIWZfEK/syDG2gUyWg4W94zdjiGPWa3gE2SSwME65x0hQzxw5lHStZ3CfiVw3x4TAt
         Y3BA==
X-Gm-Message-State: APjAAAX+ZLb3RzqQEvvslLt70vlpKiPXHOXbLceFYEoXr9tFjI7Y+e8t
        Ad/F2n9ObjupAsqzZnfgMQ==
X-Google-Smtp-Source: APXvYqwnIZK8cmA0YO3iFprGZzfXLkswL+QHCB4kYtvHSBHCzedrf8/b9bKJsZnkgklrnaIbOREtOg==
X-Received: by 2002:a9d:560e:: with SMTP id e14mr9296432oti.31.1553779125497;
        Thu, 28 Mar 2019 06:18:45 -0700 (PDT)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id o1sm4519513otj.11.2019.03.28.06.18.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 06:18:44 -0700 (PDT)
Date:   Thu, 28 Mar 2019 08:18:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 03/14] dt-bindings: pinctrl: add compatible string for
  Allwinner V3 pinctrl
Message-ID: <20190328131843.GA30336@bogus>
References: <20190312152256.35574-1-icenowy@aosc.io>
 <20190312152256.35574-4-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312152256.35574-4-icenowy@aosc.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 23:22:45 +0800, Icenowy Zheng wrote:
> The Allwinner V3 SoC, despite come with the same die with V3s, has more
> GPIO pins than V3s, and a different compatible string for pinctrl is
> needed.
> 
> Add the compatible string for V3 pinctrl.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt      | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
