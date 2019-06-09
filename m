Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5F4C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF2020833
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560098795;
	bh=JXCwo4P12ejwZfDdBCGPxvuki+mBfnKuDkGCDec2tas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EB6RUG4WmlzXV9TqHIpN7HPNRy0PiBGfgnnCsVF6mA7Dzhe5ewuee7WwMsD21sF4X
	 9/R4w5NMUaOiqLniJucftBGD4nsj4YETgNsVyQBAFB4sM4946fkhmPY9bEEp8rAznz
	 IXe6Qu4CTko5mZEKC8bDGrngiH31Ho3YNzcB1Arw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbfFIQqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:46:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730494AbfFIQqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:46:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18A6F208C0;
        Sun,  9 Jun 2019 16:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098790;
        bh=JXCwo4P12ejwZfDdBCGPxvuki+mBfnKuDkGCDec2tas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CdSt/F1KlAD/dTLvrDCnXdrwdT+CRk+T6bHut+4XUiVfty0Ob34U4/mljQBSCce/g
         6BhscWTTwJ0JlPVRet7X1gFdeRTYQmHJeRoM02M5catm5nsVt7W6QBiU941fYa7Pgs
         3teytZwHpOgO18oWzZUyWRN7nPKkH3NdO3l6IOf8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harry Wentland <harry.wentland@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.1 62/70] drm/amd/display: Add ASICREV_IS_PICASSO
Date:   Sun,  9 Jun 2019 18:42:13 +0200
Message-Id: <20190609164132.659204346@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.541128197@linuxfoundation.org>
References: <20190609164127.541128197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harry Wentland <harry.wentland@amd.com>

commit ada637e70f96862ff5ba20a169506b58cf567db9 upstream.

[WHY]
We only want to load DMCU FW on Picasso and Raven 2, not on Raven 1.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/include/dal_asic_id.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -138,13 +138,14 @@
 #endif
 #define RAVEN_UNKNOWN 0xFF
 
-#if defined(CONFIG_DRM_AMD_DC_DCN1_01)
-#define ASICREV_IS_RAVEN2(eChipRev) ((eChipRev >= RAVEN2_A0) && (eChipRev < 0xF0))
-#endif /* DCN1_01 */
 #define ASIC_REV_IS_RAVEN(eChipRev) ((eChipRev >= RAVEN_A0) && eChipRev < RAVEN_UNKNOWN)
 #define RAVEN1_F0 0xF0
 #define ASICREV_IS_RV1_F0(eChipRev) ((eChipRev >= RAVEN1_F0) && (eChipRev < RAVEN_UNKNOWN))
 
+#if defined(CONFIG_DRM_AMD_DC_DCN1_01)
+#define ASICREV_IS_PICASSO(eChipRev) ((eChipRev >= PICASSO_A0) && (eChipRev < RAVEN2_A0))
+#define ASICREV_IS_RAVEN2(eChipRev) ((eChipRev >= RAVEN2_A0) && (eChipRev < 0xF0))
+#endif /* DCN1_01 */
 
 #define FAMILY_RV 142 /* DCN 1*/
 


