Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57C4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921C52064A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713984;
	bh=E+ROpDuRuthJY2Hl4/oJtUg6QTmIEA3ZcneOCSQqwlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HuQutAEduzd31C3YePuRcGlM3okfnYorjZfBLUTOlbkuDpDYibIxbpLeRmYCDUflE
	 siftKBgqbKJpgZWCT1jBHbaphJItvkASjSouYmDa8aSRbqSMCGuPdU6cxhKAzafvNv
	 G809E3sN9uNWrdUBMzyt5f2M7T+JEB+MDZ9LIR/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388961AbfC0TND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:13:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388329AbfC0SKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:10:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 675F72147C;
        Wed, 27 Mar 2019 18:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710216;
        bh=E+ROpDuRuthJY2Hl4/oJtUg6QTmIEA3ZcneOCSQqwlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bjf7ve5zi4qlMWIV+wVoVK3r+TYmved5fn0FgelutIaXqhtyam2PtPfQkWyLtGnoo
         U/VIzRW+CUMvw/PDKCSm06yUSuICI4x+YFWCOATywnrWiCFz3jgeTj10nNiLkCEV87
         0+7csz3jHg99F/K3GUw7ViaajjuRULZJ34hEIJ14=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Brian Vincent <brainn@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 257/262] drm/dp/mst: Configure no_stop_bit correctly for remote i2c xfers
Date:   Wed, 27 Mar 2019 14:01:52 -0400
Message-Id: <20190327180158.10245-257-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

[ Upstream commit c978ae9bde582e82a04c63a4071701691dd8b35c ]

We aren't supposed to force a stop+start between every i2c msg
when performing multi message transfers. This should eg. cause
the DDC segment address to be reset back to 0 between writing
the segment address and reading the actual EDID extension block.

To quote the E-DDC spec:
"... this standard requires that the segment pointer be
 reset to 00h when a NO ACK or a STOP condition is received."

Since we're going to touch this might as well consult the
I2C_M_STOP flag to determine whether we want to force the stop
or not.

Cc: Brian Vincent <brainn@gmail.com>
References: https://bugs.freedesktop.org/show_bug.cgi?id=108081
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180928180403.22499-1-ville.syrjala@linux.intel.com
Reviewed-by: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 529414556962..1a244c53252c 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3286,6 +3286,7 @@ static int drm_dp_mst_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs
 		msg.u.i2c_read.transactions[i].i2c_dev_id = msgs[i].addr;
 		msg.u.i2c_read.transactions[i].num_bytes = msgs[i].len;
 		msg.u.i2c_read.transactions[i].bytes = msgs[i].buf;
+		msg.u.i2c_read.transactions[i].no_stop_bit = !(msgs[i].flags & I2C_M_STOP);
 	}
 	msg.u.i2c_read.read_i2c_device_id = msgs[num - 1].addr;
 	msg.u.i2c_read.num_bytes_read = msgs[num - 1].len;
-- 
2.19.1

