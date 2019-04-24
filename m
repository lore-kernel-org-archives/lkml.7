Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1954DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8CF20652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556129130;
	bh=1QXLjvJhZpBC1YwpufBIkYL+Ewqfrz9VcBjmg8DunMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xxSf17ej7/gbW3qv2YwHw8vM9uJJE3QUrgqV2Qaw0GDBK1PdN5HdXw31Tyahy0gc7
	 oL/SffZRsheO+UFkmumjJoR+ca8m6SzMPincqI2SYn0wwXu2rlMPwWCLa5aq4luNDa
	 xYl4avU0GexBmZqbjEqpK/O3PkBOFAfcL3x5UJA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388866AbfDXRSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:18:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388419AbfDXRSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:18:34 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F396621908;
        Wed, 24 Apr 2019 17:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126313;
        bh=1QXLjvJhZpBC1YwpufBIkYL+Ewqfrz9VcBjmg8DunMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i015V+Wb0UUkBaz1mfDpkgF3CpjamzcMNiC09S1svEEZx6spotm4STUDyKSmGF0tb
         Sl+3h/pLkKYYKtWti++AakAYQnABAY/ho4LmzlOqT9jmAKbYvlOIJ9igulcNSTWgzi
         3jbrocUMiBgIwwj9zDzCI6P7Oy/fF4nSfWhIUZJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Vincent <brainn@gmail.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 068/168] drm/dp/mst: Configure no_stop_bit correctly for remote i2c xfers
Date:   Wed, 24 Apr 2019 19:08:32 +0200
Message-Id: <20190424170927.789312806@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180928180403.22499-1-ville.syrjala@linux.intel.com
Reviewed-by: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 5a1bafb5ecbb..ff12d926eb65 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3019,6 +3019,7 @@ static int drm_dp_mst_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs
 		msg.u.i2c_read.transactions[i].i2c_dev_id = msgs[i].addr;
 		msg.u.i2c_read.transactions[i].num_bytes = msgs[i].len;
 		msg.u.i2c_read.transactions[i].bytes = msgs[i].buf;
+		msg.u.i2c_read.transactions[i].no_stop_bit = !(msgs[i].flags & I2C_M_STOP);
 	}
 	msg.u.i2c_read.read_i2c_device_id = msgs[num - 1].addr;
 	msg.u.i2c_read.num_bytes_read = msgs[num - 1].len;
-- 
2.19.1



