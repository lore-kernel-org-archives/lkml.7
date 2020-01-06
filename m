Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997C6C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F66E20848
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ZkOI9NGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgAFHXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 02:23:03 -0500
Received: from gateway23.websitewelcome.com ([192.185.50.185]:21185 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726668AbgAFHXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 02:23:02 -0500
X-Greylist: delayed 1383 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Jan 2020 02:23:02 EST
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id AA62E12A0B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jan 2020 00:59:58 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id oMMoiwwpfW4froMMoiDJop; Mon, 06 Jan 2020 00:59:58 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zs/OwLvCA6jS7TNxcQCit+/Ww+RcUnpu1UvuQF8dEtI=; b=ZkOI9NGA+cKtzcVCyTqZlA4v1T
        JUellohSEt5/jPkTvYMDpkLNa8Urhq3Ee4eedihHLjg8J7Zyt2EeDR1KVuMV/yrpIXmB3LoQiBcdm
        l13JvB9K1HSYQ2IGK65CSUZIh/AKvGHPyfrmV4u9fInE1hX+WmjreyPTO7fDWffoe+YK8SV1J3L61
        1VqeSxCtE2nkyogOqQiB2MH9gnd4RR/OCLVCXbi2h/7eT20Irt27yzgVM0+x3vbq1Ghrp6WGoD0X/
        t0pDD70gMtXZhCSjAthlO4eSvQ+S98UeiCtkBiL2erb555K6PUrUCYfvDpJzY8L/7RIr27tJ6AlOj
        SzhXnCXg==;
Received: from [189.152.215.240] (port=33838 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ioMMm-0014nS-Pl; Mon, 06 Jan 2020 00:59:57 -0600
Date:   Mon, 6 Jan 2020 01:01:53 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] drm/i915/display: Fix inconsistent IS_ERR and PTR_ERR
Message-ID: <20200106070152.GA13299@embeddedor>
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
X-Source-IP: 189.152.215.240
X-Source-L: No
X-Exim-ID: 1ioMMm-0014nS-Pl
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.152.215.240]:33838
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix inconsistent IS_ERR and PTR_ERR in intel_modeset_all_tiles().

The proper pointer to be passed as argument is crtc_state.

This bug was detected with the help of Coccinelle.

Fixes: a603f5bd1691 ("drm/i915/dp: Make sure all tiled connectors get added to the state with full modeset")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index da5266e76738..a96bee699a5e 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -14424,7 +14424,7 @@ intel_modeset_all_tiles(struct intel_atomic_state *state, int tile_grp_id)
 		crtc_state = drm_atomic_get_crtc_state(&state->base,
 						       conn_state->crtc);
 		if (IS_ERR(crtc_state)) {
-			ret = PTR_ERR(conn_state);
+			ret = PTR_ERR(crtc_state);
 			break;
 		}
 		crtc_state->mode_changed = true;
-- 
2.23.0

