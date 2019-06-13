Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B9EC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D92C20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560456679;
	bh=5ygQGPcit2pArGL3ij3+E6mSLrQZUtHRe65XTiaOuGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z9VlVAbMfHJSIpqLIEaC4ZgtwCVzmGaBCIRgRumy89/8VUz7xQQPo/Xy82DPezQWs
	 dV2HGaGEay8ddqnnd4NUH8UShIL6PH+CQZ7y+9jpaeaYwVc4heVlCFNKk2hzladIx6
	 S7HeC08CCF9pIZ6jdJZlsM8yxSW/5/OuzI4PXwls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbfFMULR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 16:11:17 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33544 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbfFMULR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 16:11:17 -0400
Received: by mail-qt1-f195.google.com with SMTP id x2so23198219qtr.0;
        Thu, 13 Jun 2019 13:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kynEIGqHqfFyAVA0SpaU2DX6zDv55jiILYeSznYNPNM=;
        b=VXT55wnlP1gaptlqCaP6Q19kMN8PxGge6CKEF1rbrRFG92yXiAExnzjgBeHyoO2ng0
         tPRZm/QELaK90p/pLbXs6WjnTi15OPOGiNLCTFuCxeYcSFqjTQiOEGvPwAA5fBiAZJsy
         ghAjuH9Ft7wJqig8SIBjFqxzUzOcncPGU384bRBtyLaHIYDzjDFO86dmvu6XcN6T9IY0
         lU1fDj74amOoDXJHcroJHzIP1QdVYJQVrMga0TwJ6iIt56TmKfKwSrQOhKrFBBsi0esG
         83WA+ITtCfjOi/IBAlZdd38u57mliN1zPk4+md0fpitOb/PdzicpG7qcnn8/guhoNjKh
         BvCw==
X-Gm-Message-State: APjAAAWr7uBu6t8kQLdQ98CVI1bjK40lziT8T8vKrbKzvxQr2rxu8ckG
        TpAifVglsQKG6D/d9vpaEA==
X-Google-Smtp-Source: APXvYqxe5eNSjkfbROg4faPppv8JUsym693JfsCHFj7SlJQvCa0P8AkVS5ftZTKmBf8oa+65LisbGQ==
X-Received: by 2002:a0c:e712:: with SMTP id d18mr4944214qvn.152.1560456676142;
        Thu, 13 Jun 2019 13:11:16 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id z1sm345280qth.7.2019.06.13.13.11.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 13:11:15 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:11:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH repost 4/5] dt-bindings: can: rcar_canfd: document
 r8a77990 support
Message-ID: <20190613201114.GA22253@bogus>
References: <1557429622-31676-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1557429622-31676-5-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557429622-31676-5-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 May 2019 20:20:21 +0100, Fabrizio Castro wrote:
> From: Marek Vasut <marek.vasut@gmail.com>
> 
> Document the support for rcar_canfd on R8A77990 SoC devices.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Eugeniu Rosca <erosca@de.adit-jv.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-renesas-soc@vger.kernel.org
> To: devicetree@vger.kernel.org
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  Documentation/devicetree/bindings/net/can/rcar_canfd.txt | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
