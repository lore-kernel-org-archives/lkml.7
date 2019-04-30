Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA63C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 01:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B09B21655
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 01:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556587412;
	bh=TNbkka32dDokHvEekZPM54zKlOh6IiXzyfGMUhlLNiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zSHmZBtYBVxoFYK1AmKz2KoZLcm3BuUQpaKicPSsmhCeDWuAZCqV3/0OwMeFjXKmV
	 vmanUJpGIgDIRgBchlQ9Cdd4agylVJHLuy6VDZNQwmlh1ybcwBiqXoJUKyzdc5y78k
	 d6oQ0l9Q6Upj4JP+v4/9ILOIJMORlutV99U+PFKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbfD3BXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 21:23:31 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42495 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbfD3BXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 21:23:31 -0400
Received: by mail-ot1-f65.google.com with SMTP id f23so10438638otl.9;
        Mon, 29 Apr 2019 18:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fLCNptbAqgGLbxmiV5m9esJWTcO9d7PGiLKbWNbQI4Y=;
        b=pyInkl149oIz0fINvWOVMsdn8AcUZzZMsqlSa7v85gg4KE35r4uck69xNm/ho+Knq4
         IzzSs7aMjmL5Eaj+6oFFGMJWvwrQoIb3956nOZPBgl3FX6H5fMKhpHk4dISx6fGnCukc
         zWcgPF4nwZgI4lIXvZOm/tg7YfbuPlwiXFtfB2h/uxfRlZpdfJ/8UyWyA+fnAe3Ff7OC
         QROaB0oudBdvbMfvRBtSD+tbC8do0lojlFgN9sX8VFKXonOOnxrqrUmwEr5RLCjdVOMu
         BDIasEacD+4LbgEW4TtTbCw8lBLG5F3IVAHSYy+J1fDNCrHxwhSklxul5vl/eleUX3uo
         4SXg==
X-Gm-Message-State: APjAAAVREX0ePY2/L7rj+HhgwSdB4P5sCe+xd3U7Q/FVfRHH8h9196zA
        u1H5Svz8POQS9r/0gW369Q==
X-Google-Smtp-Source: APXvYqxr8Cm+FM9VThpkbETtAkluspE6CKnCHzDXX3Pa3YrGOQn38oLZRa/gk3PUp+5WlkzbxZyFuQ==
X-Received: by 2002:a9d:6153:: with SMTP id c19mr5171001otk.110.1556587410598;
        Mon, 29 Apr 2019 18:23:30 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w13sm922030otl.26.2019.04.29.18.23.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 18:23:29 -0700 (PDT)
Date:   Mon, 29 Apr 2019 20:23:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>, heiko@sntech.de,
        Alan Stern <stern@rowland.harvard.edu>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        amstan@chromium.org, linux-rockchip@lists.infradead.org,
        William Wu <william.wu@rock-chips.com>,
        linux-usb@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Randy Li <ayaka@soulik.info>, zyw@rock-chips.com,
        mka@chromium.org, ryandcase@chromium.org,
        Amelie Delaunay <amelie.delaunay@st.com>, jwerner@chromium.org,
        dinguyen@opensource.altera.com,
        Elaine Zhang <zhangqing@rock-chips.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 3/5] Documentation: dt-bindings: Add
 snps,need-phy-for-wake for dwc2 USB
Message-ID: <20190430012328.GA25660@bogus>
References: <20190418001356.124334-1-dianders@chromium.org>
 <20190418001356.124334-4-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418001356.124334-4-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 05:13:54PM -0700, Douglas Anderson wrote:
> Some SoCs with a dwc2 USB controller may need to keep the PHY on to
> support remote wakeup.  Allow specifying this as a device tree
> property.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> For relevant prior discussion on this patch, see:
> 
> https://lkml.kernel.org/r/1435017144-2971-3-git-send-email-dianders@chromium.org
> 
> I didn't make any changes from the prior version since I never found
> out what Rob thought of my previous arguments.  If folks want a
> change, perhaps they could choose from these options:
> 
> 1. Assume that all dwc2 hosts would like to keep their PHY on for
>    suspend if there's a USB wakeup enabled, thus we totally drop this
>    binding.  This doesn't seem super great to me since I'd bet that
>    many devices that use dwc2 weren't designed for USB wakeup (they
>    may not keep enough clocks or rails on) so we might be wasting
>    power for nothing.

1b. Use SoC specific compatible strings to enable/disable remote 
wake-up. We can debate what the default is I guess.

> 2. Rename this property to "snps,wakeup-from-suspend-with-phy" to make
>    it more obvious that this property is intended both to document
>    that wakeup from suspend is possible and that we need the PHY for
>    said wakeup.
> 3. Rename this property to "snps,can-wakeup-from-suspend" and assume
>    it's implicit that if we can wakeup from suspend that we need to
>    keep the PHY on.  If/when someone shows that a device exists using
>    dwc2 where we can wakeup from suspend without the PHY they can add
>    a new property.
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/usb/dwc2.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
