Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077A9C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD44B20C01
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556810982;
	bh=4ccVWNT2Tr70kaPTsw1BldkHwE63xEjvmTgBVq7Pshs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ffZ4nRxwCLTSWTt8/Wnl2cq8OEttY+e9ns7ndQb0cqhcPRTCJGOA661T+aODRcMT4
	 jv3bzg0UjgDu/FRe9i84i6zVA8clpEn9SmzhUY9iRQ+sgqnsJwG6DmP+qAsW7lE0uZ
	 whsz8rOotI9WZEJRTINO6DClmwJ0xxVOZKSVuV4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbfEBP3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:29:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728489AbfEBP3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:29:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5764020675;
        Thu,  2 May 2019 15:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810976;
        bh=4ccVWNT2Tr70kaPTsw1BldkHwE63xEjvmTgBVq7Pshs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VetEtNO6Xay7vihiswbvicnkAOtXkRECBF9pfV3roqYFmafJ8UDKtp55LYrY02mB6
         FD0NBcYtunO+uJxAksT0wnfWktuU6K8hrzvNGk2NrEqnaVvavCvnF4nrCwvC6Nn45k
         BnxigToy0oMv+J31iPoF9Xz+hFi2VCzUXEgP1V+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anusha Srivatsa <anusha.srivatsa@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 5.0 003/101] drm/i915: Do not enable FEC without DSC
Date:   Thu,  2 May 2019 17:20:05 +0200
Message-Id: <20190502143339.703409532@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143339.434882399@linuxfoundation.org>
References: <20190502143339.434882399@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 5aae7832d1b4ec614996ea0f4fafc4d9855ec0b0 upstream.

Currently we enable FEC even when DSC is no used. While that is
theoretically valid supposedly there isn't much of a benefit from
this. But more importantly we do not account for the FEC link
bandwidth overhead (2.4%) in the non-DSC link bandwidth computations.
So the code may think we have enough bandwidth when we in fact
do not.

Cc: stable@vger.kernel.org
Cc: Anusha Srivatsa <anusha.srivatsa@intel.com>
Cc: Manasi Navare <manasi.d.navare@intel.com>
Fixes: 240999cf339f ("i915/dp/fec: Add fec_enable to the crtc state.")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190326144903.6617-1-ville.syrjala@linux.intel.com
Reviewed-by: Manasi Navare <manasi.d.navare@intel.com>
(cherry picked from commit 6fd3134ae3551d4802a04669c0f39f2f5c56f77d)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_dp.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -1871,6 +1871,9 @@ static bool intel_dp_dsc_compute_config(
 	u8 dsc_max_bpc;
 	int pipe_bpp;
 
+	pipe_config->fec_enable = !intel_dp_is_edp(intel_dp) &&
+		intel_dp_supports_fec(intel_dp, pipe_config);
+
 	if (!intel_dp_supports_dsc(intel_dp, pipe_config))
 		return false;
 
@@ -2097,9 +2100,6 @@ intel_dp_compute_config(struct intel_enc
 	if (adjusted_mode->flags & DRM_MODE_FLAG_DBLCLK)
 		return false;
 
-	pipe_config->fec_enable = !intel_dp_is_edp(intel_dp) &&
-				  intel_dp_supports_fec(intel_dp, pipe_config);
-
 	if (!intel_dp_compute_link_config(encoder, pipe_config, conn_state))
 		return false;
 


