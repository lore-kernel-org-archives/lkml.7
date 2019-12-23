Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A41C2D0CF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED38720715
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBDmb6ak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfLWOxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 09:53:15 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38042 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfLWOxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 09:53:15 -0500
Received: by mail-pj1-f68.google.com with SMTP id l35so7603289pje.3;
        Mon, 23 Dec 2019 06:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3HYYz4nX1W0aJ3i8Yqd286kyh4DuRONRoG/BRh5FLZM=;
        b=FBDmb6akcXnRiy4gGu86k3JBWheD7EF8ZJShoGDQKnd3gH9eVeNeCLS+juVOdYYUeg
         ekcNjKvoqGR/iKqvpVI5Ba8BIJBqBQETnGcgBo/+I7yrkgJSbAZwDcLnGRRBCNA8DXJJ
         YfuTY+j/6oYNlDceqx4BTi7rf8PQZcqeUKu0jbhhAFiF1QaqXwp72vLZ145sZ46vO6et
         5Pnini8/3ndy41lpqZuJFA8M8drxuawVrfQ5xAfOfO5m+9YVnyDROoTsjXH8zmWzS5oI
         PgxXThJ8xlzK9gCPE0i+YP1I4ZPgXqgd4e49VJuJhtQSus03DHvOUVFML/6gImeLZlOv
         GgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3HYYz4nX1W0aJ3i8Yqd286kyh4DuRONRoG/BRh5FLZM=;
        b=eb+sKqrByP9qFsTgyJ4HtFq/KKvqgOFOMC0CwFZBCIJhVoWKrEi7XhyFaWBAdep1JT
         tINJqx406dFO0REo72VqWoQyskzer6imKSR+P7QI8y3rfLQuhdNUyG6v3lbSbBseg3O9
         DT+ni3NBt3gx3DwaXcHgej79azBuqzSKpmJy5FEnHHyPsbBfdG1P50FVZMhVgMsaAeTf
         Q/6UnmGtl7GZgLguCmbkGtF0pGMW06gJgmerySZ5mBTk77Pop3cOHCWuJmpEwGgmSMOf
         LUm7f3HOWnKEjLQcOahVqWnlRdD5UMIzyqQ8U0C82jntMdsCUS80qZ1GlcgRXiYhqNFv
         zc7w==
X-Gm-Message-State: APjAAAWIWQ9Elxrz+H2uUOdgTVwJs88HrAn36FxbXESvcZGJdmIJhSD1
        K/iGW5sMrokd3NecWVGORcQ=
X-Google-Smtp-Source: APXvYqxcDbt12KSYdO549nYw+DSqKGA6Tdn3bVL7y1mSg9juQo+yboExHfaY7Nv7BuzAG8wiOUqI7w==
X-Received: by 2002:a17:902:8d8c:: with SMTP id v12mr9725188plo.336.1577112794685;
        Mon, 23 Dec 2019 06:53:14 -0800 (PST)
Received: from localhost (64.64.229.47.16clouds.com. [64.64.229.47])
        by smtp.gmail.com with ESMTPSA id 100sm20590383pjo.17.2019.12.23.06.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Dec 2019 06:53:14 -0800 (PST)
Date:   Mon, 23 Dec 2019 22:53:11 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/10] usb: phy: tegra: Use u32 for hardware register
 variables
Message-ID: <20191223145311.GA9183@nuc8i5>
References: <20191220015238.9228-1-digetx@gmail.com>
 <20191220015238.9228-9-digetx@gmail.com>
 <20191222132227.GA7096@nuc8i5>
 <6c0fbeb2-3db2-f331-fc0a-a900241a32f5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c0fbeb2-3db2-f331-fc0a-a900241a32f5@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 12:48:09AM +0300, Dmitry Osipenko wrote:
> 22.12.2019 16:24, Dejin Zheng пишет:
> > On Fri, Dec 20, 2019 at 04:52:36AM +0300, Dmitry Osipenko wrote:
> >> There is a mix of u32/ULONG usage in the driver's code. Let's switch to
> >> u32 uniformly, for consistency.
> >>
> >> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  drivers/usb/phy/phy-tegra-usb.c | 28 +++++++++++++++-------------
> >>  1 file changed, 15 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
> >> index d5739b6e0b6c..551c94e3877a 100644
> >> --- a/drivers/usb/phy/phy-tegra-usb.c
> >> +++ b/drivers/usb/phy/phy-tegra-usb.c
> >> @@ -202,7 +202,7 @@ static inline struct tegra_usb_phy *to_tegra_usb_phy(struct usb_phy *u_phy)
> >>  static void set_pts(struct tegra_usb_phy *phy, u8 pts_val)
> >>  {
> >>  	void __iomem *base = phy->regs;
> >> -	unsigned long val;
> >> +	u32 val;
> >>  
> >>  	if (phy->soc_config->has_hostpc) {
> >>  		val = readl_relaxed(base + TEGRA_USB_HOSTPC1_DEVLC);
> >> @@ -221,7 +221,7 @@ static void set_pts(struct tegra_usb_phy *phy, u8 pts_val)
> >>  static void set_phcd(struct tegra_usb_phy *phy, bool enable)
> >>  {
> >>  	void __iomem *base = phy->regs;
> >> -	unsigned long val;
> >> +	u32 val;
> >>  
> >>  	if (phy->soc_config->has_hostpc) {
> >>  		val = readl_relaxed(base + TEGRA_USB_HOSTPC1_DEVLC);
> >> @@ -320,7 +320,8 @@ static int utmip_pad_power_on(struct tegra_usb_phy *phy)
> >>  {
> >>  	struct tegra_utmip_config *config = phy->config;
> >>  	void __iomem *base = phy->pad_regs;
> >> -	unsigned long val, flags;
> >> +	unsigned long flags;
> >> +	u32 val;
> > Why are you still using unsigned long here?
> 
> Please take a look at [1][2], the types are matching callees.
> 
> [1]
> https://elixir.bootlin.com/linux/v5.5-rc2/source/include/linux/spinlock.h#L249
> 
> [2]
> https://elixir.bootlin.com/linux/v5.5-rc2/source/include/asm-generic/io.h#L297

Okay, thanks for your explanation.

Dejin
