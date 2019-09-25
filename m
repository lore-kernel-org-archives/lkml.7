Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6A1C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 18:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9BD207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 18:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="fotbYZpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439843AbfIYSRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 14:17:38 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42393 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408520AbfIYSRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 14:17:38 -0400
Received: by mail-yb1-f194.google.com with SMTP id v6so1393937ybe.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 11:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CJtDpH2prLr/wSMW7jQFMwNstwLyQjY7xf62aK9u0G8=;
        b=fotbYZpDe/WfE2RGCesswwOBf643snhUK+xC+gl0grOJXvhy2CdCdzYTlAkZNyjfbG
         +l/sIsqmtWrFleVf0aj1IRkaT2+ZTxc7lauUWTkR8Kjqu269pZrzCPB2Ac9EYQHuoxY7
         mp0OkI1s41mWVJMxhwB4PJEE4jWukQu9cSB56LFQkM2pycWB5ZTQFMf7PVsNkycbFrAx
         xfNuvARA8jCqdKR/zAVnqMVQnGMLdPZaoxlmjVwjHSUXCifSfTA2iuGZfcKg/i3b/U8d
         FWmXwy2SmxRP8tw4omp84zO/+VFO6p1VIw8AJOvXBFp+QR+M7h4ibevd+w0aHaVxusYm
         /ZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CJtDpH2prLr/wSMW7jQFMwNstwLyQjY7xf62aK9u0G8=;
        b=AwLJN7Bq5EyyX/PeL1w/dN8nFNf5CUEiXr8LoHKQLez5wNI1ywbLCWv93ZHLgnrsNx
         wsReCHi0nnOT6xco50pHW8kv1q6nFOGJwaCVrtXACsvjClICgF2BuvmNo//qmcUf7fXS
         EoimjKvhbt+Qdl2GISrAQ0KoJuHliztJ4Ooa9Fm6to8yUdyfjNms+rk/vSfTcOojWt8s
         xm2niTOBcVBuAu/N+gECSkMB5cXz081Lrb8gdwzWI5EpsqaTriF32BLN1UjAGs/WbhBW
         m6jcKWreNIPcJ5Cma03aP7LfSJNt9K7kTa3v2OxIPT/usWge1+iLnzS6bkIumVY1avew
         w8Aw==
X-Gm-Message-State: APjAAAX7nuMjfSQfSfqHcd50ldXxlIk2ZLArvBQ6UbyrJHljZukjcwvM
        dXwH5hKcVHnltLntLJzc5T4fUA==
X-Google-Smtp-Source: APXvYqzbWQA3sbz0ApAh45vNDs3DJzeoISnbdGysjL1AreB3vdiUlGbDFeeaX/ufAbSD3sVzhLgziw==
X-Received: by 2002:a25:d9d7:: with SMTP id q206mr3730976ybg.400.1569435455696;
        Wed, 25 Sep 2019 11:17:35 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id g128sm1371910ywb.13.2019.09.25.11.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 11:17:35 -0700 (PDT)
Date:   Wed, 25 Sep 2019 14:17:34 -0400
From:   Sean Paul <sean@poorly.run>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Deepak Rawat <drawat@vmware.com>,
        Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/27] drm/dp_mst: Move test_calc_pbn_mode() into an
 actual selftest
Message-ID: <20190925181734.GE218215@art_vandelay>
References: <20190903204645.25487-1-lyude@redhat.com>
 <20190903204645.25487-5-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190903204645.25487-5-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:45:42PM -0400, Lyude Paul wrote:
> Yes, apparently we've been testing this for every single driver load for
> quite a long time now. At least that means our PBN calculation is solid!
> 
> Anyway, introduce self tests for MST and move this into there.
> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c         | 27 ---------------
>  drivers/gpu/drm/selftests/Makefile            |  2 +-
>  .../gpu/drm/selftests/drm_modeset_selftests.h |  1 +
>  .../drm/selftests/test-drm_dp_mst_helper.c    | 34 +++++++++++++++++++
>  .../drm/selftests/test-drm_modeset_common.h   |  1 +
>  5 files changed, 37 insertions(+), 28 deletions(-)
>  create mode 100644 drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 738f260d4b15..6f7f449ca12b 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -47,7 +47,6 @@
>   */
>  static bool dump_dp_payload_table(struct drm_dp_mst_topology_mgr *mgr,
>  				  char *buf);
> -static int test_calc_pbn_mode(void);
>  
>  static void drm_dp_mst_topology_put_port(struct drm_dp_mst_port *port);
>  
> @@ -3561,30 +3560,6 @@ int drm_dp_calc_pbn_mode(int clock, int bpp)
>  }
>  EXPORT_SYMBOL(drm_dp_calc_pbn_mode);
>  
> -static int test_calc_pbn_mode(void)
> -{
> -	int ret;
> -	ret = drm_dp_calc_pbn_mode(154000, 30);
> -	if (ret != 689) {
> -		DRM_ERROR("PBN calculation test failed - clock %d, bpp %d, expected PBN %d, actual PBN %d.\n",
> -				154000, 30, 689, ret);
> -		return -EINVAL;
> -	}
> -	ret = drm_dp_calc_pbn_mode(234000, 30);
> -	if (ret != 1047) {
> -		DRM_ERROR("PBN calculation test failed - clock %d, bpp %d, expected PBN %d, actual PBN %d.\n",
> -				234000, 30, 1047, ret);
> -		return -EINVAL;
> -	}
> -	ret = drm_dp_calc_pbn_mode(297000, 24);
> -	if (ret != 1063) {
> -		DRM_ERROR("PBN calculation test failed - clock %d, bpp %d, expected PBN %d, actual PBN %d.\n",
> -				297000, 24, 1063, ret);
> -		return -EINVAL;
> -	}
> -	return 0;
> -}
> -
>  /* we want to kick the TX after we've ack the up/down IRQs. */
>  static void drm_dp_mst_kick_tx(struct drm_dp_mst_topology_mgr *mgr)
>  {
> @@ -4033,8 +4008,6 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
>  	if (!mgr->proposed_vcpis)
>  		return -ENOMEM;
>  	set_bit(0, &mgr->payload_mask);
> -	if (test_calc_pbn_mode() < 0)
> -		DRM_ERROR("MST PBN self-test failed\n");
>  
>  	mst_state = kzalloc(sizeof(*mst_state), GFP_KERNEL);
>  	if (mst_state == NULL)
> diff --git a/drivers/gpu/drm/selftests/Makefile b/drivers/gpu/drm/selftests/Makefile
> index aae88f8a016c..d2137342b371 100644
> --- a/drivers/gpu/drm/selftests/Makefile
> +++ b/drivers/gpu/drm/selftests/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  test-drm_modeset-y := test-drm_modeset_common.o test-drm_plane_helper.o \
>                        test-drm_format.o test-drm_framebuffer.o \
> -		      test-drm_damage_helper.o
> +		      test-drm_damage_helper.o test-drm_dp_mst_helper.o
>  
>  obj-$(CONFIG_DRM_DEBUG_SELFTEST) += test-drm_mm.o test-drm_modeset.o test-drm_cmdline_parser.o
> diff --git a/drivers/gpu/drm/selftests/drm_modeset_selftests.h b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
> index 464753746013..dec3ee3ec96f 100644
> --- a/drivers/gpu/drm/selftests/drm_modeset_selftests.h
> +++ b/drivers/gpu/drm/selftests/drm_modeset_selftests.h
> @@ -32,3 +32,4 @@ selftest(damage_iter_damage_one_intersect, igt_damage_iter_damage_one_intersect)
>  selftest(damage_iter_damage_one_outside, igt_damage_iter_damage_one_outside)
>  selftest(damage_iter_damage_src_moved, igt_damage_iter_damage_src_moved)
>  selftest(damage_iter_damage_not_visible, igt_damage_iter_damage_not_visible)
> +selftest(dp_mst_calc_pbn_mode, igt_dp_mst_calc_pbn_mode)
> diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> new file mode 100644
> index 000000000000..9baa5171988d
> --- /dev/null
> +++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Test cases for for the DRM DP MST helpers
> + */
> +
> +#include <drm/drm_dp_mst_helper.h>
> +#include <drm/drm_print.h>
> +
> +#include "test-drm_modeset_common.h"
> +
> +int igt_dp_mst_calc_pbn_mode(void *ignored)
> +{
> +	int pbn, i;
> +	const struct {
> +		int rate;
> +		int bpp;
> +		int expected;
> +	} test_params[] = {
> +		{ 154000, 30, 689 },
> +		{ 234000, 30, 1047 },
> +		{ 297000, 24, 1063 },
> +	};
> +
> +	for (i = 0; i < ARRAY_SIZE(test_params); i++) {
> +		pbn = drm_dp_calc_pbn_mode(test_params[i].rate,
> +					   test_params[i].bpp);
> +		FAIL(pbn != test_params[i].expected,
> +		     "Expected PBN %d for clock %d bpp %d, got %d\n",
> +		     test_params[i].expected, test_params[i].rate,
> +		     test_params[i].bpp, pbn);
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/selftests/test-drm_modeset_common.h b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
> index 8c76f09c12d1..590bda35a683 100644
> --- a/drivers/gpu/drm/selftests/test-drm_modeset_common.h
> +++ b/drivers/gpu/drm/selftests/test-drm_modeset_common.h
> @@ -39,5 +39,6 @@ int igt_damage_iter_damage_one_intersect(void *ignored);
>  int igt_damage_iter_damage_one_outside(void *ignored);
>  int igt_damage_iter_damage_src_moved(void *ignored);
>  int igt_damage_iter_damage_not_visible(void *ignored);
> +int igt_dp_mst_calc_pbn_mode(void *ignored);
>  
>  #endif
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
