Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67BBCA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 19:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D39D22468
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 19:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfJSTEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 15:04:35 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:32453
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726078AbfJSTEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 15:04:35 -0400
X-IronPort-AV: E=Sophos;i="5.67,316,1566856800"; 
   d="scan'208";a="323314015"
Received: from ip-121.net-89-2-166.rev.numericable.fr (HELO hadrien) ([89.2.166.121])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2019 21:04:31 +0200
Date:   Sat, 19 Oct 2019 21:04:31 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Wambui Karuga <wambui@karuga.xyz>
cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, sean@poorly.run,
        mripard@kernel.org, maarten.lankhorst@linux.intel.com,
        outreachy-kernel@googlegroups.com,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] drm: remove unnecessary return
 variable
In-Reply-To: <20191019071840.16877-1-wambui@karuga.xyz>
Message-ID: <alpine.DEB.2.21.1910192102410.5888@hadrien>
References: <20191019071840.16877-1-wambui@karuga.xyz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 Oct 2019, Wambui Karuga wrote:

> From: Wambui Karuga <wambui.karugax@gmail.com>
>
> Remove unnecessary variable `ret` in drm_dp_atomic_find_vcpi_slots()
> only used to hold the function return value and have the function
> return the value directly.

This patch applies for me, but with a huge offset.  What tree are you
using?

Also, Greg won't apply this, because it's not targeting staging.  Is this
for a specific outreachy project?

julia


> Issue found by coccinelle:
> @@
> local idexpression ret;
> expression e;
> @@
>
> -ret =
> +return
>      e;
> -return ret;
>
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 9cccc5e63309..b854a422a523 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -3540,7 +3540,7 @@ int drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
>  {
>  	struct drm_dp_mst_topology_state *topology_state;
>  	struct drm_dp_vcpi_allocation *pos, *vcpi = NULL;
> -	int prev_slots, req_slots, ret;
> +	int prev_slots, req_slots;
>
>  	topology_state = drm_atomic_get_mst_topology_state(state, mgr);
>  	if (IS_ERR(topology_state))
> @@ -3587,8 +3587,7 @@ int drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
>  	}
>  	vcpi->vcpi = req_slots;
>
> -	ret = req_slots;
> -	return ret;
> +	return req_slots;
>  }
>  EXPORT_SYMBOL(drm_dp_atomic_find_vcpi_slots);
>
> --
> 2.23.0
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20191019071840.16877-1-wambui%40karuga.xyz.
>
