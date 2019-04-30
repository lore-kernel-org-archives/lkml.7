Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FF2C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A3621670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556585640;
	bh=pwOPf7JE3qQ83diIA8kkBNtmBZ74DTjDv4ET8TBgYa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ql/1W1QlP6jlBq8iAaBnHPX5io/iSLJ0AIJoxYgpymoDPJLV3EUZDV+hlXCBAVAyN
	 US9YVJzNNm69oqKPmluIjIzL1ZQSjPRXvJQerh+oX4d+6zIN+NOeK7LUeMsnHam+Nn
	 8UM1ZjU568gafT9Xukk6n/+/U0K6jVqxoaLZENiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbfD3Ax7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 20:53:59 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38248 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbfD3Ax7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 20:53:59 -0400
Received: by mail-oi1-f196.google.com with SMTP id t70so4356392oif.5;
        Mon, 29 Apr 2019 17:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BmBzz+2LL/ow3G/3LbP1CmQvVguBPHTWsbFfuW3VYi4=;
        b=aE6RrbJWoVfrrbRwtznuEfH3zLmPNbN607ZT1GNKb5rYuY8Nn55xPB27Y+j3IHvJ9Y
         6Fqv+bnBkRKYIsQwBOJqCkgUEYwOi6qQUaKEUcCCg9SBuYLdwPpWFdgwBxsBoFKWoDwf
         BT3IHHA/PV3tbCvBl226Sm24uG/xjoDtZBDI1/Nkut5H55+3JzYcXxJ45ZnqS1ZNusAt
         THpmdTlTGKhXTuBkwjFjYHSssGU9hKjcSbYVyH7J9+VljKEhkF4yecn0TMvfslN/8zg4
         TfeRUnEPDKmJ7mO7IK6wSHX1pwsRTOL4QUyAWQOS1mi6P1QhKSFOgblT5YFHp/n0mpJS
         cT+w==
X-Gm-Message-State: APjAAAUfjNt4QS8jUtEUWENZJQlMJg81a3b3mHrAZxnFeSRYCx1QvhyH
        oU1o+eTrSW7xRSoLmeeloTDknCU=
X-Google-Smtp-Source: APXvYqwW2Rhfv2aIAH2xrUFX3CT2pOl/jA3haakgGQC0mYloHqU/cAV20Ao2z2vhfN4cRxPrwiFV9g==
X-Received: by 2002:aca:580a:: with SMTP id m10mr1383442oib.16.1556585638536;
        Mon, 29 Apr 2019 17:53:58 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s2sm3284079otq.28.2019.04.29.17.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 17:53:57 -0700 (PDT)
Date:   Mon, 29 Apr 2019 19:53:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        amstan@chromium.org, linux-rockchip@lists.infradead.org,
        linux-usb@vger.kernel.org, Randy Li <ayaka@soulik.info>,
        mka@chromium.org, ryandcase@chromium.org, jwerner@chromium.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: usb: dwc2: Document quirk to reset
 PHY upon wakeup
Message-ID: <20190430005357.GA13695@bogus>
References: <20190416215351.242246-1-dianders@chromium.org>
 <20190416215351.242246-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416215351.242246-2-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 02:53:48PM -0700, Douglas Anderson wrote:
> On Rockchip rk3288 there's a hardware quirk where we need to assert
> the reset signal to the PHY when we get a remote wakeup on one of the
> two ports.  Document this quirk in the bindings.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/usb/dwc2.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
> index 6dc3c4a34483..f70f3aee4bfc 100644
> --- a/Documentation/devicetree/bindings/usb/dwc2.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc2.txt
> @@ -37,6 +37,8 @@ Refer to phy/phy-bindings.txt for generic phy consumer properties
>  - g-rx-fifo-size: size of rx fifo size in gadget mode.
>  - g-np-tx-fifo-size: size of non-periodic tx fifo size in gadget mode.
>  - g-tx-fifo-size: size of periodic tx fifo per endpoint (except ep0) in gadget mode.
> +- snps,reset-phy-on-wake: If present indicates that we need to reset the PHY when
> +                          we detect a wakeup.  This is due to a hardware errata.

Synopsys or Rockchip errata?

Ideally, this should be implied by the controller or phy compatible.

Rob
