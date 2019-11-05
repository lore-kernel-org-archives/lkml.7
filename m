Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08276C5DF61
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 21:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AB121882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 21:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572988412;
	bh=KMDEbo9BzS1BKO+4mnPuhOiHRDOPVu6VDc4pIhsYFow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W8McEW2DDYetP8WpJbHtai3Gn4wiZ17cu6v5l3lTpqTy27fptoHaHWwPj62lem3CL
	 6Sy+5pgO3AVc3gL0M+B+ZY+wFKjJH07gbHgRfXGs1XjKmliUHtQe0BV2J0jGk4wh4b
	 FYzDgUOnjJ4Gooj95XAVQtaGUnOEFaEdHwdwEbCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfKEVNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 16:13:31 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38353 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729747AbfKEVNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 16:13:31 -0500
Received: by mail-ot1-f67.google.com with SMTP id v24so13645815otp.5;
        Tue, 05 Nov 2019 13:13:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:content-language
         :user-agent;
        bh=xQpq10Ks8XLSF1aJ2J82yaLZle4uyS06RKMfH207b18=;
        b=Sd+ncQsFGbUTlwJbqQEVpQuhglbvoIL6bg4gqVJHuaHd9hHM4mkg3vMYK+yaZp/Iii
         iqe5I4Kn98Z5IY2xxcQpKu792S0UWBH45JbzqM3voB/BpUHjxadNgDPB0V4P+ABEq5T2
         szVSCAL/4oBf7ku9Yi3QX3oQCLS4U4eBv/HxASGnSDkqj7+grJtyD/Q/QppVDEgFfwmc
         30FsE/N2eX75RTKKgDrnwcOoPhf9ZWutu4kRpXn8DSkbDHHNXWm4L6+u55fNxO1D22IL
         E4c4bVHzsqw4Nr76ZoXOFbwOlLpJq/0OTcEOilCqK7UeaW/vNFTrV/wZ1SSJr4FIkZvI
         wm5g==
X-Gm-Message-State: APjAAAVGUblnHYIBRNGGAZuwxenSyxdCyeRJ4w+lXQYN9j7ru3L5HJ/5
        8LXTD8ItgzdDyZ/uz7QrNQ==
X-Google-Smtp-Source: APXvYqwHT0XCg7MQJPjIrO3FGkI6ss3iabZx/QluxT+8GcfXTqMGF+mC6vHeujjKmzoz13wa+CMPtw==
X-Received: by 2002:a05:6830:11d6:: with SMTP id v22mr4995027otq.142.1572988410403;
        Tue, 05 Nov 2019 13:13:30 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c15sm6799521otk.12.2019.11.05.13.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 13:13:29 -0800 (PST)
Date:   Tue, 5 Nov 2019 15:13:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: rockchip: Split rk3399-roc-pc for with
 and  without mezzanine board.
Message-ID: <20191105211329.GA8500@bogus>
References: <7293c5f6-a07f-cf51-954f-92907879eea2@fivetechno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7293c5f6-a07f-cf51-954f-92907879eea2@fivetechno.de>
Content-Language: de-DE
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Nov 2019 16:22:25 +0100, Markus Reichl wrote:
> For rk3399-roc-pc is a mezzanine board available that carries M.2 and
> POE interfaces. Use it with a separate dts.
> 
> ---
> v3: Use enum in binding and full name in compatible string and file name.
> v2: Add new compatible string for roc-pc with mezzanine board.
> --
> 
> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
> ---
>  .../devicetree/bindings/arm/rockchip.yaml     |   4 +-
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../dts/rockchip/rk3399-roc-pc-mezzanine.dts  |  72 ++
>  .../arm64/boot/dts/rockchip/rk3399-roc-pc.dts | 757 +----------------
>  .../boot/dts/rockchip/rk3399-roc-pc.dtsi      | 770 ++++++++++++++++++
>  5 files changed, 847 insertions(+), 757 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-roc-pc-mezzanine.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> 

Acked-by: Rob Herring <robh@kernel.org>
