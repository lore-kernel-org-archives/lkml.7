Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B89C32767
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A653620866
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578098245;
	bh=w+DnMBG5f5m51ZCgawmyI1Mpraj+f/jr+3j7BeywOr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CMBpv1kkzK3TH6mH7uV3OW7dA4M9jkNA5XDazzRCkxxF+3Q3MgE8IsL4i1CNGcZAv
	 ip49gLPZt+3dO5Two2U60R8CXnshxiAO1UcJkSm4gUt3hoS5e+hT4I3yllsJYfBH3R
	 OFMy7/QZzbOR0H7nsfQdx5wT/tPwUwcKH/1sf0Xo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgADAhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 19:37:25 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:45190 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbgADAhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 19:37:20 -0500
Received: by mail-io1-f52.google.com with SMTP id i11so43078924ioi.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 16:37:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DyH66go0qsvcEZgmTI6bctw9NNe8CYLjRZjlFnsO2lI=;
        b=S/q93rF8PnO5qfkUHTWEL9MBsom3yvGNfif/cRxUAuaqteR2/MjxA4EXa/Kr/2CIti
         0kRZPi4WlB0xiJwlRnrDN3eiSTPWG86x/HT6f6f4k2Bcu9XOCBDLpem5e07tR8abhgPv
         cjszZ/dM2FjKkU5XMEbCJldFU7VZoDEs5/B7xtSmCrHPC2xloH5SiNWmY2wteEnxMu9D
         +w6Z5NmXFM5XW0NQ3lM2NLaxl+OW4kGdDOo3xryMOshG/fQeh5+PyPl3W0NUlXOZtzIO
         YpUe7s6fZRRXE+/pi8kMYgYI25wj1yfpFAzPajswb/nZ2wjtkJuM/sBrf6GPE11R1Ik4
         cKyw==
X-Gm-Message-State: APjAAAXjDBUB9f1CTjYl+HvVu0npRPALj2PWhj4Rzo5+Ad10xg7/Yy2s
        QTPW1Vta+pBSy9PfG61Pk0EQklw=
X-Google-Smtp-Source: APXvYqylt2QPZqv5lC1FDT6j6TRsuaAT+xK0Xh92f5/EMuKO34no3b2d5udGrtXTxurrUUPbwUL9SA==
X-Received: by 2002:a02:b703:: with SMTP id g3mr2751310jam.101.1578098238810;
        Fri, 03 Jan 2020 16:37:18 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id t17sm21426892ilb.29.2020.01.03.16.37.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 16:37:18 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219a5
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Fri, 03 Jan 2020 17:37:17 -0700
Date:   Fri, 3 Jan 2020 17:37:17 -0700
From:   Rob Herring <robh@kernel.org>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: Re: [Patch V3 01/18] dt-bindings: phy: tegra-xusb: Add
 usb-role-switch
Message-ID: <20200104003717.GA11747@bogus>
References: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
 <1577704195-2535-2-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577704195-2535-2-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Dec 2019 16:39:38 +0530, Nagarjuna Kristam wrote:
> Add usb-role-switch property for Tegra210 and Tegra186 platforms. This
> entry is used by XUSB pad controller driver to register for role changes
> for OTG/Peripheral capable USB 2 ports.
> 
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
> V3:
>  - Added Acked-by updates to commit message.
> ---
> V2:
>  - Moved usb-role-switch to seperate Required section as suggested by Thierry.
>  - Added reference to usb/usb-conn-gpio.txt for connector subnode.
> ---
>  .../devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt         | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
