Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76507C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A332087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552417797;
	bh=o7BTEW1BkV/8JJZr6L8AMtYFTqfQ3eMmuxPFFD4sjy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w01JdFG/5Cf8FULPDzjqA1jkmQm8p5AxzOfGy3sj66tl9f1Vla3TMEWQv8OLO7PKU
	 zTcXWhKgEzC3iUqRHFCvQqCd0F2bWUFj05qIwkRZkKOUl+jIp8kXlarAhKc2LQMtVK
	 lQBcKu6GGyjqCcDXqT6bK+9jJDpSnJsUq2NhWdWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfCLTJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 15:09:55 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34933 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfCLTJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 15:09:55 -0400
Received: by mail-oi1-f193.google.com with SMTP id u128so3064702oie.2;
        Tue, 12 Mar 2019 12:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jJKOnB1P9PKNpKShB0uPqUX+B71dLq4m19fT/OZ0LME=;
        b=dsZOQu8fS6TojTimb/iienLhE/NvQgDG0QUP1TkrfpAYnOF1VnvmGogvCgD+P2MezN
         QBhmVPA9Gqd4djbE8nWqEeIiRG4x4p4au/PUTZfLwF2/Q1tamfsGwGct+WfRspRilXsE
         4RqWlqBdU2rIbvZP5YuDfAdA9PuMJJZy/yFktY2Ddz0KJFQ2mgdRN3DYC7+/pXAzRuxQ
         fHYpesVFand0HXX3WcSUQjzwvos4/TSgqBMq82X2IBuzcgQiuqM8XJZMgWS4fGVU1F2g
         D5wcQOYk9VEJqPLp1B8mlXm7KKFiLoFL2HjcsB7wNGC5YokhtpBnHLkFDQeK8qof2QPM
         x8mg==
X-Gm-Message-State: APjAAAWJPBxpDTTG6/WJURjhRKL+6qZlBqx9pqBzKA4/2DTPqnn2wU7+
        wnOI07p0QTTN9m+FXuu3HcTuS/WJiw==
X-Google-Smtp-Source: APXvYqzOmYiyevn4pfx/OmhV9QmJPBrm3c1cxWiC68YfOw7IRUa9Y5zI+wZ8qBznprpY0q72PHFdMw==
X-Received: by 2002:aca:dec4:: with SMTP id v187mr2810071oig.92.1552417793942;
        Tue, 12 Mar 2019 12:09:53 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l93sm3981536otc.15.2019.03.12.12.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 12:09:53 -0700 (PDT)
Date:   Tue, 12 Mar 2019 14:09:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Patrick Havelange <patrick.havelange@essensium.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 4/7] dt-bindings: counter: ftm-quaddec
Message-ID: <20190312190952.GA18547@bogus>
References: <20190306111208.7454-1-patrick.havelange@essensium.com>
 <20190306111208.7454-5-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306111208.7454-5-patrick.havelange@essensium.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 12:12:05PM +0100, Patrick Havelange wrote:
> FlexTimer quadrature decoder driver.
> 
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> Reviewed-by: Esben Haabendal <esben@haabendal.dk>
> ---
> Changes v2
>      - None
> ---
>  .../bindings/counter/ftm-quaddec.txt           | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> 
> diff --git a/Documentation/devicetree/bindings/counter/ftm-quaddec.txt b/Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> new file mode 100644
> index 000000000000..4d18cd722074
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> @@ -0,0 +1,18 @@
> +FlexTimer Quadrature decoder counter
> +
> +This driver exposes a simple counter for the quadrature decoder mode.

Seems like this is more a mode of a h/w block than describing a h/w 
block. Bindings should do the latter.

> +
> +Required properties:
> +- compatible:		Must be "fsl,ftm-quaddec".
> +- reg:			Must be set to the memory region of the flextimer.
> +
> +Optional property:
> +- big-endian:		Access the device registers in big-endian mode.
> +
> +Example:
> +		counter0: counter@29d0000 {
> +			compatible = "fsl,ftm-quaddec";
> +			reg = <0x0 0x29d0000 0x0 0x10000>;
> +			big-endian;
> +			status = "disabled";
> +		};
> -- 
> 2.19.1
> 
