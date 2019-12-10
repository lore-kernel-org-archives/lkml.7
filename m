Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A376C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D6A205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576014148;
	bh=xHIDsK0asZ0gjInSJ1gh58T3ePLlo1R6dUJ1aQLt5ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CvjHtO1DYkscGymftoO4EPwl6NbZaC+lYaNU3U0tI4spLYB0+H7ZOyjKZpd7Yu5Th
	 vWs6OY12UQretCl5ZkkxSVlnO35EDIm6nDToBHTX67Hg1mAs27qRcNFK4eiM6gx+BO
	 /huaf4slOX+wRg4MYjQxnyvw5Lduq0aaYV4JNk+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbfLJVm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:42:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:38646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729895AbfLJVeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:34:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFC92208C3;
        Tue, 10 Dec 2019 21:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576013639;
        bh=xHIDsK0asZ0gjInSJ1gh58T3ePLlo1R6dUJ1aQLt5ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BlmiRoxOi7RRzXwd5t6OppHKb+Es3aXp05IozNRjQjZtgDYjbDJTZfeUPSGGe7eZB
         RF3NJtVC00VvOisuKHLnp8xcSOTbCs0wQ251o/eJvfaksx1EpyyjVnwrZAvbrvhL1w
         IBxVr/B/LIlGodqPj7JqAJYj1nvFqKlWZfacOsA0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 079/177] drm/tegra: sor: Use correct SOR index on Tegra210
Date:   Tue, 10 Dec 2019 16:30:43 -0500
Message-Id: <20191210213221.11921-79-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210213221.11921-1-sashal@kernel.org>
References: <20191210213221.11921-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit 24e64f86da40e68c5f58af08796110f147b12193 ]

The device tree bindings for the Tegra210 SOR don't require the
controller instance to be defined, since the instance can be derived
from the compatible string. The index is never used on Tegra210, so we
got away with it not getting set. However, subsequent patches will
change that, so make sure the proper index is used.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/sor.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index d7fe9f15def1d..89cb70da2bfe6 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -2922,6 +2922,11 @@ static int tegra_sor_parse_dt(struct tegra_sor *sor)
 		 * earlier
 		 */
 		sor->pad = TEGRA_IO_PAD_HDMI_DP0 + sor->index;
+	} else {
+		if (sor->soc->supports_edp)
+			sor->index = 0;
+		else
+			sor->index = 1;
 	}
 
 	return 0;
-- 
2.20.1

