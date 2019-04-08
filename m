Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF10C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D699720880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfDHIbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:31:14 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:56631 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDHIbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:31:14 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 045A51BF20B;
        Mon,  8 Apr 2019 08:31:10 +0000 (UTC)
Date:   Mon, 8 Apr 2019 10:31:10 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     megous@megous.com
Cc:     linux-sunxi@googlegroups.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: sun4i: Fix NULL/invalid pointer dereference in
 sun8i_tcon_top_un/bind
Message-ID: <20190408083110.iy3auc7ggindifbf@flea>
References: <20190405233048.3823-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5xzbmyv2nly3kyer"
Content-Disposition: inline
In-Reply-To: <20190405233048.3823-1-megous@megous.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5xzbmyv2nly3kyer
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 06, 2019 at 01:30:48AM +0200, megous@megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
>
> There are two problems here:
>
> 1. Not all clk_data->hws[] need to be initialized, depending on various
>    configured quirks. This leads to NULL ptr deref in
>    clk_hw_unregister_gate() in sun8i_tcon_top_unbind()
> 2. If there is error when registering the clk_data->hws[],
>    err_unregister_gates error path will try to unregister
>    IS_ERR()=true (invalid) pointer.
>
> For problem (1) I have this stack trace:
>
> Unable to handle kernel NULL pointer dereference at virtual
>   address 0000000000000008
> Call trace:
>  clk_hw_unregister+0x8/0x18
>  clk_hw_unregister_gate+0x14/0x28
>  sun8i_tcon_top_unbind+0x2c/0x60
>  component_unbind.isra.4+0x2c/0x50
>  component_bind_all+0x1d4/0x230
>  sun4i_drv_bind+0xc4/0x1a0
>  try_to_bring_up_master+0x164/0x1c0
>  __component_add+0xa0/0x168
>  component_add+0x10/0x18
>  sun8i_dw_hdmi_probe+0x18/0x20
>  platform_drv_probe+0x3c/0x70
>  really_probe+0xcc/0x278
>  driver_probe_device+0x34/0xa8
>
> Problem (2) was identified by head scratching.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Changed the prefix to drm/sun4i: tcon top: and applied

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--5xzbmyv2nly3kyer
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKsGzgAKCRDj7w1vZxhR
xQqGAP4kmLyFIOtPDf+pfIt6NhIgJZDBU/daZteokDJXU4w5BAEA9YB7hTNGj3lD
pxQ4XGym/+JRqbdlTKZsfF/QFucnOAY=
=V2sL
-----END PGP SIGNATURE-----

--5xzbmyv2nly3kyer--
