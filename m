Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5547CC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAF12053B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179933;
	bh=REPlmJ3AG9u8ggMbAE/uWkhiDbswCFmGAr0G8TJ0BKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QP+IPOAFfkuNHkWgbyUIHJM44G1Lg4OZSjgnCZIikno+wwwP6ezvtWnzIDceWIiH/
	 U6SbK1w6PcEqzBlgMtAD3G/W8WVrxc79iwQxtZOgOADGWPl3c/F56h6jaIdDOmncw4
	 nLMMKdEQQjRpX/GMUufLV71uoZeQZ7WNvEyMxYuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437068AbfIVSzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:55:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfIVSys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:54:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F2FB21D7C;
        Sun, 22 Sep 2019 18:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178488;
        bh=REPlmJ3AG9u8ggMbAE/uWkhiDbswCFmGAr0G8TJ0BKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i8e6le3U+hN0fKAcqIAf7QpHb6lmm5ecD3gi6j4XDt7DAjovBFOJd87K10W9o/2l3
         5dQTLlgMbgI2vTdvK4VJD/TByAAM08PALBcf9kQ00sNbdazzO/12F4CNOo2qNQ61mY
         j5a5Rv0ZAd3OseQc4L4C2OwfML4ym+49tbzc47eA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Robert Richter <rrichter@marvell.com>,
        Borislav Petkov <bp@suse.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 023/128] EDAC/mc: Fix grain_bits calculation
Date:   Sun, 22 Sep 2019 14:52:33 -0400
Message-Id: <20190922185418.2158-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185418.2158-1-sashal@kernel.org>
References: <20190922185418.2158-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Richter <rrichter@marvell.com>

[ Upstream commit 3724ace582d9f675134985727fd5e9811f23c059 ]

The grain in EDAC is defined as "minimum granularity for an error
report, in bytes". The following calculation of the grain_bits in
edac_mc is wrong:

	grain_bits = fls_long(e->grain) + 1;

Where grain_bits is defined as:

	grain = 1 << grain_bits

Example:

	grain = 8	# 64 bit (8 bytes)
	grain_bits = fls_long(8) + 1
	grain_bits = 4 + 1 = 5

	grain = 1 << grain_bits
	grain = 1 << 5 = 32

Replace it with the correct calculation:

	grain_bits = fls_long(e->grain - 1);

The example gives now:

	grain_bits = fls_long(8 - 1)
	grain_bits = fls_long(7)
	grain_bits = 3

	grain = 1 << 3 = 8

Also, check if the hardware reports a reasonable grain != 0 and fallback
with a warning to 1 byte granularity otherwise.

 [ bp: massage a bit. ]

Signed-off-by: Robert Richter <rrichter@marvell.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20190624150758.6695-2-rrichter@marvell.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/edac_mc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 7d3edd7139328..f59511bd99261 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1246,9 +1246,13 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
 	if (p > e->location)
 		*(p - 1) = '\0';
 
-	/* Report the error via the trace interface */
-	grain_bits = fls_long(e->grain) + 1;
+	/* Sanity-check driver-supplied grain value. */
+	if (WARN_ON_ONCE(!e->grain))
+		e->grain = 1;
+
+	grain_bits = fls_long(e->grain - 1);
 
+	/* Report the error via the trace interface */
 	if (IS_ENABLED(CONFIG_RAS))
 		trace_mc_event(type, e->msg, e->label, e->error_count,
 			       mci->mc_idx, e->top_layer, e->mid_layer,
-- 
2.20.1

