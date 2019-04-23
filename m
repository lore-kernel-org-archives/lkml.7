Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F206C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103AE2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfDWKuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:50:51 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:46930 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDWKuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:50:50 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id B8A5025AE8B;
        Tue, 23 Apr 2019 20:50:48 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id AD3469403E4; Tue, 23 Apr 2019 12:50:46 +0200 (CEST)
Date:   Tue, 23 Apr 2019 12:50:46 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Nguyen An Hoan <na-hoan@jinso.co.jp>
Cc:     linux-renesas-soc@vger.kernel.org,
        ramesh.shanmugasundaram@bp.renesas.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kuninori.morimoto.gx@renesas.com, magnus.damm@gmail.com,
        yoshihiro.shimoda.uh@renesas.com, h-inayoshi@jinso.co.jp,
        cv-dong@jinso.co.jp
Subject: Re: [PATCH 1/2] media: dt-bindings: media: Add r8a77965 DRIF bindings
Message-ID: <20190423105046.cshmwghdufaqp4pj@verge.net.au>
References: <1556014199-12698-1-git-send-email-na-hoan@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556014199-12698-1-git-send-email-na-hoan@jinso.co.jp>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 07:09:58PM +0900, Nguyen An Hoan wrote:
> From: Hoan Nguyen An <na-hoan@jinso.co.jp>
> 
> Add r8a77965 DRIF bindings.
> 
> Signed-off-by: Hoan Nguyen An <na-hoan@jinso.co.jp>

According to the User's Manual Hardware, v1.50 Nov 20 2019,
the DRIF IP block M3-N (r8a77965) has a BITCTR register which
is not present on the H3 (r8a7795) or M3-W (r8a77995).

Does the DRIF IP block present on the M3-N (r8a77965) function
without support for this register in the driver?

If not then I think that:
1) This patch should be updated to note that renesas,rcar-gen3-drif
   can only be used with H3 (r8a7795) and M3-W (r8a77995).
2) A driver patch is required
3) The DT patch, 2/2 of this series, should be updated to
   i) Not use renesas,rcar-gen3-drif
   ii) Extend the register aperture from 0x64 to 0x84.

> ---
>  Documentation/devicetree/bindings/media/renesas,drif.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/renesas,drif.txt b/Documentation/devicetree/bindings/media/renesas,drif.txt
> index 0d8974a..16cdee3 100644
> --- a/Documentation/devicetree/bindings/media/renesas,drif.txt
> +++ b/Documentation/devicetree/bindings/media/renesas,drif.txt
> @@ -41,6 +41,7 @@ Required properties of an internal channel:
>  -------------------------------------------
>  - compatible:	"renesas,r8a7795-drif" if DRIF controller is a part of R8A7795 SoC.
>  		"renesas,r8a7796-drif" if DRIF controller is a part of R8A7796 SoC.
> +		"renesas,r8a77965-drif" if DRIF controller is a part of R8A77965 SoC.
>  		"renesas,rcar-gen3-drif" for a generic R-Car Gen3 compatible device.
>  
>  		When compatible with the generic version, nodes must list the
> -- 
> 2.7.4
> 
