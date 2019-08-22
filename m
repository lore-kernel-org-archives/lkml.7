Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092EBC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D569923402
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566494971;
	bh=pvRAirrxkvNC8TjgZSp90jqQucwW+5Kmju3CRcBN5Ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h0xPPsLAin5mbLtYFQv3yb50dM1aYZ70gqefa9S1eN/SJ9ZcHf9Nqo4xnUvD3Eiie
	 2PrRSIYW6iysFygXiciyPciDy649ErHWkX1Qs4xlC6o2tAKX4qkg7yI6LPkuaFkriw
	 pfHVusToNTwLVa7ZF8Rbi+EJ+AWZESIR/35WHOIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390675AbfHVR3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:29:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404712AbfHVR0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:26:23 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACAF7206DD;
        Thu, 22 Aug 2019 17:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494782;
        bh=pvRAirrxkvNC8TjgZSp90jqQucwW+5Kmju3CRcBN5Ho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ef+ETW3x71WkmI2AKukgpfaYlv/6s1fuCxUzLX3KJX9ZCzDc6SRy5YhXM+zjxDfTD
         bXLTvjyzCoVbhwBrUn9UH3u1ekVyzlD7CwDKA6dcX1EtwSOVIYGHCCMQ5HBSPGt2ff
         Bj4ZuXE8uTseMmxMv1XewcpgSKznkPVuG1LZlOHQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 49/85] drm: msm: Fix add_gpu_components
Date:   Thu, 22 Aug 2019 10:19:22 -0700
Message-Id: <20190822171733.412775498@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171731.012687054@linuxfoundation.org>
References: <20190822171731.012687054@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 9ca7ad6c7706edeae331c1632d0c63897418ebad ]

add_gpu_components() adds found GPU nodes from the DT to the match list,
regardless of the status of the nodes.  This is a problem, because if the
nodes are disabled, they should not be on the match list because they will
not be matched.  This prevents display from initing if a GPU node is
defined, but it's status is disabled.

Fix this by checking the node's status before adding it to the match list.

Fixes: dc3ea265b856 (drm/msm: Drop the gpu binding)
Reviewed-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20190626180015.45242-1-jeffrey.l.hugo@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index ed9a3a1e50efb..dbfd2c006f740 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1284,7 +1284,8 @@ static int add_gpu_components(struct device *dev,
 	if (!np)
 		return 0;
 
-	drm_of_component_match_add(dev, matchptr, compare_of, np);
+	if (of_device_is_available(np))
+		drm_of_component_match_add(dev, matchptr, compare_of, np);
 
 	of_node_put(np);
 
-- 
2.20.1



