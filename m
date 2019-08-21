Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE19C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A05C206DD
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 21:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566422325;
	bh=P2WLbY56ksChpqlmuVlA1Q+og5W1u+UkRXpSGXhZXlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=evtf3xguBM/Lui4vlSTb8jXc3ZjJSTec/kDanViu03wu/+VDKfkYg6FwCc5lFl5UJ
	 MXVtRgKTlgexcHvw0lFbz6U2Qd7Pj78fPIO5rJB3EzjCXJmTDScwyschFRiQtf/Y6m
	 rks7FoGUoja+nnxDAa1WbdkkcXHTt0Wc0toACYMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbfHUVSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 17:18:44 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37693 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfHUVSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 17:18:43 -0400
Received: by mail-ot1-f67.google.com with SMTP id f17so3471574otq.4;
        Wed, 21 Aug 2019 14:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0BysGlcLSnXeBZ1pv0mPCj6ITlGQ3QNXjoyF2Ap0RJY=;
        b=hQ18nXsiPm8wqzfq38jJ8lQCu2q87OuXaZnysQLVlm9K/LZO0fxuRq+Ai+Sdhco7Un
         fqP9b6yfqiZX7LCIZ4EbqVIEG6YkMLAQ7V3Oqqoas7o7Y/uhdyvhQ8Ra/4D9GfH1yeKH
         JrU8oWEirm2LVXC+22RKxiZAFoZFBvPLUA5Mm/kIb4RCYMAg0PJWNBHXRbH6cYtsCZG+
         gg+MH3jESDgnjwl76sXZsqwodkNrIe54hB+LxVOls4gP6Zl1CeduPswL2eQZEH+EGiSh
         NaLydsc4XFU+gy+vZE+JghXCafCR3zS1FcNr0sbQGuGsoQuFTgWW17mTox5Gy7mn1vxG
         UslA==
X-Gm-Message-State: APjAAAUQp6p5H2CPCwRFiGhlurGLJMQjZASfA2XSCDMOGmUIN3xfDeX+
        hqUFdBmSHe+iye+d/Dk5VA==
X-Google-Smtp-Source: APXvYqwyCdp9o8YTLQuqlTyT5OIepCOx0aazVgW8orqSC0e9+vmRZf4pQjus03+ay0tw1yhN7gQitQ==
X-Received: by 2002:a05:6830:54:: with SMTP id d20mr25800639otp.225.1566422322638;
        Wed, 21 Aug 2019 14:18:42 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o26sm7711687otl.34.2019.08.21.14.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 14:18:42 -0700 (PDT)
Date:   Wed, 21 Aug 2019 16:18:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Cosmin Stefan Stoica <cosmin.stoica@nxp.com>,
        Larisa Ileana Grigore <larisa.grigore@nxp.com>
Subject: Re: [PATCH v2 4/6] dt-bindings: serial: Document Freescale LINFlex
 UART
Message-ID: <20190821211841.GA16627@bogus>
References: <20190809112853.15846-1-stefan-gabriel.mirea@nxp.com>
 <20190809112853.15846-5-stefan-gabriel.mirea@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809112853.15846-5-stefan-gabriel.mirea@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 11:29:14AM +0000, Stefan-gabriel Mirea wrote:
> From: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
> 
> Add documentation for the serial communication interface module (LINFlex),
> found in two instances on S32V234.
> 
> Signed-off-by: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
> Signed-off-by: Larisa Grigore <Larisa.Grigore@nxp.com>
> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> ---
>  .../bindings/serial/fsl,s32-linflexuart.txt   | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
> new file mode 100644
> index 000000000000..957ffeaca9f1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
> @@ -0,0 +1,24 @@
> +* Freescale Linflex UART

Be consistent with the name: LINFlexD?

> +
> +The LINFlexD controller implements several LIN protocol versions, as well as
> +support for full-duplex UART communication through 8-bit and 9-bit frames. The
> +Linflex UART driver enables operation only in UART mode.

What the driver supports or not is independent of the binding.

> +
> +See chapter 47 ("LINFlexD") in the reference manual[1].
> +
> +Required properties:
> +- compatible :
> +  - "fsl,s32-linflexuart" for linflex configured in uart mode which

LINFlexD?

> +  is compatible with the one integrated on S32V234 SoC

Compatibles should be SoC specific. Is 's32' specific enough to account 
for any differences or future bugs found?

> +- reg : Address and length of the register set for the device
> +- interrupts : Should contain uart interrupt
> +
> +Example:
> +uart0:serial@40053000 {

space    ^

> +	compatible = "fsl,s32-linflexuart";
> +	reg = <0x0 0x40053000 0x0 0x1000>;
> +	interrupts = <0 59 4>;
> +	status = "disabled";

Don't show status in examples.

> +};
> +
> +[1] https://www.nxp.com/webapp/Download?colCode=S32V234RM
> -- 
> 2.22.0
> 
