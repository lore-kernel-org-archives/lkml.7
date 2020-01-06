Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EF2C2D0D1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4D62072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgAFKPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 05:15:34 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42287 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgAFKPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 05:15:33 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1ioPQ4-0002KV-M8; Mon, 06 Jan 2020 11:15:32 +0100
Message-ID: <82299ef95e44190d9bcea29bacb5651f3dc75b64.camel@pengutronix.de>
Subject: Re: [PATCH 5/6] drm/etnaviv: update hwdb selection logic
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Date:   Mon, 06 Jan 2020 11:15:32 +0100
In-Reply-To: <20200102100230.420009-6-christian.gmeiner@gmail.com>
References: <20200102100230.420009-1-christian.gmeiner@gmail.com>
         <20200102100230.420009-6-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Do, 2020-01-02 at 11:02 +0100, Christian Gmeiner wrote:
> Take product id, customer id and eco id into account. If that
> delivers no match try a search for model and revision.
> 
> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> index eb0f3eb87ced..d1744f1b44b1 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> @@ -44,9 +44,26 @@ bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu)
>  	struct etnaviv_chip_identity *ident = &gpu->identity;
>  	int i;
>  
> +	/* accurate match */
>  	for (i = 0; i < ARRAY_SIZE(etnaviv_chip_identities); i++) {
>  		if (etnaviv_chip_identities[i].model == ident->model &&
> -		    etnaviv_chip_identities[i].revision == ident->revision) {
> +		    etnaviv_chip_identities[i].revision == ident->revision &&
> +		    etnaviv_chip_identities[i].product_id == ident->product_id &&

Why not simply make this:
(etnaviv_chip_identities[i].product_id == ident->product_id ||
etnaviv_chip_identities[i].product_id == ~0U)
and similar for customer and eco ID?

With this we don't need two different walks through the HWDB, as long
as the more specific entries in the DB are ordered to the front of the
array.

Regards,
Lucas

> +		    etnaviv_chip_identities[i].customer_id == ident->customer_id &&
> +		    etnaviv_chip_identities[i].eco_id == ident->eco_id) {
> +			memcpy(ident, &etnaviv_chip_identities[i],
> +			       sizeof(*ident));
> +			return true;
> +		}
> +	}
> +
> +	/* match based only on model and revision */
> +	for (i = 0; i < ARRAY_SIZE(etnaviv_chip_identities); i++) {
> +		if (etnaviv_chip_identities[i].model == ident->model &&
> +		    etnaviv_chip_identities[i].revision == ident->revision &&
> +		    etnaviv_chip_identities[i].product_id == ~0U &&
> +		    etnaviv_chip_identities[i].customer_id == ~0U &&
> +		    etnaviv_chip_identities[i].eco_id == ~0U) {
>  			memcpy(ident, &etnaviv_chip_identities[i],
>  			       sizeof(*ident));
>  			return true;

