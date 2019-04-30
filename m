Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34398C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E5B20854
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556663122;
	bh=KavVOzcC9AEP2dXBvZHoGcRrHmc/2zw48LZdw3nTJYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eopk8OKvX/ZCOf1u8c98vVecjav+MXXNaSwHyUwGnOuAV4UJDKqjZQ8RXC7cGlA2o
	 Ic8hakt2A5Hcs2ifVLwI/d+2hv/u6sUGS3KMguinnvcUX0JpyCyH856Gykh1P7EjCL
	 o5W6D+aGQw9BtoEZFtXxqJeKCSFUp7nXn8UCu+Uo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfD3WZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 18:25:20 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45213 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfD3WZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 18:25:20 -0400
Received: by mail-ot1-f68.google.com with SMTP id a10so4627902otl.12;
        Tue, 30 Apr 2019 15:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=brf7Bb8id6Hk+i6bJxTGFqDIbEXOeaazWSGC46nmM0E=;
        b=q1dqTYSsmG2wGpGZ413+9r0yGpHyUVwFtezx4Qyx+inMM9IZ+PWElnmSeW0EX7RrNf
         dfdsTYl7MG2J30dHJ55TPAhATThahRlYXoKU/TmNrovjm9SesiGPbbK9lZdsSeNpE09V
         uDpfscTJKBofEPxusXMYzReVY0iQPPYdGM34P+KlOjYW7fOg3BYPWl5OrhBZVhvUICfk
         wWTOgcTGPlfpYVbpeU2bmeM5QI6zbYJwDYN+JaYaqLphn5pYvRpFTTbiLIjDw2yvwMJh
         n/N8JSXSQobnPLb+cQLhgPfaWjz+4LzLc+wrN0usNniUNDa2z2if3FVUdTRJqJnU35iY
         kqoQ==
X-Gm-Message-State: APjAAAXaXRU1U4tiq8ciY4MymgY033fNVdRwHFF02NgAw5yXYp38hdJw
        jveFxwHPNX/sAwUcGFqX3qGboo8=
X-Google-Smtp-Source: APXvYqyyRL+scZJ1xlL9sgDE1ulI6fxpWupwNB6e11rvDCaYex/jkYDco3+Yr1qYKX+MCz5J3CuiUA==
X-Received: by 2002:a9d:5c09:: with SMTP id o9mr13588147otk.311.1556663119307;
        Tue, 30 Apr 2019 15:25:19 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n3sm15918317oia.46.2019.04.30.15.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 15:25:18 -0700 (PDT)
Date:   Tue, 30 Apr 2019 17:25:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Nishanth Menon <nm@ti.com>, tglx@linutronix.de,
        jason@lakedaemon.net,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>,
        linus.walleij@linaro.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>
Subject: Re: [PATCH v8 10/14] dt-bindings: irqchip: Introduce TISCI Interrupt
 Aggregator bindings
Message-ID: <20190430222518.GA8786@bogus>
References: <20190430101230.21794-1-lokeshvutla@ti.com>
 <20190430101230.21794-11-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430101230.21794-11-lokeshvutla@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2019 15:42:26 +0530, Lokesh Vutla wrote:
> Add the DT binding documentation for Interrupt Aggregator driver.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> Changes since v7:
> - None
>  .../interrupt-controller/ti,sci-inta.txt      | 66 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
