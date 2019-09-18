Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E96BC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040B321BE5
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568787930;
	bh=3CyFhuas6gP5M1JgVHpC1okIUboCfMCDtxVBycq2dsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1RMxDr0T90YBl6xKaW8RI41mRxmMuupxUob9HlStsdCERyCJgfdD7Ybqkg1WcwDW3
	 ZlkWQMBr+sNd11aY8a8ydIVqUdHYBRH5QLEUjkoL0aBnc/ATgBPewMld1IJ7zHHL2u
	 QFqzCitCyEjomwIuQCZaC4OqDMxhJNzYyc/Dn5q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbfIRGZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:25:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730104AbfIRGZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:25:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9476821920;
        Wed, 18 Sep 2019 06:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787925;
        bh=3CyFhuas6gP5M1JgVHpC1okIUboCfMCDtxVBycq2dsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=APo6lb/hjNP7pAN83pfA860it47bDKPL9hw4KlJt92WDcEewupmHtGMbMFy0S+Mum
         jihLOJFfrYStBQBjdrz2Aey/Y7mTf/IxOGdluLNt597g/LsQCZ38EIpk3JOOifLEEQ
         7ABK4vZlL4Umu7VQK9XhOmI9oJOkgzjb5nof+vMw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Geoffrey Bennett <gmux22@gmail.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 5.2 33/85] drm/i915: Limit MST to <= 8bpc once again
Date:   Wed, 18 Sep 2019 08:18:51 +0200
Message-Id: <20190918061235.198832090@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061234.107708857@linuxfoundation.org>
References: <20190918061234.107708857@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit bb1a71f9c4672fbfcf2158fd57d0c5c0cdae5612 upstream.

My attempt at allowing MST to use the higher color depths has
regressed some configurations. Apparently people have setups
where all MST streams will fit into the DP link with 8bpc but
won't fit with higher color depths.

What we really should be doing is reducing the bpc for all the
streams on the same link until they start to fit. But that requires
a bit more work, so in the meantime let's revert back closer to
the old behavior and limit MST to at most 8bpc.

Cc: stable@vger.kernel.org
Cc: Lyude Paul <lyude@redhat.com>
Tested-by: Geoffrey Bennett <gmux22@gmail.com>
Fixes: f1477219869c ("drm/i915: Remove the 8bpc shackles from DP MST")
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=111505
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190828102059.2512-1-ville.syrjala@linux.intel.com
Reviewed-by: Lyude Paul <lyude@redhat.com>
(cherry picked from commit 75427b2a2bffc083d51dec389c235722a9c69b05)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_dp_mst.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/intel_dp_mst.c
@@ -125,7 +125,15 @@ static int intel_dp_mst_compute_config(s
 	limits.max_lane_count = intel_dp_max_lane_count(intel_dp);
 
 	limits.min_bpp = intel_dp_min_bpp(pipe_config);
-	limits.max_bpp = pipe_config->pipe_bpp;
+	/*
+	 * FIXME: If all the streams can't fit into the link with
+	 * their current pipe_bpp we should reduce pipe_bpp across
+	 * the board until things start to fit. Until then we
+	 * limit to <= 8bpc since that's what was hardcoded for all
+	 * MST streams previously. This hack should be removed once
+	 * we have the proper retry logic in place.
+	 */
+	limits.max_bpp = min(pipe_config->pipe_bpp, 24);
 
 	intel_dp_adjust_compliance_config(intel_dp, pipe_config, &limits);
 


