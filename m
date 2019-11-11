Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E7EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F25206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="viQc/Kpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKKSLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:11:15 -0500
Received: from gateway20.websitewelcome.com ([192.185.48.38]:14685 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726763AbfKKSLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:11:14 -0500
X-Greylist: delayed 1501 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Nov 2019 13:11:13 EST
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 19956400C47C9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 10:16:44 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id UDRXiLk0wW4frUDRXinZfu; Mon, 11 Nov 2019 11:25:35 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=obJGNctpNomw0ORl8GMTnOXHVQTOW6QwMfGlRbchZDQ=; b=viQc/KpkyqpjaooaNayckCTFw5
        jPT+0IfyxeHPWb8eVLnXjU0UNzYGM+p0EvVAX8Ex1+EUwP1W+zbACBcdlQaS8+bCFJnU7q1PjsXXu
        bC0NPhCyZxaLPIp76IzUT8B2V/swRFzeHxsKtalaVs43Pc8DQ+vNNE1B+cJA78YL3wZ6fl9fZegLg
        n4/aIk6NZOtbzzNEKxJad2pCp/locExG7MJulTuSwcfXn/84kPBCbUQGwylAdhgCNHGmU9h4XCBqs
        Br+CFXHcgMvh2BTDHzYfbkhfWPE8MP1uDDjm0hnx5Tltn0FYqZ7SvKEb7Peel/MPrZ9EbCzSs3rHL
        giAKWVQg==;
Received: from [187.192.2.30] (port=45762 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1iUDRU-001CZi-Un; Mon, 11 Nov 2019 11:25:33 -0600
Date:   Mon, 11 Nov 2019 11:25:43 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Lyude Paul <lyude@redhat.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/amd/display: Fix unsigned variable compared to less than
 zero
Message-ID: <20191111172543.GA31748@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.2.30
X-Source-L: No
X-Exim-ID: 1iUDRU-001CZi-Un
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.2.30]:45762
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currenly, the error check below on variable *vcpi_slots* is always
false because it is a uint64_t type variable, hence, the values
this variable can hold are never less than zero:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:
4870         if (dm_new_connector_state->vcpi_slots < 0) {
4871                 DRM_DEBUG_ATOMIC("failed finding vcpi slots: %d\n", (int)dm_new_connector_stat     e->vcpi_slots);
4872                 return dm_new_connector_state->vcpi_slots;
4873         }

Fix this by making *vcpi_slots* of int type.

Addresses-Coverity: 1487838 ("Unsigned compared against 0")
Fixes: b4c578f08378 ("drm/amd/display: Add MST atomic routines")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 6db07e9e33ab..a8fc90a927d6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -403,7 +403,7 @@ struct dm_connector_state {
 	bool underscan_enable;
 	bool freesync_capable;
 	uint8_t abm_level;
-	uint64_t vcpi_slots;
+	int vcpi_slots;
 	uint64_t pbn;
 };
 
-- 
2.23.0

