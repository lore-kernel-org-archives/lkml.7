Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C244EC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F720206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TvXmTwnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfHMNCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:02:04 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34043 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbfHMNCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:02:03 -0400
Received: by mail-ed1-f66.google.com with SMTP id s49so72049571edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 06:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Usxm2/vWbD5u7OMs+mcilVe7obHTnEWPOQdDAn6jxmA=;
        b=TvXmTwnwVJLG14Vl3Jq1dYRx8MUpHJRwhO3cU+gO5fuOfpd+gDL7evTtnyqvJlFkAe
         GrKHZ8RAO+SPRXg12eHkzsbS7ETlMJxDngsQMkGl8TN8hwRLukfjKLPRk6ooQWqee8i/
         bXhSNxD8cR0P0aoBH0TsoTr8VnuR4HmsKVefo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Usxm2/vWbD5u7OMs+mcilVe7obHTnEWPOQdDAn6jxmA=;
        b=KEJQGCAWG8cs29QkeCDoTWvl1n9FbltEftVMBfH/vzG2zmJRmeN94V6etyh2EbyJqN
         gLA2fuZuL+eE8QEHR38kAs/2ECiEt0jgzThibJjBfPUsWOU6z/9rCG1QGglIjsvKBK71
         f0IUk8BLrv2rcR4ioOBidexo60p87t1wDlWmwoe62XDWRbuCBZhMsm22gzUGhPZ465dz
         lc+WoXzpKLeX+VrFDtjbnML5vEYZZiLgJh7Ft/wKEtfJHIkORw5Kp8bVDYcZbSo1yHOu
         SoVYBra/MhrrN9KMB2Akm8NoCm+HKYOXoHCPpOfWg1YsmyGLeQSTFw/dm+3qdAc1sJJ4
         nzlA==
X-Gm-Message-State: APjAAAVjt9aodXm68pH7LdEtpaZndrslxqJTQrXNYgMRbKbwzb1JxE8R
        XnQkpiXDaY+/PQllm8UmSjHjtTiDxksCGw==
X-Google-Smtp-Source: APXvYqw98c9xYqOnNfHxcozW97mrRhL+j6OhUbEXkZX/85FRmCRedt6gygOGwvVYyjqpc5nrW0lajw==
X-Received: by 2002:a50:8981:: with SMTP id g1mr29030473edg.53.1565701321649;
        Tue, 13 Aug 2019 06:02:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id j57sm1326150eda.61.2019.08.13.06.02.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 06:02:00 -0700 (PDT)
Date:   Tue, 13 Aug 2019 15:01:58 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Deepak Rawat <drawat@vmware.com>,
        Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/26] drm/dp_mst: Move test_calc_pbn_mode() into an
 actual selftest
Message-ID: <20190813130158.GT7444@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Deepak Rawat <drawat@vmware.com>,
        Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <20190718014329.8107-1-lyude@redhat.com>
 <20190718014329.8107-4-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190718014329.8107-4-lyude@redhat.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 09:42:26PM -0400, Lyude Paul wrote:
> Yes, apparently we've been testing this for every single driver load for
> quite a long time now. At least that means our PBN calculation is solid!
> 
> Anyway, introduce self tests for MST and move this into there.
> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

More official unit tests, yay!

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>


> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c         | 27 --------------
>  drivers/gpu/drm/selftests/Makefile            |  2 +-
>  .../gpu/drm/selftests/drm_modeset_selftests.h |  1 +
>  .../drm/selftests/test-drm_dp_mst_helper.c    | 36 +++++++++++++++++++
>  .../drm/selftests/test-drm_modeset_common.h   |  1 +
>  5 files changed, 39 insertions(+), 28 deletions(-)
>  create mode 100644 drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index d7c3d9233834..9e382117896d 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -45,7 +45,6 @@
>   */
>  static bool dump_dp_payload_table(struct drm_dp_mst_topology_mgr *mgr,
>  				  char *buf);
> -static int test_calc_pbn_mode(void);
>  
>  static void drm_dp_mst_topology_put_port(struct drm_dp_mst_port *port);
>  
> @@ -3439,30 +3438,6 @@ int drm_dp_calc_pbn_mode(int clock, int bpp)
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
> @@ -3898,8 +3873,6 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
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
> index 000000000000..51b2486ec917
> --- /dev/null
> +++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Test cases for for the DRM DP MST helpers
> + */
> +
> +#define pr_fmt(fmt) "drm_dp_mst_helper: " fmt
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
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
