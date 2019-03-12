Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CC8C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D292147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552398132;
	bh=h8/VRoGEIFxhVZzPMK3EN+z2WLQlW8+m38g6dMRwdPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UjYq4o3pw+SlYGq72xsEChz+8vuV+1vpx0en0VVn4aSYJg2RvBVhR1OheTQkExTD2
	 BOeOv5f078ZSRiOlecKV+nnBM+vzCtVGbmM8AwIE9Ld59C4ZpxqHReuNEDekC6RjNE
	 cIyfLoYVU562X+9KQ3pQx7W3+m8ngK6fGp1qdVxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfCLNmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:42:11 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37821 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfCLNmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:42:11 -0400
Received: by mail-oi1-f194.google.com with SMTP id w66so2093891oia.4;
        Tue, 12 Mar 2019 06:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HfcLv1/QrBGNjOWRj6KsbXECfCitu3ITt5OND6TyLp8=;
        b=gLYQjQj48JxAJztNK5xBtS1TzHpK846ASLCrtnEOcgW+SYK/9g6KQHaf4YwRQEXs+/
         Y3fTo9EYu+kRPU90q2KaxxJAWm3Y7DccGerDNFR88f3dzegNDChYvGXu7svba6GWds+e
         sVoiWbdLjvC+9a9pOkmH6252Cq+mORtteev/Np3jTaks+BZqVEQfrOMx2/1brcErY39u
         Uo1Te7Z2wZ7AnOvz7ltU7oEva/zTZextAQpVPqbOIT1dWfBNJ7tZ27qZpY15B7D9F6lS
         wCq+9XwZ3r/A7/75pH0LxQApT9QcHizpCwuwW/YnBvmzK9a0Qk6nAEf62jirb7FOPsqf
         dcsw==
X-Gm-Message-State: APjAAAWIKcyVPiu0n1WHry+hFXKx1duyznd+quWJwuIdDBo1YSX6mzNA
        83+gugSssVx2pJ5W85vPyakIXic=
X-Google-Smtp-Source: APXvYqwYEevY2oWR9RU4BlZqVu0LMG+77i6mtsJVfO93pDoJFh2SwxY11++65Bu3oKQuppDIY1WIcw==
X-Received: by 2002:aca:5906:: with SMTP id n6mr1664288oib.154.1552398129677;
        Tue, 12 Mar 2019 06:42:09 -0700 (PDT)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id q1sm3444268oth.42.2019.03.12.06.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 06:42:09 -0700 (PDT)
Date:   Tue, 12 Mar 2019 08:42:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 11/15] [NOT FOR MERGE] dt-bindings: Add a binding for
 a mailbox-backed interrupt controller
Message-ID: <20190312134208.GA2017@bogus>
References: <20190302042951.53671-1-samuel@sholland.org>
 <20190302042951.53671-12-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190302042951.53671-12-samuel@sholland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 10:29:47PM -0600, Samuel Holland wrote:
> This is a somewhat generic binding for an interrupt controller/forwarder
> implemented in firmware and communicated with using a mailbox.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../interrupt-controller/mbox-intc.txt        | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mbox-intc.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/mbox-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/mbox-intc.txt
> new file mode 100644
> index 000000000000..a0eb7904ca83
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/mbox-intc.txt
> @@ -0,0 +1,33 @@
> +Mailbox-backed Interrupt Controller
> +===================================

Probably never really going to be generic as every mailbox protocol is 
different.

> +
> +This binding represents an interrupt controller implemented in firmware,
> +that uses a mailbox channel to signal and acknowledge interrupts.
> +
> +Device Node:
> +============
> +
> +Required properties:
> +--------------------
> +- compatible:		Must be one of the following strings:
> +			- allwinner,sunxi-msgbox-intc
> +- interrupt-controller:	Signifies that this node is an interrupt controller.
> +- #interrupt-cells:	Must be 1.

No edge/level control?

> +- mboxes:		phandle for the mailbox controller and channel
> +			specifier. If the mailbox controller has unidirectional
> +			channels, two entries are required (see below).
> +- mbox-names:		Only required for unidirectional mailbox channels. In
> +			that case, it must contain the strings "tx" and "rx"
> +			(where "tx" and "rx" are from Linux's perspective, not

/Linux/the OS/

> +			the direction the interrupts are traveling).
> +
> +Example:
> +--------
> +
> +	msgbox_intc: interrupt-controller {
> +		compatible = "allwinner,sunxi-msgbox-intc";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		mboxes = <&msgbox 6>, <&msgbox 7>;
> +		mbox-names = "tx", "rx";
> +	};
> -- 
> 2.19.2
> 
