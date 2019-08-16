Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C466C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469F32077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565991075;
	bh=uriXE/1bpei48X3dvGlTHMHneDzIdZ1bo0Icz6ze4OU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zt6f7ZEPe3wKovd4JiE2QrhxUzdgg8FEcx5Y+t/+7dnglAt3hMmNGR7hukST9RgVb
	 g5gKdG3aOAsvR2Mf5kq2s6pDevxpDta1dFkBB449Vv0rQP/Q9CIguwwlIWUT2QOu8B
	 mzyZDokzh7c4120muXThXNy6hx8XhnxC72GAkRP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfHPVbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 17:31:14 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45141 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfHPVbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 17:31:13 -0400
Received: by mail-oi1-f196.google.com with SMTP id v12so2155144oic.12;
        Fri, 16 Aug 2019 14:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cSkX6HP4edadRsvUTh8Dt4dFym0rz2BKxLaGaU9X7YM=;
        b=ZgUmVKfdwWwhiTQ2EErxp+cuevIMxDs5Nomwxj25zHdlAysAW9KDjh7TapJNbGWQMR
         MjXmGTNwO03D4vL6pLgf9SC7bGfTuAGDHuEo4mH3dCUi0feYYVgiA5HRo1QGXUrU1H5A
         uCWsFb2sdotKmqiDt1hCLCFkSBqgtJjaOdllMv5RZjO6wrYvFMv/7hFYaGmGm4jQEfyv
         05VBfXXALmc+kSVZTCAIfUgIpoFFj/c0u5bL7aSwSV1EUgHlVL1VXl1stZyuJleSb5ZS
         7i4F61EKjWoYrSy15fK082NwgXEulel53HMZ67EcyYWBNI2bpcYtU/4OUyE3SmzXbdvx
         fpjA==
X-Gm-Message-State: APjAAAVo5e2QMtm1ZoKBKDdktwKZxM4EL1xQmSAOWXAPhYCfFm7KXact
        eGe3vIqH6qOICCCYHJZ4Gg==
X-Google-Smtp-Source: APXvYqwDR1yRX3MltSlvOjGpTB3EIJ6urfPfNJ66nUknHQOqKgdVOdgii6jtPM4lhLFSAfXNMXxzrA==
X-Received: by 2002:aca:fc14:: with SMTP id a20mr6589631oii.156.1565991072842;
        Fri, 16 Aug 2019 14:31:12 -0700 (PDT)
Received: from localhost ([2607:fb90:1cdf:eef6:c125:340:5598:396e])
        by smtp.gmail.com with ESMTPSA id q9sm1802485oij.5.2019.08.16.14.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 14:31:11 -0700 (PDT)
Date:   Fri, 16 Aug 2019 16:31:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Piotr Sroka <piotrs@cadence.com>
Cc:     linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        BrianNorris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
Subject: Re: [v5 2/2] dt-bindings: mtd: Add Cadence NAND controller driver
Message-ID: <20190816213110.GA31192@bogus>
References: <20190725145804.8886-1-piotrs@cadence.com>
 <20190725145955.13951-1-piotrs@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725145955.13951-1-piotrs@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 03:59:55PM +0100, Piotr Sroka wrote:
> Document the bindings used by Cadence NAND controller driver
> 
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> ---
> Changes for v5:
> - replace "_" by "-" in all properties
> - change compatible name from cdns,hpnfc to cdns,hp-nfc
> Changes for v4:
> - add commit message
> Changes for v3:
> - add unit suffix for board_delay 
> - move child description to proper place
> - remove prefix cadence_ for reg and sdma fields
> Changes for v2:
> - remove chip dependends parameters from dts bindings
> - add names for register ranges in dts bindings
> - add generic bindings to describe NAND chip representation
> ---
>  .../bindings/mtd/cadence-nand-controller.txt       | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt b/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
> new file mode 100644
> index 000000000000..423547a3f993
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
> @@ -0,0 +1,50 @@
> +* Cadence NAND controller
> +
> +Required properties:
> +  - compatible : "cdns,hp-nfc"
> +  - reg : Contains two entries, each of which is a tuple consisting of a
> +	  physical address and length. The first entry is the address and
> +	  length of the controller register set. The second entry is the
> +	  address and length of the Slave DMA data port.
> +  - reg-names: should contain "reg" and "sdma"
> +  - interrupts : The interrupt number.
> +  - clocks: phandle of the controller core clock (nf_clk).
> +
> +Optional properties:
> +  - dmas: shall reference DMA channel associated to the NAND controller
> +  - cdns,board-delay-ps : Estimated Board delay. The value includes the total
> +    round trip delay for the signals and is used for deciding on values
> +    associated with data read capture. The example formula for SDR mode is
> +    the following:
> +    board delay = RE#PAD delay + PCB trace to device + PCB trace from device
> +    + DQ PAD delay
> +
> +Child nodes represent the available NAND chips.
> +
> +Required properties of NAND chips:
> +  - reg: shall contain the native Chip Select ids from 0 to max supported by
> +    the cadence nand flash controller
> +
> +
> +See Documentation/devicetree/bindings/mtd/nand.txt for more details on
> +generic bindings.
> +
> +Example:
> +
> +nand_controller: nand-controller @60000000 {

space                              ^

> +	  compatible = "cdns,hp-nfc";
> +	  reg = <0x60000000 0x10000>, <0x80000000 0x10000>;
> +	  reg-names = "reg", "sdma";
> +	  clocks = <&nf_clk>;
> +	  cdns,board-delay-ps = <4830>;
> +	  interrupts = <2 0>;

You need #address-cells and #size-cells here.

With those fixes,

Reviewed-by: Rob Herring <robh@kernel.org>

> +	  nand@0 {
> +	      reg = <0>;
> +	      label = "nand-1";
> +	  };
> +	  nand@1 {
> +	      reg = <1>;
> +	      label = "nand-2";
> +	  };
> +
> +};
> -- 
> 2.15.0
> 
