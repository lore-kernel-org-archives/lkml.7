Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346B0C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF09B20693
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbfDCHwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:52:49 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60937 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfDCHwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:52:49 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 490F960004;
        Wed,  3 Apr 2019 07:52:46 +0000 (UTC)
Date:   Wed, 3 Apr 2019 09:52:45 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] clk: sunxi-ng: nkmp: Avoid GENMASK(-1, 0)
Message-ID: <20190403075245.wzjbxbkg4pxoqdkc@flea>
References: <20190402210623.14988-1-jernej.skrabec@siol.net>
 <20190402210623.14988-2-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wyl6r4r7wwthmrap"
Content-Disposition: inline
In-Reply-To: <20190402210623.14988-2-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wyl6r4r7wwthmrap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Apr 02, 2019 at 11:06:21PM +0200, Jernej Skrabec wrote:
> Sometimes one of the nkmp factors is unused. This means that one of the
> factors shift and width values are set to 0. Current nkmp clock code
> generates a mask for each factor with GENMASK(width + shift - 1, shift).
> For unused factor this translates to GENMASK(-1, 0). This code is
> further expanded by C preprocessor to final version:
> (((~0UL) - (1UL << (0)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (-1))))
> or a bit simplified:
> (~0UL & (~0UL >> BITS_PER_LONG))
>
> It turns out that result of the second part (~0UL >> BITS_PER_LONG) is
> actually undefined by C standard, which clearly specifies:
>
> "If the value of the right operand is negative or is greater than or
> equal to the width of the promoted left operand, the behavior is
> undefined."
>
> Additionally, compiling kernel with aarch64-linux-gnu-gcc 8.3.0 gave
> different results whether literals or variables with same values as
> literals were used. GENMASK with literals -1 and 0 gives zero and with
> variables gives 0xFFFFFFFFFFFFFFF (~0UL). Because nkmp driver uses
> GENMASK with variables as parameter, expression calculates mask as ~0UL
> instead of 0. This has further consequences that LSB in register is
> always set to 1 (1 is neutral value for a factor and shift is 0).
>
> For example, H6 pll-de clock is set to 600 MHz by sun4i-drm driver, but
> due to this bug ends up being 300 MHz. Additionally, 300 MHz seems to be
> too low because following warning can be found in dmesg:
>
> [    1.752763] WARNING: CPU: 2 PID: 41 at drivers/clk/sunxi-ng/ccu_common.c:41 ccu_helper_wait_for_lock.part.0+0x6c/0x90
> [    1.763378] Modules linked in:
> [    1.766441] CPU: 2 PID: 41 Comm: kworker/2:1 Not tainted 5.1.0-rc2-next-20190401 #138
> [    1.774269] Hardware name: Pine H64 (DT)
> [    1.778200] Workqueue: events deferred_probe_work_func
> [    1.783341] pstate: 40000005 (nZcv daif -PAN -UAO)
> [    1.788135] pc : ccu_helper_wait_for_lock.part.0+0x6c/0x90
> [    1.793623] lr : ccu_helper_wait_for_lock.part.0+0x48/0x90
> [    1.799107] sp : ffff000010f93840
> [    1.802422] x29: ffff000010f93840 x28: 0000000000000000
> [    1.807735] x27: ffff800073ce9d80 x26: ffff000010afd1b8
> [    1.813049] x25: ffffffffffffffff x24: 00000000ffffffff
> [    1.818362] x23: 0000000000000001 x22: ffff000010abd5c8
> [    1.823675] x21: 0000000010000000 x20: 00000000685f367e
> [    1.828987] x19: 0000000000001801 x18: 0000000000000001
> [    1.834300] x17: 0000000000000001 x16: 0000000000000000
> [    1.839613] x15: 0000000000000000 x14: ffff000010789858
> [    1.844926] x13: 0000000000000000 x12: 0000000000000001
> [    1.850239] x11: 0000000000000000 x10: 0000000000000970
> [    1.855551] x9 : ffff000010f936c0 x8 : ffff800074cec0d0
> [    1.860864] x7 : 0000800067117000 x6 : 0000000115c30b41
> [    1.866177] x5 : 00ffffffffffffff x4 : 002c959300bfe500
> [    1.871490] x3 : 0000000000000018 x2 : 0000000029aaaaab
> [    1.876802] x1 : 00000000000002e6 x0 : 00000000686072bc
> [    1.882114] Call trace:
> [    1.884565]  ccu_helper_wait_for_lock.part.0+0x6c/0x90
> [    1.889705]  ccu_helper_wait_for_lock+0x10/0x20
> [    1.894236]  ccu_nkmp_set_rate+0x244/0x2a8
> [    1.898334]  clk_change_rate+0x144/0x290
> [    1.902258]  clk_core_set_rate_nolock+0x180/0x1b8
> [    1.906963]  clk_set_rate+0x34/0xa0
> [    1.910455]  sun8i_mixer_bind+0x484/0x558
> [    1.914466]  component_bind_all+0x10c/0x230
> [    1.918651]  sun4i_drv_bind+0xc4/0x1a0
> [    1.922401]  try_to_bring_up_master+0x164/0x1c0
> [    1.926932]  __component_add+0xa0/0x168
> [    1.930769]  component_add+0x10/0x18
> [    1.934346]  sun8i_dw_hdmi_probe+0x18/0x20
> [    1.938443]  platform_drv_probe+0x50/0xa0
> [    1.942455]  really_probe+0xcc/0x280
> [    1.946032]  driver_probe_device+0x54/0xe8
> [    1.950130]  __device_attach_driver+0x80/0xb8
> [    1.954488]  bus_for_each_drv+0x78/0xc8
> [    1.958326]  __device_attach+0xd4/0x130
> [    1.962163]  device_initial_probe+0x10/0x18
> [    1.966348]  bus_probe_device+0x90/0x98
> [    1.970185]  deferred_probe_work_func+0x6c/0xa0
> [    1.974720]  process_one_work+0x1e0/0x320
> [    1.978732]  worker_thread+0x228/0x428
> [    1.982484]  kthread+0x120/0x128
> [    1.985714]  ret_from_fork+0x10/0x18
> [    1.989290] ---[ end trace 9babd42e1ca4b84f ]---
>
> This commit solves the issue by first checking value of the factor
> width. If it is equal to 0 (unused factor), mask is set to 0, otherwise
> GENMASK() macro is used as before.
>
> Fixes: d897ef56faf9 ("clk: sunxi-ng: Mask nkmp factors when setting register")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/clk/sunxi-ng/ccu_nkmp.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
> index 9b49adb20d07..69dfc6de1c4e 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkmp.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
> @@ -167,7 +167,7 @@ static int ccu_nkmp_set_rate(struct clk_hw *hw, unsigned long rate,
>  			   unsigned long parent_rate)
>  {
>  	struct ccu_nkmp *nkmp = hw_to_ccu_nkmp(hw);
> -	u32 n_mask, k_mask, m_mask, p_mask;
> +	u32 n_mask = 0, k_mask = 0, m_mask = 0, p_mask = 0;
>  	struct _ccu_nkmp _nkmp;
>  	unsigned long flags;
>  	u32 reg;
> @@ -186,10 +186,18 @@ static int ccu_nkmp_set_rate(struct clk_hw *hw, unsigned long rate,
>
>  	ccu_nkmp_find_best(parent_rate, rate, &_nkmp);
>
> -	n_mask = GENMASK(nkmp->n.width + nkmp->n.shift - 1, nkmp->n.shift);
> -	k_mask = GENMASK(nkmp->k.width + nkmp->k.shift - 1, nkmp->k.shift);
> -	m_mask = GENMASK(nkmp->m.width + nkmp->m.shift - 1, nkmp->m.shift);
> -	p_mask = GENMASK(nkmp->p.width + nkmp->p.shift - 1, nkmp->p.shift);
> +	if (nkmp->n.width)
> +		n_mask = GENMASK(nkmp->n.width + nkmp->n.shift - 1,
> +				 nkmp->n.shift);
> +	if (nkmp->k.width)
> +		k_mask = GENMASK(nkmp->k.width + nkmp->k.shift - 1,
> +				 nkmp->k.shift);
> +	if (nkmp->m.width)
> +		m_mask = GENMASK(nkmp->m.width + nkmp->m.shift - 1,
> +				 nkmp->m.shift);
> +	if (nkmp->p.width)
> +		p_mask = GENMASK(nkmp->p.width + nkmp->p.shift - 1,
> +				 nkmp->p.shift);

Thanks for the awesome commit log, and for digging this out.
I've applied this patch.

Could you write a comment just above the code to explain it as well so
that it doesn't confuse anyone? You can send a subsequent patch.

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--wyl6r4r7wwthmrap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKRmTQAKCRDj7w1vZxhR
xaP5AP4z+otvfa+Ti1iz5ptRm7NBplv6iOg7sBsRSLfzLTeBPwEAvx+shf7ltJbS
th31y9Mqu1dVNnyruIGhl/LHB79aNgs=
=tZB2
-----END PGP SIGNATURE-----

--wyl6r4r7wwthmrap--
