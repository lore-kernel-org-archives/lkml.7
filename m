Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC0CC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F24C21783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497007;
	bh=cIA2Er4jQ/jeqXZOLNDmggGDCTaLVlwFasMubnHygrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j/44ju4SA65zcPOxOtRAo+wWSbknVdO2fVSy168i6cJwTvc/zvAGeZtqHi+biDChC
	 8sPZTtW0DZPyQ50NoiibSCqe9maV4UOzMMDfGuZdQCJ8AFp4xBSMPa+ugBdsk6Ryo4
	 WEcjB6C7yLf47kndAmS9u/SDcNhtpZyONF3A/xD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKKSaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:30:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbfKKSaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:30:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C83F321872;
        Mon, 11 Nov 2019 18:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497003;
        bh=cIA2Er4jQ/jeqXZOLNDmggGDCTaLVlwFasMubnHygrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cYz1Lfqg4aRhWkNEXSwbUHsZi1rVfC+DlLmd/oT+0czZ0xp2QXuvTRwBMoSkcomgo
         hi4kCl6KY1m6uGY1Xb94P8JvB0O/QsnWULAVTNd4oKcQGgJSYaXWhRNs1OzcsmxAdQ
         opRdaKLeICz9PK1UPCgQe/BLyfNIwanb/7/uyV8A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yong Zhao <yong.zhao@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.4 13/43] drm/radeon: fix si_enable_smc_cac() failed issue
Date:   Mon, 11 Nov 2019 19:28:27 +0100
Message-Id: <20191111181302.039834392@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181246.772983347@linuxfoundation.org>
References: <20191111181246.772983347@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit 2c409ba81be25516afe05ae27a4a15da01740b01 upstream.

Need to set the dte flag on this asic.

Port the fix from amdgpu:
5cb818b861be114 ("drm/amd/amdgpu: fix si_enable_smc_cac() failed issue")

Reviewed-by: Yong Zhao <yong.zhao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/radeon/si_dpm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -1956,6 +1956,7 @@ static void si_initialize_powertune_defa
 		case 0x682C:
 			si_pi->cac_weights = cac_weights_cape_verde_pro;
 			si_pi->dte_data = dte_data_sun_xt;
+			update_dte_from_pl2 = true;
 			break;
 		case 0x6825:
 		case 0x6827:


