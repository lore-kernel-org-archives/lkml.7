Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFEAC73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48272214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562703505;
	bh=Zyh5r/5EBCY4ciidDmlCs4cfQlXb8Lq5dDHE2YULHMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s7qewlGMZueO1R9FlTG8uAGDEXezPbiUPArMN+UxzxacWihVsI8tv18SEof6mxKP5
	 7G2Z/yEOJp+txowjw2u/Z9givtCy1bMVCP53PF1/zmBJQFVSPiyjGxo8X+XmvDhKDe
	 KIcluP0CvrepQcu4lPQdZwwSj38+V0W7mhxcxfcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbfGIUSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 16:18:24 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35393 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfGIUSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 16:18:23 -0400
Received: by mail-io1-f66.google.com with SMTP id m24so36493160ioo.2;
        Tue, 09 Jul 2019 13:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6NbN5JKfhtthh8rHQeJ+/J+roRFzMU2Xl0uQ4XuNSKE=;
        b=XUnw5odP/R3U8VGWVqf3R0JXkg14pbS+/woBtg1lNMjDxcNG8a4DEY81aAoK5+y5bo
         NBZ9PWS2/9cTKHr9R9AIKItONBuPiTo1gN/GiCUDFsMWxhrHx5CKxi1FEaTBhZVAf4Iu
         /WS97fzrBohss2VRA2tT8gclPYgrrJAe1jR5+koe2pT6IeQLfP8ApA4TZTUxFnNEobJv
         NSCnGbGMUQyy1pYE1Pt8cnuTzJXjYkUireFLvh9eshW860MulRMtYPv3uGY61Iqx6uUj
         H8kiRTj/8QxNMzthfnr9bPl3PorCRwHTSKPOkxpLWRjV11q+xchi6c75H63dhQ3EKvIu
         7Dig==
X-Gm-Message-State: APjAAAUFPux6KrjE/1xNCCbg7/oSZziFjCAIVHdUCTabAuoiZdQ5uzW2
        C03+JxwhK4nJ8LO5NieCoA==
X-Google-Smtp-Source: APXvYqw/ZIS8sL7/LEDguheL73Ps4hwNdYccJgnnmSIUOUBhRrcMKya7HG/yRUQA4qaafy1VzHHMLA==
X-Received: by 2002:a5d:964d:: with SMTP id d13mr28379833ios.224.1562703502330;
        Tue, 09 Jul 2019 13:18:22 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id t4sm17179836iop.0.2019.07.09.13.18.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 13:18:21 -0700 (PDT)
Date:   Tue, 9 Jul 2019 14:18:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     catalin.marinas@arm.com, will@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, mturquette@baylibre.com,
        sboyd@kernel.org, leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        ping.bai@nxp.com, daniel.baluta@nxp.com, peng.fan@nxp.com,
        abel.vesa@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 2/4] dt-bindings: clock: imx8mm: Add system counter clock
Message-ID: <20190709201820.GA25832@bogus>
References: <20190621070720.12395-1-Anson.Huang@nxp.com>
 <20190621070720.12395-2-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621070720.12395-2-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019 15:07:18 +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Add i.MX8MM system counter clock macro definition.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  include/dt-bindings/clock/imx8mm-clock.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
