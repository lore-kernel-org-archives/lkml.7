Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04551C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4E421741
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxjmPUgd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfK1KIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:08:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41025 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfK1KIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 05:08:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id b18so30350908wrj.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 02:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sBweRuGJtvgRkqwIjHTRPe4AWescaq91ikYBaT7oIDE=;
        b=FxjmPUgdZHc6G19zBTqwi/aNTnSbVGQd+n95chLwo3aSb2Rpz+l8bNkYg6//O5q0qU
         1WFpImjfh/fiGgufX21oXLCp28ZG5ABfqj+3F6vrO9jMwSRXwkXhw1sKrhG6hC6k+oZs
         MdxObPRB629OUVimBsnOxgskdWb5cNOu6GtVK69KDedkDmkauxgyR8MTcd6Rp85+dt93
         ny8wCJ4YkxTrQmiEYwRl6B4uIzG1v4ds1Fr5YLEqGuOtbANkJmneB7U29IsfibUZI6Za
         HeXuC/vMpVKW0hDPhs1nZdp1nTK7LaQ8Vp1fE6B3iknim/CqLc5EGfaVWD3779oAkU2d
         bmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sBweRuGJtvgRkqwIjHTRPe4AWescaq91ikYBaT7oIDE=;
        b=hkwLhsNLvFUs26RAtQP/iFgPSo7JOKYWE9OHeyKmJdCOlFrIKswjRmIIHdWD/MtCmy
         svNSVO7bjfaRNxaJZjYa4Pyhhug1vgdvHpLmhnjQOhu0YtFcDCeujFl6cGoGdYaeJsgh
         fZM8pMPM0Oh73ctQWZV1yCINgc8R5p7Ni9CbGVYhBXb/np+v84xh1rlmMQ6pEiqk6AGk
         jm2hNbIKb3lNfYOX4YCfTGYLod3KdTLgqz0hGG6pUO86qCPw+9Dl9dY1SZD8y7kDzjGq
         gwX9Kf6MIdlIgp31BvgApxz2TZ0oufVSjJ3fqiCUb5rT3yuXoR53tQdOTOhIBys02obb
         VtKA==
X-Gm-Message-State: APjAAAUsBiu5mk7doWSV6YadyRFcMovL4S3iKYr+HKJRc7zgGemSdOB2
        JkG/dL7vNx3P/QpThsQ8W7Y=
X-Google-Smtp-Source: APXvYqycIyyGtRUB6blhWyP+JJrU0YUn1EpIdN/Sd4tZfKWd1HGV3hHIUgqcSsJryIGRtThO+rNAww==
X-Received: by 2002:adf:f803:: with SMTP id s3mr25400176wrp.7.1574935683685;
        Thu, 28 Nov 2019 02:08:03 -0800 (PST)
Received: from localhost ([193.47.161.132])
        by smtp.gmail.com with ESMTPSA id d186sm10445718wmf.7.2019.11.28.02.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Nov 2019 02:08:02 -0800 (PST)
Date:   Thu, 28 Nov 2019 11:06:57 +0100
From:   Oliver Graute <oliver.graute@gmail.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Andrew Lunn <andrew@lunn.ch>, Peng Fan <peng.fan@nxp.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        =?iso-8859-1?Q?Andr=E9?= Draszik <git@andred.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Change CONFIG_AT803X_PHY from m to y
Message-ID: <20191128100657.GB2460@optiplex>
References: <e39c043d-d098-283d-97b0-2a44aefec2f1@free.fr>
 <20191127124638.GC5108@optiplex>
 <CAOMZO5AeMgUjH4pxC4B1OFqHZDgtXs3dAiFazKEa9_txd81v6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5AeMgUjH4pxC4B1OFqHZDgtXs3dAiFazKEa9_txd81v6A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/19, Fabio Estevam wrote:
> Hi Oliver,
> 
> On Wed, Nov 27, 2019 at 9:47 AM Oliver Graute <oliver.graute@gmail.com> wrote:
> 
> > I'am using this DTS which I'am currently working on:
> >
> > https://lists.infradead.org/pipermail/linux-arm-kernel/2019-October/689501.html
> > >
> > > I bet one dollar that 6d4cd041f0af triggered a latent bug in the DTS.
> >
> > So what should I fix in my device tree?
> 
> Some suggestions you could try:
> 
> - Try to use phy-mode = "rgmii-id"; instead,
> - The PHY address 0 does not match the reg value of 4, so you need to
> double check the PHY address and make the @ and reg values to match.

ok I fix that in my dts.

> - If you have a GPIO connected to the Ethernet PHY reset pin, then you
> should describe it in the dts and also provide a delay as per the
> AR803X datasheet.

it seems that currently no ethernet phy reset gpio is connected on that
advantech eval board. The vendor says there is a optional resistor which can
be mounted.

Best regards,

Oliver
