Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F9AC73C50
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCA921537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 14:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562683738;
	bh=1VUMEkSfiXmaUBQ1FJwelCUaQY2UrNSCZvflitiwsVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZeRS0tg6dbF6omfiQjEl2loY6xM8oBv3zIsiINYQ2gQUPWWNViZ3WghWBxCPvDz+E
	 rhESHB66bPqo7rzJOJTCfqcaVfGpbpaurOTLzkWnfjoa3VOAc6lEi3Txr7N+RHedsX
	 WwgWzIineHcmS/rvxIFKcr6x5PXPKcHcR1KnmlOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfGIOs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 10:48:57 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43053 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfGIOs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 10:48:57 -0400
Received: by mail-io1-f66.google.com with SMTP id k20so43673377ios.10;
        Tue, 09 Jul 2019 07:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T/Vs1PK7xFKDrlW3gYSloAnKpvLJ7R0MVGjuRw+/My8=;
        b=Aik42ZQ03K/p/LiQ+UxOCm0utOs0f60yFYR3CckErcaHkDPrzxOF8LKBHlOsHIixvy
         UQsCEEwHHu5iyD9NskL5ZPyYbToqsKbB1FiNYsd+qD+q/INR85nC/0tmu9Q4o4lbLUFy
         a8Q0wHUKrjeCei3qfS6r3r9PTBdZremeYoBOtNIAQfuV0/4yHn7khWED189Lok5ZzZKc
         Df9scvPI+/WjnECCLIKx4IvkD3ICTlL5vR7bsfRSo1ZLfe+OASWRKTrCNXE6WWP0Cr0q
         qH5pQO8sjwuOw43EaS1voaM6QRhvZBVEYhWsTwatUddcgXLpSgVspojvb4OliC4sWHpi
         bGhA==
X-Gm-Message-State: APjAAAVzYDmyjLgbfpsMoHLCy+v73Ldoi0B0vX7clgXnNE5HjjF/eicj
        a4JngoJYrmw78GjEz99cEg==
X-Google-Smtp-Source: APXvYqyBShhjIwHDM6V18l3Qy1+iKno11GiIPO5CJH47QkOqrUPZqlX2lx6+G0+9VhP3FVExjUBBog==
X-Received: by 2002:a02:878a:: with SMTP id t10mr28623549jai.112.1562683736075;
        Tue, 09 Jul 2019 07:48:56 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id r7sm19309768ioa.71.2019.07.09.07.48.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 07:48:54 -0700 (PDT)
Date:   Tue, 9 Jul 2019 08:48:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Piotr Sroka <piotrs@cadence.com>
Cc:     linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        BrianNorris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [v3 2/2] dt-bindings: nand: Add Cadence NAND controller driver
Message-ID: <20190709144853.GA23699@bogus>
References: <20190614150956.31244-1-piotrs@cadence.com>
 <20190614151301.5371-1-piotrs@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614151301.5371-1-piotrs@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 04:13:01PM +0100, Piotr Sroka wrote:
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> ---
> Changes for v3:
> - add unit suffix for board_delay 
> - move child description to proper place
> - remove prefix cadence_ for reg and sdma fields
> Changes for v2:
> - remove chip dependends parameters from dts bindings
> - add names for register ranges in dts bindings
> - add generic bindings to describe NAND chip representation
> ---
>  .../bindings/mtd/cadence-nand-controller.txt       | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt b/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
> new file mode 100644
> index 000000000000..e485b87075bd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
> @@ -0,0 +1,51 @@
> +* Cadence NAND controller
> +
> +Required properties:
> +  - compatible : "cdns,hpnfc"

Only 1 version of h/w features and bugs?

'hp-nfc' would be a bit more readable IMO.

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
> +  - cdns,board-delay_ps : Estimated Board delay. The value includes the total

s/_/-/

> +    round trip delay for the signals and is used for deciding on values
> +    associated with data read capture. The example formula for SDR mode is
> +    the following:
> +    board_delay = RE#PAD_delay + PCB trace to device + PCB trace from device
> +    + DQ PAD delay
> +
> +Children nodes represent the available NAND chips.

Child nodes...

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

remove space                       ^

> +
> +	  compatible = "cdns,hpnfc";
> +	  reg = <0x60000000 0x10000>, <0x80000000 0x10000>;
> +	  reg-names = "reg", "sdma";
> +	  clocks = <&nf_clk>;
> +	  cdns,board-delay_ps = <4830>;
> +	  interrupts = <2 0>;
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
