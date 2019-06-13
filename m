Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005A0C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAED920665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560442851;
	bh=RyQfi8PifalqsZTXPrVVALQ1aLa+4Pwc5y07uBkObAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BTAB/HIIDzwS3ewkZpjY8+7nPkODkenb709eaa2LVCupEcHcC2gc6X7SFBEkpzmzg
	 L9TNPbyhsGusxe0qA0O+HltoAHcAs5XGgEbGZeswj5ZLmkqaIsghxxmAdAH26KGSj4
	 UyjpYywPC1nHkmp8TqCqZo5/jfmrPwNABQ2tfv3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388539AbfFMQUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:20:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731072AbfFMIjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:39:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E289020851;
        Thu, 13 Jun 2019 08:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415148;
        bh=RyQfi8PifalqsZTXPrVVALQ1aLa+4Pwc5y07uBkObAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WRX8ye3BT1NcwHKPYgPAUmnDn+zJmrxXb+NQd8Y2bksdqlAv3dyfS4dvjNvBZ47jF
         QzyeHoQi3uXs3rqubNsvG14bBWRWYxh3/KrvkYtZybN00docu4O8wkl9oH8uq15hD/
         rAcUpUCV/Q7keBTukEHdC8IDtTwvaXsDsMqn4q+8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 021/118] drm/nouveau/disp/dp: respect sink limits when selecting failsafe link configuration
Date:   Thu, 13 Jun 2019 10:32:39 +0200
Message-Id: <20190613075644.817855307@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075643.642092651@linuxfoundation.org>
References: <20190613075643.642092651@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 13d03e9daf70dab032c03dc172e75bb98ad899c4 ]

Where possible, we want the failsafe link configuration (one which won't
hang the OR during modeset because of not enough bandwidth for the mode)
to also be supported by the sink.

This prevents "link rate unsupported by sink" messages when link training
fails.

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c
index 5f301e632599..818d21bd28d3 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c
@@ -365,8 +365,15 @@ nvkm_dp_train(struct nvkm_dp *dp, u32 dataKBps)
 	 * and it's better to have a failed modeset than that.
 	 */
 	for (cfg = nvkm_dp_rates; cfg->rate; cfg++) {
-		if (cfg->nr <= outp_nr && cfg->nr <= outp_bw)
-			failsafe = cfg;
+		if (cfg->nr <= outp_nr && cfg->nr <= outp_bw) {
+			/* Try to respect sink limits too when selecting
+			 * lowest link configuration.
+			 */
+			if (!failsafe ||
+			    (cfg->nr <= sink_nr && cfg->bw <= sink_bw))
+				failsafe = cfg;
+		}
+
 		if (failsafe && cfg[1].rate < dataKBps)
 			break;
 	}
-- 
2.20.1



