Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AD0C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C063205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557208276;
	bh=T86Ozqa4zQwnEIPLFsnsGeVLTp6aZdkd1zJOQJbGNi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AvVEhAk8gH/cGAg3V6uAFV1MXM7TVs42jKs9SncGq/8GuszS9S97wCr8lO2xh3UpV
	 TWHoEHCD7NWjN84Jb894f2U30M+UnxCm17ZOBPG3oUZ3Lm3a4woXiFtH/yoCEFagnk
	 hhTIDRawwOmlPRMPMQovICDeSqYBFcXOHqqmf4jw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbfEGFvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728989AbfEGFj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:39:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8895C216C4;
        Tue,  7 May 2019 05:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207597;
        bh=T86Ozqa4zQwnEIPLFsnsGeVLTp6aZdkd1zJOQJbGNi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ktvlgAkdVzgLpEU+g4sYERpClVVQrnwTn8ftkdOrbhhCkrHgJR6UoscKL9WNvK6cJ
         9MgYUYplaBGS2PDiEbTcVfFvO80bDcNFBCZpupp3Pkh8q4G4b2AyKK2lk0qjCKA24u
         rOeq9XoyM3GDcJMb71x36frCK4S6re6FPmyBV4B0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 46/95] media: adv7842: when the EDID is cleared, unconfigure CEC as well
Date:   Tue,  7 May 2019 01:37:35 -0400
Message-Id: <20190507053826.31622-46-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053826.31622-1-sashal@kernel.org>
References: <20190507053826.31622-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hans.verkuil@cisco.com>

[ Upstream commit ab83203e181015b099720aff43ffabc1812e0fb3 ]

When there is no EDID the CEC adapter should be unconfigured as
well. So call cec_phys_addr_invalidate() when this happens.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Cc: <stable@vger.kernel.org>      # for v4.18 and up
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/i2c/adv7842.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/adv7842.c b/drivers/media/i2c/adv7842.c
index f9c23173c9fa..dcce8d030e5d 100644
--- a/drivers/media/i2c/adv7842.c
+++ b/drivers/media/i2c/adv7842.c
@@ -799,8 +799,10 @@ static int edid_write_hdmi_segment(struct v4l2_subdev *sd, u8 port)
 	/* Disable I2C access to internal EDID ram from HDMI DDC ports */
 	rep_write_and_or(sd, 0x77, 0xf3, 0x00);
 
-	if (!state->hdmi_edid.present)
+	if (!state->hdmi_edid.present) {
+		cec_phys_addr_invalidate(state->cec_adap);
 		return 0;
+	}
 
 	pa = cec_get_edid_phys_addr(edid, 256, &spa_loc);
 	err = cec_phys_addr_validate(pa, &pa, NULL);
-- 
2.20.1

