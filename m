Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA9EC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D926C2077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575882537;
	bh=QAsy6KYtyWoOffL4NFS3+5/Zh44sQt9mMpY2XhbERdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l1Kdq8txL3kUiMjHzSzFk3jp+bd635RTbRtm7bX2X/xejX2kqw8pucV+xodBHBBn6
	 vPFbzrC2LYWG1L/c7LHfkAnO7IPBRNxDWJ4sCbIliMc1prMdMlBs8EaM3OLW5QTVYs
	 gncE0qIu6ln31FBZqXCDbTZOk+TmVTKIDMFIwamk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfLIJI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:08:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:43100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfLIJI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:08:56 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EEB82072D;
        Mon,  9 Dec 2019 09:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575882536;
        bh=QAsy6KYtyWoOffL4NFS3+5/Zh44sQt9mMpY2XhbERdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fJr+YRMo1Rnw0+vTxF6gPpMdzFTFrIfbdML67vLN6jbyh5McznFgrIX0BjK9CA7iK
         dYFz9iFC0H8+/ml50izL4yc8S1EpANPnuREKYX0eAc4PdGphLzymmVskHnzECr1+Mu
         /+hwKeGGPVnWAKfkdb21nDvtwNEbJop3/VDxkcus=
Date:   Mon, 9 Dec 2019 17:08:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>, Alison Wang <alison.wang@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64: dts: ls1028a: put SAIs into async mode
Message-ID: <20191209090840.GL3365@dragon>
References: <20191129210937.26808-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129210937.26808-1-michael@walle.cc>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Alison Wang

On Fri, Nov 29, 2019 at 10:09:37PM +0100, Michael Walle wrote:
> The LS1028A SoC has only unidirectional SAIs. Therefore, it doesn't make
> sense to have the RX and TX part synchronous. Even worse, the RX part
> wont work out of the box because by default it is configured as
> synchronous to the TX part. And as said before, the pinmux of the SoC
> can only be configured to route either the RX or the TX signals to the
> SAI but never both at the same time. Thus configure the asynchronous
> mode by default.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Alison, Leo,

Looks good to you?

Shawn

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 379913756e90..9be33426e5ce 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -637,6 +637,7 @@
>  			dma-names = "tx", "rx";
>  			dmas = <&edma0 1 4>,
>  			       <&edma0 1 3>;
> +			fsl,sai-asynchronous;
>  			status = "disabled";
>  		};
>  
> @@ -651,6 +652,7 @@
>  			dma-names = "tx", "rx";
>  			dmas = <&edma0 1 6>,
>  			       <&edma0 1 5>;
> +			fsl,sai-asynchronous;
>  			status = "disabled";
>  		};
>  
> @@ -665,6 +667,7 @@
>  			dma-names = "tx", "rx";
>  			dmas = <&edma0 1 8>,
>  			       <&edma0 1 7>;
> +			fsl,sai-asynchronous;
>  			status = "disabled";
>  		};
>  
> @@ -679,6 +682,7 @@
>  			dma-names = "tx", "rx";
>  			dmas = <&edma0 1 10>,
>  			       <&edma0 1 9>;
> +			fsl,sai-asynchronous;
>  			status = "disabled";
>  		};
>  
> @@ -693,6 +697,7 @@
>  			dma-names = "tx", "rx";
>  			dmas = <&edma0 1 12>,
>  			       <&edma0 1 11>;
> +			fsl,sai-asynchronous;
>  			status = "disabled";
>  		};
>  
> @@ -707,6 +712,7 @@
>  			dma-names = "tx", "rx";
>  			dmas = <&edma0 1 14>,
>  			       <&edma0 1 13>;
> +			fsl,sai-asynchronous;
>  			status = "disabled";
>  		};
>  
> -- 
> 2.20.1
> 
