Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC84AC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 23:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A742147A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 23:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560467172;
	bh=Z7MqeQpIZpNdldzl502G6ZU3vKmfiSOmy3RWGn8CUF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mdSVwedq6itFJOwBUyn8SU59ucBrRPGFVXYC3tsYaeQnXsKnxd43/Lj9NoQevRbTi
	 pLAsKIdA1D3ReFcLhrEW6N3svmy5XKQ/Vn+3j9V2BlEr42zrWTe1yytHh1gah/lNta
	 3zRjDJDUbD0CgZCr3XSWJEtfr29Fj4kD/ujZMC4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfFMXGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 19:06:10 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45588 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfFMXGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 19:06:10 -0400
Received: by mail-qt1-f194.google.com with SMTP id j19so350776qtr.12;
        Thu, 13 Jun 2019 16:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0WB7++WgXsHSMQU/iyYHt1wyyCBYlEx8/DL9NzTbRRs=;
        b=nLEwdSHpRjxIF83kSW5Qk2UDSHZ65U7Z35qzojL3TZGoFWOQe27FRk1rSo9PV8/XgA
         mzQ0ZLPMnYWPexnev53P7yCexa+I2GzphFDwRijOJ1W5GVepU0j9JX50R913ecUjTBBh
         tDsBumb2SeuFpXRBC8nXroJ/WRRbnoVvPAN+YrNPo/M8Ho8XHMtPc31zhGLMCMnKoGWH
         i69vWDjphTJ0EhJtktFfnu8Wx0KqZRHsOpnGb5kEF44aKEu7HUO5wfUOg+e6hY+/luEJ
         SViDjQerZ6pmjcDbwKcOZVg+/9qbkmopKWFDimaaf1jFk+5XakpFGWhYvjcuYaaKIen4
         TImA==
X-Gm-Message-State: APjAAAWLbAy4VJP1qMCbmaW0sc9Bd5bZ9o8oxcM+kMZRHRyzGoJP2dVW
        FnolJhiBoncRs5nfWNIqkg==
X-Google-Smtp-Source: APXvYqx+14G87vSF1DTU9nLxwM7+unwwEu2UUz11EbKZ7aTXFmfrxUUj04BpoYDxl/NFoTvXCrZb5A==
X-Received: by 2002:ac8:3301:: with SMTP id t1mr72629681qta.209.1560467169096;
        Thu, 13 Jun 2019 16:06:09 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id y16sm404646qkf.93.2019.06.13.16.06.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 16:06:08 -0700 (PDT)
Date:   Thu, 13 Jun 2019 17:06:07 -0600
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
        Elaine Zhang <zhangqing@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 1/3] Documentation: dt-bindings: Add
 snps,need-phy-for-wake for dwc2 USB
Message-ID: <20190613230607.GA10347@bogus>
References: <20190520175605.2405-1-dianders@chromium.org>
 <20190520175605.2405-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520175605.2405-2-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2019 10:56:03 -0700, Douglas Anderson wrote:
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
> NOTE FOR REPOST:
> - In v2 Rob said [1] he'd prefer something based on the SoC
>   compatibility string, but that doesn't work because not all boards
>   will have the regulator setup / board design / suspend logic
>   necessary to make this work.
> 
> [1] https://lkml.kernel.org/r/20190430012328.GA25660@bogus
> 
> 
> Changes in v3: None
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/usb/dwc2.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
