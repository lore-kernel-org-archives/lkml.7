Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938F9C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64FC8218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551406485;
	bh=U8QyXvzWGdsuQ7nCEOPuFwstJ6Z4LugzC6KONHsjgs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oozhg4o4Y+4T0oMIqilQaaVWC8pyNfn6DqO1SJesoOyqdU6usc9QBTjdcSkECmRUZ
	 mMcpbJYvZM18KzTtTfNarSII16dqZhbrMSor56qSI9nQnXzIhOAjFVSpKIaazYHKBo
	 YLY8J5q3KL+p2fM/F7fS+RjFaOHvIUch6l5MzgVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbfCACOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 21:14:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:59346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbfCACOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 21:14:43 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75B4A2085A;
        Fri,  1 Mar 2019 02:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551406482;
        bh=U8QyXvzWGdsuQ7nCEOPuFwstJ6Z4LugzC6KONHsjgs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wLWKdPrcq2HgO8Xp73Y2KQSUZyBvepqKAm//VmgV6JfPo+mvRO34YfQG+Q/fKyEh7
         sTIGhFmzmk8vLkwC+C713vcSFZVUxqyQmUNh4Z+Tz+zguyJHTl2NjMah9L/+Nb5K3B
         f5vhr3DzACAcuAnuqhuzQSDseXhv2JhTYjjNcvec=
Date:   Fri, 1 Mar 2019 10:13:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6dl-yapp4: Use rgmii-id phy mode on the cpu
 port
Message-ID: <20190301021344.GK26041@dragon>
References: <1550583420-112858-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1550583420-112858-1-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 02:37:00PM +0100, Michal Vokáč wrote:
> The PHY must add delays to both Tx and Rx clock on the cpu port
> to work propperly.
> 
> It worked with the rgmii mode before beacause the qca8k driver
> (incorrecly) enabled delays in that mode.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
> This imx6dl-yapp4 platform is currently waiting in linux-next.
> 
> Commit 5ecdd77c61c8 ("net: dsa: qca8k: disable delay for RGMII mode"), now
> also in linux-next removed the delays from the RGMII mode so the networking
> stopped working.
> 
> Recently Koul submitted a patch that implements the rgmii-id mode to fix
> the issue [1].
> 
> As the networking is broken at this moment it does not matter which patch
> goes in first. It is not neccessary to wait until the Koul's patch is
> applied/merged if that should be the case.
> 
> [1] http://patchwork.ozlabs.org/patch/1044505/

Can we have such useful info in the commit log in some proper form?

Shawn

> 
>  arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
> index b715ab0fa1ff..091d829f6b05 100644
> --- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
> +++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
> @@ -125,7 +125,7 @@
>  				ethphy0: port@0 {
>  					reg = <0>;
>  					label = "cpu";
> -					phy-mode = "rgmii";
> +					phy-mode = "rgmii-id";
>  					ethernet = <&fec>;
>  
>  					fixed-link {
> -- 
> 2.1.4
> 
