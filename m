Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AADC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A82F2054F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557248976;
	bh=/ufN0mdJkCaOxfB3r9p0XlJxfbm4UMXWNlFtPzQwDDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZoZXHj5GpLZv+me7GqSKBPEqOsS8wq7BLId7+EIRIAdM/oM0G81NA/i4V1Ifraj+V
	 PwBL3RvmBGHPl1BBng/oWSCylXF9W+bUv2y8hNhXsS+7TfcLFtf6RkVAP6ZO78Uwcd
	 efdJYKGjKThy3/6CnIgF4C6lgJNdwc72OPWYfEVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfEGRJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:09:35 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38522 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfEGRJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:09:35 -0400
Received: by mail-oi1-f195.google.com with SMTP id u199so4992026oie.5;
        Tue, 07 May 2019 10:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xz8Tv2wS4rvBFAit4Ups9uLGu7qqwKS1nVvm7tnguMs=;
        b=Oq6wwkmbwunfuAUlryV8QEFsLgPQhTWfu9f9Pu+NOAau2HYI7GTKbP525w++8XJUFP
         lYQadafsnVSC4DjfvROuYuNkct2UUQAn4vYhu2TANpy8hEMieENSrBOsHPUeASjtK0+L
         rJmTvCz5pvHDGeMHJZUG7DC7RpsTDEgtgdaYPpEqrp1iGQ/IYe7BbRhtG6EpwaGmCoGM
         suVqKIA4eee/qlfHnYemI7MHfFIrmYoWD4WQ2jiBTxwb3eqGSk+YTr4STJNTRgL/ddEw
         DqeFGneiwzDlRsjd0wNKwjcaiE2N43LbUifEKM5YbgtdDn0n+1/yq2qkXfK6q50ju1Kk
         VGnw==
X-Gm-Message-State: APjAAAWUH50uTPzyon5uaDixvALKAevuO2XerR12J8MAWTJ2k0yh7+qK
        A4aQ0QDO19h9nADnBDWY5g==
X-Google-Smtp-Source: APXvYqw6hBDm8Eza1B3bub9eXvOsE9+C0443/C9azP6hZmzYu4gfI63PV1LLa/Wy+pDkmqZYVmW/tw==
X-Received: by 2002:aca:ef8a:: with SMTP id n132mr890085oih.98.1557248974374;
        Tue, 07 May 2019 10:09:34 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q124sm5979753oia.13.2019.05.07.10.09.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 10:09:33 -0700 (PDT)
Date:   Tue, 7 May 2019 12:09:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-media@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Cameron <quozl@laptop.org>, Pavel Machek <pavel@ucw.cz>,
        Libin Yang <lbyang@marvell.com>,
        Albert Wang <twang13@marvell.com>,
        jacopo mondi <jacopo@jmondi.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v5 01/10] media: dt-bindings: marvell,mmp2-ccic: Add
 Marvell MMP2 camera
Message-ID: <20190507170932.GA6587@bogus>
References: <20190505140031.9636-1-lkundrak@v3.sk>
 <20190505140031.9636-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190505140031.9636-2-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  5 May 2019 16:00:22 +0200, Lubomir Rintel wrote:
> Add Marvell MMP2 camera host interface.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v4:
> - s/Nust/Must/
> - Documented required endpoint properties; bus-type, hsync-active,
>   vsync-active and pclk-sample.
> 
> Changes since v3:
> - Dropped the video-interfaces.txt reference
> - Clarify "clocks", "clock-names" and "clock-output-names" descriptions
> - Refer to other documentation by full path
> 
> Changes since v2:
> - Added #clock-cells, clock-names, port
> 
>  .../bindings/media/marvell,mmp2-ccic.txt      | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/marvell,mmp2-ccic.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
