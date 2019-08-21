Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C3FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC3E22CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566421433;
	bh=+7x7IpHXBBLW6ZDK29uIwN2JbBnSjoWeJ3aAl0Fr/Mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XPvdRgy2kPSsOw4cqjuJ/KIgqkueQ3uxRJRG0380729lwkovMMSyA6PVWyEU6jfOH
	 rmacq666Wc6DnHQeK+Dgx0LqzU1PP/2kmUtD3+XAl8ezTwjUY3HuScMJdOsTVYYrwt
	 ZHewmfYTwL/t/nkeMY2YvtRsISTlDoop76A1G7dE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbfHUVDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 17:03:52 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41258 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbfHUVDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 17:03:51 -0400
Received: by mail-ot1-f66.google.com with SMTP id o101so3408034ota.8;
        Wed, 21 Aug 2019 14:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m90Mz/jvgDnOaaZcenPIYWv0B9+uDzU9ODuqNid723o=;
        b=B5pEq41Gc+8wmoZl2+UPRfclUKfF/XTjJF5Hi1ca4AD+OJ9n/S+4zC9JhT8HuOMpyn
         HBDRZ7XJNNxnlF4zyPRvc0h2QWyWwAOlHvcVH7G/WWnQ59JLyVx9uzlyylGBkB6AVN9G
         zoiGP4CTE1bm46jckqoQwO/zkRQR3apvJWGEsPkMf+RTbc0EEckbflRmb2Q3+Z7O6pOb
         fnNxxjtjFR5O94ETBaT5EmqK5aacXhyzgzx2E5FCvltgRVrmWDdVIy1FBxc0MMDLPFfB
         QaMtGe3rN0O/kNc1L9k5mr6u2fbr4nHnQHNOUHszqMj0kej9pmTLuuGqw6u2Etb/JOan
         9T9Q==
X-Gm-Message-State: APjAAAX69nuv7KhNMev8gJmz0fTxx5F8xT2KRUrtqZBCPQdurWQ7aWei
        p8FgFcD78NOihnBh79Xr+w==
X-Google-Smtp-Source: APXvYqzE8iHGPxCpvJfgsISvdD+N8D0mhA2Bfm65nD7V8XzgvQjLdrKSopb9P7aa7/RBblZDxVuz1Q==
X-Received: by 2002:a9d:76d3:: with SMTP id p19mr28757086otl.18.1566421430686;
        Wed, 21 Aug 2019 14:03:50 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c11sm6897992otr.54.2019.08.21.14.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 14:03:50 -0700 (PDT)
Date:   Wed, 21 Aug 2019 16:03:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Olof Johansson <olof@lixom.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 02/19] dt-bindings: arm: mrvl: Document MMP3 compatible
 string
Message-ID: <20190821210349.GA29732@bogus>
References: <20190809093158.7969-1-lkundrak@v3.sk>
 <20190809093158.7969-3-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809093158.7969-3-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 11:31:41AM +0200, Lubomir Rintel wrote:
> Marvel MMP3 is a successor to MMP2, containing similar peripherals with two
> PJ4B cores.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  Documentation/devicetree/bindings/arm/mrvl/mrvl.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt b/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
> index 951687528efb0..66e1e1414245b 100644
> --- a/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
> +++ b/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
> @@ -12,3 +12,7 @@ Required root node properties:
>  MMP2 Brownstone Board
>  Required root node properties:
>  	- compatible = "mrvl,mmp2-brownstone", "mrvl,mmp2";
> +
> +MMP3 SoC
> +Required root node properties:
> +	- compatible = "marvell,mmp3";

Please convert this file to DT schema before adding new SoCs.

Rob
