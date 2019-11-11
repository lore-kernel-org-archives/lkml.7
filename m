Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5F3C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0974D20659
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498608;
	bh=CKpL9Mzfne8s7/6HlpgrHeezbAsQHaYqTZTaJ60r60Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GkPCoM3gYcENzc4XRHiL++V2ecRX+5EjChBA/8ng6qd1nbWijAwB+p5Wlec+liF9C
	 jP1LM2ohzGNiFPasrvfG7G7rW1M2ViFWbelVLyCJz2RzLHM9abhZmZ6DKZaC944nLZ
	 5JT/UrtlbRZgbfYSyVRg3Z2nXCiZTyq8fI7JJgJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfKKS4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:56:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:55282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729594AbfKKS4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:56:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF86620818;
        Mon, 11 Nov 2019 18:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498602;
        bh=CKpL9Mzfne8s7/6HlpgrHeezbAsQHaYqTZTaJ60r60Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OT6giaG3TpF+XlJLlNVv3G5YjrQSjCzmlMH94CnGhnGEyQjGNGkK3IUjFdYv5W+Ly
         HPukxftoA59MImMO1W57j6pE7Rvg88PTYnd0JAFSEwGv8c9A+Gr+6bPObkWnbnQ8Tx
         pfkleUBNCSuPheTSB87Ri/2JYT577ZZU5xBVaT1A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jun Lei <Jun.Lei@amd.com>,
        Aric Cyr <Aric.Cyr@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 168/193] drm/amd/display: add 50us buffer as WA for pstate switch in active
Date:   Mon, 11 Nov 2019 19:29:10 +0100
Message-Id: <20191111181513.523629386@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jun Lei <Jun.Lei@amd.com>

[ Upstream commit 7c37d399c2b84d4b79de4d512a38373f1d71ab90 ]

Signed-off-by: Jun Lei <Jun.Lei@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
index 649883777f62a..6c6c486b774a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
@@ -2577,7 +2577,8 @@ static void dml20_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPer
 			mode_lib->vba.MinActiveDRAMClockChangeMargin
 					+ mode_lib->vba.DRAMClockChangeLatency;
 
-	if (mode_lib->vba.MinActiveDRAMClockChangeMargin > 0) {
+	if (mode_lib->vba.MinActiveDRAMClockChangeMargin > 50) {
+		mode_lib->vba.DRAMClockChangeWatermark += 25;
 		mode_lib->vba.DRAMClockChangeSupport[0][0] = dm_dram_clock_change_vactive;
 	} else {
 		if (mode_lib->vba.SynchronizedVBlank || mode_lib->vba.NumberOfActivePlanes == 1) {
-- 
2.20.1



