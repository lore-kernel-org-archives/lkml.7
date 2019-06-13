Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F89AC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5416720B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560456654;
	bh=KohsyPiSqhk6vrPO17bsNstthlBMJrt4eoelmwDbMFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ud0yf1HovGpJ3HZMKiA6G/OHVNu4iGq1Al14F7pGKRhA0CmjJSzbTWHcwcY6dYFsz
	 Zkne9Pk8OBFuIz3VKYfhEOHZQVnmGNdVUXzwKvEDLwqhWdK1lok8xMvV9SeNM1JiRt
	 aPhGsNyCFxpWRhfQyEko6bnIfsKsVb3xEjTfa900=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbfFMUKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 16:10:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34739 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbfFMUKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 16:10:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id m29so24111477qtu.1;
        Thu, 13 Jun 2019 13:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yY7xNPT2mwpYzEeAbehMBeCJNfkuLmQONs4c1jLx/mk=;
        b=UJXKqNmX47gP/jL6Owfvzak1gUqb+V0LZDPQqQN4ltIrJNeZ2viOK4T6joPeOOnBSZ
         0SmCOYta/isUV6ah7F95tS5Eoq4Fa+pgTG/8aCBO/GOWKLVdX5+oFoeBFaVSO11af+qS
         c1RpvL59NR16XDWItaEDj3Jm5RE8ohkUmbutBIRKBeXnYEZ9o35+wCmjeiaZ8JO6KJXy
         uHLnPnxwGPderd/Lz0i/Ng41N4+f+l2dmti8IXLy7TRCcBkZvyeUp2CiazS/vgAlqPnj
         dkGAXY1SqKWrWuclQxwSCMNXGKTQINoZnKPhK7z4BlvZeCfnQtZgAOdjQ+uA2qVdHyZ4
         +//w==
X-Gm-Message-State: APjAAAUjxgquguP7SdrI8JUPXJZ9tEl+aT3RxNAY/IZjA754G38eQSkt
        fq6zLkPKagHSPyNGes0oNQ==
X-Google-Smtp-Source: APXvYqwH1umnqn+hYGonlBk+cgknvMDSYI5LNwBwmnbKxEfbq+xxeq2KCCcC9OScQc4Wl6X/As+KZw==
X-Received: by 2002:ac8:2962:: with SMTP id z31mr78217543qtz.223.1560456651121;
        Thu, 13 Jun 2019 13:10:51 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id q187sm262926qkd.19.2019.06.13.13.10.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 13:10:50 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:10:49 -0600
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
Subject: Re: [PATCH repost 3/5] dt-bindings: can: rcar_canfd: document
 r8a77965 support
Message-ID: <20190613201049.GA21426@bogus>
References: <1557429622-31676-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1557429622-31676-4-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557429622-31676-4-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 May 2019 20:20:20 +0100, Fabrizio Castro wrote:
> From: Marek Vasut <marek.vasut@gmail.com>
> 
> Document the support for rcar_canfd on R8A77965 SoC devices.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Eugeniu Rosca <erosca@de.adit-jv.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-renesas-soc@vger.kernel.org
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  Documentation/devicetree/bindings/net/can/rcar_canfd.txt | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
