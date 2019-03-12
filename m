Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645C0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3001720693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552405827;
	bh=tZ7SuWKGLjLHh0Xxvx4CyD2SpuJXFXCaJZYZB2p8YmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TPNXAwO6nYLDXD7lpK//V4SdYf+Mn8Y2yh2N1L1kVNEI8OJuG3xijPQy5Y84nMwn8
	 VQPyjX9F9DA5r7hCJVNWQ7yyRrIgmESscGH4bcxDR3ZFxX+3KbAblQFNhjqSNwZ9FJ
	 X3hVlVRae4j0seerSSu46/cZISbmLwmt8t9EK8yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfCLPuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:50:24 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43453 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfCLPuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:50:23 -0400
Received: by mail-oi1-f195.google.com with SMTP id i8so2450221oib.10;
        Tue, 12 Mar 2019 08:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/BB6mNTxjaORJQ2jTUOA34iFYaWDI9oHJiHHTMIh8L8=;
        b=Qndo3IB5gROfEeTqmZyPMu9lT3AVU8UtudfT9PNnPhSh+wF8ZJgbnW4O8EMg/YTYuf
         dqVP6XED92vhRGwESfZFlOheJ73SzVT4pIIYuYmUf5qbz2xUThwcq8d/evWnysE/o4m2
         OKaXOhORNxikmHYPTT2J0J7IwF3uZx1cbYIEMAQfPfi8YTLBV1/pEdzaW8+6iPiolUGH
         xyc+WkONVI6a2wIhaRtjKF/cNAUBaNNNSYpGfaNCOfHwDegfuC5pGwqKKlr5Z928jUsG
         Mffzf+O077vmEwuahd77jrNH5aRHyAfVsSkGXy23qd9wCAZybpZD8pm9ylqsNiDsinkN
         +n5w==
X-Gm-Message-State: APjAAAVWzuMrR6MsCxrC2keLLwuDXi8qKXvJU/UCb1Qoto2wCCf+FX88
        Yq4rhiRpfgwRtCMJZbnHCKFKG88=
X-Google-Smtp-Source: APXvYqwVElLi80CJSoHQQx1Pj8XnPNYmOAAyv4D4TtDNFFL/Jwyj35FZZKWzZGZo39exgQJsAbQxkQ==
X-Received: by 2002:aca:4a15:: with SMTP id x21mr2052559oia.122.1552405822892;
        Tue, 12 Mar 2019 08:50:22 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u5sm3548768otb.62.2019.03.12.08.50.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 08:50:22 -0700 (PDT)
Date:   Tue, 12 Mar 2019 10:50:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: gpio-charger: Add
 status-gpios property
Message-ID: <20190312155021.GA23277@bogus>
References: <20190226150437.3704-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226150437.3704-1-contact@artur-rojek.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2019 16:04:36 +0100, Artur Rojek wrote:
> Add documentation for the "status-gpios" property.
> Update the "gpios" property with a valid example.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
> 
> Changes:
> 
> v2: - add a better description for the "status-gpios" property,
>     - add valid examples for the "gpios" and "status-gpios" properties
> 
>  .../devicetree/bindings/power/supply/gpio-charger.txt       | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
