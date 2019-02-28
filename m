Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1358C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8517920863
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551379396;
	bh=oGZxk7gh7LpBvxqzz00uR5qdulbNCWHBryOyQKPfFA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QbQD2Q5cEj5jZInE+M3vP+3bDJ/BTb0VD0q3PLDPvgeBCScmu2A/Fto2sIC0RHL2M
	 8B1oS29MdsLAnjdHlCJgNk26vhvlltDmdMIjkPGqyl6cAfB14MaG81KmP24qQCbOwX
	 D3m23OocclKyGmI4JLG+qRI6wdY8VQLoodsyujh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388236AbfB1SnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:43:15 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42540 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfB1SnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:43:14 -0500
Received: by mail-oi1-f196.google.com with SMTP id s16so17325529oih.9;
        Thu, 28 Feb 2019 10:43:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HkVMGgbmGk9sgrPgpr/Iv1gtz8ptUq5AA2J/mHjztW4=;
        b=JOQfHA4fpHPpbzl6CWJVr4FouxY1r5s5dg0uEF0h2TDxJn1Ec0PGhCnv23fVUX72c7
         fu48+cKvQwsLx/7ZXE2i9x0TWZLpvQVCydNbQghu1GOz9h6/MYjagRK5RuCkkABjbkNV
         n/WdbOIEauDstcn+ltQmb0XcwgvC2c0w9CivW92ndug4Ks5yxjqwFs3FimteCxvbej5w
         pgXcgsgzrUHEg+//+zVlvc/m8hzLBAmmdq/cYxYZHQ7AL3nJaFDn066MMkjXyBSAReL1
         3RZe/+oboQjUYBvxDwS8Qm24NciP/7eAve6E0IY3NeA/Kv3dZpuc9AGOiGzuiUrsoXWi
         Wc+Q==
X-Gm-Message-State: AHQUAuYo7jWwIugZ0RUZ94CvLTFlxHXDMm0b2opn9/K/m4eeVi2lBwea
        ETo+GspXmqY0XxhcuVp0Tg==
X-Google-Smtp-Source: AHgI3IbIYLkQrOtdTtuD2HI5RxDaL8jFaGrKON73U1qyH7jj/1pgYDZzXGddlbfZpQLqAsyiox6Hug==
X-Received: by 2002:aca:a904:: with SMTP id s4mr794192oie.20.1551379393757;
        Thu, 28 Feb 2019 10:43:13 -0800 (PST)
Received: from localhost (ip-184-203-129-180.hstntx.spcsdns.net. [184.203.129.180])
        by smtp.gmail.com with ESMTPSA id n6sm6071609oif.12.2019.02.28.10.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 10:43:13 -0800 (PST)
Date:   Thu, 28 Feb 2019 12:43:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ryder Lee <ryder.lee@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/3] dt-bindings: mediatek: update bindings for MT7629 SoC
Message-ID: <20190228184311.GA15417@bogus>
References: <56a2c38c9efa41be940858e19501fe07fbd5120e.1550233614.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56a2c38c9efa41be940858e19501fe07fbd5120e.1550233614.git.ryder.lee@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Feb 2019 21:50:30 +0800, Ryder Lee wrote:
> From: Ryder Lee <ryder.lee@mediatek.com>
> 
> This updates bindings for MT7629 SoC, which includes very basic items
> such as system timer, UART, sysirq and scpsys unit.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  .../devicetree/bindings/interrupt-controller/mediatek,sysirq.txt     | 5 +++--
>  Documentation/devicetree/bindings/serial/mtk-uart.txt                | 3 ++-
>  Documentation/devicetree/bindings/soc/mediatek/scpsys.txt            | 3 ++-
>  3 files changed, 7 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
