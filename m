Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4C6C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E476420721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387674AbgAIQad convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:30:33 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:37009 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387657AbgAIQad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:30:33 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id E41DA2000E;
        Thu,  9 Jan 2020 16:30:29 +0000 (UTC)
Date:   Thu, 9 Jan 2020 17:30:28 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     richard@nod.at, marek.vasut@gmail.com, dwmw2@infradead.org,
        bbrezillon@kernel.org, computersforpeace@gmail.com,
        vigneshr@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v4 2/2] dt-bindings: mtd: Document Macronix NAND device
 bindings
Message-ID: <20200109173028.09de5f08@xps13>
In-Reply-To: <1571902807-10388-3-git-send-email-masonccyang@mxic.com.tw>
References: <1571902807-10388-1-git-send-email-masonccyang@mxic.com.tw>
        <1571902807-10388-3-git-send-email-masonccyang@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

Mason Yang <masonccyang@mxic.com.tw> wrote on Thu, 24 Oct 2019 15:40:07
+0800:

> Document the bindings used by the Macronix NAND device.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  .../devicetree/bindings/mtd/nand-macronix.txt        | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/nand-macronix.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/nand-macronix.txt b/Documentation/devicetree/bindings/mtd/nand-macronix.txt
> new file mode 100644
> index 0000000..cb60358
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/nand-macronix.txt
> @@ -0,0 +1,20 @@
> +Macronix NANDs Device Tree Bindings
> +-----------------------------------
> +
> +Macronix NANDs support randomizer operation for user data scrambled,
> +which can be enabled with a SET_FEATURE. The penalty of randomizer
> +is subpage accesses prohibited. By adding a new specific property
> +in children nodes to enable randomizer function.

You don't mention the performance penalty nor the benefits of such
operation.

Please also insist on the fact that this is a one time persistent, non
reversible operation and the use should use this property only if they
know what they are doing!

> +
> +Required NAND chip properties in children mode:
> +- randomizer enable: should be "mxic,enable-randomizer-otp"
> +
> +Example:
> +
> +	nand: nand-controller@unit-address {
> +
> +		nand@0 {
> +			reg = <0>;
> +			mxic,enable-randomizer-otp;
> +		};
> +	};

Thanks,
Miquèl
