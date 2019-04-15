Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0CFC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832742073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355779;
	bh=Jf6Wm65SfGaJn1IcUhbm1cKC+SgNvHZK51elKDsBxXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wQsn3qHbqqn+RsBl+8WHDnp7uioAOgpm61ElAingIKdDbE3XvsGivfQ7eYlXgtxJ0
	 EZt2tNrcVYxgQ75SjfLTgvSp3vTvEnnTBpMTJaxYfm6+B6tLE0EdcU/YrXO+TOym8/
	 VxO1kOsqQ44NGuXql+DafCsLIEmHeFTHMZEIoNQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbfDOTQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:16:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731552AbfDOTNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:13:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8DB6218D3;
        Mon, 15 Apr 2019 19:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355604;
        bh=Jf6Wm65SfGaJn1IcUhbm1cKC+SgNvHZK51elKDsBxXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ozkEuO0oms9m2xqgFb14HYm4jbdHFKokRCw7fwxVxk71vyY9Fwg366UYrJI1S5RZM
         +9YK3tCJkjz5IJ3JD9nKji9SKqbVhb+G9GCezNtXfEBAFd4grs1Ih00XoeUuPwxvOr
         rbDGIREf1bFY2hJo+2+D00byQ/VhlzunX4Ngn1LU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Matt Atwood <matthew.s.atwood@intel.com>,
        "Lee, Shawn C" <shawn.c.lee@intel.com>,
        Dave Airlie <airlied@gmail.com>,
        intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@intel.com>,
        Albert Astals Cid <aacid@kde.org>,
        Emanuele Panigati <ilpanich@gmail.com>,
        Matteo Iervasi <matteoiervasi@gmail.com>
Subject: [PATCH 5.0 084/117] drm/i915/dp: revert back to max link rate and lane count on eDP
Date:   Mon, 15 Apr 2019 21:00:54 +0200
Message-Id: <20190415183749.193873670@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jani Nikula <jani.nikula@intel.com>

commit 21635d7311734d2d1b177f8a95e2f9386174b76d upstream.

Commit 7769db588384 ("drm/i915/dp: optimize eDP 1.4+ link config fast
and narrow") started to optize the eDP 1.4+ link config, both per spec
and as preparation for display stream compression support.

Sadly, we again face panels that flat out fail with parameters they
claim to support. Revert, and go back to the drawing board.

v2: Actually revert to max params instead of just wide-and-slow.

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=109959
Fixes: 7769db588384 ("drm/i915/dp: optimize eDP 1.4+ link config fast and narrow")
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Manasi Navare <manasi.d.navare@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matt Atwood <matthew.s.atwood@intel.com>
Cc: "Lee, Shawn C" <shawn.c.lee@intel.com>
Cc: Dave Airlie <airlied@gmail.com>
Cc: intel-gfx@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.0+
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Reviewed-by: Manasi Navare <manasi.d.navare@intel.com>
Tested-by: Albert Astals Cid <aacid@kde.org> # v5.0 backport
Tested-by: Emanuele Panigati <ilpanich@gmail.com> # v5.0 backport
Tested-by: Matteo Iervasi <matteoiervasi@gmail.com> # v5.0 backport
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190405075220.9815-1-jani.nikula@intel.com
(cherry picked from commit f11cb1c19ad0563b3c1ea5eb16a6bac0e401f428)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/gpu/drm/i915/intel_dp.c |   69 +++++-----------------------------------
 1 file changed, 10 insertions(+), 59 deletions(-)

--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -1845,42 +1845,6 @@ intel_dp_compute_link_config_wide(struct
 	return false;
 }
 
-/* Optimize link config in order: max bpp, min lanes, min clock */
-static bool
-intel_dp_compute_link_config_fast(struct intel_dp *intel_dp,
-				  struct intel_crtc_state *pipe_config,
-				  const struct link_config_limits *limits)
-{
-	struct drm_display_mode *adjusted_mode = &pipe_config->base.adjusted_mode;
-	int bpp, clock, lane_count;
-	int mode_rate, link_clock, link_avail;
-
-	for (bpp = limits->max_bpp; bpp >= limits->min_bpp; bpp -= 2 * 3) {
-		mode_rate = intel_dp_link_required(adjusted_mode->crtc_clock,
-						   bpp);
-
-		for (lane_count = limits->min_lane_count;
-		     lane_count <= limits->max_lane_count;
-		     lane_count <<= 1) {
-			for (clock = limits->min_clock; clock <= limits->max_clock; clock++) {
-				link_clock = intel_dp->common_rates[clock];
-				link_avail = intel_dp_max_data_rate(link_clock,
-								    lane_count);
-
-				if (mode_rate <= link_avail) {
-					pipe_config->lane_count = lane_count;
-					pipe_config->pipe_bpp = bpp;
-					pipe_config->port_clock = link_clock;
-
-					return true;
-				}
-			}
-		}
-	}
-
-	return false;
-}
-
 static int intel_dp_dsc_compute_bpp(struct intel_dp *intel_dp, u8 dsc_max_bpc)
 {
 	int i, num_bpc;
@@ -2013,15 +1977,13 @@ intel_dp_compute_link_config(struct inte
 	limits.min_bpp = 6 * 3;
 	limits.max_bpp = intel_dp_compute_bpp(intel_dp, pipe_config);
 
-	if (intel_dp_is_edp(intel_dp) && intel_dp->edp_dpcd[0] < DP_EDP_14) {
+	if (intel_dp_is_edp(intel_dp)) {
 		/*
 		 * Use the maximum clock and number of lanes the eDP panel
-		 * advertizes being capable of. The eDP 1.3 and earlier panels
-		 * are generally designed to support only a single clock and
-		 * lane configuration, and typically these values correspond to
-		 * the native resolution of the panel. With eDP 1.4 rate select
-		 * and DSC, this is decreasingly the case, and we need to be
-		 * able to select less than maximum link config.
+		 * advertizes being capable of. The panels are generally
+		 * designed to support only a single clock and lane
+		 * configuration, and typically these values correspond to the
+		 * native resolution of the panel.
 		 */
 		limits.min_lane_count = limits.max_lane_count;
 		limits.min_clock = limits.max_clock;
@@ -2035,22 +1997,11 @@ intel_dp_compute_link_config(struct inte
 		      intel_dp->common_rates[limits.max_clock],
 		      limits.max_bpp, adjusted_mode->crtc_clock);
 
-	if (intel_dp_is_edp(intel_dp))
-		/*
-		 * Optimize for fast and narrow. eDP 1.3 section 3.3 and eDP 1.4
-		 * section A.1: "It is recommended that the minimum number of
-		 * lanes be used, using the minimum link rate allowed for that
-		 * lane configuration."
-		 *
-		 * Note that we use the max clock and lane count for eDP 1.3 and
-		 * earlier, and fast vs. wide is irrelevant.
-		 */
-		ret = intel_dp_compute_link_config_fast(intel_dp, pipe_config,
-							&limits);
-	else
-		/* Optimize for slow and wide. */
-		ret = intel_dp_compute_link_config_wide(intel_dp, pipe_config,
-							&limits);
+	/*
+	 * Optimize for slow and wide. This is the place to add alternative
+	 * optimization policy.
+	 */
+	ret = intel_dp_compute_link_config_wide(intel_dp, pipe_config, &limits);
 
 	/* enable compression if the mode doesn't fit available BW */
 	if (!ret) {


