Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C5EC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B069C21841
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563985291;
	bh=iz+jSb7Boce+LPWDYmU9nw8oEuP0Ta1BCHASPoCeT3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rcGN2eXmfX5c60+Mknq82nRfQ5OiBwOucVq0XCwFG2RYq58yRSvQW7AU2Elq8R3m7
	 Z56LU+I1/4k/3OiwsNdws+NxQzTZmEnnnc26RVuPX5lQ0BUm53/QFCNwAWQQFcrXfF
	 KcUjKoG9Wkgu/rAktaXgV7eA+sU0t50NzGfowRgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfGXQVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:21:30 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35311 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfGXQVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:21:30 -0400
Received: by mail-io1-f66.google.com with SMTP id m24so90883658ioo.2;
        Wed, 24 Jul 2019 09:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cIOpdLyyO80yQr+H18fi6enmhcJP2WqDZtbyw7dr8es=;
        b=SVy+b2rpS/g3OdhNDHoouY/US0OiHIlZPx8Ng0Dt9LD21LT+KyZo7YAtz3yeCwk+6F
         6vlCrKOhqnVNxmCoEZUAjB/wp+2Mbul5THP0pxH49XORgrwtHDhsvuqkHVjVx9I4q+Kj
         TTXZAAZx8yvLtWwWxPEnGuBfWXB/P7TIxQ4QnVwT3s0WByiZk4WyWR+47VGfUz5iwZFV
         9If4IdZwXm1PIlJvahGr6LQBGswoOzAlcyBr70IFw5DHLkNJIr7FRDGP827Bz4UNYqxt
         TdoOnN/z06y2p2aHUkae76tc6rnVhV+mxQpMiEjUxtDsoolduToep37C2Q9SEAP0lGof
         mK6g==
X-Gm-Message-State: APjAAAUMzD43WbLP2RUpj3morzHgu44lIo70EE1XB/q3QTB1OMUcZwz3
        P1qgRdBBxYYOrKtVlg3sngEAA5k=
X-Google-Smtp-Source: APXvYqxQft6/Gn3J4bej7QhSHCCn4RjwBZq8Yx5ld6DVv2xVNqa1+ZQeC+BDlbugTGZmrR15x++HOA==
X-Received: by 2002:a6b:8f47:: with SMTP id r68mr80316101iod.204.1563985289138;
        Wed, 24 Jul 2019 09:21:29 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id z17sm65438559iol.73.2019.07.24.09.21.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 09:21:28 -0700 (PDT)
Date:   Wed, 24 Jul 2019 10:21:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aleix Roca Nonell <kernelrocks@gmail.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: interrupt-controller: Document RTD129x
Message-ID: <20190724162127.GA32658@bogus>
References: <20190707132246.GB13340@arks.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190707132246.GB13340@arks.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 07, 2019 at 03:22:46PM +0200, Aleix Roca Nonell wrote:
> Add binding for Realtek RTD129x interrupt controller.
> 
> Signed-off-by: Aleix Roca Nonell <kernelrocks@gmail.com>
> ---
>  .../realtek,rtd129x-intc.txt                  | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtd129x-intc.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd129x-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd129x-intc.txt
> new file mode 100644
> index 000000000000..3ebb7c02afe5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd129x-intc.txt
> @@ -0,0 +1,24 @@
> +Realtek RTD129x IRQ Interrupt Controller
> +=======================================
> +
> +Required properties:
> +
> +- compatible           :  Should be one of the following:
> +                          - "realtek,rtd129x-intc-misc"
> +                          - "realtek,rtd129x-intc-iso"

Don't use wildcards in compatible strings.

> +- reg                  :  Specifies the address of the ISR, IER and Unmask
> +                          register in couples of "address length".
> +- interrupts           :  Specifies the interrupt line which is mux'ed.
> +- interrupt-controller :  Presence indicates the node as interrupt controller.
> +- #interrupt-cells     :  Shall be 1. See common bindings in interrupt.txt.
> +
> +
> +Example:
> +
> +	interrupt-controller@98007000 {
> +		compatible = "realtek,rtd129x-iso-irq-mux";
> +		reg = <0x98007000 0x4 0x98007040 0x4 0x98007004 0x4>;

What's in the holes?

> +		interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +	};
> -- 
> 2.21.0
> 
