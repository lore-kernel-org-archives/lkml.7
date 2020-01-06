Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D622C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3095B207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="TP+Pam2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgAFTWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:22:38 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39952 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgAFTWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:22:37 -0500
Received: by mail-lj1-f193.google.com with SMTP id u1so52070937ljk.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 11:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xD7c5lp/JTbJappC7pd+ucZ9Tynnw8uEgTOT9ePpE+A=;
        b=TP+Pam2PTdFkBDpy/gZulzYsG/H7IMq7WzsRyV4WOz7x5qswCzaOUDZKO5xLXe4Jyl
         ybcgJk58DFy5xlIczIjeYgqmtBAjPSULgp9a9mF17Bp4sQQYz1GNLeb+Ps+AO48gVopr
         EhCCBfcVVTSedL6mg/Z8/t+Akir7yim2Ebgw5WOc61wjVWqfMEBfnxNePlnym/nLdUtf
         tyst3bf9iKLpqN8okUgzoANIdSRGQ01XVqm6nR974HXwhn6yVoRbon3ljBi1Ma/JXkv7
         pIX+1pK8NSWD9s53nQjCPsUIQM1We+R16PEuBT+uI7+DWzIbAlH8gmB5HjAQW8WrUz9v
         KZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xD7c5lp/JTbJappC7pd+ucZ9Tynnw8uEgTOT9ePpE+A=;
        b=LtqC66SLvqMB3txMbOXq+gOr6jVoJcVj/9WNsy5pmBlFxM6d4MiNEt1sz1vnx2WD8U
         8Vq920zDZS/3gOROAeoti06c6dFjNzbDa5O0d1fYYFulakdKnnIvmV6uwiPZOAvffmLr
         hvzqOR/tQIEpgUSd5O307L5vGR2EDASENSMYpTEPhRmWVUPMqEBAZgtk3eGu3NzRvE2+
         9q4FZXJBSQDOk8MYxx+aultMfAk9znsqBJCkzZsXzuh1R2VIGXhM7mMycOclxaWjuMW3
         hyaIoJRP6pZHnRnuD7JraOx/MGztjec86nvas/25qk02ptkGD7aprNIBliQyT7dpBjed
         LN8w==
X-Gm-Message-State: APjAAAWzL2TYE9nsxinYJdvGmPq0QNvVsVCfYL6z7UbqeA4YHmDEwBml
        W8JlM+ZWqrO9vcgx9e+K89Vozg==
X-Google-Smtp-Source: APXvYqwMq/OmT9x8fcwh1uutbMmzgyXfzN2dKfF6mn/uJfy+faFs7dTSzi3k1NrS/6ihZgUkrLqskA==
X-Received: by 2002:a2e:9705:: with SMTP id r5mr61908704lji.114.1578338555545;
        Mon, 06 Jan 2020 11:22:35 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id h81sm29432728lfd.83.2020.01.06.11.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Jan 2020 11:22:34 -0800 (PST)
Date:   Mon, 6 Jan 2020 11:22:25 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        soc@kernel.org
Subject: Re: [PATCH 4/5] ARM: dts: mmp3: Add HSIC controllers
Message-ID: <20200106192225.wc3ber4abkf7s3iu@localhost>
References: <20191220065314.237624-1-lkundrak@v3.sk>
 <20191220065314.237624-5-lkundrak@v3.sk>
 <186ca73e408654981e08f7f12ae543ba51debb68.camel@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <186ca73e408654981e08f7f12ae543ba51debb68.camel@v3.sk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 08:05:50AM +0100, Lubomir Rintel wrote:
> On Fri, 2019-12-20 at 07:53 +0100, Lubomir Rintel wrote:
> > There are two on MMP3, along with the PHYs. The PHYs are made compatible
> > with the NOP transceiver, since there's no driver for the time being and
> > they're likely configured by the firmware.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > ---
> >  arch/arm/boot/dts/mmp3.dtsi | 44 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/mmp3.dtsi b/arch/arm/boot/dts/mmp3.dtsi
> > index d9762de0ed34b..36c50706e60e0 100644
> > --- a/arch/arm/boot/dts/mmp3.dtsi
> > +++ b/arch/arm/boot/dts/mmp3.dtsi
> > @@ -201,6 +201,50 @@ usb_otg0: usb-otg@d4208000 {
> >  				status = "disabled";
> >  			};
> >  
> > +			hsic_phy0: hsic-phy@f0001800 {
> > +				compatible = "marvell,mmp3-hsic-phy",
> > +					     "usb-nop-xceiv",
> 
> I managed to mess this up right before sending it out.     ^^^
> Sorry for that. There should be a semicolon there. I'll fix this up on
> next patch spin.

Missed the comments when applying, but I fixed it up locally with the below
patch. Please send new versions incremental on top of it.

I applied the series to the mmp/hsic (and mmp/hsic-fixed) branch in our tree if
you want to use that as a base.


-Olof


---

From e2ce979bf176af4b8eb7aea866919d618c08f752 Mon Sep 17 00:00:00 2001
From: Olof Johansson <olof@lixom.net>
Date: Mon, 6 Jan 2020 11:14:10 -0800
Subject: [PATCH] ARM: dts: mmp3: Fix typos

Fixes build failures due to syntax errors.

Fixes: 3240d5b872f2 ("ARM: dts: mmp3: Add HSIC controllers")
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/boot/dts/mmp3.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/mmp3.dtsi b/arch/arm/boot/dts/mmp3.dtsi
index 36c50706e60e..1eba7fb6629b 100644
--- a/arch/arm/boot/dts/mmp3.dtsi
+++ b/arch/arm/boot/dts/mmp3.dtsi
@@ -203,7 +203,7 @@
 
 			hsic_phy0: hsic-phy@f0001800 {
 				compatible = "marvell,mmp3-hsic-phy",
-					     "usb-nop-xceiv",
+					     "usb-nop-xceiv";
 				reg = <0xf0001800 0x40>;
 				#phy-cells = <0>;
 				status = "disabled";
@@ -225,7 +225,7 @@
 
 			hsic_phy1: hsic-phy@f0002800 {
 				compatible = "marvell,mmp3-hsic-phy",
-					     "usb-nop-xceiv",
+					     "usb-nop-xceiv";
 				reg = <0xf0002800 0x40>;
 				#phy-cells = <0>;
 				status = "disabled";
-- 
2.22.GIT

