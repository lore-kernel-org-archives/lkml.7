Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECBCC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D87206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781780;
	bh=ZbF9qzPSlqMpc1jdHpqItSS2h2jKECcFT8NG6HGE4zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nuHl9m/DryjdXX7mWVoDIil+7P5QLkTR3ZBZD4AH0Qe55DP3Xt4qKkJu6nrN2iiNf
	 6kGrV7/D45X2dNHvU083iB1JvpjcUSTWCGNKZG4R1AF7wSAzq37161R43fSfsj9x6j
	 wLVHSaP2RLoOmxTGC1MlJyCosbKgO9KHGrPMyDpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbfLSS4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:56:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730788AbfLSS4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:56:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99658222C2;
        Thu, 19 Dec 2019 18:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781774;
        bh=ZbF9qzPSlqMpc1jdHpqItSS2h2jKECcFT8NG6HGE4zw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hXcdTeOCa26tqRBFMf8UsIwkSjIg6ilPbRwtTUCBwpD4dL02d3c3zkERLiHGeI/oV
         z7PAgUt9WTMiTx3Ul1//07ph3sij9plYTlShpD4aFvBT+8FaFup1Ei4AClget9fUM5
         SJnAKPWEUc+U4MRhJJxC7FXnqv2m1SdWo5Z8srLE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.4 73/80] drm/amd/display: add default clocks if not able to fetch them
Date:   Thu, 19 Dec 2019 19:35:05 +0100
Message-Id: <20191219183143.575586568@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183031.278083125@linuxfoundation.org>
References: <20191219183031.278083125@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit 946621691f9919c263b4679b77f81f06019d3636 upstream.

dm_pp_get_clock_levels_by_type needs to add the default clocks
to the powerplay case as well.  This was accidently dropped.

Fixes: b3ea88fef321de ("drm/amd/powerplay: add get_clock_by_type interface for display")
Bug: https://gitlab.freedesktop.org/drm/amd/issues/906
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -342,7 +342,8 @@ bool dm_pp_get_clock_levels_by_type(
 	if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->get_clock_by_type) {
 		if (adev->powerplay.pp_funcs->get_clock_by_type(pp_handle,
 			dc_to_pp_clock_type(clk_type), &pp_clks)) {
-		/* Error in pplib. Provide default values. */
+			/* Error in pplib. Provide default values. */
+			get_default_clock_levels(clk_type, dc_clks);
 			return true;
 		}
 	} else if (adev->smu.funcs && adev->smu.funcs->get_clock_by_type) {


