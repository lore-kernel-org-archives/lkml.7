Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD90FC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6FD20870
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="n4HjD70o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfFEPuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 11:50:06 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:36960 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfFEPuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 11:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559749804; x=1591285804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9MFrYKLeLiHQwuVnld71Reu+eO4VodzjXUL9QDeOO1A=;
  b=n4HjD70oKmRskPkU3KwatnzxMH9ESC4EKy8YwcDVuXxkIUK4dmlr8cNj
   EyUaivDB/XsVsLXmgKnALLQaLpXAocoJUn+Av488tuxel8gIJxCUVlMWo
   gv2k16dFTW9gKbHZIDN4UyD4Ij7cKbSY+K32cx3pBEQz49LbfU02u/3U8
   8=;
X-IronPort-AV: E=Sophos;i="5.60,550,1549929600"; 
   d="scan'208";a="678323901"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 05 Jun 2019 15:50:00 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (Postfix) with ESMTPS id 9F0BDC10C8;
        Wed,  5 Jun 2019 15:49:56 +0000 (UTC)
Received: from EX13D13UWB003.ant.amazon.com (10.43.161.233) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 5 Jun 2019 15:49:55 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D13UWB003.ant.amazon.com (10.43.161.233) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 5 Jun 2019 15:49:55 +0000
Received: from localhost (10.85.18.74) by mail-relay.amazon.com
 (10.43.162.232) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Wed, 5 Jun 2019 15:49:55 +0000
Date:   Wed, 5 Jun 2019 08:49:55 -0700
From:   Eduardo Valentin <eduval@amazon.com>
To:     Talel Shenhar <talel@amazon.com>
CC:     <nicolas.ferre@microchip.com>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <mark.rutland@arm.com>,
        <mchehab+samsung@kernel.org>, <robh+dt@kernel.org>,
        <davem@davemloft.net>, <shawn.lin@rock-chips.com>,
        <tglx@linutronix.de>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <jonnyc@amazon.com>, <hhhawa@amazon.com>, <ronenk@amazon.com>,
        <hanochu@amazon.com>, <barakw@amazon.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: Amazon's
 Annapurna Labs FIC
Message-ID: <20190605154955.GD1534@u40b0340c692b58f6553c.ant.amazon.com>
References: <1559731921-14023-1-git-send-email-talel@amazon.com>
 <1559731921-14023-2-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1559731921-14023-2-git-send-email-talel@amazon.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 01:52:00PM +0300, Talel Shenhar wrote:
> Document Amazon's Annapurna Labs Fabric Interrupt Controller SoC binding.
> 
> Signed-off-by: Talel Shenhar <talel@amazon.com>
> ---
>  .../interrupt-controller/amazon,al-fic.txt         | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt b/Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
> new file mode 100644
> index 0000000..a2f31a6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
> @@ -0,0 +1,22 @@
> +Amazon's Annapurna Labs Fabric Interrupt Controller
> +
> +Required properties:
> +
> +- compatible: should be "amazon,al-fic"
> +- reg: physical base address and size of the registers
> +- interrupt-controller: identifies the node as an interrupt controller
> +- #interrupt-cells: must be 2.

It would be great if you describe what the 2 numbers must represent here..

> +- interrupt-parent: specifies the parent interrupt controller.
> +- interrupts: describes which input line in the interrupt parent, this
> +  fic's output is connected to.
> +
> +Example:
> +
> +amazon_fic: amazon_fic {
> +	compatible = "amazon,al-fic";
> +	interrupt-controller;
> +	#interrupt-cells = <1>;
> +	reg = <0x0 0xfd8a8500 0x0 0x1000>;
> +	interrupt-parent = <&gic>;
> +	interrupts = <GIC_SPI 0x0 IRQ_TYPE_LEVEL_HIGH>;
> +};
> -- 
> 2.7.4
> 

-- 
All the best,
Eduardo Valentin
